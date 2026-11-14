package com.fashionstore.dao.impl;

import com.fashionstore.dao.ProductDAO;
import com.fashionstore.model.Product;
import java.util.ArrayList;
import java.util.List;

public class ProductDAOImpl implements ProductDAO {

    @Override
    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        list.add(new Product(1, "Green Hoodie", "H&M", "Men", 1599, "Warm and comfortable green hoodie.", "hoodie.jpg", "S,M,L,XL"));
        list.add(new Product(2, "Unisex Cap", "Puma", "Accessories", 499, "Stylish unisex cap, adjustable size.", "cap.jpg", "Free Size"));
        list.add(new Product(3, "Men Blue T-Shirt", "H&M", "Men", 999, "Comfortable blue t-shirt for men.", "tshirt.jpg", "S,M,L,XL"));
        list.add(new Product(4, "Sunglasses", "RAY-BAN", "Accessories", 1299, "Cool black sunglasses with UV protection.", "sunglasses2.jpg", "Free Size"));
        list.add(new Product(5, "Floral Summer Dress", "Zara", "Women", 2499, "Beautiful floral summer dress for women.", "dress.jpg", "S,M,L,XL"));
        list.add(new Product(6, "Leather Jacket", "Zara", "Men", 2999, "Premium brown leather jacket.", "jacket.jpg", "S,M,L,XL"));
        list.add(new Product(7, "Black Sneakers", "Nike", "Men", 2299, "Comfortable black sneakers for daily wear.", "sneakers.jpg", "7,8,9,10"));
        list.add(new Product(8, "Women Handbag", "Zara", "Women", 1899, "Elegant light blue handbag for women.", "handbag.jpg", "Free Size"));
        list.add(new Product(9, "Blue Slim Fit Jeans", "Levis", "Women", 1999, "Stylish blue slim fit jeans.", "jeans.jpg", "28,30,32,34"));
        return list;
    }

    @Override
    public Product getById(int id) {
        for (Product p : getAllProducts()) {
            if (p.getId() == id) {
                return p;
            }
        }
        return null;
    }
}