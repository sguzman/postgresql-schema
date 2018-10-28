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
	joined TIMESTAMP NOT NULL,
	thumbnail VARCHAR(400),
	topic_ids VARCHAR(10) [],
	topic_categories VARCHAR(200) [],
	privacy_status VARCHAR(10) NOT NULL,
	is_linked BOOLEAN NOT NULL,
	long_uploads VARCHAR(25) NOT NULL,
	tracking_id VARCHAR(25),
	moderate_comments BOOLEAN,
	show_related_channels BOOLEAN,
	show_browse BOOLEAN,
	banner_image VARCHAR(400) NOT NULL,
  CONSTRAINT chans_channels_id_fk FOREIGN KEY (id) REFERENCES youtube.entities.channels (id)
);

CREATE UNIQUE INDEX chans_chan_serial_uindex ON youtube.entities.chans (serial);