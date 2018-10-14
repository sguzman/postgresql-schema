CREATE DATABASE youtube;
USE youtube;
CREATE SCHEMA entities;
CREATE TABLE entities.videos(
  id bigserial NOT NULL,
  serial char(11) PRIMARY KEY NOT NULL,
  CONSTRAINT videos_channels_id_fk FOREIGN KEY (id) REFERENCES entities.channels (id)
);

CREATE UNIQUE INDEX videos_serial_uindex ON entities.videos (serial);

CREATE TABLE entities.channels(
id bigserial PRIMARY KEY NOT NULL,
serial char(24) NOT NULL
);
CREATE UNIQUE INDEX channels_id_uindex ON entities.channels (id);
CREATE UNIQUE INDEX channels_serial_uindex ON entities.table_name (serial);
ALTER USER postgres WITH ENCRYPTED PASSWORD 'admin';