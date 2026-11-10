
package com.fashionstore.controller;

import java.io.IOException;

import com.fashionstore.dao.ProductDAO;
import com.fashionstore.dao.impl.ProductDAOImpl;
import com.fashionstore.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/product-details")
public class ProductDetailsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
                         throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendError(400, "Product ID is required");
            return;
        }

        try {

            int id = Integer.parseInt(idParam);

            Product product = productDAO.getProductById(id);

            if (product == null) {
                response.sendError(404, "Product not found");
                return;
            }

            request.setAttribute("product", product);

            request.getRequestDispatcher(
                    "/WEB-INF/views/product-details.jsp"
            ).forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(400, "Invalid product ID");
        }
    }
}
