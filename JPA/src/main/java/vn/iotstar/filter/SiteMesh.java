package vn.iotstar.filter;

import jakarta.servlet.DispatcherType; 
import jakarta.servlet.annotation.WebFilter;
import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;


@WebFilter(filterName = "sitemesh", urlPatterns = "/*", dispatcherTypes = {DispatcherType.REQUEST, DispatcherType.FORWARD})
public class SiteMesh extends ConfigurableSiteMeshFilter {
    
    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        builder.addDecoratorPath("/admin/*", "/views/decorators/admin.jsp")
               .addExcludedPath("/login")
               .addExcludedPath("/image*");
    }
}