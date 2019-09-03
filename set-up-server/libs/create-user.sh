#!/usr/bin/env bash

createUser() {
    local userName=$1

    local usersHomeDir="/home/${userName}"

    if [[ $UID != 0 ]]
    then
        echo "Please run this createUser script with superuser privilages" 1>&1
        exit 1
    fi

    local doesUserExist=$(cut -d : -f 1 /etc/passwd | grep 'sandor' | wc -c)
    if [ $doesUserExist -gt 1 ]
    then
        echo "The user already exists so script terminates" 1>&1
        exit 0
    fi

    echo 'creating new user' 1>&1
    adduser --quiet --disabled-password --shell /bin/bash --home "${usersHomeDir}" --gecos '*1' sandor

    echo 'changing password for new user' 1>&1
    echo "sandor:Bgfkszm1234" | chpasswd

    echo 'adding new user to sudoers group' 1>&1
    usermod -aG sudo sandor
}

createUser $1
