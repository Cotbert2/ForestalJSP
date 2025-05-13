package edu.espe.cotbert.forestal.domain.repository;

import edu.espe.cotbert.forestal.domain.model.ConservationActivities;
import java.util.List;
/**
 *
 * @author Luis Sagnay
 */
public interface ConservationActivitiesRepository {
    void save(ConservationActivities activity);
    List<ConservationActivities> findAll();
    ConservationActivities findById(String uuid);
    void update(ConservationActivities activity);
    void delete(String uuid);
}
