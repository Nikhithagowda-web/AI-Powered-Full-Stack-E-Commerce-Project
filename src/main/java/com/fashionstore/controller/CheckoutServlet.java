package com.fashionstore.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Random;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            request.setAttribute("error", "Your cart is empty.");
            request.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(request, response);
            return;
        }
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String payment = request.getParameter("paymentMethod");
        if (payment == null) payment = "COD";
        double total = 0;
        for (Map<String, Object> item : cart) {
            total += (double) item.get("price") * (int) item.get("quantity");
        }
        request.setAttribute("orderId", new Random().nextInt(9000) + 1000);
        request.setAttribute("orderDate", new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date()));
        request.setAttribute("paymentMethod", payment);
        request.setAttribute("status", "PLACED");
        request.setAttribute("totalAmount", total);
        request.setAttribute("orderItems", cart);
        request.setAttribute("customerName", name);
        request.setAttribute("customerPhone", phone);
        request.setAttribute("customerAddress", address);
        request.setAttribute("customerCity", city);
        request.setAttribute("customerState", state);
        session.removeAttribute("cart");
        request.getRequestDispatcher("/WEB-INF/views/order-confirmation.jsp").forward(request, response);
    }
}