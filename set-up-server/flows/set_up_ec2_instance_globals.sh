#!/usr/bin/env bash
PRIVATE_KEY_OF_NEW_EC2_INST_PATH="/home/sandor/Documents/aws-ssh-key.pem"
OWN_PUBLIC_KEY_PATH="/home/sandor/.ssh/id_rsa.pub"
OWN_PRIVATE_KEY_PATH="/home/sandor/.ssh/id_rsa"
CREATE_USER_SCRIPT_PATH="./libs/create-user.sh"
SET_UP_SSH_KEY_SCRIPT_PATH="./libs/set-up-ssh-key.sh"
INSTALL_DOCKER_SCRIPT_PATH="./libs/install-docker.sh"
NGINX_SYSTEMD_SERVICE_FILE_PATH="./libs/nginx.service"
INSTALL_AND_START_NGINX_SCRIPT_PATH="./libs/install-and-start-nginx.sh"
MIME_TYPES_FILE_PATH="./libs/mime.types"
NGINX_CONFIG_FILE_PATH="./libs/nginx.conf.sh"
MOVE_DB_DUMP_TO_EC2_EC2_PATH="./libs/move-db-dump-to-ec2.sh"
#[[ $NEW_USERS_NAME = "" ]] && NEW_USERS_NAME="aaa" || a="ddd"

read -p 'New ec2 servers ip: ' NEW_EC2_IP
[[ $NEW_EC2_IP = "" ]] && NEW_EC2_IP="52.14.240.7"

read -p 'New ec2 users name: ' NEW_USERS_NAME
[[ $NEW_USERS_NAME = "" ]] && NEW_USERS_NAME="sandor"

EC2_ADDR_OF_DEF_USER="ubuntu@${NEW_EC2_IP}"
EC2_ADDR_OF_NEW_USER="${NEW_USERS_NAME}@${NEW_EC2_IP}"

read -p 'New ec2 users pwd:' NEW_USERS_PWD
[[ $NEW_USERS_PWD = "" ]] && NEW_USERS_PWD="sandor"

read -p 'Address of the db source server:' DB_SOURCE_SERVER_ADDRESS
[[ $DB_SOURCE_SERVER_ADDRESS = "" ]] && DB_SOURCE_SERVER_ADDRESS="104.248.161.185"

read -p 'Database source servers mysql user: ' SOURCE_SERVER_MYSQL_USER
[[ $SOURCE_SERVER_MYSQL_USER = "" ]] && SOURCE_SERVER_MYSQL_USER="sdeli"

read -p 'Database source servers mysql password: ' SOURCE_SERVER_MYSQL_PWD
[[ $SOURCE_SERVER_MYSQL_PWD = "" ]] && SOURCE_SERVER_MYSQL_PWD="dalias19"