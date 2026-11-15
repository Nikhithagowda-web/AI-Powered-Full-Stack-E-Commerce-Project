
package com.fashionstore.controller;

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
                         HttpServletResponse response) throws IOException {

        String imageName = request.getPathInfo();

        if (imageName == null || imageName.length() < 2) {
            response.sendError(404);
            return;
        }

        imageName = imageName.substring(1);

        if (imageName.contains("/") || imageName.contains("\\") ||
            imageName.contains("..")) {
            response.sendError(400);
            return;
        }

        String resourcePath = "/images/" + imageName;

        try (InputStream input =
                 getServletContext().getResourceAsStream(resourcePath)) {

            if (input == null) {
                response.sendError(404);
                return;
            }

            String contentType = getServletContext().getMimeType(imageName);
            response.setContentType(
                contentType != null ? contentType : "application/octet-stream"
            );

            try (OutputStream output = response.getOutputStream()) {
                input.transferTo(output);
            }
        }
    }
}
