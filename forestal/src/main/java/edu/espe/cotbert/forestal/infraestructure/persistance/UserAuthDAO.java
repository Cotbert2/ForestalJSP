package edu.espe.cotbert.forestal.infraestructure.persistance;

import edu.espe.cotbert.forestal.domain.model.security.UserAuthModel;
import edu.espe.cotbert.forestal.domain.model.security.UserAuthRepository;
import edu.espe.cotbert.forestal.infraestructure.config.ConnectionDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 *
 * @author mateo
 */
public class UserAuthDAO implements UserAuthRepository {

    private static final java.util.logging.Logger logger = java.util.logging.Logger.getLogger(UserAuthDAO.class.getName());

    
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

    @Override
    public List<UserAuthModel> findAll() {
        List<UserAuthModel> users = new ArrayList<>();
        try (Connection conn = ConnectionDB.getConnection(); PreparedStatement stmt = conn.prepareStatement(ConstantsDB.GET_ALL_USERS); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                UserAuthModel user = new UserAuthModel(
                        rs.getString("uuid_users"),
                        rs.getString("email_users"),
                        rs.getString("phone_users"),
                        rs.getString("first_name_users"),
                        rs.getString("last_name_users"),
                        rs.getString("role_users")
                );
                users.add(user);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }

    @Override
    public boolean updateUser(UserAuthModel user) {
        try (Connection conn = ConnectionDB.getConnection(); PreparedStatement stmt = conn.prepareStatement(ConstantsDB.UPDATE_USERS)) {

            stmt.setString(1, user.getEmailUsers());
            stmt.setString(2, user.getPhoneUsers());
            stmt.setString(3, user.getFirstNameUsers());
            stmt.setString(4, user.getLastNameUsers());
            stmt.setString(5, user.getRoleUsers());
            stmt.setObject(6, UUID.fromString(user.getUuidUsers()));

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public void delete(String uuid) {
        try (Connection conn = ConnectionDB.getConnection(); PreparedStatement stmt = conn.prepareStatement(ConstantsDB.DELETE_USER)) {

            stmt.setObject(1, UUID.fromString(uuid), java.sql.Types.OTHER);
            stmt.executeUpdate();
            logger.info("User deleted successfully");

        } catch (Exception e) {
            logger.severe("Error deleting ForestalZone: " + e.getMessage());
        }
    }

}
