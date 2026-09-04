<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký tài khoản - Device Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: linear-gradient(135deg, #3e2723 0%, #5d4037 40%, #795548 70%, #8d6e63 100%);
            min-height: 100vh;
        }
        .card-register {
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
            <div class="col-md-6 col-lg-5">
                <div class="card card-register border-0 p-4 bg-white">
                    <div class="text-center mb-4">
                        <div class="d-inline-flex p-3 rounded-circle bg-success bg-opacity-10 text-success mb-2">
                            <i class="bi bi-person-plus-fill fs-1"></i>
                        </div>
                        <h4 class="fw-bold text-dark mb-1">TẠO TÀI KHOẢN MỚI</h4>
                        <p class="text-muted small">Đăng ký thành viên Device Store để trải nghiệm dịch vụ</p>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger py-2 small" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-1"></i> ${error}
                        </div>
                    </c:if>

                    <form action="<c:url value='/register'/>" method="post">
                        <div class="mb-3">
                            <label class="form-label fw-medium small">Tên tài khoản (Username) <span class="text-danger">*</span></label>
                            <input type="text" name="username" class="form-control" placeholder="Tên đăng nhập..." required value="${param.username}">
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-medium small">Họ và tên <span class="text-danger">*</span></label>
                            <input type="text" name="fullname" class="form-control" placeholder="Họ và tên của bạn..." required value="${param.fullname}">
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-medium small">Địa chỉ Email (Nhận mã OTP) <span class="text-danger">*</span></label>
                            <input type="email" name="email" class="form-control" placeholder="example@gmail.com" required value="${param.email}">
                            <div class="form-text text-muted" style="font-size: 11px;">Mã OTP xác thực sẽ được gửi trực tiếp đến hộp thư này.</div>
                        </div>

                        <div class="row g-2 mb-4">
                            <div class="col-md-6">
                                <label class="form-label fw-medium small">Mật khẩu <span class="text-danger">*</span></label>
                                <input type="password" name="password" class="form-control" placeholder="Tối thiểu 6 ký tự" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-medium small">Xác nhận mật khẩu <span class="text-danger">*</span></label>
                                <input type="password" name="confirmPassword" class="form-control" placeholder="Nhập lại mật khẩu" required>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-earth w-100 py-2 fw-semibold shadow-sm mb-3">
                            <i class="bi bi-send-check me-1"></i> Đăng Ký &amp; Nhận Mã OTP
                        </button>

                        <div class="text-center">
                            <span class="small text-muted">Đã có tài khoản? </span>
                            <a href="<c:url value='/login'/>" class="small fw-semibold text-decoration-none text-earth">Đăng nhập</a>
                        </div>
                        <div class="text-center mt-3">
                            <a href="<c:url value='/home'/>" class="small text-secondary text-decoration-none">
                                <i class="bi bi-arrow-left me-1"></i> Quay về trang chủ
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
