package edu.espe.cotbert.forestal.infraestructure.config;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author mateo
 */

import java.util.logging.ConsoleHandler;
import java.util.logging.FileHandler;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.logging.SimpleFormatter;

public class LoggerConfig {
    private static final Logger logger = Logger.getLogger("edu.espe.cotbert");

    static {
        try {
            logger.setLevel(Level.ALL);

            if (logger.getHandlers().length == 0) {
                ConsoleHandler consoleHandler = new ConsoleHandler();
                consoleHandler.setLevel(Level.INFO);
                logger.addHandler(consoleHandler);

                FileHandler fileHandler = new FileHandler("logs/app.log", true);
                fileHandler.setFormatter(new SimpleFormatter());
                fileHandler.setLevel(Level.ALL);
                logger.addHandler(fileHandler);
            }

        } catch (Exception e) {
            System.err.println("Error initializing logger: " + e.getMessage());
        }
    }

    public static Logger getLogger() {
        return logger;
    }
}