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

@WebServlet(urlPatterns = {"/verify-otp"})
public class VerifyOtpController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");
        req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");

        String enteredOtp = req.getParameter("otp");
        HttpSession session = req.getSession();
        String email = (String) session.getAttribute("verifyEmail");

        if (email == null || email.trim().isEmpty()) {
            email = req.getParameter("email");
        }

        if (email == null || email.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/register");
            return;
        }

        if (enteredOtp == null || !enteredOtp.trim().matches("^[0-9]{6}$")) {
            req.setAttribute("error", "Vui lòng nhập chính xác mã OTP gồm 6 chữ số!");
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
            return;
        }

        boolean success = userService.verifyOtp(email.trim(), enteredOtp.trim());

        if (success) {
            session.removeAttribute("verifyEmail");
            resp.sendRedirect(req.getContextPath() + "/login?activated=1");
        } else {
            req.setAttribute("error", "Mã OTP không chính xác hoặc đã hết hạn. Vui lòng thử lại!");
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
        }
    }
}