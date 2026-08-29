package vn.iotstar.controller.admin;

import java.io.File;
import java.io.IOException;
import java.util.Set;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import vn.iotstar.model.Category;
import vn.iotstar.service.CategoryService;
import vn.iotstar.service.impl.CategoryServiceImpl;
import vn.iotstar.util.Constant;

@WebServlet(urlPatterns = "/admin/category/add")
@MultipartConfig(
        fileSizeThreshold = 2 * 1024 * 1024,
        maxFileSize = 10 * 1024 * 1024,
        maxRequestSize = 50 * 1024 * 1024)
public class CategoryAddController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final CategoryService cateService = new CategoryServiceImpl();
    private static final Set<String> ALLOWED_EXTENSIONS = Set.of("jpg", "jpeg", "png", "gif", "webp");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = req.getRequestDispatcher("/views/admin/add-category.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String name = req.getParameter("name");
        if (name == null || name.trim().isEmpty()) {
            req.setAttribute("error", "Tên danh mục không được để trống.");
            req.getRequestDispatcher("/views/admin/add-category.jsp").forward(req, resp);
            return;
        }

        Category category = new Category();
        category.setName(name.trim());

        Part filePart = req.getPart("icon");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = saveUploadedFile(filePart);
            category.setIcon("category/" + fileName);
        }

        cateService.insert(category);
        resp.sendRedirect(req.getContextPath() + "/admin/category/list");
    }

    private String saveUploadedFile(Part filePart) throws IOException {
        String originalName = filePart.getSubmittedFileName();
        String ext = getExtension(originalName);

        if (!ALLOWED_EXTENSIONS.contains(ext)) {
            throw new IOException("Định dạng ảnh không được hỗ trợ: " + ext);
        }

        File uploadDir = new File(Constant.DIR, "category");
        if (!uploadDir.exists() && !uploadDir.mkdirs()) {
            throw new IOException("Không thể tạo thư mục upload: " + uploadDir.getAbsolutePath());
        }

        String fileName = System.currentTimeMillis() + "." + ext;
        filePart.write(new File(uploadDir, fileName).getAbsolutePath());
        return fileName;
    }

    private String getExtension(String fileName) {
        if (fileName == null) {
            return "";
        }
        int index = fileName.lastIndexOf('.');
        if (index < 0 || index == fileName.length() - 1) {
            return "";
        }
        return fileName.substring(index + 1).toLowerCase();
    }
}
