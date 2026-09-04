package vn.iotstar.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import vn.iotstar.entity.User;
import vn.iotstar.services.IUserService;
import vn.iotstar.services.impl.UserServiceImpl;
import vn.iotstar.util.Constant;
import java.io.*;

@WebServlet(urlPatterns = {"/profile", "/admin/profile"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class ProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User current = (User) session.getAttribute("account");
        User dbUser = userService.findByUsername(current.getUsername());
        if (dbUser == null && current.getId() > 0) {
            dbUser = userService.findById(current.getId());
        }
        if (dbUser != null) {
            session.setAttribute("account", dbUser);
            System.out.println(">> [PROFILE DOGET] Loaded from DB: " + dbUser.getUsername() + " | Fullname: " + dbUser.getFullname() + " | Avatar: " + dbUser.getImages());
        } else {
            dbUser = current;
        }

        String uri = req.getRequestURI();
        if (uri.endsWith("/admin/profile")) {
            // Nếu không phải admin thì chuyển hướng sang trang profile người dùng
            if (dbUser.getRole() != 1) {
                resp.sendRedirect(req.getContextPath() + "/profile");
                return;
            }
            req.getRequestDispatcher("/views/admin/profile.jsp").forward(req, resp);
        } else {
            // Trang profile dành cho người dùng thông thường & khách hàng
            req.getRequestDispatcher("/views/web/profile.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User currentUser = (User) session.getAttribute("account");
        String uri = req.getRequestURI();
        boolean isAdminPath = uri.endsWith("/admin/profile");

        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");
        if (fullname != null) fullname = fullname.trim();
        if (phone != null) phone = phone.trim();

        String imageFileName = null;
        try {
            Part filePart = req.getPart("images");
            if (filePart != null && filePart.getSize() > 0) {
                String originalName = filePart.getSubmittedFileName();
                String ext = (originalName != null && originalName.contains(".")) ? originalName.substring(originalName.lastIndexOf(".")) : ".jpg";
                String fileName = "user_" + System.currentTimeMillis() + ext;
                
                File uploadDir = new File(Constant.DIR + "/user");
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                File destFile = new File(uploadDir, fileName);
                try (InputStream in = filePart.getInputStream();
                     OutputStream out = new FileOutputStream(destFile)) {
                    byte[] buf = new byte[8192];
                    int len;
                    while ((len = in.read(buf)) > 0) {
                        out.write(buf, 0, len);
                    }
                }
                
                imageFileName = "user/" + fileName;

                // Xóa file ảnh cũ nếu có
                if (currentUser.getImages() != null && !currentUser.getImages().isEmpty()) {
                    File oldFile = new File(Constant.DIR + "/" + currentUser.getImages());
                    if (oldFile.exists()) {
                        oldFile.delete();
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        boolean updated = userService.updateProfile(currentUser.getId(), currentUser.getUsername(), fullname, phone, imageFileName);

        String redirectTarget = req.getContextPath() + (isAdminPath ? "/admin/profile" : "/profile");
        if (updated) {
            // Nạp lại thông tin mới nhất từ DB vào Session
            User freshUser = userService.findByUsername(currentUser.getUsername());
            if (freshUser == null && currentUser.getId() > 0) {
                freshUser = userService.findById(currentUser.getId());
            }
            if (freshUser != null) {
                session.setAttribute("account", freshUser);
            } else {
                currentUser.setFullname(fullname);
                currentUser.setPhone(phone);
                if (imageFileName != null) {
                    currentUser.setImages(imageFileName);
                }
                session.setAttribute("account", currentUser);
            }
            resp.sendRedirect(redirectTarget + "?success=1");
        } else {
            resp.sendRedirect(redirectTarget + "?error=1");
        }
    }
}