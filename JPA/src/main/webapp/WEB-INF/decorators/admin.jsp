<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property='title'/> - Quản Trị Hệ Thống</title>
    
    <!-- Bootstrap 5 CSS & Icons qua CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <style>
        body {
            min-height: 100vh;
            background-color: #f8f9fa;
        }
        .sidebar {
            min-height: calc(100vh - 56px);
            background-color: #ffffff;
            border-right: 1px solid #dee2e6;
        }
        .sidebar .nav-link {
            color: #333;
            font-weight: 500;
            padding: 10px 15px;
            border-radius: 6px;
            margin-bottom: 4px;
        }
        .sidebar .nav-link:hover {
            background-color: #e9ecef;
            color: #0d6efd;
        }
        .main-content {
            padding: 25px;
        }
    </style>
    
    <!-- Nhúng CSS/thẻ bổ sung từ các trang con (nếu có) -->
    <sitemesh:write property='head'/>
</head>
<body>

    <!-- Header Navbar trên cùng -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow-sm">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold" href="<c:url value='/admin/category'/>">
                <i class="bi bi-shield-lock-fill text-primary"></i> ADMIN PANEL
            </a>
            
            <div class="d-flex align-items-center">
                <span class="text-light me-3">
                    <i class="bi bi-person-circle"></i> 
                    Xin chào, <strong>${not empty sessionScope.account ? sessionScope.account.username : 'Quản trị viên'}</strong>
                </span>
                <a href="<c:url value='/logout'/>" class="btn btn-outline-danger btn-sm">
                    <i class="bi bi-box-arrow-right"></i> Đăng xuất
                </a>
            </div>
        </div>
    </nav>

    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar bên trái -->
            <nav class="col-md-3 col-lg-2 d-md-block sidebar py-3 collapse show">
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/admin/category'/>">
                            <i class="bi bi-grid-fill me-2 text-primary"></i> Quản lý danh mục
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/admin/category/add'/>">
                            <i class="bi bi-plus-circle-fill me-2 text-success"></i> Thêm danh mục
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/admin/profile'/>">
                            <i class="bi bi-person-badge-fill me-2 text-info"></i> Thông tin cá nhân
                        </a>
                    </li>
                    <hr class="my-2">
                    <li class="nav-item">
                        <a class="nav-link text-danger" href="<c:url value='/logout'/>">
                            <i class="bi bi-power me-2"></i> Đăng xuất
                        </a>
                    </li>
                </ul>
            </nav>


            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 main-content">
                <sitemesh:write property='body'/>
            </main>
        </div>
    </div>

    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>