<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Kho Thiết Bị - Device Store</title>
</head>
<body>
    <div class="container my-3">
        <!-- Breadcrumb & Header -->
        <nav aria-label="breadcrumb" class="mb-3">
            <ol class="breadcrumb small">
                <li class="breadcrumb-item"><a href="<c:url value='/home'/>" class="text-decoration-none">Trang chủ</a></li>
                <li class="breadcrumb-item active" aria-current="page">Tất cả sản phẩm</li>
            </ol>
        </nav>

        <div class="row g-4">
            <!-- Sidebar Lọc Danh Mục -->
            <div class="col-lg-3">
                <div class="card border-0 shadow-sm p-3 mb-4 rounded-3">
                    <h6 class="fw-bold mb-3 text-dark d-flex align-items-center">
                        <i class="bi bi-funnel-fill text-primary me-2"></i> Lọc Theo Danh Mục
                    </h6>
                    <div class="list-group list-group-flush">
                        <a href="<c:url value='/product'><c:if test='${not empty keyword}'><c:param name='kw' value='${keyword}'/></c:if></c:url>" 
                           class="list-group-item list-group-item-action d-flex justify-content-between align-items-center border-0 px-2 py-2 rounded ${empty selectedCid ? 'bg-primary text-white fw-bold' : ''}">
                            <span><i class="bi bi-circle-fill me-2" style="font-size: 8px;"></i> Tất cả danh mục</span>
                        </a>
                        <c:forEach items="${categoryList}" var="cat">
                            <a href="<c:url value='/product'><c:param name='cid' value='${cat.id}'/><c:if test='${not empty keyword}'><c:param name='kw' value='${keyword}'/></c:if></c:url>" 
                               class="list-group-item list-group-item-action d-flex justify-content-between align-items-center border-0 px-2 py-2 rounded ${selectedCid == cat.id ? 'bg-primary text-white fw-bold' : ''}">
                                <span>
                                    <c:choose>
                                        <c:when test="${not empty cat.icon}">
                                            <img src="<c:url value='/image?fname=${cat.icon}'/>" style="width: 18px; height: 18px; object-fit: contain;" class="me-2"/>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="bi bi-tag me-2"></i>
                                        </c:otherwise>
                                    </c:choose>
                                    ${cat.name}
                                </span>
                            </a>
                        </c:forEach>
                    </div>
                </div>

                <!-- Banner nhỏ quảng cáo -->
                <div class="card border-0 shadow-sm p-4 text-white rounded-3 d-none d-lg-block" style="background: linear-gradient(135deg, #4a3525, #6f4e37);">
                    <h6 class="fw-bold mb-2" style="color: #e6ccb2;"><i class="bi bi-shield-check"></i> Bảo Hành 12 Tháng</h6>
                    <p class="small text-white-50 mb-0">Mọi thiết bị mua tại Device Store đều được hưởng chính sách bảo hành chính hãng và hỗ trợ đổi mới.</p>
                </div>
            </div>

            <!-- Danh Sách Sản Phẩm (6 SP/Trang) -->
            <div class="col-lg-9">
                <!-- Thanh công cụ tìm kiếm và thông tin kết quả -->
                <div class="card border-0 shadow-sm p-3 mb-4 rounded-3 bg-white">
                    <div class="row align-items-center g-2">
                        <div class="col-md-6">
                            <h5 class="fw-bold mb-0 text-dark">
                                Kho Thiết Bị Công Nghệ
                                <span class="badge bg-light text-muted border fw-normal fs-6 ms-1">${totalCount} sản phẩm</span>
                            </h5>
                        </div>
                        <div class="col-md-6">
                            <form action="<c:url value='/product'/>" method="get" class="d-flex">
                                <c:if test="${not empty selectedCid}">
                                    <input type="hidden" name="cid" value="${selectedCid}">
                                </c:if>
                                <div class="input-group">
                                    <input type="text" name="kw" class="form-control form-control-sm" 
                                           placeholder="Tìm theo tên thiết bị..." value="${keyword}">
                                    <button class="btn btn-primary btn-sm px-3" type="submit">
                                        <i class="bi bi-search me-1"></i> Tìm
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <c:if test="${not empty keyword || not empty selectedCid}">
                        <div class="mt-2 pt-2 border-top d-flex align-items-center gap-2 small">
                            <span class="text-muted">Đang lọc:</span>
                            <c:if test="${not empty keyword}">
                                <span class="badge" style="background-color: #e6ccb2; color: #3e2723;">Từ khóa: "${keyword}"</span>
                            </c:if>
                            <c:if test="${not empty selectedCid}">
                                <span class="badge bg-secondary">Mã danh mục: ${selectedCid}</span>
                            </c:if>
                            <a href="<c:url value='/product'/>" class="text-danger text-decoration-none ms-auto fw-semibold">
                                <i class="bi bi-x-circle"></i> Xóa bộ lọc
                            </a>
                        </div>
                    </c:if>
                </div>

                <!-- Grid hiển thị sản phẩm -->
                <div class="row g-4">
                    <c:forEach items="${productList}" var="prod">
                        <div class="col-md-6 col-lg-4">
                            <div class="card h-100 border-0 shadow-sm product-card">
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
                                        <a href="<c:url value='/product/detail?id=${prod.id}'/>" class="text-dark text-decoration-none">
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
                    <c:if test="${empty productList}">
                        <div class="col-12 text-center py-5">
                            <div class="p-5 bg-white rounded-3 shadow-sm">
                                <i class="bi bi-search fs-1 text-muted"></i>
                                <h6 class="mt-3 fw-bold text-dark">Không tìm thấy sản phẩm phù hợp</h6>
                                <p class="text-muted small">Hãy thử tìm kiếm bằng từ khóa khác hoặc chọn danh mục khác.</p>
                                <a href="<c:url value='/product'/>" class="btn btn-outline-primary btn-sm">Xem tất cả sản phẩm</a>
                            </div>
                        </div>
                    </c:if>
                </div>

                <!-- Phân Trang (6 Sản Phẩm/Trang) -->
                <c:if test="${totalPages > 1}">
                    <nav aria-label="Product pagination" class="mt-4">
                        <ul class="pagination justify-content-center">
                            <!-- Previous -->
                            <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                                <a class="page-link" href="<c:url value='/product'><c:param name='page' value='${currentPage - 1}'/><c:if test='${not empty keyword}'><c:param name='kw' value='${keyword}'/></c:if><c:if test='${not empty selectedCid}'><c:param name='cid' value='${selectedCid}'/></c:if></c:url>">
                                    <i class="bi bi-chevron-left"></i> Trước
                                </a>
                            </li>

                            <!-- Số trang -->
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link" href="<c:url value='/product'><c:param name='page' value='${i}'/><c:if test='${not empty keyword}'><c:param name='kw' value='${keyword}'/></c:if><c:if test='${not empty selectedCid}'><c:param name='cid' value='${selectedCid}'/></c:if></c:url>">
                                        ${i}
                                    </a>
                                </li>
                            </c:forEach>

                            <!-- Next -->
                            <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="<c:url value='/product'><c:param name='page' value='${currentPage + 1}'/><c:if test='${not empty keyword}'><c:param name='kw' value='${keyword}'/></c:if><c:if test='${not empty selectedCid}'><c:param name='cid' value='${selectedCid}'/></c:if></c:url>">
                                    Sau <i class="bi bi-chevron-right"></i>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </c:if>

            </div>
        </div>
    </div>
</body>
</html>
