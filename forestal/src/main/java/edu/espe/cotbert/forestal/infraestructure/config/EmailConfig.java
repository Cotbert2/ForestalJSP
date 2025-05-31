/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package edu.espe.cotbert.forestal.infraestructure.config;

/**
 *
 * @author sebrux
 */
public class EmailConfig {
    
    
    
    public static final String EMAIL_STRUCTURE= "<!DOCTYPE html>\n"
                + "<html lang=\"en\">\n"
                + "<head>\n"
                + "  <meta charset=\"UTF-8\">\n"
                + "  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
                + "  <title>Welcome | Run Forest, Run!</title>\n"
                + "</head>\n"
                + "<body style=\"background-color: #f0fdf4; font-family: Arial, sans-serif; color: #1f2937; margin: 0; padding: 0;\">\n"
                + "  <div style=\"max-width: 600px; margin: 2rem auto; background: #ffffff; border-radius: 10px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); padding: 2rem;\">\n"
                + "    <div style=\"text-align: center; margin-bottom: 1.5rem;\">\n"
                + "      <h1 style=\"color: #047857; font-size: 24px; margin: 0;\">Welcome to Run Forest, Run!</h1>\n"
                + "    </div>\n"
                + "    <div style=\"font-size: 16px; line-height: 1.6; color: #374151;\">\n"
                + "      <p>Hi <strong> {{firstName}} </strong>,</p>\n"
                + "      <p>Thank you for registering in our Forestal System.</p>\n"
                + "      <p>You can now log in and start exploring the platform's features designed to protect and manage our forest zones.</p>\n"
                + "      <p>If you didn't create this account, please ignore this email.</p>\n"
                + "      <p style=\"margin-top: 2rem; justify-content: center; text-align: center\">\n"
                + "        <a href=\"https://forestal/login\"\n"
                + "           style=\"display:inline-block; padding:10px 20px; background-color:#047857; color:#ffffff; text-decoration:none; border-radius:8px; font-weight:bold;\">\n"
                + "          Log In Now\n"
                + "        </a>\n"
                + "      </p>\n"
                + "    </div>\n"
                + "    <div style=\"text-align: center; margin-top: 2rem; font-size: 12px; color: #9ca3af;\">\n"
                + "      &copy; 2025 Run Forest, Run! All rights reserved.\n"
                + "    </div>\n"
                + "  </div>\n"
                + "</body>\n"
                + "</html>";
}
