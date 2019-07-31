#!/usr/bin/env bash

configureNginx() {
    local nginxFolderOnAws=$1

    "${nginxFolderOnAws}./configure"
        --user=nginx \
        --group=nginx \
        --sbin-path=/usr/sbin/nginx \
        --conf-path=/etc/nginx/nginx.conf \
        --with-http_v2_module \
        --with-http_gzip_static_module \
        --with-http_auth_request_module \
        --with-http_random_index_module \
        --with-http_secure_link_module \
        --with-http_degradation_module \
        --with-http_slice_module \
        --with-http_stub_status_module \
        --with-http_perl_module \
        --with-http_perl_module=dynamic \
        --with-mail \
        --with-mail=dynamic \
        --with-mail_ssl_module \
        --with-stream \
        --with-stream=dynamic \
        --with-stream_ssl_module \
        --with-stream_realip_module \
        --with-stream_geoip_module \
        --with-stream_geoip_module=dynamic \
        --with-stream_ssl_preread_module \
        --with-google_perftools_module \
        --with-cpp_test_module \
        --with-compat \
        --with-pcre \
        --with-pcre-jit  \
        --with-zlib-asm=CPU \
        --with-libatomic \
        --with-debug \
        --with-ld-opt="-Wl,-E"
}

installAndStartNginx() {
    local userName=$1
    local nginxCurrentVersion=$2

    local usersHomeDir="/home/${userName}"
    local nginxFolderOnAws="${usersHomeDir}/nginx-${nginxCurrentVersion}"
    local nginxTarFileNameNewestVersion="nginx-1.15.8.tar.gz"
    local nginxNewestVersionDownloadUrl="http://nginx.org/download/${nginxTarFileNameNewestVersion}"

    if [[ $UID != 0 ]]
    then
        echo "Please run this createUser script with superuser privilages" 1>&1
        exit 1
    fi

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

    wget -c "http://nginx.org/download/${nginxTarFileNameNewestVersion}" -O "${usersHomeDir}/${nginxTarFileNameNewestVersion}"

    tar -xvzf "${usersHomeDir}/${nginxTarFileNameNewestVersion}"
    rm -rf "${usersHomeDir}/${nginxTarFileNameNewestVersion}"

    sudo useradd -s /sbin/nologin nginx

    configureNginx nginxFolderOnAws
    sudo make && sudo make install
    sudo nginx
    ps aux | grep nginx
}

installAndStartNginx $1 $2
