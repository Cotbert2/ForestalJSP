/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package edu.espe.cotbert.forestal.util;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 *
 * @author sebrux
 */
public class MailSender {

    public static void sendEmail(String toEmail, String subject, String htmlContent) {

        String FROM_EMAIL;
        String APP_PASSWORD;
        final String PROPERTIES_FILE = "/db.properties";

        Properties props = new Properties();

        try (InputStream input = MailSender.class.getResourceAsStream("/db.properties")) {
            props.load(input);
            FROM_EMAIL = props.getProperty("email");
            APP_PASSWORD = props.getProperty("email.password");
        } catch (IOException ex) {
            ex.printStackTrace();
            return;
        }

        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");  // <- Aquí el fix

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
            }
        });

        try {
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(FROM_EMAIL));
            msg.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            msg.setSubject(subject);
            msg.setContent(htmlContent, "text/html; charset=utf-8");


            Transport.send(msg);
            System.out.println("Correo enviado a " + toEmail);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
