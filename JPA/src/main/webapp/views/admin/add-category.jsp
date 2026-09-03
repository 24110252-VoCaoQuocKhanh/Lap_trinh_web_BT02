<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm danh mục</title>
</head>
<body>
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-success text-white py-3">
                    <h5 class="mb-0"><i class="bi bi-plus-circle"></i> Thêm danh mục mới</h5>
                </div>
                <div class="card-body p-4">
                    <form action="<c:url value='/admin/category/insert'/>" method="post" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Tên danh mục</label>
                            <input type="text" name="name" class="form-control" required placeholder="Nhập tên danh mục...">
                        </div>
                        
                        <div class="mb-4">
                            <label class="form-label fw-bold">Hình ảnh (Icon)</label>
                            <input type="file" name="icon" class="form-control" accept="image/*" required>
                        </div>

                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <a href="<c:url value='/admin/category'/>" class="btn btn-outline-secondary me-md-2">
                                <i class="bi bi-arrow-left"></i> Hủy bỏ
                            </a>
                            <button type="submit" class="btn btn-success shadow-sm">
                                <i class="bi bi-save"></i> Lưu Danh Mục
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>