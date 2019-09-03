#!/usr/bin/env bash
DUMP_FILES_NAME=${1:-"all_databases11.sql"}
DOWNLOADS_fOLDER=${2:-"/home/sandor/Downloads"}
REMOTE_USER=${3:-"sandor"}
REMOTE_MYSQL_USER=${4:-"sdeli"}
REMOTE_MYSQL_PWD=${5:-"dalias19"}
SERVER_IP=${6:-"104.248.161.185"}

if ! test -f /usr/local/bin/create-all-databases-db-backup.sh; then
    echo "the /usr/local/bin/create-all-databases-db-backup.sh file is a dependency of this command but it can not be found, so please solve this"
    exit 1
fi

REMOTE_ADDRESS="${REMOTE_USER}@${SERVER_IP}"
DUMP_FILES_PATH="${HOME}/${DUMP_FILES_NAME}"
CREATE_DATABASE_ON_REMOTE_SERVER="${HOME}"/create-all-databases-db-backup.sh

scp /usr/local/bin/create-all-databases-db-backup.sh "${REMOTE_ADDRESS}":"${CREATE_DATABASE_ON_REMOTE_SERVER}"

ssh -t "${REMOTE_ADDRESS}" "$CREATE_DATABASE_ON_REMOTE_SERVER $DUMP_FILES_PATH $REMOTE_MYSQL_USER $REMOTE_MYSQL_PWD"

scp "${REMOTE_ADDRESS}:${DUMP_FILES_PATH}" "${DOWNLOADS_fOLDER}/${DUMP_FILES_NAME}"
ssh -t "${REMOTE_ADDRESS}" "rm ${CREATE_DATABASE_ON_REMOTE_SERVER} ${DUMP_FILES_PATH}"

