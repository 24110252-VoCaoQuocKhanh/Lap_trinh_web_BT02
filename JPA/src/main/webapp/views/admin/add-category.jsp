<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Thêm Danh Mục - Device Store Admin" scope="request"/>
<jsp:include page="/views/admin/header.jsp"/>

    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-7">
            <div class="card shadow-sm border-0 rounded-3">
                <div class="card-header bg-success text-white py-3">
                    <h5 class="mb-0"><i class="bi bi-plus-circle me-2"></i> Thêm Danh Mục Thiết Bị Mới</h5>
                </div>
                <div class="card-body p-4">
                    <form action="<c:url value='/admin/category/add'/>" method="post" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Tên danh mục <span class="text-danger">*</span></label>
                            <input type="text" name="name" class="form-control" required placeholder="Ví dụ: Điện thoại, Laptop, Đồng hồ thông minh...">
                        </div>
                        
                        <div class="mb-4">
                            <label class="form-label fw-bold">Biểu tượng danh mục</label>
                            <input type="file" name="icon" class="form-control" accept="image/*">
                            <div class="form-text text-muted">Hỗ trợ các file ảnh .png, .jpg, .svg</div>
                        </div>

                        <div class="d-flex justify-content-end gap-2 border-top pt-3">
                            <a href="<c:url value='/admin/category'/>" class="btn btn-outline-secondary">
                                <i class="bi bi-arrow-left me-1"></i> Hủy bỏ
                            </a>
                            <button type="submit" class="btn btn-success px-4 shadow-sm">
                                <i class="bi bi-save me-1"></i> Lưu Danh Mục
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

<jsp:include page="/views/admin/footer.jsp"/>