<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Sửa danh mục</title>
</head>
<body>
    <h2>Chỉnh sửa danh mục</h2>

    <c:if test="${not empty error}">
        <p style="color:red;"><c:out value="${error}" /></p>
    </c:if>

    <c:url value="/admin/category/edit" var="editUrl" />

    <form action="${editUrl}" method="post" enctype="multipart/form-data">
        <input name="id" value="${category.id}" type="hidden">

        <div>
            <label for="name">Tên danh mục:</label>
            <input id="name" type="text" value="${category.name}" name="name" required>
        </div>
        <br>

        <div>
            <c:if test="${not empty category.icon}">
                <c:url value="/image" var="imgUrl">
                    <c:param name="fname" value="${category.icon}" />
                </c:url>
                <img width="150" src="${imgUrl}" alt="Ảnh danh mục">
                <br><br>
            </c:if>

            <label for="icon">Ảnh đại diện mới:</label>
            <input id="icon" type="file" name="icon" accept="image/*">
        </div>
        <br>

        <button type="submit">Lưu</button>
        <button type="reset">Reset</button>
    </form>

    <p>
        <a href="<c:url value='/admin/category/list' />">Quay lại danh sách</a>
    </p>
</body>
</html>
