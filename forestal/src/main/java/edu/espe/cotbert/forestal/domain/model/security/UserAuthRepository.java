package edu.espe.cotbert.forestal.domain.model.security;

import edu.espe.cotbert.forestal.domain.model.security.UserAuthModel;

/**
 *
 * @author mateo
 */
public interface UserAuthRepository {
    UserAuthModel getUserByEmail(String email);
    boolean createUser(UserAuthModel user);
}
