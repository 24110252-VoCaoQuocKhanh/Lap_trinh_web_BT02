<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thông Tin Cá Nhân - Device Store</title>
</head>
<body>
<div class="container py-4">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<c:url value='/home'/>" class="text-decoration-none">Trang chủ</a></li>
            <li class="breadcrumb-item active" aria-current="page">Thông tin cá nhân</li>
        </ol>
    </nav>

    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <div class="card shadow-sm border-0 rounded-4">
                <div class="card-header bg-white border-bottom py-3 text-center">
                    <h5 class="mb-0 fw-bold text-dark">
                        <i class="bi bi-person-lines-fill text-primary me-2"></i> Hồ Sơ Người Dùng
                    </h5>
                </div>
                <div class="card-body p-4">
                    <c:if test="${param.success == 1}">
                        <div class="alert alert-success alert-dismissible fade show d-flex align-items-center" role="alert">
                            <i class="bi bi-check-circle-fill me-2 fs-5"></i>
                            <div>Cập nhật thông tin hồ sơ thành công!</div>
                            <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <c:if test="${param.error == 1 || not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-2 fs-5"></i>
                            <div>${not empty error ? error : 'Cập nhật thất bại. Vui lòng kiểm tra lại thông tin!'}</div>
                            <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <form action="<c:url value='/profile'/>" method="post" enctype="multipart/form-data" class="needs-validation" novalidate id="profileUserForm">
                        <!-- Avatar Display & Upload -->
                        <div class="text-center mb-4">
                            <div class="position-relative d-inline-block">
                                <img id="avatarImgUser"
                                     src="${not empty sessionScope.account.images ? pageContext.request.contextPath.concat('/image?fname=').concat(sessionScope.account.images) : 'https://cdn-icons-png.flaticon.com/512/149/149071.png'}" 
                                     class="img-thumbnail rounded-circle shadow-sm" 
                                     style="width: 120px; height: 120px; object-fit: cover;" 
                                     alt="Avatar">
                            </div>
                            <div class="mt-3">
                                <label for="avatarUpload" class="form-label text-muted small fw-medium">
                                    <i class="bi bi-camera me-1"></i> Chọn ảnh đại diện mới
                                </label>
                                <input class="form-control form-control-sm mx-auto" style="max-width: 280px;" type="file" id="avatarUpload" name="images" accept="image/png, image/jpeg, image/jpg, image/webp, image/gif" onchange="previewAvatarUser(this)">
                                <div class="form-text small text-muted">Hỗ trợ JPG, PNG, WEBP, GIF (&le; 5MB)</div>
                                <div id="avatarError" class="text-danger small mt-1 d-none">Kích thước file ảnh vượt quá 5MB. Vui lòng chọn ảnh khác!</div>
                            </div>
                        </div>

                        <!-- Username -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold small text-muted">Tên đăng nhập</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light text-muted"><i class="bi bi-person"></i></span>
                                <input type="text" class="form-control bg-light" value="${sessionScope.account.username}" readonly>
                            </div>
                        </div>

                        <!-- Email -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold small text-muted">Địa chỉ Email</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light text-muted"><i class="bi bi-envelope"></i></span>
                                <input type="email" class="form-control bg-light" value="${sessionScope.account.email}" readonly>
                            </div>
                        </div>

                        <!-- Full Name -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold small">Họ và tên <span class="text-danger">*</span></label>
                            <div class="input-group has-validation">
                                <span class="input-group-text"><i class="bi bi-card-text text-primary"></i></span>
                                <input type="text" name="fullname" class="form-control" 
                                       value="${sessionScope.account.fullname}" 
                                       placeholder="Nhập họ và tên..." minlength="2" maxlength="100" required>
                                <div class="invalid-feedback">
                                    Họ và tên không được để trống (tối thiểu 2 ký tự, tối đa 100 ký tự).
                                </div>
                            </div>
                        </div>

                        <!-- Phone -->
                        <div class="mb-4">
                            <label class="form-label fw-semibold small">Số điện thoại</label>
                            <div class="input-group has-validation">
                                <span class="input-group-text"><i class="bi bi-telephone text-primary"></i></span>
                                <input type="tel" name="phone" class="form-control" 
                                       value="${sessionScope.account.phone}" 
                                       placeholder="Ví dụ: 0901234567"
                                       pattern="^(0[3|5|7|8|9])[0-9]{8}$">
                                <div class="invalid-feedback">
                                    Số điện thoại không hợp lệ (gồm 10 chữ số, bắt đầu bằng 03, 05, 07, 08, 09).
                                </div>
                            </div>
                        </div>

                        <!-- Vai trò tài khoản -->
                        <div class="mb-4 p-3 bg-light rounded-3 d-flex justify-content-between align-items-center">
                            <span class="small fw-semibold text-muted">Loại tài khoản:</span>
                            <c:choose>
                                <c:when test="${sessionScope.account.role == 1}">
                                    <span class="badge bg-danger px-3 py-2">Quản trị viên (Admin)</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-success px-3 py-2">Khách hàng thành viên</span>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- Action Buttons -->
                        <div class="d-flex justify-content-end gap-2 border-top pt-3">
                            <a href="<c:url value='/home'/>" class="btn btn-outline-secondary px-3">
                                <i class="bi bi-house me-1"></i> Trang chủ
                            </a>
                            <button type="submit" class="btn btn-primary px-4 shadow-sm fw-medium">
                                <i class="bi bi-save me-1"></i> Lưu Thay Đổi
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
function previewAvatarUser(input) {
    var errorDiv = document.getElementById('avatarError');
    if (input.files && input.files[0]) {
        var file = input.files[0];
        if (file.size > 5 * 1024 * 1024) {
            errorDiv.classList.remove('d-none');
            input.value = '';
            return;
        } else {
            errorDiv.classList.add('d-none');
        }
        var reader = new FileReader();
        reader.onload = function(e) {
            document.getElementById('avatarImgUser').src = e.target.result;
        };
        reader.readAsDataURL(file);
    }
}

// Bootstrap 5 validation script
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
