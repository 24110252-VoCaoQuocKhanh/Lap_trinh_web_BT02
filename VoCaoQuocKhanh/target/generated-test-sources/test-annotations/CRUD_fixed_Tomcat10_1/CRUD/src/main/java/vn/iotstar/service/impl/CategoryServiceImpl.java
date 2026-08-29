package vn.iotstar.service.impl;

import java.io.File;
import java.util.List;

import vn.iotstar.dao.CategoryDao;
import vn.iotstar.dao.impl.CategoryDaoImpl;
import vn.iotstar.model.Category;
import vn.iotstar.service.CategoryService;
import vn.iotstar.util.Constant;

public class CategoryServiceImpl implements CategoryService {
    private final CategoryDao categoryDao = new CategoryDaoImpl();

    @Override
    public void insert(Category category) {
        categoryDao.insert(category);
    }

    @Override
    public void delete(int id) {
        Category category = categoryDao.get(id);
        if (category != null && category.getIcon() != null && !category.getIcon().isBlank()) {
            File file = new File(Constant.DIR, category.getIcon());
            if (file.isFile()) {
                file.delete();
            }
        }
        categoryDao.delete(id);
    }

    @Override
    public Category get(int id) {
        return categoryDao.get(id);
    }

    @Override
    public void edit(Category newCategory) {
        Category oldCategory = categoryDao.get(newCategory.getId());

        if (oldCategory == null) {
            return;
        }

        oldCategory.setName(newCategory.getName());

        if (newCategory.getIcon() != null && !newCategory.getIcon().isBlank()) {
            String oldIcon = oldCategory.getIcon();
            if (oldIcon != null && !oldIcon.isBlank()) {
                File oldFile = new File(Constant.DIR, oldIcon);
                if (oldFile.isFile()) {
                    oldFile.delete();
                }
            }
            oldCategory.setIcon(newCategory.getIcon());
        }

        categoryDao.edit(oldCategory);
    }

    @Override
    public Category get(String name) {
        return categoryDao.get(name);
    }

    @Override
    public List<Category> getAll() {
        return categoryDao.getAll();
    }

    @Override
    public List<Category> search(String keyword) {
        return categoryDao.search(keyword);
    }
}
