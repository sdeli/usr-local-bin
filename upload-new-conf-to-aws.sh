#!/usr/bin/env bash
# Download file: scp your_username@remotehost.edu:foobar.txt /local/dir
scp -i  /home/sandor/Documents/aws-ssh-key.pem /usr/local/bin/set-up-ec2-instance/libs/nginx.conf.sh sandor@52.14.240.7:/home/sandor/nginx.conf.sh
ssh -t -i /home/sandor/Documents/aws-ssh-key.pem sandor@52.14.240.7 "sudo mv /home/sandor/nginx.conf.sh /etc/nginx;
sudo nginx -s stop;
sudo nginx -t -c /etc/nginx/nginx.conf.sh;
sudo nginx -c /etc/nginx/nginx.conf.sh;
"