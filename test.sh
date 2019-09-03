#!/usr/bin/env bash
cat >/home/sandor/mysqldump.cnf <<'EOL'
line 1, ${kernel}
line 2,
line 3, ${distro}
line 4 line
...
EOL

DB_BACKUP_DUMP_FILE_PATH=${1:-"${USER}/all_databases5.sql"}
DB_USER=${2:-"sdeli"}
DB_PWD=${3:-"dalias19"}

DB_CONF_FILE_PATH="${HOME}/mysqldump.cnf"
echo ${DB_CONF_FILE_PATH}
cat >"${DB_CONF_FILE_PATH}" <<'EOL'
[mysql]
user = ${DB_USER}
password = ${DB_PWD}
EOL
cat "${DB_CONF_FILE_PATH}"
#if ! test -f /home/sandor/.bash; then
#    echo "majom"
#fi