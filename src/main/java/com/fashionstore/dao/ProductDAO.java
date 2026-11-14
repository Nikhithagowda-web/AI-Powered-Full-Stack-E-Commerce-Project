package com.fashionstore.dao;

import com.fashionstore.model.Product;
import java.util.List;

public interface ProductDAO {
    List<Product> getAllProducts();
    Product getById(int id);
}