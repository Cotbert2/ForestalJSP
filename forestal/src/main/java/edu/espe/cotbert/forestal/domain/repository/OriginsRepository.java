/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package edu.espe.cotbert.forestal.domain.repository;

import edu.espe.cotbert.forestal.domain.model.Origins;
import java.util.List;

/**
 *
 * @author sebrux
 */
public interface OriginsRepository {
    void save(Origins origin);
    List<Origins> findAll();
    Origins findById(String uuid);
}
