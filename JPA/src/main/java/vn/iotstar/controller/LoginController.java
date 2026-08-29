package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.iotstar.dao.UserDao;
import vn.iotstar.entity.User;
import java.io.IOException;

@WebServlet(urlPatterns = "/login")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("username")) {
                    req.setAttribute("savedUser", cookie.getValue());
                }
            }
        }
        req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String user = req.getParameter("username");
        String pass = req.getParameter("password");
        String remember = req.getParameter("remember");

        User account = new UserDao().login(user, pass);

        if (account != null) {
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
            resp.sendRedirect(req.getContextPath() + "/admin/category");
        } else {
            req.setAttribute("error", "Sai tài khoản hoặc mật khẩu!");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        }
    }
}