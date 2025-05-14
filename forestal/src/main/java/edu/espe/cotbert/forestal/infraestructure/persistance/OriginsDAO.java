/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package edu.espe.cotbert.forestal.infraestructure.persistance;

import edu.espe.cotbert.forestal.domain.model.Origins;
import edu.espe.cotbert.forestal.domain.repository.OriginsRepository;
import edu.espe.cotbert.forestal.infraestructure.config.ConnectionDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 *
 * @author sebrux
 */
public class OriginsDAO implements OriginsRepository{
    
    

    @Override
    public List<Origins> findAll() {
        List<Origins> origins = new ArrayList<>();
        try (Connection conn = ConnectionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(ConstantsDB.GET_ALL_ORIGINS);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Origins origin = new Origins(
                        rs.getString("uuid_origin"),
                        rs.getString("name_origin")
                );
                origins.add(origin);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return origins;
    }

    @Override
    public Origins findById(String uuid) {
        Origins origin = null;
        try (Connection conn = ConnectionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(ConstantsDB.GET_BY_ID_ORIGIN)) {

            stmt.setObject(1, UUID.fromString(uuid));
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    origin = new Origins(
                            rs.getString("uuid_origin"),
                            rs.getString("name_origin")
                    );
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return origin;
    }

    @Override
    public void save(Origins origin) {
        try (Connection conn = ConnectionDB.getConnection();
         PreparedStatement stmt = conn.prepareStatement(ConstantsDB.CREATE_ORIGINS)) {
        stmt.setObject(1, UUID.fromString(origin.getUuid_origin()));
        stmt.setString(2, origin.getName_origin());
        stmt.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
    }
    
}
