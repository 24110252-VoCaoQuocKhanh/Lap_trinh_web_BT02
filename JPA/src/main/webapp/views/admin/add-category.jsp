<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<body>
    <h2>Thêm danh mục mới</h2>
    <form action="<c:url value='/admin/category/add'/>" method="post" enctype="multipart/form-data">
        <div>
            <label>Tên danh mục:</label> 
            <input type="text" name="name" required />
        </div><br>
        <div>
            <label>Ảnh đại diện:</label> 
            <input type="file" name="icon" />
        </div><br>
        <button type="submit">Thêm mới</button>
        <button type="reset">Hủy</button>
    </form>
</body>
</html>