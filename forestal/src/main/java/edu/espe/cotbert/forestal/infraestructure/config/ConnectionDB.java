package edu.espe.cotbert.forestal.infraestructure.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Logger;
import java.io.InputStream;
import java.io.IOException;

public class ConnectionDB {

    

    private static final String URL = "jdbc:postgresql://localhost:5432/forestal";
    private static final String USER = "forestal_tree";
    private static final String PASSWORD = "admin123";
    private static final Logger logger = LoggerConfig.getLogger();
    private static final String PROPERTIES_FILE = "/db.properties";
    private static String URL;
    private static String USER;
    private static String PASSWORD;

    static {
        try (InputStream input = ConnectionDB.class.getResourceAsStream(PROPERTIES_FILE)) {
            Properties prop = new Properties();

            if (input == null) {
                throw new IOException("Unable to find " + PROPERTIES_FILE);
            }

            prop.load(input);
            URL = prop.getProperty("db.url");
            USER = prop.getProperty("db.user");
            PASSWORD = prop.getProperty("db.password");

        } catch (IOException e) {
            logger.severe("Failed to load database configuration: " + e.getMessage());
        }
    }

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
            logger.info("Success DB Connection to " + URL);
            return conn;
        } catch (ClassNotFoundException e) {
            logger.severe("PostgreSQL Driver not found: " + e.getMessage());
            throw new SQLException("PostgreSQL Driver not found", e);
        } catch (SQLException e) {
            logger.severe("Error connecting to PostgreSQL: " + e.getMessage());
            throw e;
        }
    }
}
