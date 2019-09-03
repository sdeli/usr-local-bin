                                                            #!/usr/bin/env bash

# DESCRIPTION:
#   This script is for setting up an ec2 instance
#       - sets up ssh key for new user
#       - installs docker
#
#    In the "DEPENDENCIES SET BY USER" part you find the dependencies which should be carefully read by the user of the script,
#    and modified if needed.
#
#   TYPICALLY YOU WANT PERMISSIONS ON THE .ssh FOLDER TO BE:
#       - ssh directory: 700 (drwx------)
#       - public key (.pub file): 644 (-rw-r--r--)
#       - private key (id_rsa): 600 (-rw-------)

# Abrevations:
#    *_EC2_PATH/ec2Path : files path on ec2 instance

source ./set_up_ec2_instance_globals.sh;

STARTUP_SCRIPTS_PATH_ON_EC2="/home/sandor/startup-scripts"
OWN_PUBLIC_KEY_EC2_PATH="${STARTUP_SCRIPTS_PATH_ON_EC2}/$(basename "${OWN_PUBLIC_KEY_PATH}")"

createStartupScriptsFolderOnServer() {
    ssh -i "${PRIVATE_KEY_OF_NEW_EC2_INST_PATH}" "${EC2_ADDR_OF_DEF_USER}" "mkdir startup-scripts"
    echo 'created'
}

createUser() {
    local createUserEc2Path="${STARTUP_SCRIPTS_PATH_ON_EC2}/$(basename "${CREATE_USER_SCRIPT_PATH}")"
    scp -i "${PRIVATE_KEY_OF_NEW_EC2_INST_PATH}" "${CREATE_USER_SCRIPT_PATH}" "${EC2_ADDR_OF_DEF_USER}":"${createUserEc2Path}"

    ssh -i "${PRIVATE_KEY_OF_NEW_EC2_INST_PATH}" "${EC2_ADDR_OF_DEF_USER}" "sudo ${createUserEc2Path} ${NEW_USERS_NAME}"
    STARTUP_SCRIPTS_PATH_ON_EC2="/home/${NEW_USERS_NAME}/startup-scripts"
}

setUpSshKey() {
    scp -i "${PRIVATE_KEY_OF_NEW_EC2_INST_PATH}" "${SET_UP_SSH_KEY_SCRIPT_PATH}" "${EC2_ADDR_OF_DEF_USER}":"${SET_UP_SSH_KEY_EC2_PATH}"

    ssh -i "${PRIVATE_KEY_OF_NEW_EC2_INST_PATH}" "${EC2_ADDR_OF_DEF_USER}" \
    "sudo ${SET_UP_SSH_KEY_EC2_PATH} ${NEW_USERS_NAME} ${OWN_PUBLIC_KEY_EC2_PATH}"
}

installDocker() {
    local installDockerEc2Path="${STARTUP_SCRIPTS_PATH_ON_EC2}/$(basename "${INSTALL_DOCKER_SCRIPT_PATH}")"
    # -t: safe to prompt the user for additional input without breaking things
    scp -i "${OWN_PRIVATE_KEY_PATH}" "${INSTALL_DOCKER_SCRIPT_PATH}" "${EC2_ADDR_OF_NEW_USER}":"${installDockerEc2Path}"

    ssh -t -i "${OWN_PRIVATE_KEY_PATH}" "${EC2_ADDR_OF_NEW_USER}" "sudo ${installDockerEc2Path}"
}

installNginxAndStart() {
    local nginxSystemDEc2Path="${STARTUP_SCRIPTS_PATH_ON_EC2}/$(basename "${NGINX_SYSTEMD_SERVICE_FILE_PATH}")"
    local nginxConfigEc2Path="${STARTUP_SCRIPTS_PATH_ON_EC2}/$(basename "${NGINX_CONFIG_FILE_PATH}")"
    local mimeTypesEc2Path="${STARTUP_SCRIPTS_PATH_ON_EC2}/$(basename "${MIME_TYPES_FILE_PATH}")"
    local installAndStartNginxEc2PAth="${STARTUP_SCRIPTS_PATH_ON_EC2}/$(basename "${INSTALL_AND_START_NGINX_SCRIPT_PATH}")"

    scp -i "${OWN_PRIVATE_KEY_PATH}" "${NGINX_SYSTEMD_SERVICE_FILE_PATH}" "${EC2_ADDR_OF_NEW_USER}":"${nginxSystemDEc2Path}"
    scp -i "${OWN_PRIVATE_KEY_PATH}" "${NGINX_CONFIG_FILE_PATH}" "${EC2_ADDR_OF_NEW_USER}":"${nginxConfigEc2Path}"
    scp -i "${OWN_PRIVATE_KEY_PATH}" "${MIME_TYPES_FILE_PATH}" "${EC2_ADDR_OF_NEW_USER}":"${mimeTypesEc2Path}"
    scp -i "${OWN_PRIVATE_KEY_PATH}" "${INSTALL_AND_START_NGINX_SCRIPT_PATH}" "${EC2_ADDR_OF_NEW_USER}":"${installAndStartNginxEc2PAth}"

    ssh -t -i "${OWN_PRIVATE_KEY_PATH}" "${EC2_ADDR_OF_NEW_USER}" "sudo ${installAndStartNginxEc2PAth}  \
                                                                        ${NEW_USERS_NAME}  \
                                                                        ${NGINX_VERSION}  \
                                                                        ${nginxSystemDEc2Path} \
                                                                        ${OPEN_SSL_SUBJECT}  \
                                                                        ${nginxConfigEc2Path} \
                                                                        ${mimeTypesEc2Path}"
}

moveAllMysqlDbsFromSourceServerToDestination() {
    local moveDbDumpTpEc2Path="${STARTUP_SCRIPTS_PATH_ON_EC2}/$(basename "${MOVE_DB_DUMP_TO_EC2}")"

    echo $moveDbDumpTpEc2Path

    scp -i "${OWN_PRIVATE_KEY_PATH}" "${MOVE_DB_DUMP_TO_EC2}" "${EC2_ADDR_OF_NEW_USER}":"${moveDbDumpTpEc2Path}"

    ssh -t -i "${OWN_PRIVATE_KEY_PATH}" "${EC2_ADDR_OF_NEW_USER}" "sudo ${moveDbDumpTpEc2Path}  \
                                                                        ${SOURCE_SERVER_MYSQL_USER}  \
                                                                        ${SOURCE_SERVER_MYSQL_PWD}  \
                                                                        ${DB_SOURCE_SERVER_ADDRESS}  \
                                                                        ${DUMP_FILES_NAME}  \
                                                                        ${UPLOAD_FOLDER_ON_EC2}  \
                                                                        ${DOWNLOADS_fOLDER}  \
                                                                        ${DB_SOURCE_SERVER_ADDRESS} \
                                                                        ${DESTINATION_SERVER_SSH_PUBLIC_KEY_PATH}"
}

#createStartupScriptsFolderOnServer
#createUser
#setUpSshKey
#installDocker
#installNginxAndStart
moveAllMysqlDbsFromSourceServerToDestination