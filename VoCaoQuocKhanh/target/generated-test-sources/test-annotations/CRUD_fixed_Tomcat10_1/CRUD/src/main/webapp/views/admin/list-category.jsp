<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách danh mục</title>
</head>
<body>
    <h2>Danh sách danh mục</h2>

    <p>
        <a href="<c:url value='/admin/category/add' />">Thêm danh mục mới</a>
    </p>

    <table border="1" cellpadding="8" cellspacing="0">
        <tr>
            <th>STT</th>
            <th>Hình ảnh</th>
            <th>Tên danh mục</th>
            <th>Hành động</th>
        </tr>

        <c:choose>
            <c:when test="${empty cateList}">
                <tr>
                    <td colspan="4">Chưa có danh mục.</td>
                </tr>
            </c:when>
            <c:otherwise>
                <c:forEach items="${cateList}" var="cate" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>
                        <td>
                            <c:if test="${not empty cate.icon}">
                                <c:url value="/image" var="imgUrl">
                                    <c:param name="fname" value="${cate.icon}" />
                                </c:url>
                                <img height="150" width="200" src="${imgUrl}" alt="Ảnh danh mục">
                            </c:if>
                        </td>
                        <td><c:out value="${cate.name}" /></td>
                        <td>
                            <a href="<c:url value='/admin/category/edit?id=${cate.id}' />">Sửa</a>
                            |
                            <a href="<c:url value='/admin/category/delete?id=${cate.id}' />"
                               onclick="return confirm('Bạn có chắc muốn xóa danh mục này?');">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </table>
</body>
</html>
