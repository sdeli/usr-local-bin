#!/usr/bin/env bash
mysql -u USER -p
mysqldump --all-databases > all_databases.sql -u USER -p
mysqldump --databases database_one database_two > two_databases.sql -u USER -p
mysqldump -u User -pPASSWORD --all-databases > all_databases.sql

# create all databases db backup
mysqldump -u sdeli -pdalias19 --databases $(mysql -usdeli -pdalias19 -e 'show databases' | grep -v 'Database\|information_schema\|performance_schema\|sys\|mysql' | tr -s '\n' ' ') > /home/sandor/all-filtered-databases.sql

mysql -u root < tutorials_query1.sql

scp sandor@104.248.161.185:/home/sandor/blog_databases.sql /home/sandor/Downloads/
scp -i /home/sandor/Documents/aws-ssh-key.pem /home/sandor/empire-compose.yml sandor@52.14.240.7:/home/sandor/empire-compose.yml
scp -i /home/sandor/Documents/aws-ssh-key.pem /home/sandor/empire-compose.yml sandor@52.14.240.7:/home/sandor/empire-compose.yml

ssh -t sandor@104.248.161.185 "mysqldump --databases hotel_data_db > hotel_data_db.sql -u sandor -p dalias19"

ps -e| grep node

ln -s /home/sandor/projects/austria-recruitment/austria-recruitment.yml /usr/local/bin/set-up-ec2-instance/assets
#5.7.27-0
docker exec -it sandor_db_1 bash
sudo docker exec -i sandor_db_1 sh -c 'exec export MYSQL_PASSWORD=dalias19; exec mysql -uroot -p"$MYSQL_PASSWORD" < /src/all_databases.sql'
docker exec -it sandor_db_1 "bash mysql -u sandor -p < /src/all_databases7.sql"
mysql -uroot --password=passwordhere -h localhost
sudo docker exec -it sandor_db_1 sh -c 'exec mysql -uroot -pmajom2 -e "source /src/all_databases7.sql"'
sudo docker exec -it sandor_db_1 sh -c 'exec mysql -uroot -pmajom2 -e "show databases"'

# monitor disk usage
df -h --total

# find out where a command lives
which git

sudo find / -regex '.*linuxbrew.*' -exec rm -rf {} \;
