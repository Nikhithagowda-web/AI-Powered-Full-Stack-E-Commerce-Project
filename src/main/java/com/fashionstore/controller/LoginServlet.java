package com.fashionstore.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet({"/login", "/store/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        if (email == null) email = "";
        if (password == null) password = "";
        email = email.trim();
        password = password.trim();

        boolean ok = false;
        String name = "User";

        if (email.equals("admin@fashion.com") && password.equals("admin123")) {
            ok = true;
            name = "Admin";
        } else if (email.contains("@") && password.length() >= 4) {
            ok = true;
            name = email.split("@")[0];
        }

        if (ok) {
            HttpSession session = req.getSession();
            session.setAttribute("userEmail", email);
            session.setAttribute("userName", name);
            // FIXED - NOW GOES TO HOME PAGE, NOT PRODUCTS PAGE
            res.sendRedirect(req.getContextPath() + "/home");
        } else {
            req.setAttribute("error", "Invalid email or password! Try admin@fashion.com / admin123");
            req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, res);
        }
    }
}