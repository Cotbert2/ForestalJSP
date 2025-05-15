CREATE SCHEMA forestal_managment;

CREATE TABLE forestal_managment.origins (
    uuid_origin UUID PRIMARY KEY,
    name_origin VARCHAR(255) NOT NULL
);


CREATE TABLE forestal_managment.tree_species (
    UUid_tree_species UUID PRIMARY KEY,
    name_tree_species VARCHAR(255) NOT NULL,
    common_name_tree_species VARCHAR(255) NOT NULL,
    family_tree_species VARCHAR(255) NOT NULL,
    origin_tree_species UUID NOT NULL,
    order_name_tree_species VARCHAR(255) NOT NULL,
    habitat_tree_species TEXT NOT NULL,
    description_tree_species TEXT NOT NULL,
    image_url_tree_species TEXT NOT NULL,
    is_deleted_tree_species BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (origin_tree_species) REFERENCES forestal_managment.origins(uuid_origin)
);


CREATE TABLE forestal_managment.forestal_zone(
    uuid_forestal_zone UUID PRIMARY KEY,
    name_forestal_zone VARCHAR(255) NOT NULL,
    description_forestal_zone TEXT NOT NULL,
    area_ha_forestal_zone INTEGER NOT NULL,
    image_url_forestal_zone TEXT NOT NULL,
    register_date_forestal_zone TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    map_forestal_zone JSONB NOT NULL
);


CREATE TABLE forestal_managment.conservation_activities(
    uuid_conservation_activity UUID PRIMARY KEY,
    name_conservation_activity VARCHAR(255) NOT NULL,
    description_conservation_activity TEXT NOT NULL,
    start_date_conservation_activity TIMESTAMP NOT NULL,
    end_date_conservation_activity TIMESTAMP NOT NULL,
    register_date_conservation_activity TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    uuidd_forestal_zone UUID NOT NULL,
    FOREIGN KEY (uuidd_forestal_zone) REFERENCES forestal_managment.forestal_zone(uuid_forestal_zone)
);


CREATE TABLE forestal_managment.forestal_zone_tree_species(
    uuid_forestal_zone_tree_species UUID PRIMARY KEY,
    uuid_forestal_zone UUID NOT NULL,
    uuid_tree_species UUID NOT NULL,
    FOREIGN KEY (uuid_forestal_zone) REFERENCES forestal_managment.forestal_zone(uuid_forestal_zone),
    FOREIGN KEY (uuid_tree_species) REFERENCES forestal_managment.tree_species(uuid_tree_species)
);

