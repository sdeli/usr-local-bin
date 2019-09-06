#!/usr/bin/env bash
createUser() {
    local userName=$1
    local password=$2
    local usersHomeDir="/home/${userName}"

    if [[ $UID != 0 ]]
    then
        echo "Please run this createUser script with superuser privilages" 1>&1
        exit 1
    fi

    local doesUserExist=$(cut -d : -f 1 /etc/passwd | grep "$userName" | wc -c)
    echo $userName $password $doesUserExist
    if [[ $doesUserExist -gt 0 ]]
    then
        echo "The user already exists so script terminates" 1>&1
        exit 1
    fi

    echo 'creating new user' 1>&1
    sudo adduser --quiet --disabled-password --shell /bin/bash --home "${usersHomeDir}" --gecos '*1' $userName

    echo 'changing password for new user' 1>&1
    echo "${userName}:${password}" | sudo chpasswd

    echo "entry into /etc/sudoers that sudo command for ${userName} that it doesnt need a password" 1>&1
    echo "${userName} ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers tee
}

createUser $1 $2
