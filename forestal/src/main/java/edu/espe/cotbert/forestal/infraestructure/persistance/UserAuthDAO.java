package edu.espe.cotbert.forestal.infraestructure.persistance;

import edu.espe.cotbert.forestal.domain.model.security.UserAuthModel;
import edu.espe.cotbert.forestal.domain.model.security.UserAuthRepository;
import edu.espe.cotbert.forestal.infraestructure.config.ConnectionDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.UUID;

/**
 *
 * @author mateo
 */
public class UserAuthDAO implements UserAuthRepository {

    @Override
    public UserAuthModel getUserByEmail(String email) {
        try (Connection conn = ConnectionDB.getConnection(); PreparedStatement stmt = conn.prepareStatement(ConstantsDB.GET_USER_BY_EMAIL)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new UserAuthModel(
                        rs.getString("uuid_users"),
                        rs.getString("email_users"),
                        rs.getString("phone_users"),
                        rs.getString("first_name_users"),
                        rs.getString("last_name_users"),
                        rs.getString("role_users"),
                        rs.getString("password_users")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean createUser(UserAuthModel user) {

        try (Connection conn = ConnectionDB.getConnection(); PreparedStatement stmt = conn.prepareStatement(ConstantsDB.CREATE_USER)) {

            stmt.setObject(1, UUID.fromString(user.getUuidUsers()));
            stmt.setString(2, user.getEmailUsers());
            stmt.setString(3, user.getPhoneUsers());
            stmt.setString(4, user.getFirstNameUsers());
            stmt.setString(5, user.getLastNameUsers());
            stmt.setString(6, user.getPassword());
            stmt.setString(7, user.getRoleUsers());
            stmt.setBoolean(8, true);
            
            System.out.println("Phone: " + user.getPhoneUsers());
System.out.println("Role: " + user.getRoleUsers());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
