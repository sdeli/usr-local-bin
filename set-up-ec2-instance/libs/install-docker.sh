#!/usr/bin/env bash

installDocker() {
    if [[ $UID != 0 ]]
    then
        echo "Please run this installDocker script with superuser privilages" 1>&1
        exit 1
    fi
    echo 'run'
    echo 'updating apt-get repo' 1>&1
    sudo apt-get update

    echo 'installing certs for docker' 1>&1
    sudo apt-get install \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common

    echo 'added official gpg key' 1>&1
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

    sudo apt-key fingerprint 0EBFCD88

    echo 'set up the stable repository' 1>&1
    sudo add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       stable"

    echo 'upgrading apt-get repo after beeing added docker repo' 1>&1
    sudo apt-get update

    echo 'installing docker' 1>&1
    sudo apt-get install docker-ce docker-ce-cli containerd.io

    echo 'running docker hello world' 1>&1
    sudo docker run hello-world

    echo 'finished' 1>&1
    exit 0
}

installDocker