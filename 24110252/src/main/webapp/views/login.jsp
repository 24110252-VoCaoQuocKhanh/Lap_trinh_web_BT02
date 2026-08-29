<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng Nhập</title>
</head>
<body>
    <h2>ĐĂNG NHẬP HỆ THỐNG</h2>
    
    <c:if test="${not empty alert}">
        <h3 style="color: red;">${alert}</h3>
    </c:if>

    <form action="${pageContext.request.contextPath}/login" method="POST">
        Username: <input type="text" name="username" required> <br><br>
        Password: <input type="password" name="password" required> <br><br>
        <input type="checkbox" name="remember"> Nhớ mật khẩu <br><br>
        <button type="submit">Login</button>
    </form>
</body>
</html>