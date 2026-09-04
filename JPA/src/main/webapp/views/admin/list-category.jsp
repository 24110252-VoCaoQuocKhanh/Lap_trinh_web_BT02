<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Quản lý Danh mục - Device Store Admin" scope="request"/>
<jsp:include page="/views/admin/header.jsp"/>

    <div class="card shadow-sm border-0 mb-4 rounded-3">
        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
            <h5 class="mb-0 fw-bold text-dark"><i class="bi bi-grid-fill text-primary me-2"></i> Danh Sách Danh Mục Thiết Bị</h5>
            <a href="<c:url value='/admin/category/add'/>" class="btn btn-success btn-sm shadow-sm">
                <i class="bi bi-plus-circle me-1"></i> Thêm Danh Mục Mới
            </a>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover table-striped mb-0 align-middle">
                    <thead class="table-dark">
                        <tr>
                            <th class="text-center" width="8%">STT</th>
                            <th class="text-center" width="20%">Biểu tượng</th>
                            <th>Tên danh mục</th>
                            <th class="text-center" width="25%">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${cateList}" var="cate" varStatus="STT">
                            <tr>
                                <td class="text-center fw-bold">${STT.index+1}</td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${not empty cate.icon}">
                                            <img src="<c:url value='/image?fname=${cate.icon}'/>" class="img-thumbnail shadow-sm" style="width: 70px; height: 70px; object-fit: contain;" alt="icon"/>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-light text-muted border">No icon</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="fw-semibold text-dark fs-6">${cate.name}</td>
                                <td class="text-center">
                                    <div class="btn-group btn-group-sm">
                                        <a href="<c:url value='/admin/category/edit?id=${cate.id}'/>" class="btn btn-warning text-dark shadow-sm" title="Sửa">
                                            <i class="bi bi-pencil-square"></i> Sửa
                                        </a> 
                                        <a href="<c:url value='/admin/category/delete?id=${cate.id}'/>" class="btn btn-danger shadow-sm" title="Xóa"
                                           onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục: ${cate.name}?');">
                                            <i class="bi bi-trash"></i> Xóa
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            
            <c:if test="${empty cateList}">
                <div class="text-center p-5 text-muted">
                    <i class="bi bi-inbox fs-1"></i>
                    <p class="mt-2">Chưa có danh mục nào trong hệ thống!</p>
                    <a href="<c:url value='/admin/category/add'/>" class="btn btn-outline-success btn-sm">Thêm danh mục đầu tiên</a>
                </div>
            </c:if>
        </div>
    </div>

<jsp:include page="/views/admin/footer.jsp"/>