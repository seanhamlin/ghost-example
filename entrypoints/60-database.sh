#!/bin/sh

# Ghosts uses special environment variables for the connection to the database.
echo "Setting up the database connection"
export database__client=mysql
export database__pool__min=0
export database__pool__max=32
export database__connection__host=${MARIADB_HOST:-mariadb}
export database__connection__user=${MARIADB_USERNAME:-lagoon}
export database__connection__password=${MARIADB_PASSWORD:-lagoon}
export database__connection__database=${MARIADB_DATABASE:-lagoon}

echo "Host: ${database__connection__host}"
echo "Username: ${database__connection__user}"
echo "Database: ${database__connection__database}"

echo "Setting up default URL"
export url=${LAGOON_ROUTE:-ghost.docker.amazee.io}

echo "Setting up email"
# mail__transport: ${MAIL_TRANSPORT:-Direct}
# mail__options__service: ${MAIL_SERVICE}
# mail__options__host: ${MAIL_HOST}
# mail__options__port: ${MAIL_PORT:-25}
# mail__options__secureConnection: ${MAIL_SECURE:-false}
# mail__options__auth__user: ${MAIL_USER}
# mail__options__auth__pass: ${MAIL_PASSWORD}
