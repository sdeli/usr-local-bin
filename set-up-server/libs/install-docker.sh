#!/usr/bin/env bash
echo "========================="
echo "INSTALLING DOCKER"
echo "========================="

installDocker() {

    echo 'updating apt-get repo' 1>&1
    sudo apt-get update

    echo 'installing certs for docker' 1>&1
    sudo apt-get install \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common -y

    echo 'added official gpg key' 1>&1
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

    sudo apt-key fingerprint 0EBFCD88

    echo 'set up the stable repository' 1>&1
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

    echo 'upgrading apt-get repo after beeing added docker repo' 1>&1
    sudo apt-get update

    echo 'installing docker' 1>&1
    sudo apt-get install docker-ce docker-ce-cli containerd.io -y

    echo 'running docker hello world' 1>&1
    sudo docker run hello-world

    echo 'installing docker compose' 1>&1
    sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

    echo 'set up port forwarding for ssl tunnel' 1>&1
#    docker run -d -v /var/run/docker.sock:/var/run/docker.sock -p 127.0.0.1:1234:1234 bobrik/socat TCP-LISTEN:1234,fork UNIX-CONNECT:/var/run/docker.sock
#    may need it sudo nano /etc/ssh/ssh_config => GatewayPorts yes
    sudo ncat -lknvp 2375 -c "ncat -U /var/run/docker.sock"
    ssh -L 8877:localhost:2375 sandor@18.223.143.155

    echo 'finished' 1>&1
    exit 0
}

installDocker
