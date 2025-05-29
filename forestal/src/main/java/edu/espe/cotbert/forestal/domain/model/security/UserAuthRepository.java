package edu.espe.cotbert.forestal.domain.model.security;

import edu.espe.cotbert.forestal.domain.model.security.UserAuthModel;
import java.util.List;

/**
 *
 * @author mateo
 */
public interface UserAuthRepository {
    UserAuthModel getUserByEmail(String email);
    boolean createUser(UserAuthModel user);
    List<UserAuthModel> findAll();
    boolean updateUser(UserAuthModel user);
    void delete(String uuid);
}
