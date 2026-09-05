package vn.iotstar.controller.admin;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import vn.iotstar.entity.Category;
import vn.iotstar.entity.Product;
import vn.iotstar.services.ICategoryService;
import vn.iotstar.services.IProductService;
import vn.iotstar.services.impl.CategoryServiceImpl;
import vn.iotstar.services.impl.ProductServiceImpl;
import vn.iotstar.util.Constant;

@WebServlet(urlPatterns = {
    "/admin/product",
    "/admin/product/add",
    "/admin/product/edit",
    "/admin/product/delete"
})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
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

        if ("/admin/product/add".equals(path)) {
            List<Category> categories = categoryService.findAll();
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/views/admin/add-product.jsp").forward(req, resp);
        } else if ("/admin/product/edit".equals(path)) {
            int id = Integer.parseInt(req.getParameter("id"));
            Product product = productService.findById(id);
            List<Category> categories = categoryService.findAll();
            req.setAttribute("product", product);
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/views/admin/edit-product.jsp").forward(req, resp);
        } else if ("/admin/product/delete".equals(path)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                Product oldProd = productService.findById(id);
                if (oldProd != null && oldProd.getImage() != null) {
                    File oldFile = new File(Constant.DIR + "/" + oldProd.getImage());
                    if (oldFile.exists()) oldFile.delete();
                }
                productService.delete(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/product");
        } else {
            List<Product> list = productService.findAll();
            req.setAttribute("productList", list);
            req.getRequestDispatcher("/views/admin/list-product.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");

        String path = req.getServletPath();

        String name = req.getParameter("name");
        if (name != null) name = name.trim();

        String description = req.getParameter("description");
        double price = 0;
        try {
            price = Double.parseDouble(req.getParameter("price"));
        } catch (Exception e) {
            price = 0;
        }

        int categoryId = 0;
        try {
            categoryId = Integer.parseInt(req.getParameter("categoryId"));
        } catch (Exception e) {
            categoryId = 0;
        }
        Category category = (categoryId > 0) ? categoryService.findById(categoryId) : null;

        // Server-side validation
        if (name == null || name.length() < 2 || name.length() > 255) {
            forwardError(req, resp, path, "Tên thiết bị / sản phẩm không được để trống (từ 2 đến 255 ký tự)!");
            return;
        }

        if (price < 1000) {
            forwardError(req, resp, path, "Giá sản phẩm không hợp lệ! Đơn giá tối thiểu là 1,000 VNĐ.");
            return;
        }

        if (category == null) {
            forwardError(req, resp, path, "Vui lòng chọn danh mục hợp lệ cho sản phẩm!");
            return;
        }

        // Xử lý upload hình ảnh sản phẩm
        Part filePart = req.getPart("image");
        String fileName = null;
        if (filePart != null && filePart.getSize() > 0) {
            if (filePart.getSize() > 5 * 1024 * 1024) {
                forwardError(req, resp, path, "Kích thước hình ảnh không được vượt quá 5MB!");
                return;
            }

            String originalName = filePart.getSubmittedFileName();
            String ext = "";
            if (originalName != null && originalName.contains(".")) {
                ext = originalName.substring(originalName.lastIndexOf(".")).toLowerCase();
            }
            if (!ext.equals(".jpg") && !ext.equals(".jpeg") && !ext.equals(".png") && !ext.equals(".webp") && !ext.equals(".gif")) {
                forwardError(req, resp, path, "Định dạng file không hợp lệ! Chỉ chấp nhận ảnh .jpg, .jpeg, .png, .webp, .gif.");
                return;
            }

            fileName = "product_" + System.currentTimeMillis() + ext;
            File uploadDir = new File(Constant.DIR + "/product");
            if (!uploadDir.exists()) uploadDir.mkdirs();
            filePart.write(Constant.DIR + "/product/" + fileName);
        }

        if ("/admin/product/add".equals(path)) {
            Product product = new Product();
            product.setName(name);
            product.setDescription(description);
            product.setPrice(price);
            product.setCategory(category);
            product.setCreatedAt(new Date());
            if (fileName != null) {
                product.setImage("product/" + fileName);
            }
            productService.insert(product);
        } else if ("/admin/product/edit".equals(path)) {
            int id = Integer.parseInt(req.getParameter("id"));
            Product product = productService.findById(id);
            if (product != null) {
                product.setName(name);
                product.setDescription(description);
                product.setPrice(price);
                product.setCategory(category);

                if (fileName != null) {
                    // Xóa ảnh cũ
                    if (product.getImage() != null) {
                        File oldFile = new File(Constant.DIR + "/" + product.getImage());
                        if (oldFile.exists()) oldFile.delete();
                    }
                    product.setImage("product/" + fileName);
                }
                productService.update(product);
            }
        }

        resp.sendRedirect(req.getContextPath() + "/admin/product");
    }

    private void forwardError(HttpServletRequest req, HttpServletResponse resp, String path, String errorMsg) throws ServletException, IOException {
        req.setAttribute("error", errorMsg);
        List<Category> categories = categoryService.findAll();
        req.setAttribute("categories", categories);
        if ("/admin/product/edit".equals(path)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                Product product = productService.findById(id);
                req.setAttribute("product", product);
            } catch (Exception ignored) {}
            req.getRequestDispatcher("/views/admin/edit-product.jsp").forward(req, resp);
        } else {
            req.getRequestDispatcher("/views/admin/add-product.jsp").forward(req, resp);
        }
    }
}
