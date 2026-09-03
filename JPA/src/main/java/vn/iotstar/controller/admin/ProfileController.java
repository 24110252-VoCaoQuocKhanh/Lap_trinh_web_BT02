package vn.iotstar.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import vn.iotstar.dao.UserDao;
import vn.iotstar.entity.User;
import vn.iotstar.util.Constant;
import java.io.*;

@WebServlet(urlPatterns = "/admin/profile")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class ProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    UserDao userDao = new UserDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/admin/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        
        
        User currentUser = (User) session.getAttribute("account");

        
        currentUser.setFullname(req.getParameter("fullname"));
        currentUser.setPhone(req.getParameter("phone"));

        
        Part filePart = req.getPart("images");
        if (filePart != null && filePart.getSize() > 0) {
            String originalName = filePart.getSubmittedFileName();
            String fileName = "user_" + System.currentTimeMillis() + "." + originalName.substring(originalName.lastIndexOf(".") + 1);
            File uploadDir = new File(Constant.DIR + "/user");
            if (!uploadDir.exists()) uploadDir.mkdirs();
            
            
            if (currentUser.getImages() != null && !currentUser.getImages().isEmpty()) {
                new File(Constant.DIR + "/" + currentUser.getImages()).delete();
            }
            
            filePart.write(Constant.DIR + "/user/" + fileName);
            currentUser.setImages("user/" + fileName);
        }

        
        userDao.update(currentUser);
        session.setAttribute("account", currentUser);

        
        resp.sendRedirect(req.getContextPath() + "/admin/profile?success=1");
    }
}