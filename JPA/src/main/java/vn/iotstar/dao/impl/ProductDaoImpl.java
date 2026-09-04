package vn.iotstar.dao.impl;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JPAConfig;
import vn.iotstar.dao.IProductDao;
import vn.iotstar.entity.Product;

public class ProductDaoImpl implements IProductDao {

    @Override
    public void insert(Product product) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(product);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public void update(Product product) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(product);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(int id) throws Exception {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Product product = em.find(Product.class, id);
            if (product != null) {
                em.remove(product);
            } else {
                throw new Exception("Không tìm thấy sản phẩm có ID: " + id);
            }
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            e.printStackTrace();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public Product findById(int id) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            return em.find(Product.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Product> findAll() {
        try {
            EntityManager em = JPAConfig.getEntityManager();
            try {
                String jpql = "SELECT p FROM Product p ORDER BY p.id DESC";
                TypedQuery<Product> query = em.createQuery(jpql, Product.class);
                return query.getResultList();
            } finally {
                em.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return new java.util.ArrayList<>();
        }
    }

    @Override
    public List<Product> getTop10Recent() {
        try {
            EntityManager em = JPAConfig.getEntityManager();
            try {
                String jpql = "SELECT p FROM Product p ORDER BY p.id DESC";
                TypedQuery<Product> query = em.createQuery(jpql, Product.class);
                query.setFirstResult(0);
                query.setMaxResults(10);
                return query.getResultList();
            } finally {
                em.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return new java.util.ArrayList<>();
        }
    }

    @Override
    public List<Product> findPagination(int page, int pageSize) {
        try {
            EntityManager em = JPAConfig.getEntityManager();
            try {
                String jpql = "SELECT p FROM Product p ORDER BY p.id DESC";
                TypedQuery<Product> query = em.createQuery(jpql, Product.class);
                int firstPosition = Math.max(0, (page - 1) * pageSize);
                query.setFirstResult(firstPosition);
                query.setMaxResults(pageSize);
                return query.getResultList();
            } finally {
                em.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return new java.util.ArrayList<>();
        }
    }

    @Override
    public long countAll() {
        try {
            EntityManager em = JPAConfig.getEntityManager();
            try {
                String jpql = "SELECT COUNT(p) FROM Product p";
                TypedQuery<Long> query = em.createQuery(jpql, Long.class);
                return query.getSingleResult();
            } finally {
                em.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public List<Product> searchByName(String keyword) {
        try {
            EntityManager em = JPAConfig.getEntityManager();
            try {
                String jpql = "SELECT p FROM Product p WHERE p.name LIKE :kw ORDER BY p.id DESC";
                TypedQuery<Product> query = em.createQuery(jpql, Product.class);
                query.setParameter("kw", "%" + keyword + "%");
                return query.getResultList();
            } finally {
                em.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return new java.util.ArrayList<>();
        }
    }

    @Override
    public List<Product> findByCategoryId(int categoryId) {
        try {
            EntityManager em = JPAConfig.getEntityManager();
            try {
                String jpql = "SELECT p FROM Product p WHERE p.category.id = :cid ORDER BY p.id DESC";
                TypedQuery<Product> query = em.createQuery(jpql, Product.class);
                query.setParameter("cid", categoryId);
                return query.getResultList();
            } finally {
                em.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return new java.util.ArrayList<>();
        }
    }

    @Override
    public List<Product> search(String keyword, Integer categoryId, int page, int pageSize) {
        try {
            EntityManager em = JPAConfig.getEntityManager();
            try {
                StringBuilder jpql = new StringBuilder("SELECT p FROM Product p WHERE 1=1");
                if (keyword != null && !keyword.trim().isEmpty()) {
                    jpql.append(" AND LOWER(p.name) LIKE :kw");
                }
                if (categoryId != null && categoryId > 0) {
                    jpql.append(" AND p.category.id = :cid");
                }
                jpql.append(" ORDER BY p.id DESC");

                TypedQuery<Product> query = em.createQuery(jpql.toString(), Product.class);
                if (keyword != null && !keyword.trim().isEmpty()) {
                    query.setParameter("kw", "%" + keyword.trim().toLowerCase() + "%");
                }
                if (categoryId != null && categoryId > 0) {
                    query.setParameter("cid", categoryId);
                }

                int firstPosition = Math.max(0, (page - 1) * pageSize);
                query.setFirstResult(firstPosition);
                query.setMaxResults(pageSize);

                return query.getResultList();
            } finally {
                em.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return new java.util.ArrayList<>();
        }
    }

    @Override
    public long countSearch(String keyword, Integer categoryId) {
        try {
            EntityManager em = JPAConfig.getEntityManager();
            try {
                StringBuilder jpql = new StringBuilder("SELECT COUNT(p) FROM Product p WHERE 1=1");
                if (keyword != null && !keyword.trim().isEmpty()) {
                    jpql.append(" AND LOWER(p.name) LIKE :kw");
                }
                if (categoryId != null && categoryId > 0) {
                    jpql.append(" AND p.category.id = :cid");
                }

                TypedQuery<Long> query = em.createQuery(jpql.toString(), Long.class);
                if (keyword != null && !keyword.trim().isEmpty()) {
                    query.setParameter("kw", "%" + keyword.trim().toLowerCase() + "%");
                }
                if (categoryId != null && categoryId > 0) {
                    query.setParameter("cid", categoryId);
                }

                return query.getSingleResult();
            } finally {
                em.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
}