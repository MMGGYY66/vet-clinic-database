/* Database schema to keep the structure of entire database. */

/* Animals Table */

CREATE TABLE animals (
  id INT, 
  name TEXT, 
  date_of_birth DATE, 
  escape_attempts INT, 
  neutered BIT, 
  weight_kg DECIMAL(10, 2)
);

ALTER TABLE animals ADD COLUMN species VARCHAR(100);

/* Owners Table */

CREATE TABLE owners (
	id INT GENERATED ALWAYS AS IDENTITY,
	full_name VARCHAR(100),
	age INT,
	PRIMARY KEY(id)
);

/* Species Table */

CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    PRIMARY KEY(id)
);

/* UPDATE animals table */

ALTER TABLE animals ALTER COLUMN id SET NOT NULL;
ALTER TABLE animals ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (START WITH 11);

ALTER TABLE animals
DROP COLUMN species,
ADD COLUMN species_id INT,
ADD COLUMN owner_id INT,
ADD PRIMARY KEY (id),
ADD CONSTRAINT fk_animals_species FOREIGN KEY (species_id) REFERENCES species (id),
ADD CONSTRAINT fk_animals_owners FOREIGN KEY (owner_id) REFERENCES owners (id);

/* Vets table */

CREATE TABLE vets (
   id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
   name VARCHAR(150),
   age INT,
   date_of_graduation DATE, 
   PRIMARY KEY(id)
);

/* specializations table */

CREATE TABLE specializations (
   id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
   vet_id INT,
   species_id INT,
   FOREIGN KEY (vet_id) REFERENCES vets (id),
   FOREIGN KEY (species_id) REFERENCES species (id)
);

/* visits table */

CREATE TABLE visits (
  id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  vet_id INT,
  animal_id INT,
  visit_date DATE,
  FOREIGN KEY (vet_id) REFERENCES vets (id),
  FOREIGN KEY (animal_id) REFERENCES animals (id)
);
