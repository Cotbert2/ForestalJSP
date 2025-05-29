/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package edu.espe.cotbert.forestal.util;

import edu.espe.cotbert.forestal.domain.model.security.PasswordHasher;

/**
 *
 * @author sebrux
 */
public class Main {
    public static void main(String[] args) {
        String hash = PasswordHasher.hash("root1234"); // tu contraseña deseada
        System.out.println("Hash generado: " + hash);
    }
}
