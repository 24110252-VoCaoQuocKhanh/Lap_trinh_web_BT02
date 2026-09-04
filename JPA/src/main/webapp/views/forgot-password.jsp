<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên mật khẩu - Device Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: linear-gradient(135deg, #3e2723 0%, #5d4037 40%, #795548 70%, #8d6e63 100%);
            min-height: 100vh;
        }
        .card-auth {
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
    </style>
</head>
<body class="d-flex align-items-center min-vh-100 py-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-5 col-lg-4">
                <div class="card card-auth border-0 p-4 bg-white text-center">
                    <div class="mb-3">
                        <div class="d-inline-flex p-3 rounded-circle mb-2" style="background-color: #f5ebe0; color: #6f4e37;">
                            <i class="bi bi-key-fill fs-1"></i>
                        </div>
                        <h4 class="fw-bold text-dark mb-1">QUÊN MẬT KHẨU</h4>
                        <p class="text-muted small">
                            Nhập địa chỉ email đăng ký để nhận mã OTP đặt lại mật khẩu
                        </p>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger py-2 small text-start" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-1"></i> ${error}
                        </div>
                    </c:if>

                    <form action="<c:url value='/forgot-password'/>" method="post" class="text-start">
                        <div class="mb-3">
                            <label class="form-label fw-medium small">Email đăng ký tài khoản</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="bi bi-envelope text-muted"></i></span>
                                <input type="email" name="email" class="form-control border-start-0 ps-0" 
                                       placeholder="example@gmail.com" required value="${param.email}">
                            </div>
                        </div>
                        <button type="submit" class="btn btn-earth w-100 py-2 fw-semibold shadow-sm mb-3">
                            <i class="bi bi-send me-1"></i> Gửi Mã OTP Qua Email
                        </button>
                    </form>

                    <div class="pt-2 border-top">
                        <a href="<c:url value='/login'/>" class="small text-muted text-decoration-none me-3">
                            <i class="bi bi-arrow-left"></i> Quay lại đăng nhập
                        </a>
                        <a href="<c:url value='/register'/>" class="small text-earth fw-semibold text-decoration-none">
                            Đăng ký mới
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
