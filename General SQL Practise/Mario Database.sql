#  Mario Database

##- Create a database, tables, columns, and populate it with data.
##- Define Primary & Foreign keys.
##- Join tables with one-to-one and many-to-one relationships.




ALTER DATABASE first_database RENAME TO mario_database;
ALTER DATABASE
second_database=> \list
second_database=>                                     List of databases
+-----------------+--------------+----------+---------+---------+-----------------------+
|      Name       |    Owner     | Encoding | Collate |  Ctype  |   Access privileges   |
+-----------------+--------------+----------+---------+---------+-----------------------+
| mario_database  | freecodecamp | UTF8     | C.UTF-8 | C.UTF-8 |                       |
| postgres        | postgres     | UTF8     | C.UTF-8 | C.UTF-8 |                       |
| second_database | freecodecamp | UTF8     | C.UTF-8 | C.UTF-8 |                       |
| template0       | postgres     | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +|
|                 |              |          |         |         | postgres=CTc/postgres |
| template1       | postgres     | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +|
|                 |              |          |         |         | postgres=CTc/postgres |
+-----------------+--------------+----------+---------+---------+-----------------------+
(5 rows)

\c mario_database;
You are now connected to database "mario_database" as user "freecodecamp".

mario_database=> DROP DATABASE second_database;
DROP DATABASE sec\list
mario_database=>                                    List of databases
+----------------+--------------+----------+---------+---------+-----------------------+
|      Name      |    Owner     | Encoding | Collate |  Ctype  |   Access privileges   |
+----------------+--------------+----------+---------+---------+-----------------------+
| mario_database | freecodecamp | UTF8     | C.UTF-8 | C.UTF-8 |                       |
| postgres       | postgres     | UTF8     | C.UTF-8 | C.UTF-8 |                       |
| template0      | postgres     | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +|
|                |              |          |         |         | postgres=CTc/postgres |
| template1      | postgres     | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +|
|                |              |          |         |         | postgres=CTc/postgres |
+----------------+--------------+----------+---------+---------+-----------------------+
(4 rows)

mario_database=> CREATE TABLE characters();
CREATE TABLE

mario_database=> ALTER TABLE characters ADD COLUMN character_id SERIAL;
ALTER TABLE
mario_database=> \d characters
                                     Table "public.characters"
+--------------+---------+-----------+----------+--------------------------------------------------+
|    Column    |  Type   | Collation | Nullable |                     Default                      |
+--------------+---------+-----------+----------+--------------------------------------------------+
| character_id | integer |           | not null | nextval('characters_character_id_seq'::regclass) |
+--------------+---------+-----------+----------+--------------------------------------------------+

mario_database=> ALTER TABLE characters ADD COLUMN name VARCHAR(30) NOT NULL;
ALTER TABLE

mario_database=> ALTER TABLE characters ADD COLUMN homeland VARCHAR(60);
ALTER TABLE

mario_database=> ALTER TABLE characters ADD COLUMN favourite_color VARCHAR(30);
mario_database=> ALTER TABLE

ALTER TABLE characters ADD COLUMN favorite_color VARCHAR(30);
ALTER TABLE

mario_database=> \d 
                        List of relations
+--------+-----------------------------+----------+--------------+
| Schema |            Name             |   Type   |    Owner     |
+--------+-----------------------------+----------+--------------+
| public | characters                  | table    | freecodecamp |
| public | characters_character_id_seq | sequence | freecodecamp |
+--------+-----------------------------+----------+--------------+
(2 rows)

mario_database=> \d characters
                                              Table "public.characters"
+-----------------+-----------------------+-----------+----------+--------------------------------------------------+
|     Column      |         Type          | Collation | Nullable |                     Default                      |
+-----------------+-----------------------+-----------+----------+--------------------------------------------------+
| character_id    | integer               |           | not null | nextval('characters_character_id_seq'::regclass) |
| name            | character varying(30) |           | not null |                                                  |
| homeland        | character varying(60) |           |          |                                                  |
| favourite_color | character varying(30) |           |          |                                                  |
| favorite_color  | character varying(30) |           |          |                                                  |
+-----------------+-----------------------+-----------+----------+--------------------------------------------------+

mario_database=> ALTER TABLE characters DROP COLUMN favourite_color;
mario_database=> ALTER TABLE
ALTER TABLE chara\d characters
                                             Table "public.characters"
+----------------+-----------------------+-----------+----------+--------------------------------------------------+
|     Column     |         Type          | Collation | Nullable |                     Default                      |
+----------------+-----------------------+-----------+----------+--------------------------------------------------+
| character_id   | integer               |           | not null | nextval('characters_character_id_seq'::regclass) |
| name           | character varying(30) |           | not null |                                                  |
| homeland       | character varying(60) |           |          |                                                  |
| favorite_color | character varying(30) |           |          |                                                  |
+----------------+-----------------------+-----------+----------+--------------------------------------------------+

mario_database=> INSERT INTO characters(name, homeland, favorite_color) VALUES('Mario', 'Mushroom Kingdom', 'Red');
INSERT 0 1

mario_database=> SELECT * FROM characters;                    
+--------------+-------+------------------+----------------+
| character_id | name  |     homeland     | favorite_color |
+--------------+-------+------------------+----------------+
|            1 | Mario | Mushroom Kingdom | Red            |
+--------------+-------+------------------+----------------+
(1 row)

mario_database=> INSERT INTO characters(name, homeland, favorite_color) VALUES('Luigi', 'Mushroom Kingdom', 'Green');
INSERT 0 1

mario_database=> SELECT * FROM characters;                             
+--------------+-------+------------------+----------------+
| character_id | name  |     homeland     | favorite_color |
+--------------+-------+------------------+----------------+
|            1 | Mario | Mushroom Kingdom | Red            |
|            2 | Luigi | Mushroom Kingdom | Green          |
+--------------+-------+------------------+----------------+
(2 rows)

mario_database=> INSERT INTO characters(name, homeland, favorite_color) VALUES('Peach', 'Mushroom Kingdom', 'Pink');
INSERT 0 1

mario_database=> INSERT INTO characters(name, homeland, favorite_color) VALUES('Toadstool', 'Mushroom Kingdom', 'Red'), ('Bowser', 'Mushroom Kingdom', 'Green');
INSERT 0 2

mario_database=> INSERT INTO characters(name, homeland, favorite_color) VALUES('Daisy', 'Sarasaland', 'Yellow'), ('Yoshi', 'Dinosaur Land', 'Green');
INSERT 0 2

mario_database=> SELECT * FROM characters;
mario_database=>                                 
+--------------+-----------+------------------+----------------+
| character_id |   name    |     homeland     | favorite_color |
+--------------+-----------+------------------+----------------+
|            1 | Mario     | Mushroom Kingdom | Red            |
|            2 | Luigi     | Mushroom Kingdom | Green          |
|            3 | Peach     | Mushroom Kingdom | Pink           |
|            4 | Peach     | Mushroom Kingdom | Pink           |
|            5 | Toadstool | Mushroom Kingdom | Red            |
|            6 | Bowser    | Mushroom Kingdom | Green          |
|            7 | Daisy     | Sarasaland       | Yellow         |
|            8 | Yoshi     | Dinosaur Land    | Green          |
+--------------+-----------+------------------+----------------+
(8 rows)

mario_database=> DELETE FROM characters WHERE name='Peach';
DELETE 2

mario_database=> SELECT * FROM characters;                   
+--------------+-----------+------------------+----------------+
| character_id |   name    |     homeland     | favorite_color |
+--------------+-----------+------------------+----------------+
|            1 | Mario     | Mushroom Kingdom | Red            |
|            2 | Luigi     | Mushroom Kingdom | Green          |
|            5 | Toadstool | Mushroom Kingdom | Red            |
|            6 | Bowser    | Mushroom Kingdom | Green          |
|            7 | Daisy     | Sarasaland       | Yellow         |
|            8 | Yoshi     | Dinosaur Land    | Green          |
+--------------+-----------+------------------+----------------+
(6 rows)

mario_database=> INSERT INTO characters(name, homeland, favorite_color) VALUES('Peach', 'Mushroom Kingdom', 'Pink');
INSERT 0 1

mario_database=> SELECT * FROM characters;
mario_database=>                                 
+--------------+-----------+------------------+----------------+
| character_id |   name    |     homeland     | favorite_color |
+--------------+-----------+------------------+----------------+
|            1 | Mario     | Mushroom Kingdom | Red            |
|            2 | Luigi     | Mushroom Kingdom | Green          |
|            5 | Toadstool | Mushroom Kingdom | Red            |
|            6 | Bowser    | Mushroom Kingdom | Green          |
|            7 | Daisy     | Sarasaland       | Yellow         |
|            8 | Yoshi     | Dinosaur Land    | Green          |
|            9 | Peach     | Mushroom Kingdom | Pink           |
+--------------+-----------+------------------+----------------+
(7 rows)

mario_database=> UPDATE characters SET favorite_color = 'Orange' WHERE name='Daisy';
UPDATE 1

mario_database=> SELECT * FROM characters;
mario_database=>                                 
+--------------+-----------+------------------+----------------+
| character_id |   name    |     homeland     | favorite_color |
+--------------+-----------+------------------+----------------+
|            1 | Mario     | Mushroom Kingdom | Red            |
|            2 | Luigi     | Mushroom Kingdom | Green          |
|            5 | Toadstool | Mushroom Kingdom | Red            |
|            6 | Bowser    | Mushroom Kingdom | Green          |
|            8 | Yoshi     | Dinosaur Land    | Green          |
|            9 | Peach     | Mushroom Kingdom | Pink           |
|            7 | Daisy     | Sarasaland       | Orange         |
+--------------+-----------+------------------+----------------+
(7 rows)


mario_database=> UPDATE characters SET name='Toad' WHERE favorite_color='Red';
UPDATE 2

mario_database=> SELECT * FROM characters;
                               
+--------------+--------+------------------+----------------+
| character_id |  name  |     homeland     | favorite_color |
+--------------+--------+------------------+----------------+
|            2 | Luigi  | Mushroom Kingdom | Green          |
|            6 | Bowser | Mushroom Kingdom | Green          |
|            8 | Yoshi  | Dinosaur Land    | Green          |
|            9 | Peach  | Mushroom Kingdom | Pink           |
|            7 | Daisy  | Sarasaland       | Orange         |
|            1 | Toad   | Mushroom Kingdom | Red            |
|            5 | Toad   | Mushroom Kingdom | Red            |
+--------------+--------+------------------+----------------+
(7 rows)

mario_database=> UPDATE characters SET name='Mario' WHERE character_id='1';
mario_database=> UPDATE 1

UPDATE charactersSELECT * FROM characters;
                               
+--------------+--------+------------------+----------------+
| character_id |  name  |     homeland     | favorite_color |
+--------------+--------+------------------+----------------+
|            2 | Luigi  | Mushroom Kingdom | Green          |
|            6 | Bowser | Mushroom Kingdom | Green          |
|            8 | Yoshi  | Dinosaur Land    | Green          |
|            9 | Peach  | Mushroom Kingdom | Pink           |
|            7 | Daisy  | Sarasaland       | Orange         |
|            5 | Toad   | Mushroom Kingdom | Red            |
|            1 | Mario  | Mushroom Kingdom | Red            |
+--------------+--------+------------------+----------------+
(7 rows)

mario_database=> UPDATE characters SET favorite_color='Blue' WHERE name='Toad';
UPDATE 1

mario_database=> UPDATE characters SET favorite_color='Yellow' WHERE name='Bowser';
UPDATE 1

mario_database=> UPDATE characters SET homeland='Koopa Kingdom' WHERE name='Bowser';
UPDATE 1

mario_database=> SELECT * FROM characters;
                               
+--------------+--------+------------------+----------------+
| character_id |  name  |     homeland     | favorite_color |
+--------------+--------+------------------+----------------+
|            2 | Luigi  | Mushroom Kingdom | Green          |
|            8 | Yoshi  | Dinosaur Land    | Green          |
|            9 | Peach  | Mushroom Kingdom | Pink           |
|            7 | Daisy  | Sarasaland       | Orange         |
|            1 | Mario  | Mushroom Kingdom | Red            |
|            5 | Toad   | Mushroom Kingdom | Blue           |
|            6 | Bowser | Koopa Kingdom    | Yellow         |
+--------------+--------+------------------+----------------+
(7 rows)

mario_database=> SELECT * FROM characters ORDER BY character_id;
                               
+--------------+--------+------------------+----------------+
| character_id |  name  |     homeland     | favorite_color |
+--------------+--------+------------------+----------------+
|            1 | Mario  | Mushroom Kingdom | Red            |
|            2 | Luigi  | Mushroom Kingdom | Green          |
|            5 | Toad   | Mushroom Kingdom | Blue           |
|            6 | Bowser | Koopa Kingdom    | Yellow         |
|            7 | Daisy  | Sarasaland       | Orange         |
|            8 | Yoshi  | Dinosaur Land    | Green          |
|            9 | Peach  | Mushroom Kingdom | Pink           |
+--------------+--------+------------------+----------------+
(7 rows)

mario_database=> ALTER TABLE characters ADD PRIMARY KEY(name);
ALTER TABLE

mario_database=> \d characters
                                             Table "public.characters"
+----------------+-----------------------+-----------+----------+--------------------------------------------------+
|     Column     |         Type          | Collation | Nullable |                     Default                      |
+----------------+-----------------------+-----------+----------+--------------------------------------------------+
| character_id   | integer               |           | not null | nextval('characters_character_id_seq'::regclass) |
| name           | character varying(30) |           | not null |                                                  |
| homeland       | character varying(60) |           |          |                                                  |
| favorite_color | character varying(30) |           |          |                                                  |
+----------------+-----------------------+-----------+----------+--------------------------------------------------+
Indexes:
    "characters_pkey" PRIMARY KEY, btree (name)

mario_database=> ALTER TABLE characters DROP CONsTRAINT characters_pkey;
ALTER TABLE

mario_database=> SELECT * FROM characters;
                               
+--------------+--------+------------------+----------------+
| character_id |  name  |     homeland     | favorite_color |
+--------------+--------+------------------+----------------+
|            2 | Luigi  | Mushroom Kingdom | Green          |
|            8 | Yoshi  | Dinosaur Land    | Green          |
|            9 | Peach  | Mushroom Kingdom | Pink           |
|            7 | Daisy  | Sarasaland       | Orange         |
|            1 | Mario  | Mushroom Kingdom | Red            |
|            5 | Toad   | Mushroom Kingdom | Blue           |
|            6 | Bowser | Koopa Kingdom    | Yellow         |
+--------------+--------+------------------+----------------+
(7 rows)

mario_database=> \d characters;
                                             Table "public.characters"
+----------------+-----------------------+-----------+----------+--------------------------------------------------+
|     Column     |         Type          | Collation | Nullable |                     Default                      |
+----------------+-----------------------+-----------+----------+--------------------------------------------------+
| character_id   | integer               |           | not null | nextval('characters_character_id_seq'::regclass) |
| name           | character varying(30) |           | not null |                                                  |
| homeland       | character varying(60) |           |          |                                                  |
| favorite_color | character varying(30) |           |          |                                                  |
+----------------+-----------------------+-----------+----------+--------------------------------------------------+

mario_database=> ALTER TABLE characters ADD PRIMARY KEY(character_id);
ALTER TABLE

mario_database=> \d characters;
                                             Table "public.characters"
+----------------+-----------------------+-----------+----------+--------------------------------------------------+
|     Column     |         Type          | Collation | Nullable |                     Default                      |
+----------------+-----------------------+-----------+----------+--------------------------------------------------+
| character_id   | integer               |           | not null | nextval('characters_character_id_seq'::regclass) |
| name           | character varying(30) |           | not null |                                                  |
| homeland       | character varying(60) |           |          |                                                  |
| favorite_color | character varying(30) |           |          |                                                  |
+----------------+-----------------------+-----------+----------+--------------------------------------------------+
Indexes:
    "characters_pkey" PRIMARY KEY, btree (character_id)

mario_database=> CREATE TABLE more_info();
CREATE TABLE

mario_database=> ALTER TABLE more_info ADD COLUMN more_info_id SERIAL;
ALTER TABLE

mario_database=> ALTER TABLE more_info ADD PRIMARY KEY (more_info_id);
ALTER TABLE

mario_database=> \list
mario_database=>                                    List of databases
+----------------+--------------+----------+---------+---------+-----------------------+
|      Name      |    Owner     | Encoding | Collate |  Ctype  |   Access privileges   |
+----------------+--------------+----------+---------+---------+-----------------------+
| mario_database | freecodecamp | UTF8     | C.UTF-8 | C.UTF-8 |                       |
| postgres       | postgres     | UTF8     | C.UTF-8 | C.UTF-8 |                       |
| template0      | postgres     | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +|
|                |              |          |         |         | postgres=CTc/postgres |
| template1      | postgres     | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +|
|                |              |          |         |         | postgres=CTc/postgres |
+----------------+--------------+----------+---------+---------+-----------------------+
(4 rows)

\d mario_database;
Did not find any relation named "mario_database".
mario_database=> \d more_info
                                     Table "public.more_info"
+--------------+---------+-----------+----------+-------------------------------------------------+
|    Column    |  Type   | Collation | Nullable |                     Default                     |
+--------------+---------+-----------+----------+-------------------------------------------------+
| more_info_id | integer |           | not null | nextval('more_info_more_info_id_seq'::regclass) |
+--------------+---------+-----------+----------+-------------------------------------------------+
Indexes:
    "more_info_pkey" PRIMARY KEY, btree (more_info_id)

mario_database=> \d more_info_id
Did not find any relation named "more_info_id".
mario_database=> \d
                        List of relations
+--------+-----------------------------+----------+--------------+
| Schema |            Name             |   Type   |    Owner     |
+--------+-----------------------------+----------+--------------+
| public | characters                  | table    | freecodecamp |
| public | characters_character_id_seq | sequence | freecodecamp |
| public | more_info                   | table    | freecodecamp |
| public | more_info_more_info_id_seq  | sequence | freecodecamp |
+--------+-----------------------------+----------+--------------+
(4 rows)

mario_database=> ALTER TABLE more_info ADD COLUMN birthday DATE;
ALTER TABLE
mario_database=> ALTER TABLE more_info ADD COLUMN height INT;
ALTER TABLE
mario_database=> ALTER TABLE more_info ADD COLUMN weight NUMERIC(4, 1);
ALTER TABLE
mario_database=> \d
mario_database=>                         List of relations
+--------+-----------------------------+----------+--------------+
| Schema |            Name             |   Type   |    Owner     |
+--------+-----------------------------+----------+--------------+
| public | characters                  | table    | freecodecamp |
| public | characters_character_id_seq | sequence | freecodecamp |
| public | more_info                   | table    | freecodecamp |
| public | more_info_more_info_id_seq  | sequence | freecodecamp |
+--------+-----------------------------+----------+--------------+
(4 rows)

\d more_info
                                        Table "public.more_info"
+--------------+--------------+-----------+----------+-------------------------------------------------+
|    Column    |     Type     | Collation | Nullable |                     Default                     |
+--------------+--------------+-----------+----------+-------------------------------------------------+
| more_info_id | integer      |           | not null | nextval('more_info_more_info_id_seq'::regclass) |
| birthday     | date         |           |          |                                                 |
| height       | integer      |           |          |                                                 |
| weight       | numeric(4,1) |           |          |                                                 |
+--------------+--------------+-----------+----------+-------------------------------------------------+
Indexes:
    "more_info_pkey" PRIMARY KEY, btree (more_info_id)

mario_database=> ALTER TABLE more_info ADD COLUMN character_id INT REFERENCES characters(character_id);
ALTER TABLE


mario_database=> SELECT * FROM characters ORDER BY character_id;
mario_database=>                                
+--------------+--------+------------------+----------------+
| character_id |  name  |     homeland     | favorite_color |
+--------------+--------+------------------+----------------+
|            1 | Mario  | Mushroom Kingdom | Red            |
|            2 | Luigi  | Mushroom Kingdom | Green          |
|            3 | Peach  | Mushroom Kingdom | Pink           |
|            4 | Toad   | Mushroom Kingdom | Blue           |
|            5 | Bowser | Koopa Kingdom    | Yellow         |
|            6 | Daisy  | Sarasaland       | Orange         |
|            7 | Yoshi  | Dinosaur Land    | Green          |
+--------------+--------+------------------+----------------+
(7 rows)

mario_database=> INSERT INTO sounds(character_id, filename) VALUES(1, 'its-a-me.wav');
INSERT 0 1

mario_database=> INSERT INTO sounds(character_id, filename) VALUES(1, 'yippee.wav');
INSERT 0 1

mario_database=> INSERT INTO sounds(character_id, filename) VALUES(2, 'ha-ha.wav');
mario_database=> INSERT 0 1

INSERT INTO sounds(character_id, filename) VALUES(2, 'oh-yeah.wav');
INSERT 0 1

mario_database=> INSERT INTO sounds(character_id, filename) VALUES(3, 'yay.wav'), (3,  'woo-hoo.wav');
mario_database=> INSERT 0 2

INSERT INTO sounds(character_id, filename) VALUES(3, 'mm-hmm.wav'), (1,  'yahoo.wav');
mario_database=> INSERT 0 2

SELECT * FROM sounds;
mario_database=>                      
+----------+--------------+--------------+
| sound_id |   filename   | character_id |
+----------+--------------+--------------+
|        1 | its-a-me.wav |            1 |
|        2 | yippee.wav   |            1 |
|        3 | ha-ha.wav    |            2 |
|        4 | oh-yeah.wav  |            2 |
|        5 | yay.wav      |            3 |
|        6 | woo-hoo.wav  |            3 |
|        7 | mm-hmm.wav   |            3 |
|        8 | yahoo.wav    |            1 |
+----------+--------------+--------------+
(8 rows)

mario_database=> CREATE TABLE actions(action_id SERIAL PRIMARY KEY);
CREATE TABLE

mario_database=> ALTER TABLE actions ADD COLUMN action VARCHAR(20) UNIQUE NOT NULL;
ALTER TABLE

mario_database=> INSERT INTO actions(action) VALUES('run');
INSERT 0 1

mario_database=> INSERT INTO actions(action) VALUES('jump');
mario_database=> INSERT 0 1

INSERT INTO actions(action) VALUES('duck');
mario_database=> INSERT 0 1

mario_database=> SELECT * FROM actions;       
+-----------+--------+
| action_id | action |
+-----------+--------+
|         1 | run    |
|         2 | jump   |
|         3 | duck   |
+-----------+--------+
(3 rows)

mario_database=> CREATE TABLE character_actions();
mario_database=> CREATE TABLE

mario_database=> ALTER TABLE character_actions ADD COLUMN character_id INT NOT NULL;
ALTER TABLE

mario_database=> ALTER TABLE character_actions ADD FOREIGN KEY(character_id) REFERENCES characters(character_id);
ALTER TABLE

mario_database=> SELECT * FROM character_actions;
mario_database=>         
+--------------+
| character_id |
+--------------+
+--------------+
(0 rows)

\d character_actions;
             Table "public.character_actions"
+--------------+---------+-----------+----------+---------+
|    Column    |  Type   | Collation | Nullable | Default |
+--------------+---------+-----------+----------+---------+
| character_id | integer |           | not null |         |
+--------------+---------+-----------+----------+---------+
Foreign-key constraints:
    "character_actions_character_id_fkey" FOREIGN KEY (character_id) REFERENCES characters(character_id)

mario_database=> ALTER TABLE character_actions ADD COLUMN action_id INT NOT NULL;
ALTER TABLE

mario_database=> ALTER TABLE character_actions ADD FOREIGN KEY(action_id) REFERENCES actions(action_id);
ALTER TABLE

mario_database=> \d character_actions
             Table "public.character_actions"
+--------------+---------+-----------+----------+---------+
|    Column    |  Type   | Collation | Nullable | Default |
+--------------+---------+-----------+----------+---------+
| character_id | integer |           | not null |         |
| action_id    | integer |           | not null |         |
+--------------+---------+-----------+----------+---------+
Foreign-key constraints:
    "character_actions_action_id_fkey" FOREIGN KEY (action_id) REFERENCES actions(action_id)
    "character_actions_character_id_fkey" FOREIGN KEY (character_id) REFERENCES characters(character_id)

mario_database=> ALTER TABLE character_actions ADD PRIMARY KEY(character_id, action_id);
ALTER TABLE
mario_database=> \d character_actions;
             Table "public.character_actions"
+--------------+---------+-----------+----------+---------+
|    Column    |  Type   | Collation | Nullable | Default |
+--------------+---------+-----------+----------+---------+
| character_id | integer |           | not null |         |
| action_id    | integer |           | not null |         |
+--------------+---------+-----------+----------+---------+
Indexes:
    "character_actions_pkey" PRIMARY KEY, btree (character_id, action_id)
Foreign-key constraints:
    "character_actions_action_id_fkey" FOREIGN KEY (action_id) REFERENCES actions(action_id)
    "character_actions_character_id_fkey" FOREIGN KEY (character_id) REFERENCES characters(character_id)


mario_database=> \d characters;
mario_database=>                                              Table "public.characters"
+----------------+-----------------------+-----------+----------+--------------------------------------------------+
|     Column     |         Type          | Collation | Nullable |                     Default                      |
+----------------+-----------------------+-----------+----------+--------------------------------------------------+
| character_id   | integer               |           | not null | nextval('characters_character_id_seq'::regclass) |
| name           | character varying(30) |           | not null |                                                  |
| homeland       | character varying(60) |           |          |                                                  |
| favorite_color | character varying(30) |           |          |                                                  |
+----------------+-----------------------+-----------+----------+--------------------------------------------------+
Indexes:
    "characters_pkey" PRIMARY KEY, btree (character_id)
Referenced by:
    TABLE "character_actions" CONSTRAINT "character_actions_character_id_fkey" FOREIGN KEY (character_id) REFERENCES characters(character_id)
    TABLE "more_info" CONSTRAINT "more_info_character_id_fkey" FOREIGN KEY (character_id) REFERENCES characters(character_id)
    TABLE "sounds" CONSTRAINT "sounds_character_id_fkey" FOREIGN KEY (character_id) REFERENCES characters(character_id)

\d actions;
mario_database=>                                          Table "public.actions"
+-----------+-----------------------+-----------+----------+--------------------------------------------+
|  Column   |         Type          | Collation | Nullable |                  Default                   |
+-----------+-----------------------+-----------+----------+--------------------------------------------+
| action_id | integer               |           | not null | nextval('actions_action_id_seq'::regclass) |
| action    | character varying(20) |           | not null |                                            |
+-----------+-----------------------+-----------+----------+--------------------------------------------+
Indexes:
    "actions_pkey" PRIMARY KEY, btree (action_id)
    "actions_action_key" UNIQUE CONSTRAINT, btree (action)
Referenced by:
    TABLE "character_actions" CONSTRAINT "character_actions_action_id_fkey" FOREIGN KEY (action_id) REFERENCES actions(action_id)

mario_database=> SELECT * FROM characters, actions;
mario_database=>                                          
+--------------+--------+------------------+----------------+-----------+--------+
| character_id |  name  |     homeland     | favorite_color | action_id | action |
+--------------+--------+------------------+----------------+-----------+--------+
|            2 | Luigi  | Mushroom Kingdom | Green          |         1 | run    |
|            3 | Peach  | Mushroom Kingdom | Pink           |         1 | run    |
|            7 | Yoshi  | Dinosaur Land    | Green          |         1 | run    |
|            6 | Daisy  | Sarasaland       | Orange         |         1 | run    |
|            1 | Mario  | Mushroom Kingdom | Red            |         1 | run    |
|            4 | Toad   | Mushroom Kingdom | Blue           |         1 | run    |
|            5 | Bowser | Koopa Kingdom    | Yellow         |         1 | run    |
|            2 | Luigi  | Mushroom Kingdom | Green          |         2 | jump   |
|            3 | Peach  | Mushroom Kingdom | Pink           |         2 | jump   |
|            7 | Yoshi  | Dinosaur Land    | Green          |         2 | jump   |
|            6 | Daisy  | Sarasaland       | Orange         |         2 | jump   |
|            1 | Mario  | Mushroom Kingdom | Red            |         2 | jump   |
|            4 | Toad   | Mushroom Kingdom | Blue           |         2 | jump   |
|            5 | Bowser | Koopa Kingdom    | Yellow         |         2 | jump   |
|            2 | Luigi  | Mushroom Kingdom | Green          |         3 | duck   |
|            3 | Peach  | Mushroom Kingdom | Pink           |         3 | duck   |
|            7 | Yoshi  | Dinosaur Land    | Green          |         3 | duck   |
|            6 | Daisy  | Sarasaland       | Orange         |         3 | duck   |
|            1 | Mario  | Mushroom Kingdom | Red            |         3 | duck   |
|            4 | Toad   | Mushroom Kingdom | Blue           |         3 | duck   |
|            5 | Bowser | Koopa Kingdom    | Yellow         |         3 | duck   |
+--------------+--------+------------------+----------------+-----------+--------+
(21 rows)

mario_database=> INSERT INTO character_actions(character_id, action_id) VALUES(7, 1), (7, 2), (7, 3);
INSERT 0 3
mario_database=> SELECT * FROM character_actions;
              
+--------------+-----------+
| character_id | action_id |
+--------------+-----------+
|            7 |         1 |
|            7 |         2 |
|            7 |         3 |
+--------------+-----------+
(3 rows)

mario_database=> INSERT INTO character_actions(character_id, action_id) VALUES(6, 1), (6, 2), (6, 3);
INSERT 0 3

mario_database=> INSERT INTO character_actions(character_id, action_id) VALUES(5, 1), (5, 2), (5, 3);
INSERT 0 3

mario_database=> INSERT INTO character_actions(character_id, action_id) VALUES(4, 1), (4, 2), (4, 3);
INSERT 0 3

mario_database=> INSERT INTO character_actions(character_id, action_id) VALUES(3, 1), (3, 2), (3, 3);
INSERT 0 3

mario_database=> INSERT INTO character_actions(character_id, action_id) VALUES(2, 1), (2, 2), (2, 3);
INSERT 0 3

mario_database=> INSERT INTO character_actions(character_id, action_id) VALUES(1, 1), (1, 2), (1, 3);
INSERT 0 3

mario_database=> SELECT * FROM character_actions;      
+-------------+-----------+
| character_id | action_id |
+--------------+-----------+
|            7 |         1 |
|            7 |         2 |
|            7 |         3 |
|            6 |         1 |
|            6 |         2 |
|            6 |         3 |
|            5 |         1 |
|            5 |         2 |
|            5 |         3 |
|            4 |         1 |
|            4 |         2 |
|            4 |         3 |
|            3 |         1 |
|            3 |         2 |
|            3 |         3 |
|            2 |         1 |
|            2 |         2 |
|            2 |         3 |
|            1 |         1 |
|            1 |         2 |
|            1 |         3 |
+--------------+-----------+
(21 rows)

mario_database=> \d
                        List of relations
+--------+-----------------------------+----------+--------------+
| Schema |            Name             |   Type   |    Owner     |
+--------+-----------------------------+----------+--------------+
| public | actions                     | table    | freecodecamp |
| public | actions_action_id_seq       | sequence | freecodecamp |
| public | character_actions           | table    | freecodecamp |
| public | characters                  | table    | freecodecamp |
| public | characters_character_id_seq | sequence | freecodecamp |
| public | more_info                   | table    | freecodecamp |
| public | more_info_more_info_id_seq  | sequence | freecodecamp |
| public | sounds                      | table    | freecodecamp |
| public | sounds_sound_id_seq         | sequence | freecodecamp |
+--------+-----------------------------+----------+--------------+
(9 rows)

mario_database=> \d characters
                                             Table "public.characters"
+----------------+-----------------------+-----------+----------+--------------------------------------------------+
|     Column     |         Type          | Collation | Nullable |                     Default                      |
+----------------+-----------------------+-----------+----------+--------------------------------------------------+
| character_id   | integer               |           | not null | nextval('characters_character_id_seq'::regclass) |
| name           | character varying(30) |           | not null |                                                  |
| homeland       | character varying(60) |           |          |                                                  |
| favorite_color | character varying(30) |           |          |                                                  |
+----------------+-----------------------+-----------+----------+--------------------------------------------------+
Indexes:
    "characters_pkey" PRIMARY KEY, btree (character_id)
Referenced by:
    TABLE "character_actions" CONSTRAINT "character_actions_character_id_fkey" FOREIGN KEY (character_id) REFERENCES characters(character_id)
    TABLE "more_info" CONSTRAINT "more_info_character_id_fkey" FOREIGN KEY (character_id) REFERENCES characters(character_id)
    TABLE "sounds" CONSTRAINT "sounds_character_id_fkey" FOREIGN KEY (character_id) REFERENCES characters(character_id)

mario_database=> SELECT * FROM characters;                      
+--------------+--------+------------------+----------------+
| character_id |  name  |     homeland     | favorite_color |
+--------------+--------+------------------+----------------+
|            2 | Luigi  | Mushroom Kingdom | Green          |
|            3 | Peach  | Mushroom Kingdom | Pink           |
|            7 | Yoshi  | Dinosaur Land    | Green          |
|            6 | Daisy  | Sarasaland       | Orange         |
|            1 | Mario  | Mushroom Kingdom | Red            |
|            4 | Toad   | Mushroom Kingdom | Blue           |
|            5 | Bowser | Koopa Kingdom    | Yellow         |
+--------------+--------+------------------+----------------+
(7 rows)

mario_database=> SELECT * FROM more_info;                               
+--------------+------------+--------------+--------------+--------------+
| more_info_id |  birthday  | height_in_cm | weight_in_kg | character_id |
+--------------+------------+--------------+--------------+--------------+
|            1 | 1981-07-09 |          155 |         64.5 |            1 |
|            2 | 1983-07-14 |          175 |         48.8 |            2 |
|            3 | 1985-10-18 |          173 |         52.2 |            3 |
|            4 | 1950-01-10 |           66 |         35.6 |            4 |
|            5 | 1990-10-29 |          258 |        300.0 |            5 |
|            6 | 1989-07-31 |              |              |            6 |
|            7 | 1990-04-13 |          162 |         59.1 |            7 |
+--------------+------------+--------------+--------------+--------------+
(7 rows)

mario_database=> SELECT * FROM characters FULL JOIN more_info ON characters.character_id = more_info.character_id;
mario_database=>                                                                    
+--------------+--------+------------------+----------------+--------------+------------+--------------+--------------+--------------+
| character_id |  name  |     homeland     | favorite_color | more_info_id |  birthday  | height_in_cm | weight_in_kg | character_id |
+--------------+--------+------------------+----------------+--------------+------------+--------------+--------------+--------------+
|            2 | Luigi  | Mushroom Kingdom | Green          |            2 | 1983-07-14 |          175 |         48.8 |            2 |
|            3 | Peach  | Mushroom Kingdom | Pink           |            3 | 1985-10-18 |          173 |         52.2 |            3 |
|            7 | Yoshi  | Dinosaur Land    | Green          |            7 | 1990-04-13 |          162 |         59.1 |            7 |
|            6 | Daisy  | Sarasaland       | Orange         |            6 | 1989-07-31 |              |              |            6 |
|            1 | Mario  | Mushroom Kingdom | Red            |            1 | 1981-07-09 |          155 |         64.5 |            1 |
|            4 | Toad   | Mushroom Kingdom | Blue           |            4 | 1950-01-10 |           66 |         35.6 |            4 |
|            5 | Bowser | Koopa Kingdom    | Yellow         |            5 | 1990-10-29 |          258 |        300.0 |            5 |
+--------------+--------+------------------+----------------+--------------+------------+--------------+--------------+--------------+
(7 rows)

SELECT * FROM characters FULL JOIN sounds ON characters.character_id = sounds.character_id;                                                 
+--------------+--------+------------------+----------------+----------+--------------+--------------+
| character_id |  name  |     homeland     | favorite_color | sound_id |   filename   | character_id |
+--------------+--------+------------------+----------------+----------+--------------+--------------+
|            1 | Mario  | Mushroom Kingdom | Red            |        1 | its-a-me.wav |            1 |
|            1 | Mario  | Mushroom Kingdom | Red            |        2 | yippee.wav   |            1 |
|            2 | Luigi  | Mushroom Kingdom | Green          |        3 | ha-ha.wav    |            2 |
|            2 | Luigi  | Mushroom Kingdom | Green          |        4 | oh-yeah.wav  |            2 |
|            3 | Peach  | Mushroom Kingdom | Pink           |        5 | yay.wav      |            3 |
|            3 | Peach  | Mushroom Kingdom | Pink           |        6 | woo-hoo.wav  |            3 |
|            3 | Peach  | Mushroom Kingdom | Pink           |        7 | mm-hmm.wav   |            3 |
|            1 | Mario  | Mushroom Kingdom | Red            |        8 | yahoo.wav    |            1 |
|            5 | Bowser | Koopa Kingdom    | Yellow         |          |              |              |
|            6 | Daisy  | Sarasaland       | Orange         |          |              |              |
|            4 | Toad   | Mushroom Kingdom | Blue           |          |              |              |
|            7 | Yoshi  | Dinosaur Land    | Green          |          |              |              |
+--------------+--------+------------------+----------------+----------+--------------+--------------+
(12 rows)

mario_database=> SELECT * FROM character_actions FULL JOIN characters ON character_actions.character_id = characters.character_id FULL JOIN actions ON character_actions.action_id = actions.action_id;
mario_database=>                                                        
+--------------+-----------+--------------+--------+------------------+----------------+-----------+--------+
| character_id | action_id | character_id |  name  |     homeland     | favorite_color | action_id | action |
+--------------+-----------+--------------+--------+------------------+----------------+-----------+--------+
|            7 |         1 |            7 | Yoshi  | Dinosaur Land    | Green          |         1 | run    |
|            7 |         2 |            7 | Yoshi  | Dinosaur Land    | Green          |         2 | jump   |
|            7 |         3 |            7 | Yoshi  | Dinosaur Land    | Green          |         3 | duck   |
|            6 |         1 |            6 | Daisy  | Sarasaland       | Orange         |         1 | run    |
|            6 |         2 |            6 | Daisy  | Sarasaland       | Orange         |         2 | jump   |
|            6 |         3 |            6 | Daisy  | Sarasaland       | Orange         |         3 | duck   |
|            5 |         1 |            5 | Bowser | Koopa Kingdom    | Yellow         |         1 | run    |
|            5 |         2 |            5 | Bowser | Koopa Kingdom    | Yellow         |         2 | jump   |
|            5 |         3 |            5 | Bowser | Koopa Kingdom    | Yellow         |         3 | duck   |
|            4 |         1 |            4 | Toad   | Mushroom Kingdom | Blue           |         1 | run    |
|            4 |         2 |            4 | Toad   | Mushroom Kingdom | Blue           |         2 | jump   |
|            4 |         3 |            4 | Toad   | Mushroom Kingdom | Blue           |         3 | duck   |
|            3 |         1 |            3 | Peach  | Mushroom Kingdom | Pink           |         1 | run    |
|            3 |         2 |            3 | Peach  | Mushroom Kingdom | Pink           |         2 | jump   |
|            3 |         3 |            3 | Peach  | Mushroom Kingdom | Pink           |         3 | duck   |
|            2 |         1 |            2 | Luigi  | Mushroom Kingdom | Green          |         1 | run    |
|            2 |         2 |            2 | Luigi  | Mushroom Kingdom | Green          |         2 | jump   |
|            2 |         3 |            2 | Luigi  | Mushroom Kingdom | Green          |         3 | duck   |
|            1 |         1 |            1 | Mario  | Mushroom Kingdom | Red            |         1 | run    |
|            1 |         2 |            1 | Mario  | Mushroom Kingdom | Red            |         2 | jump   |
|            1 |         3 |            1 | Mario  | Mushroom Kingdom | Red            |         3 | duck   |
+--------------+-----------+--------------+--------+------------------+----------------+-----------+--------+
(21 rows)


THE END