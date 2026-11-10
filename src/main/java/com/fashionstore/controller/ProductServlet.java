
package com.fashionstore.controller;

import java.io.IOException;
import java.util.List;

import com.fashionstore.dao.ProductDAO;
import com.fashionstore.dao.impl.ProductDAOImpl;
import com.fashionstore.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {

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

        try {

            String search = request.getParameter("search");
            String category = request.getParameter("category");
            String sortBy = request.getParameter("sortBy");

            double minPrice = 0;
            double maxPrice = Double.MAX_VALUE;

            String min = request.getParameter("minPrice");
            String max = request.getParameter("maxPrice");

            if (min != null && !min.trim().isEmpty()) {
                minPrice = Double.parseDouble(min);
            }

            if (max != null && !max.trim().isEmpty()) {
                maxPrice = Double.parseDouble(max);
            }

            if (minPrice < 0 || maxPrice < minPrice) {
                response.sendError(400, "Invalid price range");
                return;
            }

            List<Product> products = productDAO.filterProducts(
                    search, category, minPrice, maxPrice, sortBy
            );

            request.setAttribute("products", products);

            request.getRequestDispatcher(
                    "/WEB-INF/views/products.jsp"
            ).forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(400, "Invalid price entered");

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error loading products", e);
        }
    }
}
