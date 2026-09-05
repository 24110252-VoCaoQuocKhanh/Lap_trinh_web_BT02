## Source code nằm trong folder JPA ##
### 📁 Cấu trúc thư mục dự án

```text
JPA/
├── pom.xml                                   # Quản lý dependencies Maven (Jakarta EE 10, Hibernate 6, MySQL)
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── vn/iotstar/
│   │   │       ├── config/
│   │   │       │   └── JPAConfig.java                 # Cấu hình EntityManagerFactory (JPA / Hibernate)
│   │   │       ├── controller/
│   │   │       │   ├── DownloadImageController.java   # Phục vụ hiển thị ảnh upload từ ổ đĩa
│   │   │       │   ├── ForgotPasswordController.java  # Xử lý quên mật khẩu
│   │   │       │   ├── HomeController.java            # Điều hướng trang chủ Web
│   │   │       │   ├── LoginController.java           # Xử lý đăng nhập & phân quyền
│   │   │       │   ├── LogoutController.java          # Xử lý đăng xuất tài khoản
│   │   │       │   ├── ProductController.java         # Xem sản phẩm & chi tiết phía Web
│   │   │       │   ├── RegisterController.java        # Đăng ký tài khoản người dùng
│   │   │       │   ├── VerifyOtpController.java       # Xác thực kích hoạt tài khoản qua OTP
│   │   │       │   └── admin/
│   │   │       │       ├── CategoryController.java    # Quản trị danh mục (CRUD)
│   │   │       │       ├── ProductController.java     # Quản trị sản phẩm (CRUD)
│   │   │       │       └── ProfileController.java     # Cập nhật hồ sơ & avatar (Admin & User)
│   │   │       ├── dao/
│   │   │       │   ├── ICategoryDao.java              # Interface DAO Danh mục
│   │   │       │   ├── IProductDao.java               # Interface DAO Sản phẩm
│   │   │       │   ├── IUserDao.java                  # Interface DAO Người dùng
│   │   │       │   └── impl/
│   │   │       │       ├── CategoryDaoImpl.java       # Cài đặt DAO Danh mục
│   │   │       │       ├── ProductDaoImpl.java        # Cài đặt DAO Sản phẩm
│   │   │       │       └── UserDaoImpl.java           # Cài đặt DAO Người dùng (Direct JDBC & JPA)
│   │   │       ├── entity/
│   │   │       │   ├── Category.java                  # Thực thể Danh mục (JPA Entity)
│   │   │       │   ├── Product.java                   # Thực thể Sản phẩm (JPA Entity)
│   │   │       │   └── User.java                      # Thực thể Người dùng (JPA Entity)
│   │   │       ├── filter/
│   │   │       │   ├── AuthFilter.java                # Bộ lọc chặn truy cập trái phép /admin/*
│   │   │       │   └── SiteMesh.java                  # Cấu hình SiteMesh Decorator
│   │   │       ├── services/
│   │   │       │   ├── ICategoryService.java          # Interface Service Danh mục
│   │   │       │   ├── IProductService.java           # Interface Service Sản phẩm
│   │   │       │   ├── IUserService.java              # Interface Service Người dùng
│   │   │       │   └── impl/
│   │   │       │       ├── CategoryServiceImpl.java   # Cài đặt Service Danh mục
│   │   │       │       ├── ProductServiceImpl.java    # Cài đặt Service Sản phẩm
│   │   │       └── util/
│   │   │           ├── Constant.java                  # Hằng số hệ thống & đường dẫn upload ảnh
│   │   │           └── EmailUtil.java                 # Tiện ích gửi mã OTP qua Gmail
│   │   ├── resources/
│   │   │   └── META-INF/
│   │   │       └── persistence.xml                    # Cấu hình kết nối MySQL & Hibernate PU
│   │   └── webapp/
│   │       ├── index.jsp                              # Trang điều hướng mặc định
│   │       ├── views/
│   │       │   ├── login.jsp                          # Giao diện Đăng nhập
│   │       │   ├── register.jsp                       # Giao diện Đăng ký
│   │       │   ├── forgot-password.jsp                # Giao diện Quên mật khẩu
│   │       │   ├── verify-otp.jsp                     # Giao diện Nhập mã OTP
│   │       │   ├── reset-password.jsp                 # Giao diện Đặt lại mật khẩu
│   │       │   ├── admin/                             # Giao diện dành riêng cho Admin
│   │       │   │   ├── header.jsp                     # Header & Sidebar Admin (kèm avatar)
│   │       │   │   ├── footer.jsp                     # Footer Admin
│   │       │   │   ├── list-category.jsp              # Danh sách danh mục
│   │       │   │   ├── add-category.jsp               # Thêm mới danh mục
│   │       │   │   ├── edit-category.jsp              # Cập nhật danh mục
│   │       │   │   ├── list-product.jsp               # Danh sách sản phẩm
│   │       │   │   ├── add-product.jsp                # Thêm mới sản phẩm
│   │       │   │   ├── edit-product.jsp               # Cập nhật sản phẩm
│   │       │   │   └── profile.jsp                    # Hồ sơ cá nhân Admin
│   │       │   └── web/                               # Giao diện dành cho Khách hàng / User
│   │       │       ├── header.jsp                     # Header Navbar Web (kèm avatar & menu)
│   │       │       ├── footer.jsp                     # Footer Web
│   │       │       ├── home.jsp                       # Trang chủ hiển thị sản phẩm
│   │       │       ├── product-list.jsp               # Danh sách sản phẩm người dùng xem
│   │       │       ├── product-detail.jsp             # Chi tiết sản phẩm
│   │       │       └── profile.jsp                    # Hồ sơ cá nhân người dùng
│   │       └── WEB-INF/
│   │           ├── decorators/
│   │           │   ├── admin.jsp                      # Layout trang Quản trị
│   │           │   └── web.jsp                        # Layout trang Khách hàng
│   │           └── sitemesh3.xml                      # Cấu hình SiteMesh 3
```
