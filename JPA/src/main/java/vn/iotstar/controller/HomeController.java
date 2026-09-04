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
import vn.iotstar.services.IUserService;
import vn.iotstar.services.impl.CategoryServiceImpl;
import vn.iotstar.services.impl.ProductServiceImpl;
import vn.iotstar.services.impl.UserServiceImpl;

@WebServlet(urlPatterns = {"/home"})
public class HomeController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IProductService productService = new ProductServiceImpl();
    private ICategoryService categoryService = new CategoryServiceImpl();
    private IUserService userService = new UserServiceImpl();

    @Override
    public void init() throws ServletException {
        // Đảm bảo tài khoản admin tồn tại sẵn khi ứng dụng khởi chạy
        userService.initAdminAccount();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");

        // Lấy 10 sản phẩm mới nhất cho trang chủ
        List<Product> top10Products = productService.getTop10Recent();
        List<Category> categoryList = categoryService.findAll();

        req.setAttribute("top10Products", top10Products);
        req.setAttribute("categoryList", categoryList);

        req.getRequestDispatcher("/views/web/home.jsp").forward(req, resp);
    }
}
