package edu.espe.cotbert.forestal.presentation.services;

import edu.espe.cotbert.forestal.domain.model.ForestalZone;
import edu.espe.cotbert.forestal.domain.model.TreeSpecies;
import jakarta.jws.WebMethod;
import java.sql.Timestamp;
import java.util.List;

/**
 *
 * @author mateo
 */
public interface Router {
    @WebMethod
    List<ForestalZone> getForestalZones();

    @WebMethod
    List<TreeSpecies> getTreeeSpecies();
    
    @WebMethod
    Boolean createForestalZone(
            String name, String description, 
            float area, String image, 
            String registerDate, String mapJson
    );
    
    @WebMethod
    Boolean deleteTreeSpecie(
            String uuid
    );
}
