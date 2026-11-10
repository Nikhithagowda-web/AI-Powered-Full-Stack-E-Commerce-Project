package com.fashionstore.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");
        if (cart == null) cart = new ArrayList<>();
        String action = request.getParameter("action");
        if ("add".equals(action)) {
            String id = request.getParameter("productId");
            String name = request.getParameter("productName");
            if (name == null) name = "Product " + id;
            String brand = request.getParameter("brand");
            if (brand == null) brand = "H&M";
            String size = request.getParameter("size");
            if (size == null) size = "XL";
            String image = request.getParameter("image");
            if (image == null) image = "";
            String priceStr = request.getParameter("price");
            if (priceStr == null) priceStr = "1299";
            int qty = 1;
            try { qty = Integer.parseInt(request.getParameter("quantity")); } catch (Exception e) {}
            double price = Double.parseDouble(priceStr);
            boolean found = false;
            for (Map<String, Object> item : cart) {
                if (String.valueOf(item.get("id")).equals(id)) {
                    item.put("quantity", (int) item.get("quantity") + qty);
                    found = true;
                }
            }
            if (!found) {
                Map<String, Object> item = new HashMap<>();
                item.put("id", id);
                item.put("name", name);
                item.put("brand", brand);
                item.put("size", size);
                item.put("image", image);
                item.put("price", price);
                item.put("quantity", qty);
                cart.add(item);
            }
        }
        if ("update".equals(action)) {
            String id = request.getParameter("productId");
            int newQty = 1;
            try { newQty = Integer.parseInt(request.getParameter("quantity")); } catch (Exception e) {}
            for (Map<String, Object> item : cart) {
                if (String.valueOf(item.get("id")).equals(id)) {
                    item.put("quantity", newQty);
                }
            }
        }
        if ("remove".equals(action)) {
            String id = request.getParameter("productId");
            cart.removeIf(item -> String.valueOf(item.get("id")).equals(id));
        }
        session.setAttribute("cart", cart);
        response.sendRedirect(request.getContextPath() + "/cart");
    }
}