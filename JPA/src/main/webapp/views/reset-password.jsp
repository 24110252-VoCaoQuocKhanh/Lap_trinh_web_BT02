<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt lại mật khẩu - Device Store</title>
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
                <div class="card card-auth border-0 p-4 bg-white">
                    <div class="text-center mb-3">
                        <div class="d-inline-flex p-3 rounded-circle mb-2" style="background-color: #f5ebe0; color: #6f4e37;">
                            <i class="bi bi-shield-lock-fill fs-1"></i>
                        </div>
                        <h4 class="fw-bold text-dark mb-1">ĐẶT LẠI MẬT KHẨU</h4>
                        <p class="text-muted small">
                            Mã OTP đã được gửi đến email: <strong>${sessionScope.resetEmail}</strong>
                        </p>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger py-2 small" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-1"></i> ${error}
                        </div>
                    </c:if>

                    <form action="<c:url value='/reset-password'/>" method="post" class="needs-validation" novalidate id="resetPasswordForm">
                        <div class="mb-3">
                            <label class="form-label fw-medium small">Mã xác thực OTP (6 chữ số):</label>
                            <input type="text" name="otp" class="form-control text-center fs-5 fw-bold" 
                                   pattern="[0-9]{6}" inputmode="numeric" maxlength="6" placeholder="------" required autofocus style="color: #6f4e37;">
                            <div class="invalid-feedback">
                                Vui lòng nhập đúng 6 chữ số OTP.
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-medium small">Mật khẩu mới:</label>
                            <input type="password" name="newPassword" id="newPassword" class="form-control" 
                                   minlength="6" placeholder="Mật khẩu mới (tối thiểu 6 ký tự)" required>
                            <div class="invalid-feedback">
                                Mật khẩu mới phải có ít nhất 6 ký tự.
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-medium small">Xác nhận mật khẩu mới:</label>
                            <input type="password" name="confirmPassword" id="confirmPassword" class="form-control" 
                                   minlength="6" placeholder="Nhập lại mật khẩu mới" required>
                            <div class="invalid-feedback" id="confirmFeedback">
                                Vui lòng xác nhận mật khẩu mới.
                            </div>
                        </div>

                        <button type="submit" class="btn btn-earth w-100 py-2 fw-semibold shadow-sm mb-3">
                            <i class="bi bi-check2-circle me-1"></i> Cập Nhật Mật Khẩu
                        </button>
                    </form>

                    <div class="text-center pt-2 border-top">
                        <a href="<c:url value='/login'/>" class="small text-muted text-decoration-none">
                            <i class="bi bi-arrow-left"></i> Quay lại đăng nhập
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
            const form = document.getElementById('resetPasswordForm');
            const pass = document.getElementById('newPassword');
            const confirm = document.getElementById('confirmPassword');
            const confirmFeedback = document.getElementById('confirmFeedback');

            function validatePasswordMatch() {
                if (confirm.value !== pass.value) {
                    confirm.setCustomValidity('Passwords do not match');
                    confirmFeedback.textContent = 'Mật khẩu xác nhận không khớp!';
                } else {
                    confirm.setCustomValidity('');
                    confirmFeedback.textContent = 'Vui lòng xác nhận mật khẩu mới.';
                }
            }

            pass.addEventListener('input', () => {
                if (confirm.value) validatePasswordMatch();
            });
            confirm.addEventListener('input', validatePasswordMatch);

            form.addEventListener('submit', event => {
                validatePasswordMatch();
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);
        })();
    </script>
</body>
</html>
