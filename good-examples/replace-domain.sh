#!/bin/bash
# it replaces these strings to 'http://localhost' in an sql file:
# 'oceancsempebolt.hu'
# https://oceancsempebolt.hu http://localhost
# http://oceancsempebolt.hu http://localhost
# http://www.oceancsempebolt.hu http://localhost
# https://www.oceancsempebolt.hu http://localhost

SQL_FILE_PATH=$1
BACKUP_SQL_FILE_PATH=$(echo $SQL_FILE_PATH | sed "s/.sql/-backup.sql/")
cat $1 > $BACKUP_SQL_FILE_PATH
echo "To replace urls to 'localhost' started, it will take some time!"

sed -i '' 's/https:\/\/oceancsempebolt.hu/http:\/\/localhost/g' $SQL_FILE_PATH
sed -i '' 's/https:\/\/oceancsempebolt.hu/http:\/\/localhost/g' $SQL_FILE_PATH
sed -i '' 's/http:\/\/oceancsempebolt.hu/http:\/\/localhost/g' $SQL_FILE_PATH
sed -i '' 's/http:\/\/www.oceancsempebolt.hu/http:\/\/localhost/g' $SQL_FILE_PATH
sed -i '' 's/https:\/\/www.oceancsempebolt.hu/http:\/\/localhost/g' $SQL_FILE_PATH
sed -i '' "s/'oceancsempebolt.hu'/'localhost'/g" $SQL_FILE_PATH

cat << EOF
if no bugs/errors were reported by script, and "${SQL_FILE_PATH}.sedback" got created, 
then check if the following exchanges have happened in: "$SQL_FILE_PATH"

https://oceancsempebolt.hu => http://localhost
http://oceancsempebolt.hu => http://localhost
http://www.oceancsempebolt.hu => http://localhost
https://www.oceancsempebolt.hu => http://localhost
EOF