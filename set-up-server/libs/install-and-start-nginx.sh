sudo apt install build-essential libpcre3-dev zlib1g-dev libssl-dev libatomic-ops-dev libxml2-dev libxslt1-dev libgeoip1 libgeoip-dev libgd-dev google-perftools libgoogle-perftools-dev libperl-dev -y

wget -c http://nginx.org/download/nginx-1.17.4.tar.gz
tar -xvzf nginx-1.17.4.tar.gz
sudo useradd -s /sbin/nologin nginx
cd nginx-1.17.4/
sudo ./configure --user=nginx --group=nginx --sbin-path=/usr/sbin/nginx --with-select_module --with-poll_module --with-threads --with-file-aio --with-http_ssl_module --with-http_v2_module --with-http_realip_module --with-http_addition_module --with-http_xslt_module --with-http_xslt_module=dynamic --with-http_image_filter_module --with-http_image_filter_module=dynamic --with-http_geoip_module --with-http_geoip_module=dynamic --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_mp4_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_auth_request_module --with-http_random_index_module --with-http_secure_link_module --with-http_degradation_module --with-http_slice_module --with-http_stub_status_module --with-http_perl_module --with-http_perl_module=dynamic --with-mail --with-mail=dynamic --with-mail_ssl_module --with-stream --with-stream=dynamic --with-stream_ssl_module --with-stream_realip_module --with-stream_geoip_module --with-stream_geoip_module=dynamic --with-stream_ssl_preread_module --with-google_perftools_module --with-cpp_test_module --with-compat --with-pcre --with-pcre-jit  --with-zlib-asm=CPU --with-libatomic --with-debug --with-ld-opt="-Wl,-E"
sudo make && sudo make install
sudo nano /lib/systemd/system/nginx.service

"
[Unit]
Description=The Nginx 1.15.8 service
After=syslog.target network.target remote-fs.target nss-lookup.target

[Service]
Type=forking
PIDFile=/usr/local/nginx/logs/nginx.pid
ExecStartPre=/usr/sbin/nginx -t
ExecStart=/usr/sbin/nginx
ExecReload=/usr/sbin/nginx -s reload
ExecStop=/bin/kill -s QUIT $MAINPID
PrivateTmp=true

[Install]
WantedBy=multi-user.target
"

 sudo service nginx start