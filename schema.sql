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
country CHAR(2),
joined TIMESTAMP NOT NULL
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

create view space_usage as SELECT *, pg_size_pretty(total_bytes) AS total
 , pg_size_pretty(index_bytes) AS INDEX
 , pg_size_pretty(toast_bytes) AS toast
 , pg_size_pretty(table_bytes) AS TABLE
 FROM (
SELECT *, total_bytes-index_bytes-COALESCE(toast_bytes,0) AS table_bytes FROM (
SELECT c.oid,nspname AS table_schema, relname AS TABLE_NAME
, c.reltuples AS row_estimate
, pg_total_relation_size(c.oid) AS total_bytes
, pg_indexes_size(c.oid) AS index_bytes
, pg_total_relation_size(reltoastrelid) AS toast_bytes
FROM pg_class c
 LEFT JOIN pg_namespace n ON n.oid = c.relnamespace
WHERE relkind = 'r'
) a
) a order by total_bytes desc;
