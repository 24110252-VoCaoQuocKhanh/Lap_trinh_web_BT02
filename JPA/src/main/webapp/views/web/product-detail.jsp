<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>${product.name} - Chi Tiết Thiết Bị</title>
</head>
<body>
    <div class="container my-4">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb" class="mb-4">
            <ol class="breadcrumb small">
                <li class="breadcrumb-item"><a href="<c:url value='/home'/>" class="text-decoration-none">Trang chủ</a></li>
                <li class="breadcrumb-item"><a href="<c:url value='/product'/>" class="text-decoration-none">Sản phẩm</a></li>
                <c:if test="${not empty product.category}">
                    <li class="breadcrumb-item">
                        <a href="<c:url value='/product?cid=${product.category.id}'/>" class="text-decoration-none">
                            ${product.category.name}
                        </a>
                    </li>
                </c:if>
                <li class="breadcrumb-item active text-truncate" style="max-width: 300px;" aria-current="page">${product.name}</li>
            </ol>
        </nav>

        <!-- Product Main Detail Card -->
        <div class="card border-0 shadow-sm rounded-4 p-4 p-lg-5 mb-5 bg-white">
            <div class="row g-5 align-items-center">
                <!-- Cột Hình ảnh lớn -->
                <div class="col-lg-5 text-center">
                    <div class="bg-light rounded-4 p-4 border d-flex align-items-center justify-content-center" style="min-height: 380px;">
                        <c:choose>
                            <c:when test="${not empty product.image}">
                                <img src="<c:url value='/image?fname=${product.image}'/>" 
                                     class="img-fluid rounded-3 shadow-sm" style="max-height: 350px; object-fit: contain;" alt="${product.name}">
                            </c:when>
                            <c:otherwise>
                                <div class="text-muted text-center py-5">
                                    <i class="bi bi-image display-1"></i>
                                    <p class="mt-2">Chưa có ảnh thiết bị</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Cột Thông tin chi tiết -->
                <div class="col-lg-7">
                    <c:if test="${not empty product.category}">
                        <span class="badge bg-primary px-3 py-2 rounded-pill mb-2">
                            <i class="bi bi-tag-fill me-1"></i> ${product.category.name}
                        </span>
                    </c:if>

                    <h2 class="fw-bold text-dark mb-3">${product.name}</h2>

                    <!-- Giá bán nổi bật đơn vị VND -->
                    <div class="p-3 bg-light rounded-3 mb-4 d-inline-block border">
                        <span class="text-muted small d-block">Giá bán chính hãng tại Device Store:</span>
                        <span class="display-6 fw-bold text-danger">
                            <fmt:formatNumber value="${product.price}" pattern="#,###"/> đ
                        </span>
                        <span class="badge bg-success ms-2">Còn hàng</span>
                    </div>

                    <div class="mb-4">
                        <h6 class="fw-bold text-dark mb-2"><i class="bi bi-info-circle me-1 text-primary"></i> Mô tả sản phẩm:</h6>
                        <div class="text-secondary lh-lg" style="white-space: pre-line;">
                            <c:choose>
                                <c:when test="${not empty product.description}">
                                    ${product.description}
                                </c:when>
                                <c:otherwise>
                                    <span class="text-muted fst-italic">Đang cập nhật thông số kỹ thuật và mô tả chi tiết cho sản phẩm này.</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <ul class="list-unstyled small text-muted mb-4 border-top pt-3">
                        <li class="mb-2"><i class="bi bi-calendar-event me-2 text-primary"></i> Ngày cập nhật: 
                            <fmt:formatDate value="${product.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                        </li>
                        <li class="mb-2"><i class="bi bi-shield-check me-2 text-success"></i> Bảo hành chính hãng 12 tháng tại các trung tâm uỷ quyền</li>
                        <li class="mb-2"><i class="bi bi-arrow-repeat me-2 text-warning"></i> 1 đổi 1 trong 30 ngày nếu có lỗi phần cứng</li>
                    </ul>

                    <div class="d-flex gap-3">
                        <a href="<c:url value='/product'/>" class="btn btn-outline-secondary px-4 py-2">
                            <i class="bi bi-arrow-left me-1"></i> Quay lại kho sản phẩm
                        </a>
                        <a href="<c:url value='/home'/>" class="btn btn-primary px-4 py-2 shadow-sm">
                            <i class="bi bi-house-door me-1"></i> Về trang chủ
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Sản phẩm liên quan / cùng danh mục -->
        <c:if test="${not empty relatedProducts}">
            <div class="mb-5">
                <h4 class="fw-bold mb-4 text-dark"><i class="bi bi-collection me-2 text-primary"></i> Thiết bị cùng danh mục</h4>
                <div class="row g-4">
                    <c:forEach items="${relatedProducts}" var="rel" begin="0" end="3">
                        <c:if test="${rel.id != product.id}">
                            <div class="col-6 col-md-3">
                                <div class="card h-100 border-0 shadow-sm product-card">
                                    <a href="<c:url value='/product/detail?id=${rel.id}'/>" class="text-decoration-none">
                                        <div class="bg-light text-center p-3" style="height: 160px; display: flex; align-items: center; justify-content: center;">
                                            <c:choose>
                                                <c:when test="${not empty rel.image}">
                                                    <img src="<c:url value='/image?fname=${rel.image}'/>" class="img-fluid" 
                                                         style="max-height: 140px; object-fit: contain;" alt="${rel.name}">
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="bi bi-image text-muted fs-1"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </a>
                                    <div class="card-body p-3 d-flex flex-column">
                                        <h6 class="card-title fw-bold text-truncate mb-2">
                                            <a href="<c:url value='/product/detail?id=${rel.id}'/>" class="text-dark text-decoration-none">
                                                ${rel.name}
                                            </a>
                                        </h6>
                                        <div class="price-tag small mb-2">
                                            <fmt:formatNumber value="${rel.price}" pattern="#,###"/> đ
                                        </div>
                                        <a href="<c:url value='/product/detail?id=${rel.id}'/>" class="btn btn-outline-primary btn-sm mt-auto">
                                            Xem chi tiết
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </c:if>
    </div>
</body>
</html>
