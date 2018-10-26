CREATE database youtube;
\connect youtube
CREATE SCHEMA entities;

CREATE TABLE youtube.entities.channels(
  serial CHAR(24) PRIMARY KEY NOT NULL
);
CREATE UNIQUE INDEX channels_serial_uindex ON youtube.entities.channels (serial);

CREATE TABLE youtube.entities.videos(
  serial CHAR(11) PRIMARY KEY NOT NULL,
);

CREATE UNIQUE INDEX videos_serial_uindex ON youtube.entities.videos (serial);

CREATE VIEW counts AS
  SELECT
         (SELECT count(*) FROM youtube.entities.videos) vids,
         (SELECT count(*) FROM youtube.entities.channels) chans;


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

CREATE TABLE youtube.entities.vids(
	serial CHAR(11) NOT NULL,
  published_at TIMESTAMP NOT NULL,
  channel_id CHAR(24) NOT NULL,
  title VARCHAR(100) NOT NULL,
  description VARCHAR(8000) NOT NULL,
  thumbnail VARCHAR(400) NOT NULL,
  category_id INT NOT NULL,
  live_broadcasting_content VARCHAR(10),
  default_audio_language VARCHAR(20),
  duration INTERVAL NOT NULL,
  dimension CHAR(2) NOT NULL,
  definition CHAR(2) NOT NULL,
  caption BOOLEAN NOT NULL,
  licensed_content BOOLEAN NOT NULL,
  projection VARCHAR(15) NOT NULL,
  upload_status VARCHAR(30) NOT NULL,
  privacy_status VARCHAR(10) NOT NULL,
  license VARCHAR(15) NOT NULL,
  embeddable BOOLEAN NOT NULL,
  public_stats_viewable BOOLEAN NOT NULL,
  relevant_topic_ids VARCHAR(10) [],
  topic_categories VARCHAR(100) []
);

CREATE UNIQUE INDEX vids_serial_uindex ON youtube.entities.vids (serial);

CREATE VIEW cnt AS
  SELECT
         (SELECT count(*) FROM youtube.entities.vids) vids,
         (SELECT count(*) FROM youtube.entities.chans) chans;