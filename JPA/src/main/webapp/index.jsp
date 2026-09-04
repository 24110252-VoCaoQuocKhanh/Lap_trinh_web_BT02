<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    response.sendRedirect(request.getContextPath() + "/home");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="refresh" content="0;url=<%=request.getContextPath()%>/home">
    <title>Device Store - Đang tải...</title>
    <script>
        window.location.replace("<%=request.getContextPath()%>/home");
    </script>
</head>
<body style="font-family: sans-serif; text-align: center; padding-top: 50px;">
    <h3>Đang chuyển hướng đến Device Store...</h3>
    <p>Nếu trang không tự chuyển, vui lòng <a href="<%=request.getContextPath()%>/home">nhấn vào đây</a>.</p>
</body>
</html>