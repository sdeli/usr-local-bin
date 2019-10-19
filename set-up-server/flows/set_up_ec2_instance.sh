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

readonly STARTUP_SCRIPTS_PATH_ON_EC2="/home/${NEW_USERS_NAME}/opt"
readonly OWN_PUBLIC_KEY_EC2_PATH="${STARTUP_SCRIPTS_PATH_ON_EC2}/$(basename "${OWN_PUBLIC_KEY_PATH}")"

createUser() {
    local createUserEc2Path="/home/ubuntu/$(basename "${CREATE_USER_SCRIPT_PATH}")"
    echo "${PRIVATE_KEY_OF_NEW_EC2_INST_PATH}"
    scp -i "${PRIVATE_KEY_OF_NEW_EC2_INST_PATH}" "${CREATE_USER_SCRIPT_PATH}" "${EC2_ADDR_OF_DEF_USER}":"${createUserEc2Path}"

    ssh -i "${PRIVATE_KEY_OF_NEW_EC2_INST_PATH}" "${EC2_ADDR_OF_DEF_USER}" \
    sudo "${createUserEc2Path}" "${NEW_USERS_NAME}" "${NEW_USERS_PWD}"

     [[ $? > 0 ]] && exit "There was a problem during creating the user" || \
     echo "User created successfully"
}

setUpSshKey() {
    local setUpSshKeyEc2Path="/home/ubuntu/$(basename "${SET_UP_SSH_KEY_SCRIPT_PATH}")"
    echo $setUpSshKeyEc2Path
    scp -i "${PRIVATE_KEY_OF_NEW_EC2_INST_PATH}" "${SET_UP_SSH_KEY_SCRIPT_PATH}" "${EC2_ADDR_OF_DEF_USER}":"${setUpSshKeyEc2Path}"

    local publicKeyEc2Path="/home/ubuntu/$(basename "${OWN_PUBLIC_KEY_PATH}")"
    echo $publicKeyEc2Path
    scp -i "${PRIVATE_KEY_OF_NEW_EC2_INST_PATH}" "${OWN_PUBLIC_KEY_PATH}" "${EC2_ADDR_OF_DEF_USER}":"${publicKeyEc2Path}"

    ssh -i "${PRIVATE_KEY_OF_NEW_EC2_INST_PATH}" "${EC2_ADDR_OF_DEF_USER}" \
    "sudo ${setUpSshKeyEc2Path} ${NEW_USERS_NAME} ${publicKeyEc2Path}"

    [[ $? > 0 ]] && exit "There was a problem during setting up the ssh keys" || \
    echo "ssh keys are set up successfully"
}

createStartupScriptsFolderOnServer() {
    ssh -i "${PRIVATE_KEY_OF_NEW_EC2_INST_PATH}" "${EC2_ADDR_OF_NEW_USER}" "
    sudo mkdir ${STARTUP_SCRIPTS_PATH_ON_EC2};
    sudo chown ${NEW_USERS_NAME} ${STARTUP_SCRIPTS_PATH_ON_EC2};
    "

    [[ $? > 0 ]] && exit "There was a problem during creating startup scripts folder" || \
    echo "successfully created folder for scripts"
}

installDocker() {
    local installDockerEc2Path="${STARTUP_SCRIPTS_PATH_ON_EC2}/$(basename "${INSTALL_DOCKER_SCRIPT_PATH}")"
    # -t: safe to prompt the user for additional input without breaking things
    scp -i "${OWN_PRIVATE_KEY_PATH}" "${INSTALL_DOCKER_SCRIPT_PATH}" "${EC2_ADDR_OF_NEW_USER}":"${installDockerEc2Path}"

    ssh -t -i "${OWN_PRIVATE_KEY_PATH}" "${EC2_ADDR_OF_NEW_USER}" "sudo ${installDockerEc2Path}"
    [[ $? > 0 ]] && exit "There was a problem during creating installing docker"
}

installNginxAndStart() {
    local nginxConfigEc2Path="${STARTUP_SCRIPTS_PATH_ON_EC2}/$(basename "${NGINX_CONFIG_FILE_PATH}")"
    local mimeTypesEc2Path="${STARTUP_SCRIPTS_PATH_ON_EC2}/$(basename "${MIME_TYPES_FILE_PATH}")"
    local installAndStartNginxEc2PAth="${STARTUP_SCRIPTS_PATH_ON_EC2}/$(basename "${INSTALL_AND_START_NGINX_SCRIPT_PATH}")"

    "${EC2_ADDR_OF_NEW_USER}":"${nginxSystemDEc2Path}" scp -i "${OWN_PRIVATE_KEY_PATH}" "${NGINX_CONFIG_FILE_PATH}"
    "${EC2_ADDR_OF_NEW_USER}":"${nginxConfigEc2Path}" scp -i "${OWN_PRIVATE_KEY_PATH}" "${MIME_TYPES_FILE_PATH}"
    "${EC2_ADDR_OF_NEW_USER}":"${mimeTypesEc2Path}" scp -i "${OWN_PRIVATE_KEY_PATH}"
    "${INSTALL_AND_START_NGINX_SCRIPT_PATH}" "${EC2_ADDR_OF_NEW_USER}":"${installAndStartNginxEc2PAth}"

    ssh -t -i "${OWN_PRIVATE_KEY_PATH}" "${EC2_ADDR_OF_NEW_USER}" "sudo ${installAndStartNginxEc2PAth}"
    [[ $? > 0 ]] && exit "There was a problem during setting up nginx"
}

moveAllMysqlDbsFromSourceServerToDestination() {
    cd $(dirname $MOVE_DB_DUMP_TO_EC2)
    local moveDpDumpToEc2Ec2PAth="./$(basename $MOVE_DB_DUMP_TO_EC2)"

    sudo ${moveDpDumpToEc2Ec2PAth}  \
    ${DB_SOURCE_SERVER_ADDRESS}  \
    ${SOURCE_SERVER_MYSQL_USER}  \
    ${SOURCE_SERVER_MYSQL_PWD}  \
    ${EC2_ADDR_OF_NEW_USER}  \
    ${OWN_PRIVATE_KEY_PATH} \
    ${DUMP_FILES_NAME}  \
    ${UPLOAD_FOLDER_ON_EC2}  \
    ${DOWNLOADS_fOLDER}

    [[ $? > 0 ]] && exit "There was a problem during moving db dump from one server to the other+"
}

createUser
setUpSshKey
createStartupScriptsFolderOnServer
installDocker
#installNginxAndStart
#moveAllMysqlDbsFromSourceServerToDestination