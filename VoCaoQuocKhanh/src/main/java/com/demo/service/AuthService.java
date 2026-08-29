package com.demo.service;

public class AuthService {
    public boolean checkLogin(String username, String password) {
        if (username != null && password != null) {
            return username.equals("admin") && password.equals("123456");
        }
        return false;
    }
}