
package com.fashionstore.dao.impl;

import com.fashionstore.dao.CartItemDAO;
import com.fashionstore.model.CartItem;
import com.fashionstore.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class CartItemDAOImpl implements CartItemDAO {

    // ADD PRODUCT TO CART
    @Override
    public boolean addToCart(int userId, int productId, int quantity) {

        if (quantity <= 0) {
            return false;
        }

        String findCart = "SELECT cart_id FROM cart WHERE user_id = ? LIMIT 1";

        String createCart = "INSERT INTO cart (user_id) VALUES (?)";

        String findItem = "SELECT cart_item_id FROM cart_items " +
                          "WHERE cart_id = ? AND product_id = ?";

        String updateItem = "UPDATE cart_items SET quantity = quantity + ? " +
                            "WHERE cart_id = ? AND product_id = ?";

        String insertItem = "INSERT INTO cart_items " +
                            "(cart_id, product_id, quantity) VALUES (?, ?, ?)";

        try (Connection con = DBConnection.getConnection()) {

            con.setAutoCommit(false);

            try {
                int cartId = 0;

                // Find existing cart
                try (PreparedStatement ps = con.prepareStatement(findCart)) {
                    ps.setInt(1, userId);

                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            cartId = rs.getInt("cart_id");
                        }
                    }
                }

                // Create cart if it does not exist
                if (cartId == 0) {

                    try (PreparedStatement ps = con.prepareStatement(
                            createCart, Statement.RETURN_GENERATED_KEYS)) {

                        ps.setInt(1, userId);
                        ps.executeUpdate();

                        try (ResultSet rs = ps.getGeneratedKeys()) {
                            if (rs.next()) {
                                cartId = rs.getInt(1);
                            }
                        }
                    }
                }

                if (cartId == 0) {
                    throw new Exception("Unable to create cart");
                }

                boolean itemExists = false;

                // Check whether product already exists
                try (PreparedStatement ps = con.prepareStatement(findItem)) {
                    ps.setInt(1, cartId);
                    ps.setInt(2, productId);

                    try (ResultSet rs = ps.executeQuery()) {
                        itemExists = rs.next();
                    }
                }

                // Update quantity or insert new product
                if (itemExists) {

                    try (PreparedStatement ps = con.prepareStatement(updateItem)) {
                        ps.setInt(1, quantity);
                        ps.setInt(2, cartId);
                        ps.setInt(3, productId);
                        ps.executeUpdate();
                    }

                } else {

                    try (PreparedStatement ps = con.prepareStatement(insertItem)) {
                        ps.setInt(1, cartId);
                        ps.setInt(2, productId);
                        ps.setInt(3, quantity);
                        ps.executeUpdate();
                    }
                }

                con.commit();
                return true;

            } catch (Exception e) {
                con.rollback();
                e.printStackTrace();
                return false;

            } finally {
                con.setAutoCommit(true);
            }

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // GET ALL CART PRODUCTS FOR A USER
    @Override
    public List<CartItem> getCartByUser(int userId) {

        List<CartItem> list = new ArrayList<>();

        String sql = "SELECT c.cart_id, c.user_id, ci.product_id, " +
                     "ci.quantity, p.name, p.price, p.image " +
                     "FROM cart c " +
                     "JOIN cart_items ci ON c.cart_id = ci.cart_id " +
                     "JOIN products p ON ci.product_id = p.id " +
                     "WHERE c.user_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    CartItem item = new CartItem();

                    item.setCartId(rs.getInt("cart_id"));
                    item.setUserId(rs.getInt("user_id"));
                    item.setProductId(rs.getInt("product_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setProductName(rs.getString("name"));
                    item.setPrice(rs.getDouble("price"));
                    item.setImage(rs.getString("image"));

                    list.add(item);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // UPDATE PRODUCT QUANTITY
    @Override
    public boolean updateQuantity(int userId, int productId, int quantity) {

        if (quantity <= 0) {
            return removeFromCart(userId, productId);
        }

        String sql = "UPDATE cart_items SET quantity = ? " +
                     "WHERE product_id = ? " +
                     "AND cart_id IN (SELECT cart_id FROM cart WHERE user_id = ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, quantity);
            ps.setInt(2, productId);
            ps.setInt(3, userId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // REMOVE PRODUCT FROM CART
    @Override
    public boolean removeFromCart(int userId, int productId) {

        String sql = "DELETE FROM cart_items " +
                     "WHERE product_id = ? " +
                     "AND cart_id IN (SELECT cart_id FROM cart WHERE user_id = ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, productId);
            ps.setInt(2, userId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // CLEAR USER CART
    @Override
    public boolean clearCart(int userId) {

        String sql = "DELETE FROM cart_items " +
                     "WHERE cart_id IN (SELECT cart_id FROM cart WHERE user_id = ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            return ps.executeUpdate() >= 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
