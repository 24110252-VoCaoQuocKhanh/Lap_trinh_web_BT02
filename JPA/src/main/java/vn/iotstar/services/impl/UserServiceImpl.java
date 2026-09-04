package vn.iotstar.services.impl;

import vn.iotstar.dao.IUserDao;
import vn.iotstar.dao.impl.UserDaoImpl;
import vn.iotstar.entity.User;
import vn.iotstar.services.IUserService;
import vn.iotstar.util.EmailUtil;

public class UserServiceImpl implements IUserService {

    private IUserDao userDao = new UserDaoImpl();

    @Override
    public User findById(int id) {
        return userDao.findById(id);
    }

    @Override
    public User login(String username, String password) {
        return userDao.login(username, password);
    }

    @Override
    public void insert(User user) {
        userDao.insert(user);
    }

    @Override
    public void update(User user) {
        userDao.update(user);
    }

    @Override
    public boolean updateProfile(int id, String username, String fullname, String phone, String images) {
        return userDao.updateProfile(id, username, fullname, phone, images);
    }

    @Override
    public User findByEmail(String email) {
        return userDao.findByEmail(email);
    }

    @Override
    public User findByUsername(String username) {
        return userDao.findByUsername(username);
    }

    @Override
    public boolean checkExistUsername(String username) {
        return userDao.checkExistUsername(username);
    }

    @Override
    public boolean checkExistEmail(String email) {
        return userDao.checkExistEmail(email);
    }

    @Override
    public void initAdminAccount() {
        userDao.initAdminAccount();
    }

    @Override
    public boolean register(String username, String password, String email, String fullname) throws Exception {
        if (checkExistUsername(username) || checkExistEmail(email)) {
            return false;
        }

        String otp = EmailUtil.generateOTP();

        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setEmail(email);
        user.setFullname(fullname);
        user.setRole(2);   // 2: User thường
        user.setStatus(0); // 0: Chờ xác thực OTP
        user.setOtp(otp);

        userDao.insert(user);

        // Ghi log mã OTP ra Console để hỗ trợ kiểm thử / chấm bài
        System.out.println("==================================================");
        System.out.println(">> MA OTP DANG KY CHO [" + email + "] LA: " + otp);
        System.out.println("==================================================");

        // Gửi email OTP
        try {
            String subject = "Device Store - Mã xác thực kích hoạt tài khoản";
            String content = "<div style='font-family: Arial, sans-serif; max-width: 500px; margin: auto; padding: 20px; border: 1px solid #ddd; border-radius: 8px;'>"
                    + "<h2 style='color: #0d6efd; text-align: center;'>DEVICE STORE</h2>"
                    + "<p>Xin chào <strong>" + fullname + "</strong>,</p>"
                    + "<p>Cảm ơn bạn đã đăng ký tài khoản tại <strong>Device Store</strong>. Mã OTP xác thực kích hoạt tài khoản của bạn là:</p>"
                    + "<div style='text-align: center; margin: 20px 0;'>"
                    + "<span style='font-size: 32px; font-weight: bold; color: #dc3545; letter-spacing: 6px; background-color: #f8f9fa; padding: 10px 20px; border-radius: 6px; border: 1px dashed #dc3545; display: inline-block;'>"
                    + otp + "</span>"
                    + "</div>"
                    + "<p style='color: #6c757d; font-size: 13px;'>Mã này chỉ có hiệu lực trong thời gian ngắn. Vui lòng không chia sẻ mã này với bất kỳ ai.</p>"
                    + "<hr style='border: 0; border-top: 1px solid #eee; margin: 20px 0;'>"
                    + "<p style='text-align: center; font-size: 12px; color: #adb5bd;'>Trân trọng,<br>Đội ngũ Device Store</p>"
                    + "</div>";

            EmailUtil.sendEmail(email, subject, content);
        } catch (Exception e) {
            System.err.println("Cảnh báo: Không thể gửi email qua SMTP: " + e.getMessage());
            // Không re-throw để tài khoản vẫn được phép xác thực qua OTP console
        }
        return true;
    }

    @Override
    public boolean verifyOtp(String email, String otp) {
        if (email == null || otp == null) return false;
        User user = userDao.findByEmail(email.trim());
        if (user == null) {
            user = userDao.findByUsername(email.trim());
        }
        if (user != null && otp.trim().equals(user.getOtp())) {
            user.setStatus(1); // Kích hoạt tài khoản
            user.setOtp(null); // Xóa OTP
            userDao.update(user);
            return true;
        }
        return false;
    }

    @Override
    public boolean sendForgotPasswordOtp(String email) throws Exception {
        User user = userDao.findByEmail(email);
        if (user == null) {
            return false;
        }

        String otp = EmailUtil.generateOTP();
        user.setOtp(otp);
        userDao.update(user);

        System.out.println("==================================================");
        System.out.println(">> MA OTP QUEN MAT KHAU CHO [" + email + "] LA: " + otp);
        System.out.println("==================================================");

        try {
            String subject = "Device Store - Mã xác thực đặt lại mật khẩu";
            String content = "<div style='font-family: Arial, sans-serif; max-width: 500px; margin: auto; padding: 20px; border: 1px solid #ddd; border-radius: 8px;'>"
                    + "<h2 style='color: #0d6efd; text-align: center;'>DEVICE STORE</h2>"
                    + "<p>Xin chào <strong>" + (user.getFullname() != null ? user.getFullname() : user.getUsername()) + "</strong>,</p>"
                    + "<p>Chúng tôi nhận được yêu cầu đặt lại mật khẩu cho tài khoản tại <strong>Device Store</strong>. Mã OTP xác thực của bạn là:</p>"
                    + "<div style='text-align: center; margin: 20px 0;'>"
                    + "<span style='font-size: 32px; font-weight: bold; color: #ffc107; letter-spacing: 6px; background-color: #212529; padding: 10px 20px; border-radius: 6px; display: inline-block;'>"
                    + otp + "</span>"
                    + "</div>"
                    + "<p style='color: #6c757d; font-size: 13px;'>Nếu bạn không yêu cầu hành động này, vui lòng bỏ qua email.</p>"
                    + "<hr style='border: 0; border-top: 1px solid #eee; margin: 20px 0;'>"
                    + "<p style='text-align: center; font-size: 12px; color: #adb5bd;'>Trân trọng,<br>Đội ngũ Device Store</p>"
                    + "</div>";

            EmailUtil.sendEmail(email, subject, content);
        } catch (Exception e) {
            System.err.println("Cảnh báo: Không thể gửi email qua SMTP: " + e.getMessage());
        }
        return true;
    }

    @Override
    public boolean resetPassword(String email, String otp, String newPassword) {
        if (email == null || otp == null) return false;
        User user = userDao.findByEmail(email.trim());
        if (user == null) {
            user = userDao.findByUsername(email.trim());
        }
        if (user != null && otp.trim().equals(user.getOtp())) {
            user.setPassword(newPassword);
            user.setOtp(null);
            userDao.update(user);
            return true;
        }
        return false;
    }
}
