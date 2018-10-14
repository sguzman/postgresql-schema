FROM postgres:10.5-alpine

USER postgres

RUN chmod 0700 /var/lib/postgresql/data &&\
    initdb /var/lib/postgresql/data &&\
    echo "host all  all    0.0.0.0/0  md5" >> /var/lib/postgresql/data/pg_hba.conf &&\
    echo "listen_addresses='*'" >> /var/lib/postgresql/data/postgresql.conf &&\
    pg_ctl start &&\
    psql -U postgres -c 'CREATE DATABASE youtube' &&\
    psql -U postgres -c 'CREATE SCHEMA entities' 'youtube' &&\
    psql -U postgres -c 'CREATE TABLE entities.channels(id bigserial PRIMARY KEY NOT NULL, serial char(24) NOT NULL); CREATE UNIQUE INDEX channels_id_uindex ON entities.channels (id); CREATE UNIQUE INDEX channels_serial_uindex ON entities.table_name (serial);' 'youtube' &&\
    psql -U postgres -c 'CREATE TABLE entities.videos(id bigserial NOT NULL,serial char(11) PRIMARY KEY NOT NULL,CONSTRAINT videos_channels_id_fk FOREIGN KEY (id) REFERENCES entities.channels (id));CREATE UNIQUE INDEX videos_serial_uindex ON entities.videos (serial);' 'youtube' &&\
    psql --command "ALTER USER postgres WITH ENCRYPTED PASSWORD 'admin';"

EXPOSE 5432