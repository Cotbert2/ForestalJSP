/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package edu.espe.cotbert.forestal.domain.repository;

import edu.espe.cotbert.forestal.domain.model.ForestalZoneTreeSpecies;
import java.util.List;

/**
 *
 * @author jeffersonyepez
 */
public interface ForestalZoneTreeSpeciesRepository {
    void save(ForestalZoneTreeSpecies forestalZone);
    List<ForestalZoneTreeSpecies> findAll();
    ForestalZoneTreeSpecies findById(String uuid);
    void update(ForestalZoneTreeSpecies Zone);
    void delete(String uuid);
}
