
package com.fashionstore.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

@WebServlet("/images/*")
public class ImageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String imageName = request.getPathInfo();

        if (imageName == null || imageName.equals("/")) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        if (imageName.contains("..") || imageName.contains("/")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        String resourcePath = "/images" + imageName;

        try (InputStream input =
                     getServletContext().getResourceAsStream(resourcePath)) {

            if (input == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            response.setContentType(
                getServletContext().getMimeType(imageName)
            );

            response.setHeader("Cache-Control", "public, max-age=86400");

            try (OutputStream output = response.getOutputStream()) {
                input.transferTo(output);
            }
        }
    }
}
