#!/usr/bin/env bash
scp \
-i /home/sandor/Documents/aws-ssh-key.pem \
/usr/local/bin/set-up-ec2-instance/libs/all_databases4.sql \
sandor@52.14.240.7:\
/home/sandor/db/all_databases7.sql
