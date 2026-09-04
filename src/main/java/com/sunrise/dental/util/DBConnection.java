package com.sunrise.dental.util;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnection {

    private static String url;
    private static String user;
    private static String password;
    private static boolean initialized = false;

    private static synchronized void init() {
        if (initialized) {
            return;
        }
        try (InputStream in = DBConnection.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (in == null) {
                throw new RuntimeException(
                        "db.properties not found on classpath. Make sure it exists in src/main/resources.");
            }
            Properties props = new Properties();
            props.load(in);
            url = props.getProperty("db.url");
            user = props.getProperty("db.user");
            password = props.getProperty("db.password");

            Class.forName("com.mysql.cj.jdbc.Driver");
            initialized = true;
        } catch (Exception e) {
            throw new RuntimeException("Failed to initialise database configuration: " + e.getMessage(), e);
        }
    }

    public static Connection getConnection() throws SQLException {
        init();
        return DriverManager.getConnection(url, user, password);
    }
}
