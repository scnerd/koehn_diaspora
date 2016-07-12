#!/bin/bash

echo "host replication diaspora 0.0.0.0/0 trust" >> /var/lib/postgresql/data/pg_hba.conf 
echo "max_wal_senders = 1" >> /var/lib/postgresql/data/postgresql.conf
echo "wal_level = archive" >> /var/lib/postgresql/data/postgresql.conf
