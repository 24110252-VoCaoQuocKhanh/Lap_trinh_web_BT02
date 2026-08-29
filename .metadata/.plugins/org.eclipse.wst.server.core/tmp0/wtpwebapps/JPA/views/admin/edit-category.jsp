<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<body>
    <h2>Chỉnh sửa danh mục</h2>
    <form action="<c:url value='/admin/category/edit'/>" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${category.id}">
        <div>
            <label>Tên danh mục:</label> 
            <input type="text" name="name" value="${category.name}" required />
        </div><br>
        <div>
            <label>Ảnh hiện tại:</label><br>
            <img height="100" src="<c:url value='/image?fname=${category.icon}'/>" alt="icon" /><br><br>
            <label>Tải lên ảnh mới (Bỏ trống nếu giữ nguyên):</label> 
            <input type="file" name="icon" />
        </div><br>
        <button type="submit">Cập nhật</button>
        <a href="<c:url value='/admin/category'/>"><button type="button">Hủy</button></a>
    </form>
</body>
</html>