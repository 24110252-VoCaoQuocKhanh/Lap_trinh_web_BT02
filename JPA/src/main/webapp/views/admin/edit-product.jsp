<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cập Nhật Sản Phẩm - Device Store Admin</title>
</head>
<body>
    <div class="row justify-content-center">
        <div class="col-md-10 col-lg-9">
            <div class="card shadow-sm border-0 rounded-3">
                <div class="card-header bg-warning py-3">
                    <h5 class="mb-0 text-dark"><i class="bi bi-pencil-square me-2"></i> Cập Nhật Thông Tin Thiết Bị</h5>
                </div>
                <div class="card-body p-4">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i> ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <form action="<c:url value='/admin/product/edit'/>" method="post" enctype="multipart/form-data" class="needs-validation" novalidate id="editProductForm">
                        <input type="hidden" name="id" value="${product.id}">

                        <div class="mb-3">
                            <label class="form-label fw-bold">Tên thiết bị / sản phẩm <span class="text-danger">*</span></label>
                            <div class="input-group has-validation">
                                <input type="text" name="name" class="form-control" value="${product.name}" minlength="2" maxlength="255" required>
                                <div class="invalid-feedback">
                                    Tên sản phẩm không được để trống (từ 2 đến 255 ký tự).
                                </div>
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Danh mục sản phẩm <span class="text-danger">*</span></label>
                                <div class="input-group has-validation">
                                    <select name="categoryId" class="form-select" required>
                                        <c:forEach items="${categories}" var="cat">
                                            <option value="${cat.id}" ${product.category != null && product.category.id == cat.id ? 'selected' : ''}>
                                                ${cat.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <div class="invalid-feedback">
                                        Vui lòng chọn danh mục cho sản phẩm.
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Giá bán (VND) <span class="text-danger">*</span></label>
                                <div class="input-group has-validation">
                                    <input type="number" name="price" class="form-control" required min="1000" step="1000" value="${product.price}">
                                    <span class="input-group-text bg-light fw-bold">VNĐ</span>
                                    <div class="invalid-feedback">
                                        Giá bán phải từ 1,000 VNĐ trở lên.
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Hình ảnh sản phẩm hiện tại</label>
                            <div class="mb-2">
                                <c:choose>
                                    <c:when test="${not empty product.image}">
                                        <img src="<c:url value='/image?fname=${product.image}'/>" 
                                             class="img-thumbnail shadow-sm" style="max-height: 120px; object-fit: contain;" alt="preview">
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-muted small fst-italic">Chưa có hình ảnh.</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <label class="form-label text-muted small">Chọn ảnh mới (nếu muốn thay đổi):</label>
                            <input type="file" name="image" class="form-control" accept="image/png, image/jpeg, image/jpg, image/webp">
                            <div class="form-text text-muted">Hỗ trợ các định dạng .jpg, .png, .jpeg, .webp (&le; 10MB)</div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-bold">Mô tả chi tiết sản phẩm</label>
                            <textarea name="description" class="form-control" rows="5">${product.description}</textarea>
                        </div>

                        <div class="d-flex justify-content-end gap-2 border-top pt-3">
                            <a href="<c:url value='/admin/product'/>" class="btn btn-outline-secondary">
                                <i class="bi bi-arrow-left me-1"></i> Quay lại
                            </a>
                            <button type="submit" class="btn btn-warning px-4 shadow-sm text-dark fw-bold">
                                <i class="bi bi-check-circle me-1"></i> Cập Nhật Sản Phẩm
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
