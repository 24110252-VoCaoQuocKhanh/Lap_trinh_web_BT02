package vn.iotstar.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import vn.iotstar.entity.User;
import java.io.IOException;

@WebFilter(urlPatterns = {"/admin/*"})
public class AuthFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        if (session != null && session.getAttribute("account") != null) {
            User account = (User) session.getAttribute("account");
            // Chỉ tài khoản có role == 1 (Admin) mới được vào khu vực /admin/*
            if (account.getRole() == 1) {
                chain.doFilter(request, response);
                return;
            }
        }
        resp.sendRedirect(req.getContextPath() + "/login?error=access_denied");
    }
}