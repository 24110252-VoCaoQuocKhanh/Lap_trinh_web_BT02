<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Trang chủ - Device Store</title>
</head>
<body>

    <!-- Hero Banner (Mệnh Thổ Palette) -->
    <div class="container mb-4">
        <div class="p-4 p-md-5 text-white rounded-4 shadow-sm" style="background: linear-gradient(135deg, #4a3525 0%, #6f4e37 40%, #8c6849 70%, #b08968 100%);">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <div class="mb-4">
                        <span class="badge px-3 py-2 rounded-pill shadow-sm" style="background-color: #e6ccb2; color: #3e2723; font-weight: 700; font-size: 0.95rem;">
                            Chào mừng đến với Device Store
                        </span>
                    </div>
                    <div class="d-flex gap-3">
                        <a href="<c:url value='/product'/>" class="btn btn-lg px-4 shadow-sm" style="background-color: #d4a373; border-color: #d4a373; color: #2b1704; font-weight: 700;">
                            <i class="bi bi-bag-check me-2"></i> Mua sắm ngay
                        </a>
                        <a href="#top-products" class="btn btn-outline-light btn-lg px-4 fw-semibold">
                            Xem sản phẩm mới
                        </a>
                    </div>
                </div>
                <div class="col-lg-4 text-center d-none d-lg-block">
                    <i class="bi bi-laptop display-1" style="font-size: 6.5rem; color: #f5ebe0; opacity: 0.85;"></i>
                </div>
            </div>
        </div>
    </div>

    <!-- Danh mục nổi bật -->
    <c:if test="${not empty categoryList}">
        <div class="container mb-5">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h4 class="fw-bold mb-0 text-dark">
                    <i class="bi bi-grid-fill text-primary me-2"></i> Danh Mục Thiết Bị
                </h4>
                <a href="<c:url value='/product'/>" class="text-primary text-decoration-none small fw-semibold">
                    Xem tất cả <i class="bi bi-arrow-right"></i>
                </a>
            </div>
            <div class="row g-3">
                <c:forEach items="${categoryList}" var="c">
                    <div class="col-6 col-md-4 col-lg-2">
                        <a href="<c:url value='/product?cid=${c.id}'/>" class="text-decoration-none">
                            <div class="card h-100 border-0 shadow-sm text-center p-3 product-card">
                                <c:choose>
                                    <c:when test="${not empty c.icon}">
                                        <img src="<c:url value='/image?fname=${c.icon}'/>" class="mx-auto mb-2" 
                                             style="width: 48px; height: 48px; object-fit: contain;" alt="${c.name}"/>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="mx-auto mb-2 d-flex align-items-center justify-content-center bg-light rounded-circle" style="width: 48px; height: 48px;">
                                            <i class="bi bi-folder text-primary fs-4"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                                <span class="small fw-bold text-dark text-truncate">${c.name}</span>
                            </div>
                        </a>
                    </div>
                </c:forEach>
            </div>
        </div>
    </c:if>

    <!-- Top 10 Sản phẩm mới nhất -->
    <div class="container mb-5" id="top-products">
        <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-2">
            <div>
                <span class="badge bg-danger mb-1"><i class="bi bi-fire"></i> Mới cập nhật</span>
                <h3 class="fw-bold mb-0 text-dark">10 SẢN PHẨM MỚI NHẤT</h3>
            </div>
            <a href="<c:url value='/product'/>" class="btn btn-outline-primary btn-sm fw-semibold">
                Xem toàn bộ kho hàng <i class="bi bi-chevron-right"></i>
            </a>
        </div>

        <div class="row g-4">
            <c:forEach items="${top10Products}" var="prod" varStatus="loop">
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="card h-100 border-0 shadow-sm product-card position-relative">
                        <span class="position-absolute top-0 start-0 m-2 badge bg-danger shadow-sm">
                            Mới #${loop.index + 1}
                        </span>

                        <a href="<c:url value='/product/detail?id=${prod.id}'/>" class="text-decoration-none text-dark d-block">
                            <div class="bg-light text-center p-3" style="height: 200px; display: flex; align-items: center; justify-content: center;">
                                <c:choose>
                                    <c:when test="${not empty prod.image}">
                                        <img src="<c:url value='/image?fname=${prod.image}'/>" class="img-fluid" 
                                             style="max-height: 180px; object-fit: contain;" alt="${prod.name}">
                                    </c:when>
                                    <c:otherwise>
                                        <i class="bi bi-image text-muted display-4"></i>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </a>

                        <div class="card-body d-flex flex-column p-3">
                            <c:if test="${not empty prod.category}">
                                <div class="small text-muted mb-1">
                                    <i class="bi bi-tag-fill me-1 text-primary"></i>${prod.category.name}
                                </div>
                            </c:if>
                            <h6 class="card-title fw-bold mb-2 text-truncate">
                                <a href="<c:url value='/product/detail?id=${prod.id}'/>" class="text-dark text-decoration-none hover-primary">
                                    ${prod.name}
                                </a>
                            </h6>

                            <div class="mt-auto">
                                <div class="price-tag mb-3">
                                    <fmt:formatNumber value="${prod.price}" pattern="#,###"/> đ
                                </div>
                                <a href="<c:url value='/product/detail?id=${prod.id}'/>" class="btn btn-outline-primary btn-sm w-100 fw-medium">
                                    <i class="bi bi-eye me-1"></i> Xem chi tiết
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty top10Products}">
                <div class="col-12 text-center py-5 text-muted">
                    <i class="bi bi-inbox fs-1"></i>
                    <p class="mt-2">Chưa có sản phẩm nào trong hệ thống!</p>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Dịch vụ & Cam kết -->
    <div class="container mb-4">
        <div class="row g-4 text-center">
            <div class="col-md-3">
                <div class="p-4 bg-white rounded-3 shadow-sm h-100">
                    <i class="bi bi-shield-check text-success fs-1 mb-2"></i>
                    <h6 class="fw-bold">100% Chính Hãng</h6>
                    <p class="small text-muted mb-0">Cam kết nguồn gốc xuất xứ rõ ràng cho mọi thiết bị.</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="p-4 bg-white rounded-3 shadow-sm h-100">
                    <i class="bi bi-truck text-primary fs-1 mb-2"></i>
                    <h6 class="fw-bold">Giao Hàng Miễn Phí</h6>
                    <p class="small text-muted mb-0">Giao hàng nhanh chóng và an toàn trên toàn quốc.</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="p-4 bg-white rounded-3 shadow-sm h-100">
                    <i class="bi bi-arrow-repeat text-warning fs-1 mb-2"></i>
                    <h6 class="fw-bold">Đổi Trả Trong 30 Ngày</h6>
                    <p class="small text-muted mb-0">Lỗi 1 đổi 1 nhanh chóng nếu phát hiện lỗi từ NSX.</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="p-4 bg-white rounded-3 shadow-sm h-100">
                    <i class="bi bi-headset text-danger fs-1 mb-2"></i>
                    <h6 class="fw-bold">Hỗ Trợ 24/7</h6>
                    <p class="small text-muted mb-0">Tư vấn kỹ thuật tận tình, chu đáo mọi lúc mọi nơi.</p>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
