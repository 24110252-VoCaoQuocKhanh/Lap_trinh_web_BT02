<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cập nhật hồ sơ</title>
</head>
<body>
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-primary text-white text-center py-3">
                    <h4 class="mb-0"><i class="bi bi-person-lines-fill"></i> Thông tin cá nhân</h4>
                </div>
                <div class="card-body p-4">
                    <c:if test="${param.success == 1}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="bi bi-check-circle-fill"></i> Cập nhật hồ sơ thành công!
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <form action="<c:url value='/admin/profile'/>" method="post" enctype="multipart/form-data">
                        <div class="text-center mb-4">
                            <img src="${not empty sessionScope.account.images ? pageContext.request.contextPath.concat('/image?fname=').concat(sessionScope.account.images) : 'https://cdn-icons-png.flaticon.com/512/149/149071.png'}" 
                                 class="img-thumbnail rounded-circle shadow-sm" style="width: 150px; height: 150px; object-fit: cover;" alt="Avatar">
                            <div class="mt-3">
                                <label for="avatarUpload" class="form-label text-muted small">Chọn ảnh đại diện mới</label>
                                <input class="form-control form-control-sm" type="file" id="avatarUpload" name="images" accept="image/*">
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Tài khoản đăng nhập</label>
                            <input type="text" class="form-control bg-light" value="${sessionScope.account.username}" readonly>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">Họ và tên</label>
                            <input type="text" name="fullname" class="form-control" value="${sessionScope.account.fullname}" placeholder="Nhập họ và tên...">
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-bold">Số điện thoại</label>
                            <input type="text" name="phone" class="form-control" value="${sessionScope.account.phone}" placeholder="Nhập số điện thoại...">
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary btn-lg"><i class="bi bi-save"></i> Lưu Thay Đổi</button>
                            <a href="<c:url value='/admin/category'/>" class="btn btn-outline-secondary">Quay lại</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>