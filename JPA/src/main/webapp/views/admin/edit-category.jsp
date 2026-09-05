<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cập Nhật Danh Mục - Device Store Admin</title>
</head>
<body>
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-7">
            <div class="card shadow-sm border-0 rounded-3">
                <div class="card-header bg-warning py-3">
                    <h5 class="mb-0 text-dark"><i class="bi bi-pencil-square me-2"></i> Cập Nhật Thông Tin Danh Mục</h5>
                </div>
                <div class="card-body p-4">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i> ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <form action="<c:url value='/admin/category/update'/>" method="post" enctype="multipart/form-data" class="needs-validation" novalidate id="editCategoryForm">
                        <input type="hidden" name="id" value="${cate.id}">
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">Tên danh mục <span class="text-danger">*</span></label>
                            <div class="input-group has-validation">
                                <input type="text" name="name" class="form-control" value="${cate.name}" minlength="2" maxlength="200" required>
                                <div class="invalid-feedback">
                                    Tên danh mục không được để trống (tối thiểu 2 ký tự, tối đa 200 ký tự).
                                </div>
                            </div>
                        </div>
                        
                        <div class="mb-4">
                            <label class="form-label fw-bold">Biểu tượng hiện tại</label>
                            <div class="mb-2">
                                <c:choose>
                                    <c:when test="${not empty cate.icon}">
                                        <img src="<c:url value='/image?fname=${cate.icon}'/>" class="img-thumbnail shadow-sm" style="max-height: 100px; object-fit: contain;" alt="icon"/>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-muted small fst-italic">Chưa có biểu tượng.</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <label class="form-label text-muted small mt-2">Chọn ảnh mới (nếu muốn thay đổi):</label>
                            <input type="file" name="icon" class="form-control" accept="image/png, image/jpeg, image/jpg, image/webp, image/svg+xml">
                            <div class="form-text text-muted">Hỗ trợ các file ảnh .png, .jpg, .webp, .svg (&le; 5MB)</div>
                        </div>

                        <div class="d-flex justify-content-end gap-2 border-top pt-3">
                            <a href="<c:url value='/admin/category'/>" class="btn btn-outline-secondary">
                                <i class="bi bi-arrow-left me-1"></i> Hủy bỏ
                            </a>
                            <button type="submit" class="btn btn-warning px-4 shadow-sm text-dark fw-bold">
                                <i class="bi bi-check-circle me-1"></i> Cập Nhật Danh Mục
                            </button>
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