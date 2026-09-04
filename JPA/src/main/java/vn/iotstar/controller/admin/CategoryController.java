package vn.iotstar.controller.admin;

import java.io.File;
import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import vn.iotstar.entity.Category;
import vn.iotstar.services.ICategoryService;
import vn.iotstar.services.impl.CategoryServiceImpl;
import vn.iotstar.util.Constant;

@WebServlet(urlPatterns = {
    "/admin/category", 
    "/admin/category/add", 
    "/admin/category/insert",
    "/admin/category/edit", 
    "/admin/category/update",
    "/admin/category/delete"
})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class CategoryController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ICategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");
        
        String path = req.getServletPath();

        if (path.equals("/admin/category/add") || path.equals("/admin/category/insert")) {
            req.getRequestDispatcher("/views/admin/add-category.jsp").forward(req, resp);
        } else if (path.equals("/admin/category/edit") || path.equals("/admin/category/update")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Category cate = categoryService.findById(id);
            req.setAttribute("category", cate);
            req.setAttribute("cate", cate); // Hỗ trợ cả 2 tên attribute
            req.getRequestDispatcher("/views/admin/edit-category.jsp").forward(req, resp);
        } else if (path.equals("/admin/category/delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            categoryService.delete(id);
            resp.sendRedirect(req.getContextPath() + "/admin/category");
        } else {
            List<Category> list = categoryService.findAll();
            req.setAttribute("cateList", list);
            req.getRequestDispatcher("/views/admin/list-category.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");

        String path = req.getServletPath();

        Category category = new Category();
        category.setName(req.getParameter("name"));

        Part filePart = req.getPart("icon");
        String fileName = null;
        
        if (filePart != null && filePart.getSize() > 0) {
            String originalName = filePart.getSubmittedFileName();
            fileName = System.currentTimeMillis() + "." + originalName.substring(originalName.lastIndexOf(".") + 1);
            File uploadDir = new File(Constant.DIR + "/category");
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            filePart.write(Constant.DIR + "/category/" + fileName);
            category.setIcon("category/" + fileName);
        }

        if (path.equals("/admin/category/add") || path.equals("/admin/category/insert")) {
            categoryService.insert(category);
        } else if (path.equals("/admin/category/edit") || path.equals("/admin/category/update")) {
            int id = Integer.parseInt(req.getParameter("id"));
            category.setId(id);
            Category oldCate = categoryService.findById(id);
            if (fileName == null && oldCate != null) {
                category.setIcon(oldCate.getIcon());
            } else if (oldCate != null && oldCate.getIcon() != null) {
                File oldFile = new File(Constant.DIR + "/" + oldCate.getIcon());
                if (oldFile.exists()) {
                    oldFile.delete();
                }
            }
            categoryService.update(category);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/category");
    }
}