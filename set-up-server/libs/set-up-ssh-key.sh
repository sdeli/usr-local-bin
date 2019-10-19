#!/usr/bin/env bash
echo "========================="
echo "SETTING UP SSH KEY"
echo "========================="

# ==== DEPENDENCIES ====
readonly USERNAME=$1
readonly PUBLIC_KEY_FILE_PATH=$2
# ==== DEPENDENCIES END ====

setUpSshKey() {
    userName=$1
    publicKeyFilePath=$2

    if [[ $UID != 0 ]]
    then
        echo "Please run this setUpSshKey script with superuser privilages" 1>&1
        exit 1
    fi

    local usersHomeDir="/home/${userName}"
    cd "${usersHomeDir}"

    if test -e ".ssh/authorized_keys";
    then
        echo ".ssh/authorized_keys file exist so ssh key creation terminates"
        exit 0
    fi

    echo "creating .ssh folder in: ${usersHomeDir}" 1>&1
    mkdir .ssh
    chmod 700 .ssh
    chown "${userName}" .ssh

    echo 'copying public key into .ssh folder'
    touch .ssh/authorized_keys
    chmod 600 .ssh/authorized_keys
    chown "${userName}" .ssh/authorized_keys
    cat "${publicKeyFilePath}" > .ssh/authorized_keys

    echo 'deleting original public key file'
    rm "${publicKeyFilePath}"
}

setUpSshKey \
$USERNAME \
$PUBLIC_KEY_FILE_PATH