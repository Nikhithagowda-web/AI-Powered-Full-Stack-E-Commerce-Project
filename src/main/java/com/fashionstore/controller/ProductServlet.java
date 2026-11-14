package com.fashionstore.controller;

import com.fashionstore.dao.impl.ProductDAOImpl;
import com.fashionstore.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

@WebServlet({"/products", "/store/products"})
public class ProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        ProductDAOImpl dao = new ProductDAOImpl();
        List<Product> all = dao.getAllProducts();

        String search = req.getParameter("search");
        if (search != null && !search.trim().isEmpty()) {
            String s = search.toLowerCase().trim();
            List<Product> filtered = new ArrayList<>();
            for (Product p : all) {
                if (p.getName().toLowerCase().contains(s)
                        || p.getBrand().toLowerCase().contains(s)
                        || p.getCategory().toLowerCase().contains(s)) {
                    filtered.add(p);
                }
            }
            all = filtered;
        }

        String category = req.getParameter("category");
        if (category != null && !category.trim().isEmpty()) {
            List<Product> filtered = new ArrayList<>();
            for (Product p : all) {
                if (p.getCategory().equalsIgnoreCase(category.trim())) {
                    filtered.add(p);
                }
            }
            all = filtered;
        }

        String minStr = req.getParameter("minPrice");
        String maxStr = req.getParameter("maxPrice");
        double min = 0;
        double max = 1000000;
        try { if (minStr != null && !minStr.trim().isEmpty()) min = Double.parseDouble(minStr.trim()); } catch (Exception e) {}
        try { if (maxStr != null && !maxStr.trim().isEmpty()) max = Double.parseDouble(maxStr.trim()); } catch (Exception e) {}
        if (minStr != null || maxStr != null) {
            List<Product> filtered = new ArrayList<>();
            for (Product p : all) {
                if (p.getPrice() >= min && p.getPrice() <= max) filtered.add(p);
            }
            all = filtered;
        }

        String sort = req.getParameter("sort");
        if ("low".equals(sort)) {
            all.sort(Comparator.comparingDouble(Product::getPrice));
        } else if ("high".equals(sort)) {
            all.sort((a, b) -> Double.compare(b.getPrice(), a.getPrice()));
        }

        req.setAttribute("products", all);
        req.setAttribute("category", category == null ? "" : category);
        req.setAttribute("search", search == null ? "" : search);
        req.getRequestDispatcher("/WEB-INF/views/products.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        doGet(req, res);
    }
}