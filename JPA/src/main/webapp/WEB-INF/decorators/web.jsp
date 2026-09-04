<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property='title'/> - Device Store</title>

    <!-- Bootstrap 5 CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --ds-primary: #0d6efd;
            --ds-dark: #1e293b;
            --ds-accent: #f59e0b;
        }
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f8fafc;
            color: #334155;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .navbar-brand {
            font-weight: 800;
            letter-spacing: -0.5px;
            font-size: 1.4rem;
        }
        .main-wrapper {
            flex: 1;
        }
        .footer {
            background-color: #0f172a;
            color: #94a3b8;
        }
        .product-card {
            transition: all 0.25s ease-in-out;
            border-radius: 12px;
            overflow: hidden;
            background: #fff;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.08) !important;
        }
        .price-tag {
            color: #dc2626;
            font-weight: 700;
            font-size: 1.15rem;
        }
        .badge-brand {
            background: linear-gradient(135deg, #0d6efd, #0b5ed7);
        }
    </style>
    <sitemesh:write property='head'/>
</head>
<body>

    <!-- Header Navigation - Device Store -->
    <header class="sticky-top shadow-sm">
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark py-3">
            <div class="container">
                <a class="navbar-brand text-white d-flex align-items-center" href="<c:url value='/home'/>">
                    <span>Device Store</span>
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
                    <span class="navbar-toggler-indicator"><i class="bi bi-list text-white fs-2"></i></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-3">
                        <li class="nav-item">
                            <a class="nav-link text-white-50 px-3 fw-medium" href="<c:url value='/home'/>">
                                <i class="bi bi-house-door me-1"></i> Trang chủ
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white-50 px-3 fw-medium" href="<c:url value='/product'/>">
                                <i class="bi bi-grid me-1"></i> Tất cả sản phẩm
                            </a>
                        </li>
                    </ul>

                    <!-- Thanh tìm kiếm nhanh -->
                    <form class="d-flex me-lg-3 my-2 my-lg-0" action="<c:url value='/product'/>" method="get">
                        <div class="input-group">
                            <input class="form-control form-control-sm border-0 bg-light" type="search" name="kw" 
                                   placeholder="Tìm kiếm thiết bị..." value="${param.kw}">
                            <button class="btn btn-primary btn-sm px-3" type="submit">
                                <i class="bi bi-search"></i>
                            </button>
                        </div>
                    </form>

                    <!-- Khu vực người dùng / Đăng nhập -->
                    <div class="d-flex align-items-center gap-2">
                        <c:choose>
                            <c:when test="${not empty sessionScope.account}">
                                <div class="dropdown">
                                    <button class="btn btn-outline-light btn-sm dropdown-toggle d-flex align-items-center" 
                                            type="button" data-bs-toggle="dropdown">
                                        <i class="bi bi-person-circle me-2"></i>
                                        <span>${not empty sessionScope.account.fullname ? sessionScope.account.fullname : sessionScope.account.username}</span>
                                        <c:if test="${sessionScope.account.role == 1}">
                                            <span class="badge bg-danger ms-2">Admin</span>
                                        </c:if>
                                    </button>
                                    <ul class="dropdown-menu dropdown-menu-end shadow-sm">
                                        <c:if test="${sessionScope.account.role == 1}">
                                            <li>
                                                <a class="dropdown-item fw-bold text-primary" href="<c:url value='/admin/product'/>">
                                                    <i class="bi bi-speedometer2 me-2"></i> Trang quản trị Admin
                                                </a>
                                            </li>
                                            <li><hr class="dropdown-divider"></li>
                                        </c:if>
                                        <li>
                                            <a class="dropdown-item text-danger" href="<c:url value='/logout'/>">
                                                <i class="bi bi-box-arrow-right me-2"></i> Đăng xuất
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <a href="<c:url value='/login'/>" class="btn btn-outline-light btn-sm px-3">
                                    <i class="bi bi-box-arrow-in-right me-1"></i> Đăng nhập
                                </a>
                                <a href="<c:url value='/register'/>" class="btn btn-primary btn-sm px-3 shadow-sm">
                                    <i class="bi bi-person-plus me-1"></i> Đăng ký
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </nav>
    </header>

    <!-- Main Content -->
    <main class="main-wrapper py-4">
        <sitemesh:write property='body'/>
    </main>

    <!-- Footer - Device Store -->
    <footer class="footer pt-4 pb-3 mt-auto">
        <div class="container">
            <div class="row align-items-center py-3">
                <div class="col-md-6 mb-3 mb-md-0">
                    <h4 class="text-white fw-bold mb-0">Device Store</h4>
                </div>
                <div class="col-md-6 text-md-end">
                    <ul class="list-inline mb-0 small">
                        <li class="list-inline-item me-3"><a href="#" class="text-white-50 text-decoration-none">Chính sách bảo hành</a></li>
                        <li class="list-inline-item me-3"><a href="#" class="text-white-50 text-decoration-none">Chính sách đổi trả</a></li>
                        <li class="list-inline-item"><a href="#" class="text-white-50 text-decoration-none">Giao hàng toàn quốc</a></li>
                    </ul>
                </div>
            </div>
            <hr class="border-secondary my-3">
            <div class="text-center small text-white-50">
                &copy; 2026 <strong>Device Store</strong>. All rights reserved. Phát triển trên nền tảng JPA &amp; Hibernate MVC.
            </div>
        </div>
    </footer>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
