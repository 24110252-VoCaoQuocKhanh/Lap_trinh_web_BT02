package vn.iotstar.services.impl;

import java.util.List;
import vn.iotstar.dao.IProductDao;
import vn.iotstar.dao.impl.ProductDaoImpl;
import vn.iotstar.entity.Product;
import vn.iotstar.services.IProductService;

public class ProductServiceImpl implements IProductService {

    private IProductDao productDao = new ProductDaoImpl();

    @Override
    public void insert(Product product) {
        productDao.insert(product);
    }

    @Override
    public void update(Product product) {
        productDao.update(product);
    }

    @Override
    public void delete(int id) throws Exception {
        productDao.delete(id);
    }

    @Override
    public Product findById(int id) {
        return productDao.findById(id);
    }

    @Override
    public List<Product> findAll() {
        return productDao.findAll();
    }

    @Override
    public List<Product> getTop10Recent() {
        return productDao.getTop10Recent();
    }

    @Override
    public List<Product> findPagination(int page, int pageSize) {
        return productDao.findPagination(page, pageSize);
    }

    @Override
    public long countAll() {
        return productDao.countAll();
    }

    @Override
    public List<Product> searchByName(String keyword) {
        return productDao.searchByName(keyword);
    }

    @Override
    public List<Product> findByCategoryId(int categoryId) {
        return productDao.findByCategoryId(categoryId);
    }

    @Override
    public List<Product> search(String keyword, Integer categoryId, int page, int pageSize) {
        return productDao.search(keyword, categoryId, page, pageSize);
    }

    @Override
    public long countSearch(String keyword, Integer categoryId) {
        return productDao.countSearch(keyword, categoryId);
    }
}
