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

@WebServlet(urlPatterns = {"/forgot-password", "/reset-password"})
public class ForgotPasswordController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");

        String path = req.getServletPath();
        if ("/reset-password".equals(path)) {
            req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
        } else {
            req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");

        String path = req.getServletPath();

        if ("/forgot-password".equals(path)) {
            String email = req.getParameter("email");
            if (email == null || email.trim().isEmpty()) {
                req.setAttribute("error", "Vui lòng nhập địa chỉ email!");
                req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
                return;
            }

            try {
                boolean sent = userService.sendForgotPasswordOtp(email.trim());
                if (sent) {
                    HttpSession session = req.getSession();
                    session.setAttribute("resetEmail", email.trim());
                    resp.sendRedirect(req.getContextPath() + "/reset-password");
                } else {
                    req.setAttribute("error", "Email không tồn tại trong hệ thống Device Store!");
                    req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
                }
            } catch (Exception e) {
                e.printStackTrace();
                req.setAttribute("error", "Lỗi gửi email: " + e.getMessage());
                req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
            }
        } else if ("/reset-password".equals(path)) {
            HttpSession session = req.getSession();
            String email = (String) session.getAttribute("resetEmail");

            if (email == null) {
                resp.sendRedirect(req.getContextPath() + "/forgot-password");
                return;
            }

            String enteredOtp = req.getParameter("otp");
            String newPassword = req.getParameter("newPassword");
            String confirmPassword = req.getParameter("confirmPassword");

            if (enteredOtp == null || newPassword == null || confirmPassword == null ||
                enteredOtp.trim().isEmpty() || newPassword.trim().isEmpty()) {
                req.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
                req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
                return;
            }

            if (!newPassword.equals(confirmPassword)) {
                req.setAttribute("error", "Mật khẩu xác nhận không khớp!");
                req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
                return;
            }

            boolean success = userService.resetPassword(email, enteredOtp.trim(), newPassword);
            if (success) {
                session.removeAttribute("resetEmail");
                req.setAttribute("message", "Đặt lại mật khẩu thành công! Bạn có thể đăng nhập với mật khẩu mới.");
                req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", "Mã OTP không chính xác hoặc đã hết hạn!");
                req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
            }
        }
    }
}
