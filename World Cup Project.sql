


# Creating a worldcup database in PostgreSQL and populating it with 2014 , and 2018 match results.



codeally@def3baa3ae97:~/project$ psql --username=freecodecamp --dbname=postgres
psql (12.9 (Ubuntu 12.9-2.pgdg20.04+1))
Type "help" for help.

postgres=> CREATE TABLE worldcup();
CREATE TABLE
postgres=> \c worldcup
connection to server on socket "/var/run/postgresql/.s.PGSQL.5432" failed: FATAL:  database "worldcup" does not exist
Previous connection kept
postgres=> \list
                               List of databases
     Name     |  Owner   | Encoding | Collate |  Ctype  |   Access privileges   
--------------+----------+----------+---------+---------+-----------------------
 postgres     | postgres | UTF8     | C.UTF-8 | C.UTF-8 | 
 template0    | postgres | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +
              |          |          |         |         | postgres=CTc/postgres
 template1    | postgres | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +
              |          |          |         |         | postgres=CTc/postgres
 worldcuptest | postgres | UTF8     | C.UTF-8 | C.UTF-8 | 
(4 rows)

postgres=> CREATE DATABASE worldcup;
CREATE DATABASE
postgres=> \c worldcup
You are now connected to database "worldcup" as user "freecodecamp".

worldcup=> CREATE TABLE teams();
CREATE TABLE

worldcup=> CREATE TABLE games();
CREATE TABLE

worldcup=> ALTER TABLE teams ADD COLUMN team_id SERIAL PRIMARY KEY;
ALTER TABLE

worldcup=> ALTER TABLE teams ADD COLUMN name SERIAL UNIQUE;
ALTER TABLE

worldcup=> ALTER TABLE games ADD COLUMN game_id SERIAL PRIMARY KEY;
ALTER TABLE

worldcup=> ALTER TABLE games ADD COLUMN year INT;
ALTER TABLE

worldcup=> ALTER TABLE games ADD COLUMN round VARCHAR;
ALTER TABLE

worldcup=> \d
                  List of relations
 Schema |       Name        |   Type   |    Owner     
--------+-------------------+----------+--------------
 public | games             | table    | freecodecamp
 public | games_game_id_seq | sequence | freecodecamp
 public | teams             | table    | freecodecamp
 public | teams_name_seq    | sequence | freecodecamp
 public | teams_team_id_seq | sequence | freecodecamp
(5 rows)

worldcup=> \d games
                                    Table "public.games"
 Column  |       Type        | Collation | Nullable |                Default                 
---------+-------------------+-----------+----------+----------------------------------------
 game_id | integer           |           | not null | nextval('games_game_id_seq'::regclass)
 year    | integer           |           |          | 
 round   | character varying |           |          | 
Indexes:
    "games_pkey" PRIMARY KEY, btree (game_id)


worldcup=> ALTER TABLE games ADD COLUMN winner_goals INT;
ALTER TABLE

worldcup=> ALTER TABLE games ADD COLUMN opponent_goals INT;
ALTER TABLE
worldcup=> \d
                  List of relations
 Schema |       Name        |   Type   |    Owner     
--------+-------------------+----------+--------------
 public | games             | table    | freecodecamp
 public | games_game_id_seq | sequence | freecodecamp
 public | teams             | table    | freecodecamp
 public | teams_name_seq    | sequence | freecodecamp
 public | teams_team_id_seq | sequence | freecodecamp
(5 rows)

worldcup=> \d games
                                        Table "public.games"
     Column     |       Type        | Collation | Nullable |                Default                 
----------------+-------------------+-----------+----------+----------------------------------------
 game_id        | integer           |           | not null | nextval('games_game_id_seq'::regclass)
 year           | integer           |           |          | 
 round          | character varying |           |          | 
 winner_goals   | integer           |           |          | 
 opponent_goals | integer           |           |          | 
Indexes:
    "games_pkey" PRIMARY KEY, btree (game_id)


worldcup=> ALTER TABLE games ADD COLUMN winner_id INT NOT NULL;
ALTER TABLE

worldcup=> ALTER TABLE games ADD FOREIGN KEY(winner_id) REFERENCES teams(team_id);
ALTER TABLE

worldcup=> ALTER TABLE games ADD COLUMN opponent_id INT NOT NULL;
ALTER TABLE

worldcup=> ALTER TABLE games ADD FOREIGN KEY(opponent_id) REFERENCES teams(team_id);
ALTER TABLE

worldcup=> \d games
                                        Table "public.games"
     Column     |       Type        | Collation | Nullable |                Default                 
----------------+-------------------+-----------+----------+----------------------------------------
 game_id        | integer           |           | not null | nextval('games_game_id_seq'::regclass)
 year           | integer           |           |          | 
 round          | character varying |           |          | 
 winner_goals   | integer           |           |          | 
 opponent_goals | integer           |           |          | 
 winner_id      | integer           |           | not null | 
 opponent_id    | integer           |           | not null | 
Indexes:
    "games_pkey" PRIMARY KEY, btree (game_id)
Foreign-key constraints:
    "games_opponent_id_fkey" FOREIGN KEY (opponent_id) REFERENCES teams(team_id)
    "games_winner_id_fkey" FOREIGN KEY (winner_id) REFERENCES teams(team_id)


worldcup=> ALTER TABLE games DROP COLUMN year;
ALTER TABLE

worldcup=> ALTER TABLE games ADD COLUMN year INT NOT NULL;
ALTER TABLE

worldcup=> ALTER TABLE games DROP COLUMN round;
ALTER TABLE

worldcup=> ALTER TABLE games ADD COLUMN round VARCHAR NOT NULL;
ALTER TABLE

worldcup=> ALTER TABLE games DROP COLUMN winner_id;
ALTER TABLE

worldcup=> ALTER TABLE games ADD COLUMN winner_id INT NOT NULL;
ALTER TABLE

worldcup=> ALTER TABLE games DROP COLUMN winner_goals;
ALTER TABLE

worldcup=> ALTER TABLE games DROP COLUMN opponent_goals;
ALTER TABLE

worldcup=> ALTER TABLE games ADD COLUMN winner_goals INT NOT NULL;
ALTER TABLE

worldcup=> ALTER TABLE games ADD COLUMN opponent_goals INT NOT NULL;
ALTER TABLE

worldcup=> \d games
                                        Table "public.games"
     Column     |       Type        | Collation | Nullable |                Default                 
----------------+-------------------+-----------+----------+----------------------------------------
 game_id        | integer           |           | not null | nextval('games_game_id_seq'::regclass)
 opponent_id    | integer           |           | not null | 
 year           | integer           |           | not null | 
 round          | character varying |           | not null | 
 winner_id      | integer           |           | not null | 
 winner_goals   | integer           |           | not null | 
 opponent_goals | integer           |           | not null | 
Indexes:
    "games_pkey" PRIMARY KEY, btree (game_id)
Foreign-key constraints:
    "games_opponent_id_fkey" FOREIGN KEY (opponent_id) REFERENCES teams(team_id)

worldcup=> \d teams
                               Table "public.teams"
 Column  |  Type   | Collation | Nullable |                Default                 
---------+---------+-----------+----------+----------------------------------------
 team_id | integer |           | not null | nextval('teams_team_id_seq'::regclass)
 name    | integer |           | not null | nextval('teams_name_seq'::regclass)
Indexes:
    "teams_pkey" PRIMARY KEY, btree (team_id)
    "teams_name_key" UNIQUE CONSTRAINT, btree (name)
Referenced by:
    TABLE "games" CONSTRAINT "games_opponent_id_fkey" FOREIGN KEY (opponent_id) REFERENCES teams(team_id)

worldcup=> 

worldcup=> ALTER TABLE games ADD FOREIGN KEY (winner_id) REFERENCES teams(team_id);
ALTER TABLE
worldcup=> ALTER TABLE games ADD FOREIGN KEY (opponent_id) REFERENCES teams(team_id);
ALTER TABLE



FIRST FILE!
insert_data.sh

#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo $($PSQL "TRUNCATE TABLE games, teams")

cat games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT WINNER_G OPPONENT_G
do
  TEAMS="$($PSQL "SELECT name FROM teams WHERE name='$WINNER'")"
  if [[ $WINNER != "winner" ]]
  then
    if [[ -z $TEAMS ]]
    then
    INSERT_TEAM="$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")"
      if [[ INSERT_TEAM == "INSERT 0 1" ]]
      then
      echo Insert into teams, $WINNER
      fi
    fi
  fi

  TEAMS2="$($PSQL "SELECT name FROM teams WHERE name='$OPPONENT'")"
 if [[ $OPPONENT != "opponent" ]]
  then
    if [[ -z $TEAMS2 ]]
    then
    INSERT_TEAM2="$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")"
      if [[ INSERT_TEAM2 == "INSERT 0 1" ]]
      then
      echo Insert into teams, $OPPONENT
      fi
    fi
  fi

  TEAM_ID_W="$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")"
  TEAM_ID_O="$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")"


  if [[ -n $TEAM_ID_W || -n $TEAM_ID-O ]]
    then
    if [[ $YEAR != "year" ]]
      then
        INSERT_GAMES="$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $TEAM_ID_W, $TEAM_ID_O, $WINNER_G, $OPPONENT_G)")"
      if [[ $INSERT_GAMES == "INSERT 0 1" ]]
        then
        echo Inserted into games, $YEAR
      fi
    fi
  fi

done  




SECOND FILE!
queries.sh

#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"
Total number of goals in all games from winning teams:
68

echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "SELECT SUM(winner_goals + opponent_goals) FROM games")"
Total number of goals in all games from both teams combined:
90

echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT AVG(winner_goals) FROM games")"
Average number of goals in all games from the winning teams:
2.1250000000000000

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "SELECT ROUND(AVG(winner_goals), 2) FROM games")"
Average number of goals in all games from the winning teams rounded to two decimal places:
2.13

echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "SELECT AVG(winner_goals + opponent_goals) FROM games")"
Average number of goals in all games from both teams:
2.8125000000000000

echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "SELECT MAX(winner_goals) FROM games")"
Most goals scored in a single game by one team:
7

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "SELECT COUNT(*) FROM games WHERE winner_goals > 2 ")"
Number of games where the winning team scored more than two goals:
6

echo -e "\nWinner of the 2018 tournament team name:"
echo "$($PSQL "SELECT name FROM teams INNER JOIN games ON teams.team_id = games.winner_id WHERE year=2018 AND round ='Final'")"
Winner of the 2018 tournament team name:
France

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "SELECT name FROM teams LEFT JOIN games ON teams.team_id = games.winner_id OR teams.team_id=games.opponent_id WHERE round='Eighth-Final' AND year=2014 GROUP BY name ORDER BY name")"
List of teams who played in the 2014 'Eighth-Final' round:
Algeria
Argentina
Belgium
Brazil
Chile
Colombia
Costa Rica
France
Germany
Greece
Mexico
Netherlands
Nigeria
Switzerland
United States
Uruguay

echo -e "\nList of unique winning team names in the whole data set:"
echo "$($PSQL "SELECT DISTINCT(name) FROM teams RIGHT JOIN games ON teams.team_id = games.winner_id ORDER BY name")"
List of unique winning team names in the whole data set:
Argentina
Belgium
Brazil
Colombia
Costa Rica
Croatia
England
France
Germany
Netherlands
Russia
Sweden
Uruguay

echo -e "\nYear and team name of all the champions:"
echo "$($PSQL "SELECT year, name FROM teams RIGHT JOIN games ON teams.team_id = games.winner_id WHERE round='Final' ORDER BY year")"
Year and team name of all the champions:
2014|Germany
2018|France

echo -e "\nList of teams that start with 'Co':"
echo "$($PSQL "SELECT name FROM teams WHERE name LIKE 'Co%'")"
List of teams that start with 'Co':
Colombia
Costa Rica

#The End.
