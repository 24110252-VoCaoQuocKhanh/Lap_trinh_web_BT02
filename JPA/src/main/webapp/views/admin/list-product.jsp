<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="Quản lý Sản phẩm - Device Store Admin" scope="request"/>
<jsp:include page="/views/admin/header.jsp"/>

    <div class="card shadow-sm border-0 mb-4 rounded-3">
        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
            <h5 class="mb-0 fw-bold text-dark">
                <i class="bi bi-boxes text-primary me-2"></i> Danh Sách Sản Phẩm (Kho Thiết Bị)
            </h5>
            <a href="<c:url value='/admin/product/add'/>" class="btn btn-success btn-sm shadow-sm">
                <i class="bi bi-plus-circle me-1"></i> Thêm Sản Phẩm Mới
            </a>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover table-striped mb-0 align-middle">
                    <thead class="table-dark">
                        <tr>
                            <th class="text-center" width="5%">ID</th>
                            <th class="text-center" width="12%">Hình ảnh</th>
                            <th width="30%">Tên sản phẩm</th>
                            <th width="15%">Danh mục</th>
                            <th width="15%">Giá bán (VND)</th>
                            <th width="13%">Ngày tạo</th>
                            <th class="text-center" width="10%">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${productList}" var="prod">
                            <tr>
                                <td class="text-center fw-bold">${prod.id}</td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${not empty prod.image}">
                                            <img src="<c:url value='/image?fname=${prod.image}'/>" 
                                                 class="img-thumbnail shadow-sm" style="width: 70px; height: 70px; object-fit: cover;" alt="product"/>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-light text-muted border">No image</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <span class="fw-bold text-dark">${prod.name}</span>
                                    <c:if test="${not empty prod.description}">
                                        <small class="text-muted d-block text-truncate" style="max-width: 300px;">
                                            ${prod.description}
                                        </small>
                                    </c:if>
                                </td>
                                <td>
                                    <span class="badge bg-info text-dark">
                                        <i class="bi bi-tag-fill me-1"></i>${not empty prod.category ? prod.category.name : 'Chưa phân loại'}
                                    </span>
                                </td>
                                <td class="fw-bold text-danger">
                                    <fmt:formatNumber value="${prod.price}" pattern="#,###"/> đ
                                </td>
                                <td class="small text-muted">
                                    <fmt:formatDate value="${prod.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                </td>
                                <td class="text-center">
                                    <div class="btn-group btn-group-sm">
                                        <a href="<c:url value='/admin/product/edit?id=${prod.id}'/>" 
                                           class="btn btn-warning text-dark shadow-sm" title="Sửa">
                                            <i class="bi bi-pencil-square"></i>
                                        </a>
                                        <a href="<c:url value='/admin/product/delete?id=${prod.id}'/>" 
                                           class="btn btn-danger shadow-sm" title="Xóa"
                                           onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm: ${prod.name}?');">
                                            <i class="bi bi-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <c:if test="${empty productList}">
                <div class="text-center p-5 text-muted">
                    <i class="bi bi-inbox fs-1"></i>
                    <p class="mt-2">Chưa có sản phẩm nào trong hệ thống!</p>
                    <a href="<c:url value='/admin/product/add'/>" class="btn btn-outline-success btn-sm">Thêm sản phẩm đầu tiên</a>
                </div>
            </c:if>
        </div>
    </div>

<jsp:include page="/views/admin/footer.jsp"/>
