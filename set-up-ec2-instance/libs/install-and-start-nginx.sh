#!/usr/bin/env bash

# nginx path prefix: "/usr/local/nginx"
# nginx binary file: "/usr/local/nginx/sbin/nginx"
# nginx modules path: "/usr/local/nginx/modules"
# nginx configuration prefix: "/usr/local/nginx/conf"
# nginx configuration file: "/usr/local/nginx/conf/nginx.conf"
# nginx pid file: "/usr/local/nginx/logs/nginx.pid"
# nginx error log file: "/usr/local/nginx/logs/error.log"
# nginx http access log file: "/usr/local/nginx/logs/access.log"
# nginx http client request body temporary files: "client_body_temp"
# nginx http proxy temporary files: "proxy_temp"
# nginx http fastcgi temporary files: "fastcgi_temp"
# nginx http uwsgi temporary files: "uwsgi_temp"
# nginx http scgi temporary files: "scgi_temp"

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

    cd "${nginxFolderOnAws}"
    ./configure
        --sbin-path=/usr/sbin/nginx \
        --conf-path=/etc/nginx/nginx.conf \
        --with-http_v2_module \
        --with-http_gzip_static_module \
        --with-pcre \
        --with-http_ssl_module
}

createAndStartNginxSystemdService() {
    local nginxSystemdServiceFilePathOnServer=$1

    mv "${nginxSystemdServiceFilePathOnServer}" /lib/systemd/system/
    systemctl daemon-reload
    systemctl start nginx
}

installAndStartNginx() {
    local userName=$1
    local nginxCurrentVersion=$2
    local nginxSystemdServiceFilePathOnServer=$3

    local usersHomeDir="/home/${userName}"
    local nginxFolderOnAws="${usersHomeDir}/nginx-${nginxCurrentVersion}"
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

    mv "${nginxSystemdServiceFilePathOnServer}" /lib/systemd/system/
    systemctl daemon-reload
    systemctl enable nginx
    systemctl start nginx
    systemctl status nginx
}

#installAndStartNginx $1 $2
installAndStartNginx $1 $2 $3
