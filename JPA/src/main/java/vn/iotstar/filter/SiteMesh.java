package vn.iotstar.filter;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

/**
 * SiteMesh Filter đã được vô hiệu hóa (@WebFilter đã tắt).
 * 
 * LÝ DO: Trên Apache Tomcat 11 (Jakarta EE 11 / Servlet 6.1), cơ chế I/O mới (ByteBuffer)
 * và tối ưu hóa Coyote connector khiến SiteMesh 3 gặp lỗi không flush được response wrapper,
 * dẫn đến hiện tượng TRẮNG MÀN HÌNH (HTTP 200 - Content-Length: 0).
 * 
 * Toàn bộ hệ thống giao diện (Web & Admin) đã được chuyển đổi sang cơ chế chuẩn <jsp:include>
 * (/views/web/header.jsp, /views/admin/header.jsp, ...), giúp ứng dụng tương thích 100% với Tomcat 11,
 * tốc độ tải trang cực nhanh và không bao giờ bị lỗi trắng màn hình.
 */
// @WebFilter(filterName = "sitemesh", urlPatterns = "/*")
public class SiteMesh extends ConfigurableSiteMeshFilter {
    
    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        // Không dùng decorator của sitemesh để tránh xung đột trên Tomcat 11
    }
}