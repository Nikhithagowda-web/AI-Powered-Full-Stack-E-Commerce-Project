package com.fashionstore.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fashionstore.model.User;
import com.fashionstore.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/my-orders")
public class MyOrdersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        int userId = user.getUserId();

        List<Map<String, Object>> ordersList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {
            String orderSql = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC";
            try (PreparedStatement ps = con.prepareStatement(orderSql)) {
                ps.setInt(1, userId);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        Map<String, Object> order = new HashMap<>();
                        int orderId = rs.getInt("id");
                        order.put("id", orderId);
                        order.put("total", rs.getBigDecimal("total_amount"));
                        order.put("status", rs.getString("status"));
                        order.put("paymentMethod", rs.getString("payment_method"));
                        order.put("paymentStatus", rs.getString("payment_status"));
                        order.put("address", rs.getString("shipping_address"));
                        order.put("date", rs.getTimestamp("order_date"));

                        // Get items for this order
                        List<Map<String, Object>> items = new ArrayList<>();
                        String itemSql = "SELECT oi.quantity, oi.price, p.name as product_name, p.image_url as image FROM order_items oi JOIN products p ON oi.product_id = p.id WHERE oi.order_id = ?";
                        try (PreparedStatement ps2 = con.prepareStatement(itemSql)) {
                            ps2.setInt(1, orderId);
                            try (ResultSet rs2 = ps2.executeQuery()) {
                                while (rs2.next()) {
                                    Map<String, Object> item = new HashMap<>();
                                    item.put("name", rs2.getString("product_name"));
                                    item.put("quantity", rs2.getInt("quantity"));
                                    item.put("price", rs2.getBigDecimal("price"));
                                    item.put("image", rs2.getString("image"));
                                    items.add(item);
                                }
                            }
                        }
                        order.put("items", items);
                        ordersList.add(order);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("orders", ordersList);
        request.getRequestDispatcher("/WEB-INF/views/my-orders.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}