#!/bin/bash - 

. /app/lib/common.sh

CHECK_BIN "sed"
CHECK_BIN "dbconfig-generate-include"
CHECK_BIN "uwsgi"

MSG "Configuring Roundcube..."
sed -i -e "s/{{ROUNDCUBE_DBUSER}}/${ROUNDCUBE_DBUSER}/" \
	-e "s/{{ROUNDCUBE_DBPASS}}/${ROUNDCUBE_DBPASS}/" \
	-e "s/{{ROUNDCUBE_DBSERVER}}/${ROUNDCUBE_DBSERVER}/" \
	-e "s/{{ROUNDCUBE_DBPORT}}/${ROUNDCUBE_DBPORT}/" \
	-e "s/{{ROUNDCUBE_DBNAME}}/${ROUNDCUBE_DBNAME}/" \
	/etc/dbconfig-common/roundcube.conf

dbconfig-generate-include /etc/dbconfig-common/roundcube.conf > /etc/roundcube/debian-db.php

MSG "Serving site..."

exec "$@"
