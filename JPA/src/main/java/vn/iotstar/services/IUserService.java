package vn.iotstar.services;

import vn.iotstar.entity.User;

public interface IUserService {
    User findById(int id);
    User login(String username, String password);
    void insert(User user);
    void update(User user);
    boolean updateProfile(int id, String username, String fullname, String phone, String images);
    User findByEmail(String email);
    User findByUsername(String username);
    boolean checkExistUsername(String username);
    boolean checkExistEmail(String email);
    void initAdminAccount();
    boolean register(String username, String password, String email, String fullname) throws Exception;
    boolean verifyOtp(String email, String otp);
    boolean sendForgotPasswordOtp(String email) throws Exception;
    boolean resetPassword(String email, String otp, String newPassword);
}
