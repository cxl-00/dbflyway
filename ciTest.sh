#!/usr/bin/env bash

set -e
declare -A db_mappings=(
    ["demodb"]="demodb"
    )

# declare -a flyway_pathes=("demodb")

FLYWAY_DB_HOST=${FLYWAY_DB_HOST:-db}
FLYWAY_DB_PORT=${FLYWAY_DB_PORT:-3306}
export FLYWAY_DRIVER=${FLYWAY_DRIVER:-com.mysql.cj.jdbc.Driver}
export FLYWAY_CONNECT_RETRIES=${FLYWAY_CONNECT_RETRIES:-1}
export FLYWAY_USER=${FLYWAY_USER:-root}
export FLYWAY_PASSWORD=${FLYWAY_PASSWORD:-123456}

for path in ${!db_mappings[@]}; do
    db_name="${db_mappings[${path}]}"
    echo "CREATE DB - ${db_name}"
    mysql -h${FLYWAY_DB_HOST} -P${FLYWAY_DB_PORT} -u${FLYWAY_USER} -p${FLYWAY_PASSWORD} -e "DROP DATABASE IF EXISTS ${db_name} ;"
    mysql -h${FLYWAY_DB_HOST} -P${FLYWAY_DB_PORT} -u${FLYWAY_USER} -p${FLYWAY_PASSWORD} -e "CREATE DATABASE ${db_name} ;"
    echo "Migrate (${path}) into ${db_name}"
    export FLYWAY_URL="jdbc:mysql://${FLYWAY_DB_HOST}:${FLYWAY_DB_PORT}/${db_name}?useUnicode=true"
    /flyway/flyway migrate -locations=filesystem:${path}
    echo "--------------------"
    /flyway/flyway info -locations=filesystem:${path}
    echo "--------------------"
    echo "Clean (${path}) from ${db_name}"
    /flyway/flyway clean -locations=filesystem:${path}
    echo "DROP DB - ${db_name}"
    mysql -h${FLYWAY_DB_HOST} -P${FLYWAY_DB_PORT} -u${FLYWAY_USER} -p${FLYWAY_PASSWORD} -e "DROP DATABASE ${db_name} ;"
    echo "=========================================="
done

echo "All scripts passed."