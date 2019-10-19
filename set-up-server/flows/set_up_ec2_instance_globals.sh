#!/usr/bin/env bash
readonly DATE_WITH_TIME=`date "+%Y-%m-%d-%H-%-M-%S"`
readonly PRIVATE_KEY_OF_NEW_EC2_INST_PATH="/home/sandor/Documents/aws-ssh-key.pem"
readonly OWN_PUBLIC_KEY_PATH="/home/sandor/.ssh/id_rsa.pub"
readonly OWN_PRIVATE_KEY_PATH="/home/sandor/.ssh/id_rsa"
readonly CREATE_USER_SCRIPT_PATH="../libs/create-user.sh"
readonly SET_UP_SSH_KEY_SCRIPT_PATH="../libs/set-up-ssh-key.sh"
readonly INSTALL_DOCKER_SCRIPT_PATH="../libs/install-docker.sh"
readonly INSTALL_AND_START_NGINX_SCRIPT_PATH="../libs/install-and-start-nginx/index.sh"
readonly MIME_TYPES_FILE_PATH="../libs/mime.types"
readonly NGINX_CONFIG_FILE_PATH="../libs/nginx.conf.sh"
readonly MOVE_DB_DUMP_TO_EC2="../libs/move-db-dump-to-ec2/index.sh"
readonly DUMP_FILES_NAME="all-databases-${DATE_WITH_TIME}.sql"
readonly UPLOAD_FOLDER_ON_EC2="/home/sandor/db"
readonly DOWNLOADS_fOLDER="/home/sandor/Documents"
readonly NEW_SERVER_SSH_PUBLIC_KEY_PATH="/home/sandor/Documents/aws-ssh-key.pem"
#[[ $NEW_USERS_NAME = "" ]] && NEW_USERS_NAME="aaa" || a="ddd"

read -p 'New ec2 servers ip: ' NEW_EC2_IP
[[ $NEW_EC2_IP = "" ]] && NEW_EC2_IP="18.223.143.155"

read -p 'New ec2 users name: ' NEW_USERS_NAME
[[ $NEW_USERS_NAME = "" ]] && NEW_USERS_NAME="sandor"

readonly EC2_ADDR_OF_DEF_USER="ubuntu@${NEW_EC2_IP}"
readonly EC2_ADDR_OF_NEW_USER="${NEW_USERS_NAME}@${NEW_EC2_IP}"

read -p 'New ec2 users pwd:' NEW_USERS_PWD
[[ $NEW_USERS_PWD = "" ]] && NEW_USERS_PWD="password"

read -p 'Address of the db source server:' DB_SOURCE_SERVER_IP
[[ $DB_SOURCE_SERVER_IP = "" ]] && DB_SOURCE_SERVER_IP="104.248.161.185"

read -p 'User name of the db source server:' DB_SOURCE_SERVER_USERS_NAME
[[ $DB_SOURCE_SERVER_USERS_NAME = "" ]] && DB_SOURCE_SERVER_USERS_NAME="username"

DB_SOURCE_SERVER_ADDRESS="${DB_SOURCE_SERVER_USERS_NAME}@${DB_SOURCE_SERVER_IP}"

read -p 'Database source servers mysql user: ' SOURCE_SERVER_MYSQL_USER
[[ $SOURCE_SERVER_MYSQL_USER = "" ]] && SOURCE_SERVER_MYSQL_USER="mysqlusername"

read -p 'Database source servers mysql password: ' SOURCE_SERVER_MYSQL_PWD
[[ $SOURCE_SERVER_MYSQL_PWD = "" ]] && SOURCE_SERVER_MYSQL_PWD="mysqlpassword"