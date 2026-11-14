package com.fashionstore.controller;

import com.fashionstore.dao.impl.ProductDAOImpl;
import com.fashionstore.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebServlet({"/product-details", "/store/product-details"})
public class ProductDetailsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            res.sendRedirect(req.getContextPath() + "/products");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idStr.trim());
        } catch (NumberFormatException e) {
            res.sendRedirect(req.getContextPath() + "/products");
            return;
        }

        ProductDAOImpl dao = new ProductDAOImpl();
        Product p = dao.getById(id);

        if (p == null) {
            res.sendRedirect(req.getContextPath() + "/products");
            return;
        }

        List<Product> all = dao.getAllProducts();
        req.setAttribute("product", p);
        req.setAttribute("allProducts", all);

        if (p.getSizes() != null && !p.getSizes().isEmpty()) {
            req.setAttribute("sizes", Arrays.asList(p.getSizes().split(",")));
        } else {
            req.setAttribute("sizes", Arrays.asList("Free Size"));
        }

        req.getRequestDispatcher("/WEB-INF/views/product-details.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        doGet(req, res);
    }
}