
package com.fashionstore.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
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

@WebServlet("/order-confirmation")
public class OrderConfirmationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String orderIdParam = request.getParameter("orderId");

        if (orderIdParam == null || orderIdParam.trim().isEmpty()) {
            response.sendError(400, "Order ID is required.");
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdParam);

            User user = (User) session.getAttribute("user");

            String orderSql =
                "SELECT * FROM orders WHERE order_id = ? AND user_id = ?";

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(orderSql)) {

                ps.setInt(1, orderId);
                ps.setInt(2, user.getUserId());

                try (ResultSet rs = ps.executeQuery()) {

                    if (!rs.next()) {
                        response.sendError(404, "Order not found.");
                        return;
                    }

                    Timestamp orderDate = rs.getTimestamp("order_date");

                    request.setAttribute("orderId",
                            rs.getInt("order_id"));

                    request.setAttribute("totalAmount",
                            rs.getDouble("total_amount"));

                    request.setAttribute("orderDate", orderDate);

                    request.setAttribute("orderStatus",
                            rs.getString("status"));

                    request.setAttribute("paymentMethod",
                            rs.getString("payment_method"));

                    request.setAttribute("paymentStatus",
                            rs.getString("payment_status"));

                    request.setAttribute("shippingAddress",
                            rs.getString("shipping_address"));

                    // Estimated delivery: 5 days after order date
                    if (orderDate != null) {
                        Calendar calendar = Calendar.getInstance();
                        calendar.setTimeInMillis(orderDate.getTime());
                        calendar.add(Calendar.DAY_OF_MONTH, 5);

                        request.setAttribute("expectedDeliveryDate",
                                calendar.getTime());
                    }

                }
            }

            // Retrieve all products belonging to this order
            List<Map<String, Object>> orderItems = new ArrayList<>();

            String itemSql =
                "SELECT oi.product_id, oi.quantity, oi.price, " +
                "p.name, p.image " +
                "FROM order_items oi " +
                "JOIN products p ON oi.product_id = p.id " +
                "WHERE oi.order_id = ?";

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(itemSql)) {

                ps.setInt(1, orderId);

                try (ResultSet rs = ps.executeQuery()) {

                    while (rs.next()) {

                        Map<String, Object> item = new HashMap<>();

                        item.put("productId",
                                rs.getInt("product_id"));

                        item.put("productName",
                                rs.getString("name"));

                        item.put("productImage",
                                rs.getString("image"));

                        item.put("quantity",
                                rs.getInt("quantity"));

                        item.put("price",
                                rs.getDouble("price"));

                        item.put("subtotal",
                                rs.getDouble("price") *
                                rs.getInt("quantity"));

                        orderItems.add(item);
                    }
                }
            }

            request.setAttribute("orderItems", orderItems);

            request.getRequestDispatcher(
                "/WEB-INF/views/order-confirmation.jsp")
                .forward(request, response);

        } catch (NumberFormatException e) {

            response.sendError(400, "Invalid order ID.");

        } catch (Exception e) {

            throw new ServletException(
                "Unable to load order confirmation.", e);
        }
    }
}
