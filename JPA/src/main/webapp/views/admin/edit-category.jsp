<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sửa danh mục</title>
</head>
<body>
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-warning py-3">
                    <h5 class="mb-0 text-dark"><i class="bi bi-pencil-square"></i> Cập nhật danh mục</h5>
                </div>
                <div class="card-body p-4">
                    <form action="<c:url value='/admin/category/update'/>" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="id" value="${cate.id}">
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">Tên danh mục</label>
                            <input type="text" name="name" class="form-control" value="${cate.name}" required>
                        </div>
                        
                        <div class="mb-4">
                            <label class="form-label fw-bold">Hình ảnh hiện tại</label>
                            <div class="mb-2">
                                <c:if test="${cate.icon != null && cate.icon != ''}">
                                    <img src="<c:url value='/image?fname=${cate.icon}'/>" class="img-thumbnail shadow-sm" style="height: 120px; border-radius: 8px;" alt="icon"/>
                                </c:if>
                            </div>
                            <label class="form-label text-muted small mt-2">Chọn ảnh mới (Chỉ up file nếu muốn đổi ảnh)</label>
                            <input type="file" name="icon" class="form-control" accept="image/*">
                        </div>

                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <a href="<c:url value='/admin/category'/>" class="btn btn-outline-secondary me-md-2">
                                <i class="bi bi-arrow-left"></i> Hủy bỏ
                            </a>
                            <button type="submit" class="btn btn-warning shadow-sm">
                                <i class="bi bi-check-circle"></i> Cập nhật
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>