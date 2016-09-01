#!/bin/sh

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

#echo "import pty; pty.spawn('/bin/bash')" > /tmp/asdf.py
#python /tmp/asdf.py

sed -i "/listen_addresses/i listen_addresses='*'" /var/lib/postgresql/data/pgdata/postgresql.conf

sed -i "/^# IPv4 local connections:/i host    all             all             0.0.0.0/0               md5" /var/lib/postgresql/data/pgdata/pg_hba.conf
echo "host all all 172.17.0.0/16 trust" >> /var/lib/postgresql/data/pgdata/pg_hba.conf

set -e



if [ ! `su postgres 'psql -lqt | cut -d \| -f 1 | grep -qw jbpm'` ]; then

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE USER jbpm WITH PASSWORD 'jbpm';
    CREATE DATABASE jbpm;
    GRANT ALL PRIVILEGES ON DATABASE jbpm TO jbpm;
EOSQL

fi

#if [ ! `su postgres 'psql -lqt | cut -d \| -f 1 | grep -qw security'` ]; then

#psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
#    CREATE USER security WITH PASSWORD 'security';
#    CREATE DATABASE security;
#    GRANT ALL PRIVILEGES ON DATABASE security TO security;
#EOSQL
#/bin/su postgres -c 'psql -f /docker-entrypoint-initdb.d/security.dump security'
#fi




export POSTGRES_USER

#pg_createcluster 9.4 main --start

/etc/init.d/postgresql restart