#!/usr/bin/env bash
DB_BACKUP_DUMP_FILE_PATH=${1:-"${HOME}/all_databases5.sql"}
DB_USER=${2:-"sdeli"}
DB_PWD=${3:-"dalias19"}

LIST_OF_ALL_DATABASES_WITHOUT_SYSTEM_DBS=$(mysql -u "${DB_USER}" -p"${DB_PWD}" -e 'show databases' | grep -v 'Database\|information_schema\|performance_schema\|sys\|mysql' | tr -s '\n' ' ')

mysqldump -u "${DB_USER}" -p"${DB_PWD}" --databases ${LIST_OF_ALL_DATABASES_WITHOUT_SYSTEM_DBS} > "${DB_BACKUP_DUMP_FILE_PATH}"

echo '====================='
echo 'DATABASE DUMP CREATED'
echo '====================='