package vn.iotstar.filter;

import jakarta.servlet.annotation.WebFilter;
import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;
import org.sitemesh.webapp.DispatchMode;

@WebFilter(filterName = "sitemesh", urlPatterns = "/*")
public class SiteMesh extends ConfigurableSiteMeshFilter {
    
    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        // Cấu hình chế độ dispatch INCLUDE tương thích với Tomcat 11 để không bị commit response gây trắng trang
        try {
            builder.setDispatchMode(DispatchMode.INCLUDE);
        } catch (Throwable ignored) {
            // Trường hợp phiên bản sitemesh cấu hình dispatch mode qua sitemesh3.xml
        }

        // Ánh xạ Decorator Bootstrap (SiteMesh 3 có sẵn prefix là /WEB-INF/decorators/)
        builder.addDecoratorPath("/admin/*", "admin.jsp")
               .addDecoratorPath("/*", "web.jsp")
               // Bỏ qua Decorator cho các trang xác thực độc lập & binary upload
               .addExcludedPath("/login*")
               .addExcludedPath("/register*")
               .addExcludedPath("/forgot-password*")
               .addExcludedPath("/verify-otp*")
               .addExcludedPath("/reset-password*")
               .addExcludedPath("/logout*")
               .addExcludedPath("/image*")
               .addExcludedPath("/assets/*")
               .addExcludedPath("/static/*")
               .addExcludedPath("/WEB-INF/*");
    }
}