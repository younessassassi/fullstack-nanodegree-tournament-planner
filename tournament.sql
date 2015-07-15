-- Create database "tournament" and connect to that database before creating tables
\c vagrant
DROP DATABASE IF EXISTS tournament;
CREATE DATABASE tournament;
\c tournament

-- player table
CREATE TABLE player ( id SERIAL PRIMARY KEY,
					  full_name VARCHAR(40) NOT NULL);

-- match table
CREATE TABLE match ( id SERIAL,
					 winner INTEGER REFERENCES player(id),
					 loser INTEGER REFERENCES player(id),
				   	 CONSTRAINT game_key PRIMARY KEY (winner, loser));

-- matches table
CREATE TABLE matches ( id INTEGER REFERENCES player(id) PRIMARY KEY,
					   matches_played INTEGER DEFAULT 0,
					   wins INTEGER DEFAULT 0);

-- ranking view
CREATE VIEW standings AS SELECT player.id, player.full_name, matches.wins , matches.matches_played
					   FROM player LEFT JOIN matches
					   ON player.id = matches.id
					   ORDER BY matches.wins DESC;
