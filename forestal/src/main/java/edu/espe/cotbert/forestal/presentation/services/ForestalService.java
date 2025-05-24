package edu.espe.cotbert.forestal.presentation.services;

import edu.espe.cotbert.forestal.domain.model.ForestalZone;
import edu.espe.cotbert.forestal.domain.model.TreeSpecies;
import edu.espe.cotbert.forestal.infraestructure.persistance.ForestalZoneDAO;
import edu.espe.cotbert.forestal.infraestructure.persistance.TreeSpeciesDAO;
import jakarta.jws.WebParam;
import jakarta.jws.WebService;
import java.sql.Timestamp;
import java.util.List;

/**
 *
 * @author mateo
 */
@WebService(serviceName = "ForestalSOAP")
public class ForestalService implements Router {

    private ForestalZoneDAO forestalZoneDAO = new ForestalZoneDAO();
    private TreeSpeciesDAO treeSpeciesDAO = new TreeSpeciesDAO();

    @Override
    public List<ForestalZone> getForestalZones() {
        return forestalZoneDAO.findAll();
    }

    @Override
    public Boolean createForestalZone(
            @WebParam(name =  "name") String name, 
            @WebParam(name =  "description") String description,
            @WebParam(name =  "area") float area, 
            @WebParam(name =  "image") String image,
            @WebParam(name =  "registerDate") String registerDate, 
            @WebParam(name =  "mapJson") String mapJson) {
        return forestalZoneDAO.save(new ForestalZone(
                name, description, area, image, Timestamp.valueOf(registerDate), mapJson
        ));
    }

    @Override
    public Boolean deleteTreeSpecie(@WebParam(name = "uuid") String uuid) {
        System.out.println("Received UUID: " + uuid);
        return treeSpeciesDAO.delete(uuid);
    }

    @Override
    public List<TreeSpecies> getTreeeSpecies() {
        return treeSpeciesDAO.findAll();

    }
}
