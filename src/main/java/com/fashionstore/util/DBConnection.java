
package com.fashionstore.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String DB_URL =
            System.getenv("DB_URL");

    private static final String DB_USER =
            System.getenv("DB_USER");

    private static final String DB_PASSWORD =
            System.getenv("DB_PASSWORD");

    public static Connection getConnection()
            throws SQLException {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException(
                    "MySQL JDBC Driver not found", e
            );
        }

        if (DB_URL == null || DB_URL.isBlank()) {
            throw new SQLException("DB_URL is missing");
        }

        if (DB_USER == null || DB_USER.isBlank()) {
            throw new SQLException("DB_USER is missing");
        }

        if (DB_PASSWORD == null || DB_PASSWORD.isBlank()) {
            throw new SQLException("DB_PASSWORD is missing");
        }

        return DriverManager.getConnection(
                DB_URL,
                DB_USER,
                DB_PASSWORD
        );
    }
}
