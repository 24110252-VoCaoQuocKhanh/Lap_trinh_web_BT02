package vn.iotstar.controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.entity.Category;
import vn.iotstar.entity.Product;
import vn.iotstar.services.ICategoryService;
import vn.iotstar.services.IProductService;
import vn.iotstar.services.impl.CategoryServiceImpl;
import vn.iotstar.services.impl.ProductServiceImpl;

@WebServlet(urlPatterns = {"/product", "/product/detail"})
public class ProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IProductService productService = new ProductServiceImpl();
    private ICategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");

        String path = req.getServletPath();

        // 1. Xem chi tiết 01 sản phẩm
        if ("/product/detail".equals(path)) {
            String idStr = req.getParameter("id");
            if (idStr != null && !idStr.trim().isEmpty()) {
                try {
                    int id = Integer.parseInt(idStr.trim());
                    Product product = productService.findById(id);
                    if (product != null) {
                        req.setAttribute("product", product);
                        // Lấy thêm các sản phẩm cùng danh mục để gợi ý
                        if (product.getCategory() != null) {
                            List<Product> relatedProducts = productService.findByCategoryId(product.getCategory().getId());
                            req.setAttribute("relatedProducts", relatedProducts);
                        }
                        req.getRequestDispatcher("/views/web/product-detail.jsp").forward(req, resp);
                        return;
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            resp.sendRedirect(req.getContextPath() + "/product");
            return;
        }

        // 2. Danh sách sản phẩm phân trang 6 sản phẩm/trang, tìm kiếm và lọc danh mục
        int page = 1;
        int pageSize = 6; // Yêu cầu đề bài: đúng 6 sp / trang

        String pageStr = req.getParameter("page");
        if (pageStr != null && !pageStr.trim().isEmpty()) {
            try {
                page = Math.max(1, Integer.parseInt(pageStr.trim()));
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        String keyword = req.getParameter("kw");
        String cidStr = req.getParameter("cid");
        Integer categoryId = null;
        if (cidStr != null && !cidStr.trim().isEmpty()) {
            try {
                categoryId = Integer.parseInt(cidStr.trim());
            } catch (NumberFormatException e) {
                categoryId = null;
            }
        }

        List<Product> productList = productService.search(keyword, categoryId, page, pageSize);
        long totalCount = productService.countSearch(keyword, categoryId);
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);
        if (totalPages == 0) totalPages = 1;

        List<Category> categoryList = categoryService.findAll();

        req.setAttribute("productList", productList);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalCount", totalCount);
        req.setAttribute("keyword", keyword != null ? keyword : "");
        req.setAttribute("selectedCid", categoryId);
        req.setAttribute("categoryList", categoryList);

        req.getRequestDispatcher("/views/web/product-list.jsp").forward(req, resp);
    }
}
