CREATE database youtube;
\connect youtube
CREATE SCHEMA entities;

CREATE TABLE youtube.entities.channels(
  serial CHAR(24) PRIMARY KEY NOT NULL
);
CREATE UNIQUE INDEX channels_serial_uindex ON youtube.entities.channels (serial);

CREATE TABLE youtube.entities.chans(
	serial CHAR(24) NOT NULL,
	title VARCHAR(100) NOT NULL,
	custom_url VARCHAR(100),
	description VARCHAR(8000),
	country CHAR(2),
	joined TIMESTAMP NOT NULL,
	topic_categories VARCHAR(200) []
);

CREATE UNIQUE INDEX chans_chan_serial_uindex ON youtube.entities.chans (serial);

CREATE TABLE youtube.entities.chan_stats
(
	time timestamptz DEFAULT now() NOT NULL,
	serial char(24) NOT NULL,
	subs bigint NOT NULL,
	videos int NOT NULL,
	views bigint NOT NULL
);

SELECT create_hypertable('youtube.entities.chan_stats', 'time');