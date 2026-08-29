<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<body>
    <div style="display:flex; justify-content:space-between; align-items:center;">
        <h2>Danh sách danh mục</h2>
        <p>Xin chào, <b>${sessionScope.account.username}</b> | <a href="<c:url value='/logout'/>">Đăng xuất</a></p>
    </div>
    <a href="<c:url value='/admin/category/add'/>">Thêm danh mục mới</a>
    <table border="1" width="100%" style="margin-top: 10px;">
        <tr>
            <th>STT</th>
            <th>Hình ảnh</th>
            <th>Tên danh mục</th>
            <th>Hành động</th>
        </tr>
        <c:forEach items="${cateList}" var="cate" varStatus="STT">
            <tr>
                <td style="text-align: center;">${STT.index+1}</td>
                <td style="text-align: center;">
                    <img height="100" src="<c:url value='/image?fname=${cate.icon}'/>" alt="icon"/>
                </td>
                <td>${cate.name}</td>
                <td style="text-align: center;">
                    <a href="<c:url value='/admin/category/edit?id=${cate.id}'/>">Sửa</a> | 
                    <a href="<c:url value='/admin/category/delete?id=${cate.id}'/>">Xóa</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>