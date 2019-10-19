#!/usr/bin/env bash
user www-data;

worker_processes auto;

events {
  worker_connections 1024;
}

http {

    include mime.types;

        server {

    #    activating ssl and http2 and listening on the standard 443 ports
        listen 80;
        server_name www.sandorsjavascript.live sandorsjavascript.live;

        location / {
            return 200 "kiraly";
        }

        location /zsir {
            return 200 "megzsirabb";
        }
    }
}