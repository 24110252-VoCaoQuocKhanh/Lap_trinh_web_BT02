<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Khai báo thư viện JSTL cho Jakarta EE 10 -->
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang Chủ</title>
</head>
<body>
    <c:choose>

        <c:when test="${isHome == true}">
            <h1>HOME</h1>
            <p>Bạn đã đăng nhập thành công!</p>
        </c:when>
        
        <c:otherwise>
            <h2>ĐÂY LÀ TRANG CHỦ CỦA PROJECT</h2>
            <p>Nhấp vào liên kết bên dưới để đăng nhập:</p>
            <a href="${pageContext.request.contextPath}/login">Login</a>
        </c:otherwise>
    </c:choose>
</body>
</html>