<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - Device Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: linear-gradient(135deg, #3e2723 0%, #5d4037 40%, #795548 70%, #8d6e63 100%);
            min-height: 100vh;
        }
        .card-login {
            border-radius: 16px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.25);
        }
        .btn-earth {
            background-color: #6f4e37 !important;
            border-color: #6f4e37 !important;
            color: #ffffff !important;
        }
        .btn-earth:hover {
            background-color: #533927 !important;
            border-color: #533927 !important;
            color: #ffffff !important;
        }
        .text-earth {
            color: #6f4e37 !important;
        }
        .text-earth:hover {
            color: #533927 !important;
        }
        .form-check-input:checked {
            background-color: #6f4e37;
            border-color: #6f4e37;
        }
    </style>
</head>
<body class="d-flex align-items-center min-vh-100 py-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-5 col-lg-4">
                <div class="card card-login border-0 p-4 bg-white">
                    <div class="text-center mb-4">
                        <h4 class="fw-bold mb-1" style="color: #4a3525;">DEVICE STORE</h4>
                        <p class="text-muted small">Đăng nhập tài khoản hệ thống</p>
                    </div>

                    <c:if test="${not empty message}">
                        <div class="alert alert-success py-2 small" role="alert">
                            <i class="bi bi-check-circle-fill me-1"></i> ${message}
                        </div>
                    </c:if>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger py-2 small" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-1"></i> ${error}
                        </div>
                    </c:if>

                    <form action="<c:url value='/login'/>" method="post" class="needs-validation" novalidate id="loginForm">
                        <div class="mb-3">
                            <label class="form-label fw-medium small">Tài khoản <span class="text-danger">*</span></label>
                            <div class="input-group has-validation">
                                <span class="input-group-text bg-light border-end-0"><i class="bi bi-person text-muted"></i></span>
                                <input type="text" name="username" class="form-control border-start-0 ps-2" 
                                       placeholder="Nhập tên đăng nhập hoặc email" value="${savedUser}" required minlength="3">
                                <div class="invalid-feedback">
                                    Vui lòng nhập tên đăng nhập hoặc email (tối thiểu 3 ký tự).
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <div class="d-flex justify-content-between align-items-center">
                                <label class="form-label fw-medium small mb-0">Mật khẩu <span class="text-danger">*</span></label>
                                <a href="<c:url value='/forgot-password'/>" class="text-decoration-none small text-earth fw-medium">Quên mật khẩu?</a>
                            </div>
                            <div class="input-group has-validation mt-1">
                                <span class="input-group-text bg-light border-end-0"><i class="bi bi-lock text-muted"></i></span>
                                <input type="password" name="password" class="form-control border-start-0 ps-2" 
                                       placeholder="Nhập mật khẩu" required minlength="3">
                                <div class="invalid-feedback">
                                    Vui lòng nhập mật khẩu.
                                </div>
                            </div>
                        </div>

                        <div class="form-check mb-4">
                            <input class="form-check-input" type="checkbox" name="remember" id="rememberMe" ${not empty savedUser ? 'checked' : ''}>
                            <label class="form-check-label small text-muted" for="rememberMe">
                                Ghi nhớ tài khoản
                            </label>
                        </div>

                        <button type="submit" class="btn btn-earth w-100 py-2 fw-semibold shadow-sm mb-3">
                            Đăng nhập
                        </button>

                        <div class="text-center">
                            <span class="small text-muted">Chưa có tài khoản? </span>
                            <a href="<c:url value='/register'/>" class="small fw-semibold text-decoration-none text-earth">Đăng ký ngay</a>
                        </div>
                        <div class="text-center mt-3">
                            <a href="<c:url value='/home'/>" class="small text-secondary text-decoration-none">
                                <i class="bi bi-arrow-left me-1"></i> Quay về trang chủ cửa hàng
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
    (function () {
      'use strict'
      var forms = document.querySelectorAll('.needs-validation')
      Array.prototype.slice.call(forms).forEach(function (form) {
        form.addEventListener('submit', function (event) {
          if (!form.checkValidity()) {
            event.preventDefault()
            event.stopPropagation()
          }
          form.classList.add('was-validated')
        }, false)
      })
    })()
    </script>
</body>
</html>