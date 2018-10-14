CREATE database youtube;
\connect youtube
CREATE SCHEMA entities;

CREATE TABLE youtube.entities.channels(
  id bigserial PRIMARY KEY NOT NULL,
  serial char(24) NOT NULL
);
CREATE UNIQUE INDEX channels_id_uindex ON youtube.entities.channels (id);
CREATE UNIQUE INDEX channels_serial_uindex ON youtube.entities.channels (serial);

CREATE TABLE youtube.entities.videos(
  id bigserial NOT NULL,
  serial char(11) PRIMARY KEY NOT NULL,
  CONSTRAINT videos_channels_id_fk FOREIGN KEY (id) REFERENCES youtube.entities.channels (id)
);

CREATE UNIQUE INDEX videos_serial_uindex ON youtube.entities.videos (serial);