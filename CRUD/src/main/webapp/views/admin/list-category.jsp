<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<body>
    <h2>Danh sách danh mục</h2>
    <a href="<c:url value='/admin/category/add'/>">Thêm danh mục mới</a>
    <table border="1">
        <tr>
            <th>STT</th>
            <th>Hình ảnh</th>
            <th>Tên danh mục</th>
            <th>Hành động</th>
        </tr>
        <c:forEach items="${cateList}" var="cate" varStatus="STT">
            <tr class="odd gradeX">
                <td>${STT.index+1}</td>
                <c:url value="/image?fname=${cate.icon}" var="imgUrl"></c:url>
                <td><img height="150" width="200" src="${imgUrl}" /></td>
                <td>${cate.name}</td>
                <td>
                    <a href="<c:url value='/admin/category/edit?id=${cate.id}'/>" class="center">Sửa</a> | 
                    <a href="<c:url value='/admin/category/delete?id=${cate.id}'/>" class="center">Xóa</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>