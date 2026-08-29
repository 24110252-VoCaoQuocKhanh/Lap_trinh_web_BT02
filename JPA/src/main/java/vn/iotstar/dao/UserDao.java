package vn.iotstar.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JPAConfig;
import vn.iotstar.entity.User;

public class UserDao {
    public User login(String username, String password) {
        EntityManager enma = JPAConfig.getEntityManager();
        try {
            TypedQuery<User> query = enma.createQuery("SELECT u FROM User u WHERE u.username = :user AND u.password = :pass", User.class);
            query.setParameter("user", username);
            query.setParameter("pass", password);
            return query.getSingleResult();
        } catch (Exception e) {
            return null;
        } finally {
            enma.close();
        }
    }
}