
package com.fashionstore.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.fashionstore.dao.ProductDAO;
import com.fashionstore.model.Product;
import com.fashionstore.util.DBConnection;

public class ProductDAOImpl implements ProductDAO {

    private Product mapProduct(ResultSet rs) throws Exception {

        Product p = new Product();

        p.setId(rs.getInt("id"));
        p.setName(rs.getString("name"));
        p.setBrand(rs.getString("brand"));
        p.setPrice(rs.getDouble("price"));
        p.setDescription(rs.getString("description"));
        p.setCategory(rs.getString("category"));
        p.setImage(rs.getString("image"));

        return p;
    }

    @Override
    public Product getProductById(int id) {

        String sql = "SELECT * FROM products WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapProduct(rs);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public List<Product> getAllProducts() {

        return filterProducts(
                null, null, 0, Double.MAX_VALUE, "default"
        );
    }

    @Override
    public List<Product> filterProducts(
            String search,
            String category,
            double minPrice,
            double maxPrice,
            String sortBy) {

        List<Product> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT * FROM products WHERE price BETWEEN ? AND ?"
        );

        if (search != null && !search.trim().isEmpty()) {
            sql.append(
                " AND (name LIKE ? OR brand LIKE ? OR description LIKE ?)"
            );
        }

        if (category != null && !category.trim().isEmpty()
                && !category.equalsIgnoreCase("All Categories")) {
            sql.append(" AND category = ?");
        }

        if ("low-high".equals(sortBy)) {
            sql.append(" ORDER BY price ASC");
        } else if ("high-low".equals(sortBy)) {
            sql.append(" ORDER BY price DESC");
        } else {
            sql.append(" ORDER BY id DESC");
        }

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            int i = 1;

            ps.setDouble(i++, minPrice);
            ps.setDouble(i++, maxPrice);

            if (search != null && !search.trim().isEmpty()) {
                String keyword = "%" + search.trim() + "%";

                ps.setString(i++, keyword);
                ps.setString(i++, keyword);
                ps.setString(i++, keyword);
            }

            if (category != null && !category.trim().isEmpty()
                    && !category.equalsIgnoreCase("All Categories")) {
                ps.setString(i++, category);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapProduct(rs));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
