
package com.fashionstore.dao;

import java.util.List;
import com.fashionstore.model.Product;

public interface ProductDAO {

    Product getProductById(int id);

    List<Product> getAllProducts();

    List<Product> filterProducts(
            String search,
            String category,
            double minPrice,
            double maxPrice,
            String sortBy
    );
}
