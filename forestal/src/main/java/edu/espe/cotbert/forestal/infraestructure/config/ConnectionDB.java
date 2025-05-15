/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package edu.espe.cotbert.forestal.infraestructure.config;

import edu.espe.cotbert.forestal.infraestructure.config.LoggerConfig;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Logger;

/**
 *
 * @author mateo
 */
public class ConnectionDB {
    

    private static final String URL = "jdbc:postgresql://localhost:5433/forestal";
    private static final String USER = "forestal_tree";
    private static final String PASSWORD = "admin123";
    private static final Logger logger = LoggerConfig.getLogger();


    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("org.postgresql.Driver");

            Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
            logger.info("Succes DB Connectino " + URL);
            return conn;

        } catch (ClassNotFoundException e) {
            logger.severe("Driver PostgreSQL not found: " + e.getMessage());
            throw new SQLException("Driver PostgreSQL not found", e);

        } catch (SQLException e) {
            logger.severe("Error connecting PostgreSQL: " + e.getMessage());
            throw e; 
        }
    }
}
