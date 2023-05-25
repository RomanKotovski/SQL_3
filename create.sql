CREATE TABLE IF NOT EXISTS genre (
	id serial PRIMARY KEY,
	name varchar(60) NOT NULL
);

CREATE TABLE IF NOT EXISTS author (
	id SERIAL PRIMARY KEY,
	name varchar(60) NOT NULL
);

CREATE TABLE IF NOT EXISTS album (
	id serial PRIMARY KEY,
	name varchar(60) NOT NULL,
	year integer NOT NULL
);

CREATE TABLE IF NOT EXISTS track (
	id serial PRIMARY KEY,
	name varchar(60) NOT NULL,
	duration interval NOT NULL,
	album_id integer NOT NULL REFERENCES album(id)
);

CREATE TABLE IF NOT EXISTS mixtape (
	id serial PRIMARY KEY,
	name varchar(60) NOT NULL,
	year integer NOT NULL
);

CREATE TABLE IF NOT EXISTS genreauthor (
	genre_id integer REFERENCES genre(id),
	author_id integer REFERENCES author(id),
	constraint ge PRIMARY KEY (genre_id, author_id)
);
	
CREATE TABLE IF NOT EXISTS albumauthor (
	album_id integer REFERENCES album(id),
	author_id integer REFERENCES author(id),
	constraint aa PRIMARY KEY (album_id, author_id)
);

CREATE TABLE IF NOT EXISTS trackmixtape (
	track_id integer REFERENCES track(id),
	mixtape_id integer REFERENCES mixtape(id),
	constraint tm PRIMARY KEY (track_id, mixtape_id)
);