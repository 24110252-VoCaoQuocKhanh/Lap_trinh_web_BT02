<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Trang Chủ</title>
</head>
<body>
    <h1>CHÀO MỪNG, ${sessionScope.account.fullname}!</h1>
    <p>Bạn đã đăng nhập thành công.</p>
    
    <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
</body>
</html>