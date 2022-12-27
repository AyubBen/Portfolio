CREATE DATABASE universe;

CREATE TABLE galaxy (
galaxy_id SERIAL PRIMARY KEY,
name VARCHAR(255) NOT NULL,
type INT NOT NULL,
distance_from_earth NUMERIC(10,2) NOT NULL,
description TEXT,
wearable BOOLEAN NOT NULL
);

CREATE TABLE star (
star_id SERIAL PRIMARY KEY,
name VARCHAR(255) NOT NULL,
galaxy_id INT NOT NULL,
type INT NOT NULL,
temperature NUMERIC(10,2) NOT NULL,
FOREIGN KEY (galaxy_id) REFERENCES galaxy(galaxy_id)
);

CREATE TABLE planet (
planet_id SERIAL PRIMARY KEY,
name VARCHAR(255) NOT NULL,
star_id INT NOT NULL,
type INT NOT NULL,
size NUMERIC(10,2) NOT NULL,
FOREIGN KEY (star_id) REFERENCES star(star_id)
);

CREATE TABLE moon (
moon_id SERIAL PRIMARY KEY,
name VARCHAR(255) NOT NULL,
planet_id INT NOT NULL,
type INT NOT NULL,
distance_from_planet NUMERIC(10,2) NOT NULL,
FOREIGN KEY (planet_id) REFERENCES planet(planet_id)
);

CREATE TABLE comet (
comet_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(255) NOT NULL UNIQUE,
type INT NOT NULL,
size NUMERIC(10,2) NOT NULL,
last_seen DATE NOT NULL,
description TEXT,
visible BOOLEAN NOT NULL
);


# Populating the galaxy table:
INSERT INTO galaxy (name, type, distance_from_earth, description, wearable)
VALUES ('Milky Way', 1, 25000, 'Our home galaxy', TRUE),
('Andromeda', 2, 30000, 'A spiral galaxy similar to the Milky Way', FALSE),
('Triangulum', 3, 35000, 'A large, nearby spiral galaxy', TRUE),
('Spiral', 1, 35000, 'A galaxy with spiral arms', TRUE),
('Elliptical', 2, 40000, 'A galaxy with an elliptical shape', FALSE),
('Irregular', 3, 45000, 'A galaxy with a irregular shape', TRUE);


# Populating the star table:
INSERT INTO star (name, galaxy_id, type, temperature)
VALUES ('Sun', 1, 1, 5778),
('Alpha Centauri A', 2, 2, 6100),
('Proxima Centauri', 2, 3, 3042),
('Barnard's Star', 3, 1, 2300),
('Luhman 16', 3, 2, 2500),
('WISE 0855-0714', 4, 3, 300);

 
#Populating the planet table: 
INSERT INTO planet (name, star_id, type, size)
VALUES ('Earth', 1, 1, 12756),
('Mars', 1, 2, 6792),
('Jupiter', 1, 3, 142984),
('Saturn', 1, 1, 120536),
('Uranus', 1, 2, 51118),
('Neptune', 1, 3, 49528),
('Proxima b', 3, 1, 12),
('Proxima c', 3, 2, 18),
('Proxima d', 3, 3, 14),
('Barnard c', 4, 1, 8),
('Barnard d', 4, 2, 6),
('Barnard e', 4, 3, 10);
 
 
# Populating the moon table:
INSERT INTO moon (name, planet_id, type, distance_from_planet)
VALUES ('Moon', 1, 1, 384400),
('Phobos', 2, 2, 9350),
('Deimos', 2, 3, 23470),
('Io', 3, 1, 421000),
('Europa', 3, 2, 671100),
('Ganymede', 3, 3, 1070000),
('Callisto', 3, 1, 1880000),
('Mimas', 4, 2, 185500),
('Enceladus', 4, 3, 238000),
('Tethys', 4, 1, 295000),
('Dione', 4, 2, 377000),
('Rhea', 4, 3, 527000),
('Titan', 5, 1, 1221000),
('Triton', 6, 2, 354800),
('Thalassa', 6, 3, 25200),
('Hippocamp', 6, 1, 105284)
('Nereid', 6, 2, 5513400)
('Galatea', 6, 3, 37200)
('Despina', 6, 1, 27700)
('Naiad', 6, 2, 48224)
 
 
 # Populating the comet table:
INSERT INTO comet (name, type, size, last_seen, description, visible)
VALUES ('Halley''s Comet', 1, 15.5, '2061-03-14', 'A periodic comet that is visible from Earth about every 76 years', TRUE),
('Comet Encke', 2, 3.5, '2022-10-01', 'A periodic comet with the shortest known orbital period of any comet', TRUE),
('Comet Hyakutake', 3, 10.2, '1996-03-25', 'A periodic comet that passed very close to Earth in 1996', FALSE);
 
 
 
 
 
 
 
