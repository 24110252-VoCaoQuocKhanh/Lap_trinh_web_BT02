<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Thêm Sản Phẩm Mới - Device Store Admin" scope="request"/>
<jsp:include page="/views/admin/header.jsp"/>

    <div class="row justify-content-center">
        <div class="col-md-10 col-lg-9">
            <div class="card shadow-sm border-0 rounded-3">
                <div class="card-header bg-success text-white py-3">
                    <h5 class="mb-0"><i class="bi bi-plus-circle me-2"></i> Thêm Thiết Bị Mới Vào Kho</h5>
                </div>
                <div class="card-body p-4">
                    <form action="<c:url value='/admin/product/add'/>" method="post" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Tên thiết bị / sản phẩm <span class="text-danger">*</span></label>
                            <input type="text" name="name" class="form-control" required placeholder="Ví dụ: iPhone 15 Pro Max 256GB, Laptop Dell XPS 13...">
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Danh mục sản phẩm <span class="text-danger">*</span></label>
                                <select name="categoryId" class="form-select" required>
                                    <option value="">-- Chọn danh mục --</option>
                                    <c:forEach items="${categories}" var="cat">
                                        <option value="${cat.id}">${cat.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Giá bán (VND) <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <input type="number" name="price" class="form-control" required min="0" step="1000" placeholder="Ví dụ: 25000000">
                                    <span class="input-group-text bg-light fw-bold">VNĐ</span>
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Hình ảnh sản phẩm</label>
                            <input type="file" name="image" class="form-control" accept="image/*">
                            <div class="form-text text-muted">Hỗ trợ các định dạng .jpg, .png, .jpeg, .webp</div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-bold">Mô tả chi tiết sản phẩm</label>
                            <textarea name="description" class="form-control" rows="5" placeholder="Nhập cấu hình, thông số kỹ thuật, bảo hành..."></textarea>
                        </div>

                        <div class="d-flex justify-content-end gap-2 border-top pt-3">
                            <a href="<c:url value='/admin/product'/>" class="btn btn-outline-secondary">
                                <i class="bi bi-arrow-left me-1"></i> Hủy bỏ
                            </a>
                            <button type="submit" class="btn btn-success px-4 shadow-sm">
                                <i class="bi bi-save me-1"></i> Lưu Sản Phẩm
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

<jsp:include page="/views/admin/footer.jsp"/>
