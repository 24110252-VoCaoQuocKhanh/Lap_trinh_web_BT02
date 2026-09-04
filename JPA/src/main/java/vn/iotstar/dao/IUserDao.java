package vn.iotstar.dao;

import vn.iotstar.entity.User;

public interface IUserDao {
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
}