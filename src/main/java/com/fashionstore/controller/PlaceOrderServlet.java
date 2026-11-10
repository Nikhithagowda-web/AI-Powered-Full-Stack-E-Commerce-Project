
package com.fashionstore.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.fashionstore.model.User;
import com.fashionstore.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/place-order")
public class PlaceOrderServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        int userId = user.getUserId();

        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String pincode = request.getParameter("pincode");
        String paymentMethod = request.getParameter("paymentMethod");

        if (isEmpty(address) || isEmpty(city) ||
            isEmpty(state) || isEmpty(pincode) ||
            isEmpty(paymentMethod)) {

            request.setAttribute("errorMessage",
                    "Please fill in all required fields.");

            request.getRequestDispatcher(
                    "/WEB-INF/views/checkout.jsp").forward(request, response);
            return;
        }

        try (Connection con = DBConnection.getConnection()) {

            con.setAutoCommit(false);

            try {
                int cartId = 0;

                // Get user's cart
                String cartSql =
                        "SELECT cart_id FROM cart WHERE user_id = ?";

                try (PreparedStatement ps = con.prepareStatement(cartSql)) {
                    ps.setInt(1, userId);

                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            cartId = rs.getInt("cart_id");
                        }
                    }
                }

                if (cartId == 0) {
                    throw new SQLException("Your cart is empty.");
                }

                // Calculate total amount
                double totalAmount = 0;

                String totalSql =
                    "SELECT SUM(p.price * ci.quantity) AS total " +
                    "FROM cart_items ci " +
                    "JOIN product_variants pv ON ci.variant_id = pv.variant_id " +
                    "JOIN products p ON pv.product_id = p.product_id " +
                    "WHERE ci.cart_id = ?";

                try (PreparedStatement ps = con.prepareStatement(totalSql)) {
                    ps.setInt(1, cartId);

                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            totalAmount = rs.getDouble("total");
                        }
                    }
                }

                if (totalAmount <= 0) {
                    throw new SQLException("Your cart is empty.");
                }

                // Insert order
                String orderSql =
                    "INSERT INTO orders " +
                    "(user_id, total_amount, shipping_address, city, state, " +
                    "pincode, payment_method, order_status) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

                int orderId;

                try (PreparedStatement ps = con.prepareStatement(
                        orderSql, PreparedStatement.RETURN_GENERATED_KEYS)) {

                    ps.setInt(1, userId);
                    ps.setDouble(2, totalAmount);
                    ps.setString(3, address);
                    ps.setString(4, city);
                    ps.setString(5, state);
                    ps.setString(6, pincode);
                    ps.setString(7, paymentMethod);
                    ps.setString(8, "PLACED");

                    ps.executeUpdate();

                    try (ResultSet rs = ps.getGeneratedKeys()) {
                        if (!rs.next()) {
                            throw new SQLException("Order ID was not generated.");
                        }
                        orderId = rs.getInt(1);
                    }
                }

                // Insert order items
                String itemsSql =
                    "INSERT INTO order_items " +
                    "(order_id, variant_id, quantity, price) " +
                    "SELECT ?, ci.variant_id, ci.quantity, p.price " +
                    "FROM cart_items ci " +
                    "JOIN product_variants pv ON ci.variant_id = pv.variant_id " +
                    "JOIN products p ON pv.product_id = p.product_id " +
                    "WHERE ci.cart_id = ?";

                try (PreparedStatement ps = con.prepareStatement(itemsSql)) {
                    ps.setInt(1, orderId);
                    ps.setInt(2, cartId);
                    ps.executeUpdate();
                }

                // Clear cart after successful order
                String deleteSql =
                        "DELETE FROM cart_items WHERE cart_id = ?";

                try (PreparedStatement ps = con.prepareStatement(deleteSql)) {
                    ps.setInt(1, cartId);
                    ps.executeUpdate();
                }

                con.commit();

                response.sendRedirect(
                    request.getContextPath() +
                    "/order-confirmation?orderId=" + orderId
                );

            } catch (Exception e) {
                con.rollback();

                request.setAttribute("errorMessage", e.getMessage());

                request.getRequestDispatcher(
                    "/WEB-INF/views/checkout.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            throw new ServletException("Unable to place your order.", e);
        }
    }

    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }
}
