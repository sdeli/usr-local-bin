#!/usr/bin/env bash

installNginxDependencies() {
    sudo apt install \
        build-essential \
        libpcre3-dev \
        zlib1g-dev \
        libssl-dev \
        libatomic-ops-dev \
        libxml2-dev \
        libxslt1-dev \
        libgeoip1 \
        libgeoip-dev \
        libgd-dev \
        google-perftools \
        libgoogle-perftools-dev \
        libperl-dev
}

configureNginx() {
    local nginxFolderOnAws=$1

    "${nginxFolderOnAws}/configure"
        --sbin-path=/usr/sbin/nginx \
        --conf-path=/etc/nginx/nginx.conf \
        --with-http_v2_module \
        --with-http_gzip_static_module \
        --with-pcre
}

installAndStartNginx() {
    local userName=$1
    local nginxCurrentVersion=$2

    local usersHomeDir="/home/${userName}"
    local nginxFolderOnAws="/${usersHomeDir}/nginx-${nginxCurrentVersion}"
    local nginxTarFileNameNewestVersion="nginx-${nginxCurrentVersion}.tar.gz"
    local nginxNewestVersionDownloadUrl="http://nginx.org/download/${nginxTarFileNameNewestVersion}"

    echo $usersHomeDir
    echo $nginxFolderOnAws
    echo $nginxTarFileNameNewestVersion
    echo $nginxNewestVersionDownloadUrl

    if [[ $UID != 0 ]]
    then
        echo "Please run this createUser script with superuser privilages" 1>&1
        exit 1
    fi

    installNginxDependencies

    wget -c "http://nginx.org/download/${nginxTarFileNameNewestVersion}" -O "${usersHomeDir}/${nginxTarFileNameNewestVersion}"
    tar -xvzf "${usersHomeDir}/${nginxTarFileNameNewestVersion}" -C "${usersHomeDir}"
    rm -rf "${usersHomeDir}/${nginxTarFileNameNewestVersion}"
#
    sudo useradd -s /sbin/nologin nginx

    configureNginx $nginxFolderOnAws

    cd "${nginxFolderOnAws}"
    sudo make && sudo make install

    sudo nginx
    ps aux | grep nginx
}

#installAndStartNginx $1 $2
installAndStartNginx "sandor" "1.15.8"
