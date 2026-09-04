package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.iotstar.entity.User;
import vn.iotstar.services.IUserService;
import vn.iotstar.services.impl.UserServiceImpl;
import java.io.IOException;

@WebServlet(urlPatterns = "/login")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IUserService userService = new UserServiceImpl();

    @Override
    public void init() throws ServletException {
        // Tự động khởi tạo tài khoản admin/123 nếu chưa có
        userService.initAdminAccount();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String error = req.getParameter("error");
        if ("access_denied".equals(error)) {
            req.setAttribute("error", "Bạn không có quyền truy cập trang Quản trị! Vui lòng đăng nhập với tài khoản Admin.");
        }

        if ("1".equals(req.getParameter("activated"))) {
            req.setAttribute("message", "Kích hoạt tài khoản thành công! Bạn có thể đăng nhập ngay bây giờ.");
        }

        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("username")) {
                    req.setAttribute("savedUser", cookie.getValue());
                }
            }
        }
        resp.setContentType("text/html; charset=UTF-8");
        req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");

        String user = req.getParameter("username");
        String pass = req.getParameter("password");
        String remember = req.getParameter("remember");

        if (user != null) user = user.trim();
        if (pass != null) pass = pass.trim();

        User account = userService.login(user, pass);

        if (account != null) {
            // Kiểm tra trạng thái kích hoạt tài khoản (Admin luôn được phép đăng nhập)
            if (account.getRole() != 1 && account.getStatus() == 0) {
                HttpSession session = req.getSession();
                session.setAttribute("verifyEmail", account.getEmail());
                req.setAttribute("error", "Tài khoản của bạn chưa kích hoạt qua OTP. Vui lòng nhập mã OTP được gửi đến email!");
                req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
                return;
            }

            HttpSession session = req.getSession(true);
            session.setAttribute("account", account);

            if (remember != null) {
                Cookie cookie = new Cookie("username", user);
                cookie.setMaxAge(60 * 60 * 24);
                resp.addCookie(cookie);
            } else {
                Cookie cookie = new Cookie("username", "");
                cookie.setMaxAge(0);
                resp.addCookie(cookie);
            }

            // Phân quyền chuyển hướng
            if (account.getRole() == 1) {
                resp.sendRedirect(req.getContextPath() + "/admin/product");
            } else {
                resp.sendRedirect(req.getContextPath() + "/home");
            }
        } else {
            req.setAttribute("error", "Sai tài khoản hoặc mật khẩu!");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        }
    }
}