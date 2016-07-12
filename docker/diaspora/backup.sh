#!/bin/bash

echo "diaspora:5432:diaspora_production:diaspora:diaspora" > $HOME/.pgpass
chmod 600 $HOME/.pgpass

BACKUP_TMP_DIR=/tmp/backups

mkdir $BACKUP_TMP_DIR
BACKUPFILE=$BACKUP_TMP_DIR/postgres
pg_basebackup -h postgres -U diaspora -x -P -D $BACKUPFILE && \
rsync -a /home/diaspora $BACKUP_TMP_DIR && \
cd $BACKUP_TMP_DIR && \
tar czvf /backups/diaspora-backups-`date +%Y-%m-%dT%H:%M:%S`.tgz .
