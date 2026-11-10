
package com.fashionstore.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DatabaseSelectTest {

    public static void main(String[] args) {

        String query = "SELECT * FROM categories";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery()
        ) {

            System.out.println("Categories in Fashion Store:");
            System.out.println("-----------------------------");

            while (rs.next()) {

                int categoryId = rs.getInt("category_id");
                String categoryName = rs.getString("category_name");
                String description = rs.getString("description");

                System.out.println("Category ID: " + categoryId);
                System.out.println("Category Name: " + categoryName);
                System.out.println("Description: " + description);

                System.out.println("-----------------------------");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
