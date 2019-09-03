#!/usr/bin/env bash
SOURCE_SERVER_MYSQL_USER=$1
SOURCE_SERVER_MYSQL_PWD=$2
SOURCE_SERVER_ADDRESS=$3
DESTINATION_SERVER_ADDRESS=$4
DUMP_FILES_NAME=${7:-"all_databases.sql"}
UPLOAD_FOLDER_ON_TARGET_SERVER=${8:-"/home/sandor/db"}
DOWNLOADS_fOLDER=${9:-"/home/sandor/Downloads"}
DESTINATION_SERVER_SSH_PUBLIC_KEY_PATH=${10:-"/home/sandor/Documents/aws-ssh-key.pem"}

echo $SOURCE_SERVER_MYSQL_USER $SOURCE_SERVER_MYSQL_PWD $SOURCE_SERVER_ADDRESS $DUMP_FILES_NAME $UPLOAD_FOLDER_ON_TARGET_SERVER $DOWNLOADS_fOLDER $DESTINATION_SERVER_SSH_PUBLIC_KEY_PATH

if ! test -f /usr/local/bin/download-db-backup-from-server.sh; then
    echo "the /usr/local/bin/download-db-backup-from-server.sh file is a dependency of this command but it can not be found, so please solve this"
    exit 1
fi

upload-file-to-server() {
    scp \
    -i $DESTINATION_SERVER_SSH_PUBLIC_KEY_PATH \
    "${DOWNLOADS_fOLDER}/${DUMP_FILES_NAME}" \
    "${DESTINATION_SERVER_ADDRESS}:"\
    "${UPLOAD_FOLDER_ON_TARGET_SERVER};"
}

#download-db-backup-from-server.sh \
#$DUMP_FILES_NAME \
#$DOWNLOADS_fOLDER \
#$SOURCE_SERVER_ADDRESS \
#$SOURCE_SERVER_MYSQL_USER \
#$SOURCE_SERVER_MYSQL_PWD;
#
#upload-file-to-server