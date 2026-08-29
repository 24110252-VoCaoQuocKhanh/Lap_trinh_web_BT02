package vn.iotstar.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import vn.iotstar.dao.CategoryDao;
import vn.iotstar.entity.Category;
import vn.iotstar.util.Constant;
import java.io.*;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/category", "/admin/category/add", "/admin/category/edit", "/admin/category/delete"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class CategoryController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    CategoryDao categoryDao = new CategoryDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if (path.equals("/admin/category/add")) {
            req.getRequestDispatcher("/views/admin/add-category.jsp").forward(req, resp);
        } else if (path.equals("/admin/category/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            req.setAttribute("category", categoryDao.findById(id));
            req.getRequestDispatcher("/views/admin/edit-category.jsp").forward(req, resp);
        } else if (path.equals("/admin/category/delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            categoryDao.delete(id);
            resp.sendRedirect(req.getContextPath() + "/admin/category");
        } else {
            List<Category> list = categoryDao.findAll();
            req.setAttribute("cateList", list);
            req.getRequestDispatcher("/views/admin/list-category.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getServletPath();

        Category category = new Category();
        category.setName(req.getParameter("name"));

        Part filePart = req.getPart("icon");
        String fileName = null;
        
        if (filePart != null && filePart.getSize() > 0) {
            String originalName = filePart.getSubmittedFileName();
            fileName = System.currentTimeMillis() + "." + originalName.substring(originalName.lastIndexOf(".") + 1);
            File uploadDir = new File(Constant.DIR + "/category");
            if (!uploadDir.exists()) uploadDir.mkdirs();
            filePart.write(Constant.DIR + "/category/" + fileName);
            category.setIcon("category/" + fileName);
        }

        if (path.equals("/admin/category/add")) {
            categoryDao.insert(category);
        } else if (path.equals("/admin/category/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            category.setId(id);
            Category oldCate = categoryDao.findById(id);
            if (fileName == null) {
                category.setIcon(oldCate.getIcon());
            } else if (oldCate.getIcon() != null) {
                new File(Constant.DIR + "/" + oldCate.getIcon()).delete();
            }
            categoryDao.update(category);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/category");
    }
}