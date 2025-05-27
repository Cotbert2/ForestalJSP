package edu.espe.cotbert.forestal.domain.model.security;

import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author mateo
 */
public class PasswordHasher {
    public static String hash(String plainText) {
        return BCrypt.hashpw(plainText, BCrypt.gensalt());
    }
    
    public static boolean verify(String plainText, String hashed) {
        return BCrypt.checkpw(plainText, hashed);
    }
}
