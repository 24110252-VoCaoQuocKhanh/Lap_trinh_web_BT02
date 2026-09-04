package vn.iotstar.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.services.IUserService;
import vn.iotstar.services.impl.UserServiceImpl;

@WebServlet(urlPatterns = {"/register"})
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");
        req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");

        String username = req.getParameter("username");
        String fullname = req.getParameter("fullname");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");

        if (username == null || email == null || password == null || 
            username.trim().isEmpty() || email.trim().isEmpty() || password.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ các thông tin bắt buộc!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        if (!password.equals(confirmPassword)) {
            req.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        if (userService.checkExistUsername(username.trim())) {
            req.setAttribute("error", "Tên tài khoản đã tồn tại!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        if (userService.checkExistEmail(email.trim())) {
            req.setAttribute("error", "Email này đã được sử dụng!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        try {
            boolean success = userService.register(username.trim(), password, email.trim(), fullname != null ? fullname.trim() : username.trim());
            if (success) {
                HttpSession session = req.getSession();
                session.setAttribute("verifyEmail", email.trim());
                resp.sendRedirect(req.getContextPath() + "/verify-otp");
            } else {
                req.setAttribute("error", "Đăng ký thất bại. Vui lòng kiểm tra lại thông tin!");
                req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi gửi mail OTP: " + e.getMessage());
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
        }
    }
}