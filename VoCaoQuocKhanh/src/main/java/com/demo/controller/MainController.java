package com.demo.controller;

import com.demo.service.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = {"", "/", "/home", "/login", "/error"})
public class MainController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AuthService authService;

    @Override
    public void init() throws ServletException {
        authService = new AuthService(); 
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String path = request.getServletPath();
        
        switch (path) {
            case "/login":
                request.getRequestDispatcher("/views/login.jsp").forward(request, response);
                break;
            case "/error":
                request.getRequestDispatcher("/views/error.jsp").forward(request, response);
                break;
            case "/home":
                
                request.setAttribute("isHome", true);
                request.getRequestDispatcher("/views/index.jsp").forward(request, response);
                break;
            case "/":
            default:
                
                request.setAttribute("isHome", false);
                request.getRequestDispatcher("/views/index.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        if ("/login".equals(request.getServletPath())) {
            String user = request.getParameter("username");
            String pass = request.getParameter("password");

            if (authService.checkLogin(user, pass)) {
                
                response.sendRedirect(request.getContextPath() + "/home");
            } else {
                
                response.sendRedirect(request.getContextPath() + "/error");
            }
        }
    }
}