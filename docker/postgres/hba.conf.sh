#!/bin/bash

# Adds a line to `pg_hba.conf` that allows the backups to work. 

echo "updating pg_hba.conf…"

cat >> /var/lib/postgresql/data/pg_hba.conf <<-EOF
host       replication  diaspora  0.0.0.0/0  trust  
EOF