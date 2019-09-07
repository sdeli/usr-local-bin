#!/usr/bin/env bash
echo "=================================="
echo "MOVING MYSQL DB DUMP TO NEW SERVER"
echo "=================================="

# ==== DEPENDENCIES ====
readonly SOURCE_SERVER_ADDRESS=$1
readonly SOURCE_SERVER_MYSQL_USER=$2
readonly SOURCE_SERVER_MYSQL_PWD=$3
readonly DESTINATION_SERVER_ADDRESS=$4
readonly DESTINATION_SERVER_SSH_PRIVATE_KEY_PATH=$5
readonly DUMP_FILES_NAME=${6:-"all_databases.sql"}
readonly UPLOAD_FOLDER_ON_TARGET_SERVER=${7:-"/home/sandor/db"}
readonly DOWNLOADS_fOLDER=${8:-"/home/sandor/Downloads"}
# ==== DEPENDENCIES END ====

readonly DUMP_FILES_PATH="${HOME}/${DUMP_FILES_NAME}"

createDbDumpOnRemoteServer() {
    local exportDbDumpForAllDbs="./modules/create-all-databases-db-backup.sh"
    local exportDbDumpForAllDbsOnEc2="${HOME}/create-all-databases-db-backup.sh"

    scp "${exportDbDumpForAllDbs}" "${SOURCE_SERVER_ADDRESS}":"${exportDbDumpForAllDbsOnEc2}"
    ssh -t "${SOURCE_SERVER_ADDRESS}" <<EOF
        ${exportDbDumpForAllDbsOnEc2} ${DUMP_FILES_PATH} ${SOURCE_SERVER_MYSQL_USER} ${SOURCE_SERVER_MYSQL_PWD}
        rm ${exportDbDumpForAllDbsOnEc2}
EOF
}

downloadDbBackupFromServer() {
    scp "${SOURCE_SERVER_ADDRESS}:${DUMP_FILES_PATH}" "${DOWNLOADS_fOLDER}/${DUMP_FILES_NAME}"

    echo '==============================='
    echo 'DATABASE DUMP DOWNLOADED INTO:'
    echo "${DOWNLOADS_fOLDER}"
    echo '==============================='

    ssh -t "${SOURCE_SERVER_ADDRESS}" "rm ${DUMP_FILES_PATH}"
}

uploadFileToServer() {
    echo "$DESTINATION_SERVER_SSH_PRIVATE_KEY_PATH ${DOWNLOADS_fOLDER}/${DUMP_FILES_NAME} $DESTINATION_SERVER_ADDRESS $UPLOAD_FOLDER_ON_TARGET_SERVER"
    scp -i ${DESTINATION_SERVER_SSH_PRIVATE_KEY_PATH} "${DOWNLOADS_fOLDER}/${DUMP_FILES_NAME}" "${DESTINATION_SERVER_ADDRESS}:${UPLOAD_FOLDER_ON_TARGET_SERVER}"

    echo '=========================='
    echo 'DATABASE DUMP UPLOADED TO:'
    echo "${DESTINATION_SERVER_ADDRESS} ${UPLOAD_FOLDER_ON_TARGET_SERVER}"
    echo '=========================='
}

createDbDumpOnRemoteServer
downloadDbBackupFromServer
uploadFileToServer