package vn.iotstar.dao;

import java.util.List;
import vn.iotstar.entity.Product;

public interface IProductDao {
    void insert(Product product);
    void update(Product product);
    void delete(int id) throws Exception;
    Product findById(int id);
    List<Product> findAll();
    List<Product> getTop10Recent();
    List<Product> findPagination(int page, int pageSize);
    long countAll();
    List<Product> searchByName(String keyword);
    List<Product> findByCategoryId(int categoryId);
    List<Product> search(String keyword, Integer categoryId, int page, int pageSize);
    long countSearch(String keyword, Integer categoryId);
}