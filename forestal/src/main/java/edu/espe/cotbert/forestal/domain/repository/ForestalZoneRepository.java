/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package edu.espe.cotbert.forestal.domain.repository;

import edu.espe.cotbert.forestal.domain.model.ForestalZone;
import java.util.List;

/**
 *
 * @author mateo
 */

public interface ForestalZoneRepository {
    void save(ForestalZone forestalZone);
    List<ForestalZone> findAll();
    ForestalZone findById(String uuid);
    void update(ForestalZone Zone);
    void delete(String uuid);
}
