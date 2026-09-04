<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${not empty pageTitle ? pageTitle : 'Device Store - Thiết Bị Công Nghệ Chính Hãng'}</title>

    <!-- Bootstrap 5 CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
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
            color: #8c4a2f;
            font-weight: 700;
            font-size: 1.15rem;
        }

        /* Bảng Màu Phong Thủy Mệnh Thổ (Tone Nâu Đất & Vàng Nâu Pastel) */
        :root {
            --bs-primary: #6f4e37;
            --bs-primary-rgb: 111, 78, 55;
            --bs-link-color: #6f4e37;
            --bs-link-hover-color: #533927;
        }
        .btn-primary, .btn-primary:active, .btn-primary:focus {
            background-color: #6f4e37 !important;
            border-color: #6f4e37 !important;
            color: #ffffff !important;
        }
        .btn-primary:hover {
            background-color: #533927 !important;
            border-color: #533927 !important;
            color: #ffffff !important;
        }
        .btn-outline-primary {
            color: #6f4e37 !important;
            border-color: #6f4e37 !important;
        }
        .btn-outline-primary:hover, .btn-outline-primary:active, .btn-outline-primary:focus {
            background-color: #6f4e37 !important;
            border-color: #6f4e37 !important;
            color: #ffffff !important;
        }
        .bg-primary {
            background-color: #6f4e37 !important;
        }
        .text-primary, a.text-primary, .nav-link.text-primary {
            color: #6f4e37 !important;
        }
        .badge.bg-primary {
            background-color: #6f4e37 !important;
        }
        .page-item.active .page-link {
            background-color: #6f4e37 !important;
            border-color: #6f4e37 !important;
            color: #ffffff !important;
        }
        .page-link {
            color: #6f4e37 !important;
        }
        .page-link:hover {
            color: #533927 !important;
            background-color: #f5ebe0 !important;
        }
        .breadcrumb-item a {
            color: #6f4e37 !important;
        }
        .list-group-item.bg-primary {
            background-color: #6f4e37 !important;
            border-color: #6f4e37 !important;
        }
    </style>
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
                                        <img src="${not empty sessionScope.account.images ? pageContext.request.contextPath.concat('/image?fname=').concat(sessionScope.account.images) : 'https://cdn-icons-png.flaticon.com/512/149/149071.png'}" 
                                             class="rounded-circle me-2 border border-secondary shadow-sm" style="width: 28px; height: 28px; object-fit: cover;" alt="Avatar">
                                        <span>Xin chào, <strong>${not empty sessionScope.account.fullname ? sessionScope.account.fullname : sessionScope.account.username}</strong></span>
                                        <c:if test="${sessionScope.account.role == 1}">
                                            <span class="badge bg-danger ms-2">Admin</span>
                                        </c:if>
                                    </button>
                                    <ul class="dropdown-menu dropdown-menu-end shadow-sm">
                                        <li>
                                            <a class="dropdown-item" href="<c:url value='/profile'/>">
                                                <i class="bi bi-person-badge me-2 text-primary"></i> Thông tin cá nhân
                                            </a>
                                        </li>
                                        <c:if test="${sessionScope.account.role == 1}">
                                            <li>
                                                <a class="dropdown-item fw-bold text-primary" href="<c:url value='/admin/product'/>">
                                                    <i class="bi bi-speedometer2 me-2"></i> Trang quản trị Admin
                                                </a>
                                            </li>
                                        </c:if>
                                        <li><hr class="dropdown-divider"></li>
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

    <!-- Main Content Wrapper -->
    <main class="main-wrapper py-4">
