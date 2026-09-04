<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${not empty pageTitle ? pageTitle : 'Device Store Admin'}</title>
    
    <!-- Bootstrap 5 CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            min-height: 100vh;
            background-color: #f1f5f9;
        }
        .sidebar {
            min-height: calc(100vh - 56px);
            background-color: #ffffff;
            border-right: 1px solid #e2e8f0;
        }
        .sidebar .nav-link {
            color: #475569;
            font-weight: 500;
            padding: 11px 16px;
            border-radius: 8px;
            margin-bottom: 4px;
            transition: all 0.2s;
        }
        .sidebar .nav-link:hover {
            background-color: #f5ebe0;
            color: #533927;
        }
        .sidebar .nav-link.active {
            background-color: #e6ccb2;
            color: #3e2723;
            font-weight: 700;
        }
        .main-content {
            padding: 30px;
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
        .text-primary, a.text-primary {
            color: #6f4e37 !important;
        }
        .badge.bg-primary {
            background-color: #6f4e37 !important;
        }
    </style>
</head>
<body>

    <!-- Header Navbar Admin -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow-sm">
        <div class="container-fluid px-4">
            <a class="navbar-brand fw-bold d-flex align-items-center" href="<c:url value='/admin/product'/>">
                <span>Device Store</span>
            </a>
            
            <div class="d-flex align-items-center gap-3">
                <a href="<c:url value='/home'/>" class="btn btn-outline-info btn-sm text-white" target="_blank">
                    <i class="bi bi-box-arrow-up-right me-1"></i> Xem Cửa Hàng
                </a>
                <span class="text-light d-flex align-items-center">
                    <img src="${not empty sessionScope.account.images ? pageContext.request.contextPath.concat('/image?fname=').concat(sessionScope.account.images) : 'https://cdn-icons-png.flaticon.com/512/149/149071.png'}" 
                         class="rounded-circle me-2 border border-secondary shadow-sm" style="width: 28px; height: 28px; object-fit: cover;" alt="Avatar">
                    <span>Xin chào, <strong>${not empty sessionScope.account.fullname ? sessionScope.account.fullname : (not empty sessionScope.account.username ? sessionScope.account.username : 'Admin')}</strong></span>
                </span>
                <a href="<c:url value='/logout'/>" class="btn btn-outline-danger btn-sm">
                    <i class="bi bi-box-arrow-right me-1"></i> Đăng xuất
                </a>
            </div>
        </div>
    </nav>

    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar Admin -->
            <nav class="col-md-3 col-lg-2 d-md-block sidebar py-3 collapse show shadow-sm">
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <small class="text-muted text-uppercase fw-bold px-3 d-block mb-2">Quản lý Sản phẩm</small>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/admin/product'/>">
                            <i class="bi bi-boxes me-2 text-primary"></i> Danh sách sản phẩm
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/admin/product/add'/>">
                            <i class="bi bi-plus-circle-dotted me-2 text-success"></i> Thêm sản phẩm mới
                        </a>
                    </li>

                    <li class="nav-item mt-3">
                        <small class="text-muted text-uppercase fw-bold px-3 d-block mb-2">Quản lý Danh mục</small>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/admin/category'/>">
                            <i class="bi bi-grid-fill me-2 text-primary"></i> Danh sách danh mục
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/admin/category/add'/>">
                            <i class="bi bi-plus-circle-fill me-2 text-success"></i> Thêm danh mục
                        </a>
                    </li>

                    <li class="nav-item mt-3">
                        <small class="text-muted text-uppercase fw-bold px-3 d-block mb-2">Tài khoản</small>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/admin/profile'/>">
                            <i class="bi bi-person-badge-fill me-2 text-info"></i> Thông tin cá nhân
                        </a>
                    </li>
                    <hr class="my-3">
                    <li class="nav-item">
                        <a class="nav-link text-danger" href="<c:url value='/logout'/>">
                            <i class="bi bi-power me-2"></i> Đăng xuất
                        </a>
                    </li>
                </ul>
            </nav>

            <!-- Main Content Area -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 main-content">
