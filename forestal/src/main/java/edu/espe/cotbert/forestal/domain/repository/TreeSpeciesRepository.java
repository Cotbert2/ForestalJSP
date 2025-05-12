
package edu.espe.cotbert.forestal.domain.repository;
import edu.espe.cotbert.forestal.domain.model.TreeSpecies;
import java.util.List;

/**
 *
 * @author jeffersonyepez
 */
public interface TreeSpeciesRepository {
    void save(TreeSpecies treeSpecies);
    List<TreeSpecies> findAll();
    TreeSpecies findById(String uuid);
    void update(TreeSpecies tree);
    void delete(String uuid);
}
