<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác thực OTP - Device Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: linear-gradient(135deg, #3e2723 0%, #5d4037 40%, #795548 70%, #8d6e63 100%);
            min-height: 100vh;
        }
        .card-otp {
            border-radius: 16px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.25);
        }
        .otp-input {
            letter-spacing: 12px;
            font-size: 28px;
            font-weight: 700;
            color: #6f4e37 !important;
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
    </style>
</head>
<body class="d-flex align-items-center min-vh-100 py-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-5 col-lg-4">
                <div class="card card-otp border-0 p-4 bg-white text-center">
                    <div class="mb-3">
                        <div class="d-inline-flex p-3 rounded-circle mb-2" style="background-color: #f5ebe0; color: #6f4e37;">
                            <i class="bi bi-shield-check fs-1"></i>
                        </div>
                        <h4 class="fw-bold text-dark mb-1">KÍCH HOẠT TÀI KHOẢN</h4>
                        <p class="text-muted small">
                            Mã xác thực gồm 6 chữ số đã được gửi đến email:<br>
                            <span class="badge bg-light text-earth border mt-1 fs-6">${not empty sessionScope.verifyEmail ? sessionScope.verifyEmail : param.email}</span>
                        </p>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger py-2 small" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-1"></i> ${error}
                        </div>
                    </c:if>

                    <form action="<c:url value='/verify-otp'/>" method="post" class="needs-validation" novalidate>
                        <input type="hidden" name="email" value="${not empty sessionScope.verifyEmail ? sessionScope.verifyEmail : param.email}">
                        <div class="mb-4">
                            <label class="form-label fw-semibold small text-muted">Nhập mã OTP (6 chữ số):</label>
                            <input type="text" name="otp" class="form-control text-center otp-input" 
                                   pattern="[0-9]{6}" inputmode="numeric" maxlength="6" placeholder="------" autofocus required>
                            <div class="invalid-feedback text-start">
                                Vui lòng nhập chính xác mã OTP gồm 6 chữ số!
                            </div>
                        </div>
                        <button type="submit" class="btn btn-earth w-100 py-2 fw-semibold shadow-sm mb-3">
                            <i class="bi bi-check-circle me-1"></i> Kích Hoạt Tài Khoản
                        </button>
                    </form>

                    <div class="pt-2 border-top">
                        <a href="<c:url value='/register'/>" class="small text-muted text-decoration-none me-3">
                            <i class="bi bi-arrow-left"></i> Đăng ký lại
                        </a>
                        <a href="<c:url value='/login'/>" class="small text-earth fw-semibold text-decoration-none">
                            Đăng nhập
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        (() => {
            'use strict';
            const forms = document.querySelectorAll('.needs-validation');
            Array.from(forms).forEach(form => {
                form.addEventListener('submit', event => {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        })();
    </script>
</body>
</html>