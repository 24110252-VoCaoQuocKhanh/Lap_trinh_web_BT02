<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Thông Tin Cá Nhân - Device Store Admin" scope="request"/>
<jsp:include page="/views/admin/header.jsp"/>

    <div class="row justify-content-center">
        <div class="col-md-7 col-lg-6">
            <div class="card shadow-sm border-0 rounded-4 overflow-hidden">
                <div class="card-header text-white text-center py-3" style="background: linear-gradient(135deg, #4a3525 0%, #6f4e37 100%);">
                    <h5 class="mb-0 fw-bold"><i class="bi bi-person-lines-fill me-2"></i> Thông Tin Cá Nhân</h5>
                </div>
                <div class="card-body p-4">
                    <c:if test="${param.success == 1}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="bi bi-check-circle-fill me-1"></i> Cập nhật hồ sơ thành công!
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>
                    <c:if test="${param.error == 1}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-1"></i> Cập nhật thất bại. Vui lòng thử lại!
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <form action="<c:url value='/admin/profile'/>" method="post" enctype="multipart/form-data">
                        <div class="text-center mb-4">
                            <img id="avatarImg" 
                                 src="${not empty sessionScope.account.images ? pageContext.request.contextPath.concat('/image?fname=').concat(sessionScope.account.images) : 'https://cdn-icons-png.flaticon.com/512/149/149071.png'}" 
                                 class="img-thumbnail rounded-circle shadow-sm" style="width: 130px; height: 130px; object-fit: cover;" alt="Avatar">
                            <div class="mt-3">
                                <label for="avatarUpload" class="form-label text-muted small fw-medium">Chọn ảnh đại diện mới</label>
                                <input class="form-control form-control-sm" type="file" id="avatarUpload" name="images" accept="image/*" onchange="previewAvatar(this)">
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Tài khoản đăng nhập</label>
                            <input type="text" class="form-control bg-light" value="${sessionScope.account.username}" readonly>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Email</label>
                            <input type="email" class="form-control bg-light" value="${sessionScope.account.email}" readonly>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">Họ và tên</label>
                            <input type="text" name="fullname" class="form-control" value="${sessionScope.account.fullname}" placeholder="Nhập họ và tên..." required>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-bold">Số điện thoại</label>
                            <input type="text" name="phone" class="form-control" value="${sessionScope.account.phone}" placeholder="Nhập số điện thoại...">
                        </div>

                        <div class="d-flex justify-content-end gap-2 border-top pt-3">
                            <a href="<c:url value='/admin/product'/>" class="btn btn-outline-secondary">
                                <i class="bi bi-arrow-left me-1"></i> Quay lại
                            </a>
                            <button type="submit" class="btn btn-primary px-4 shadow-sm" style="background-color: #6f4e37; border-color: #6f4e37;">
                                <i class="bi bi-save me-1"></i> Lưu Thay Đổi
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
    function previewAvatar(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById('avatarImg').src = e.target.result;
            };
            reader.readAsDataURL(input.files[0]);
        }
    }
    </script>

<jsp:include page="/views/admin/footer.jsp"/>