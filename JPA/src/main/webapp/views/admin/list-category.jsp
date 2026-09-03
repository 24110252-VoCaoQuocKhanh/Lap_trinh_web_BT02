<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Danh sách danh mục</title>
</head>
<body>
    <div class="card shadow-sm border-0 mb-4">
        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
            <h5 class="mb-0 fw-bold"><i class="bi bi-list-ul text-primary"></i> Quản lý danh mục</h5>
            <a href="<c:url value='/admin/category/add'/>" class="btn btn-success btn-sm shadow-sm">
                <i class="bi bi-plus-circle"></i> Thêm mới
            </a>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover table-striped mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th class="text-center" width="5%">STT</th>
                            <th class="text-center" width="20%">Hình ảnh</th>
                            <th>Tên danh mục</th>
                            <th class="text-center" width="25%">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${cateList}" var="cate" varStatus="STT">
                            <tr class="align-middle">
                                <td class="text-center fw-bold">${STT.index+1}</td>
                                <td class="text-center">
                                    <c:if test="${cate.icon != null && cate.icon != ''}">
                                        <img src="<c:url value='/image?fname=${cate.icon}'/>" class="img-thumbnail shadow-sm" style="width: 80px; height: 80px; object-fit: cover;" alt="icon"/>
                                    </c:if>
                                </td>
                                <td class="fw-medium">${cate.name}</td>
                                <td class="text-center">
                                    <a href="<c:url value='/admin/category/edit?id=${cate.id}'/>" class="btn btn-warning btn-sm text-dark shadow-sm">
                                        <i class="bi bi-pencil-square"></i> Sửa
                                    </a> 
                                    <a href="<c:url value='/admin/category/delete?id=${cate.id}'/>" class="btn btn-danger btn-sm shadow-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?');">
                                        <i class="bi bi-trash"></i> Xóa
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            
            <c:if test="${empty cateList}">
                <div class="text-center p-4 text-muted">
                    <i class="bi bi-inbox fs-1"></i>
                    <p class="mt-2">Chưa có danh mục nào!</p>
                </div>
            </c:if>
        </div>
    </div>
</body>
</html>