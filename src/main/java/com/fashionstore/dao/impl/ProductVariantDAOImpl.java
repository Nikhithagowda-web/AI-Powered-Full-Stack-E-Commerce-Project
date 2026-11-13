package com.fashionstore.dao.impl;

import com.fashionstore.dao.ProductVariantDAO;
import com.fashionstore.model.ProductVariant;
import com.fashionstore.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductVariantDAOImpl implements ProductVariantDAO {

    @Override
    public boolean addVariant(ProductVariant variant) {
        String sql = "INSERT INTO product_variants "
                + "(product_id, size, color, price, stock_quantity) "
                + "VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, variant.getProductId());
            ps.setString(2, variant.getSize());
            ps.setString(3, variant.getColor());
            ps.setDouble(4, variant.getPrice());
            ps.setInt(5, variant.getStockQuantity());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public ProductVariant getVariantById(int variantId) {
        String sql = "SELECT * FROM product_variants WHERE variant_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, variantId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapProductVariant(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<ProductVariant> getVariantsByProductId(int productId) {
        List<ProductVariant> variants = new ArrayList<>();
        String sql = "SELECT * FROM product_variants WHERE product_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) variants.add(mapProductVariant(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return variants;
    }

    @Override
    public List<ProductVariant> getAllVariants() {
        List<ProductVariant> variants = new ArrayList<>();
        String sql = "SELECT * FROM product_variants";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) variants.add(mapProductVariant(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return variants;
    }

    @Override
    public boolean updateVariant(ProductVariant variant) {
        String sql = "UPDATE product_variants SET product_id = ?, "
                + "size = ?, color = ?, price = ?, stock_quantity = ? "
                + "WHERE variant_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, variant.getProductId());
            ps.setString(2, variant.getSize());
            ps.setString(3, variant.getColor());
            ps.setDouble(4, variant.getPrice());
            ps.setInt(5, variant.getStockQuantity());
            ps.setInt(6, variant.getVariantId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteVariant(int variantId) {
        String sql = "DELETE FROM product_variants WHERE variant_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, variantId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private ProductVariant mapProductVariant(ResultSet rs) throws SQLException {
        ProductVariant variant = new ProductVariant();
        variant.setVariantId(rs.getInt("variant_id"));
        variant.setProductId(rs.getInt("product_id"));
        variant.setSize(rs.getString("size"));
        variant.setColor(rs.getString("color"));
        variant.setPrice(rs.getDouble("price"));
        variant.setStockQuantity(rs.getInt("stock_quantity"));
        return variant;
    }
}
