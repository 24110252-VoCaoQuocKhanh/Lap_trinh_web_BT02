<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập hệ thống</title>
</head>
<body>
    <h2>Đăng nhập quản trị hệ thống</h2>
    <p style="color:red">${error}</p>
    <form action="${pageContext.request.contextPath}/login" method="post">
        Tài khoản: <input type="text" name="username" value="${savedUser}" required><br><br>
        Mật khẩu: <input type="password" name="password" required><br><br>
        <input type="checkbox" name="remember" ${not empty savedUser ? 'checked' : ''}> Nhớ tài khoản<br><br>
        <button type="submit">Đăng nhập</button>
    </form>
</body>
</html>