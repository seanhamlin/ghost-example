#!/bin/sh

# Ghosts uses special environment variables for the connection to the database.
echo "Setting up database credentials"
export database__connection__host=${MARIADB_HOST:-mariadb}
export database__connection__user=${MARIADB_USERNAME:-lagoon}
export database__connection__password=${MARIADB_PASSWORD:-lagoon}
export database__connection__database=${MARIADB_DATABASE:-lagoon}
