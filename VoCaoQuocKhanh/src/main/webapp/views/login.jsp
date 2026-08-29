<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng Nhập</title>
</head>
<body>
    <h2>Form Login</h2>
    
    <form action="${pageContext.request.contextPath}/login" method="POST">
        Username: <input type="text" name="username" required> <br><br>
        Password: <input type="password" name="password" required> <br><br>
        <button type="submit">Login</button>
    </form>
</body>
</html>