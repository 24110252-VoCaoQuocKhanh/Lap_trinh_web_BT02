<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm danh mục</title>
</head>
<body>
    <h2>Thêm danh mục mới</h2>

    <% if (request.getAttribute("error") != null) { %>
        <p style="color:red;"><%= request.getAttribute("error") %></p>
    <% } %>

    <form action="<%= request.getContextPath() %>/admin/category/add"
          method="post"
          enctype="multipart/form-data">
        <div>
            <label for="name">Tên danh mục:</label>
            <input id="name" type="text" name="name" required>
        </div>
        <br>
        <div>
            <label for="icon">Ảnh đại diện:</label>
            <input id="icon" type="file" name="icon" accept="image/*">
        </div>
        <br>
        <button type="submit">Thêm</button>
        <button type="reset">Hủy</button>
    </form>

    <p>
        <a href="<%= request.getContextPath() %>/admin/category/list">Quay lại danh sách</a>
    </p>
</body>
</html>
