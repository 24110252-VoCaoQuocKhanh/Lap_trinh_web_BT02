package vn.iotstar.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import vn.iotstar.config.JPAConfig;
import vn.iotstar.entity.Category;
import java.util.List;

public class CategoryDao {
    public List<Category> findAll() {
        EntityManager enma = JPAConfig.getEntityManager();
        List<Category> list = enma.createQuery("SELECT c FROM Category c", Category.class).getResultList();
        enma.close();
        return list;
    }

    public Category findById(int id) {
        EntityManager enma = JPAConfig.getEntityManager();
        Category cate = enma.find(Category.class, id);
        enma.close();
        return cate;
    }

    public void insert(Category category) {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.persist(category);
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
        } finally {
            enma.close();
        }
    }

    public void update(Category category) {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.merge(category);
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
        } finally {
            enma.close();
        }
    }

    public void delete(int id) {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            Category category = enma.find(Category.class, id);
            if(category != null) enma.remove(category);
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
        } finally {
            enma.close();
        }
    }
}