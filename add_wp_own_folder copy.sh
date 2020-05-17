# chmod 777 /usr/local/bin/add_wp_own_folder.sh
echo start
pwd
cd /var/www/html
pwd
ls -la
mv wp-content/ app
mkdir wp
chmod 755 wp
mv wp-activate.php wp-admin/ \
    wp-blog-header.php \
    wp-comments-post.php \
    wp-cron.php \
    wp-includes/ \
    wp-links-opml.php \
    wp-load.php \
    wp-login.php \
    wp-mail.php \
    wp-settings.php \
    wp-signup.php \
    wp-trackback.php \
    license.txt \
    readme.html \
    xmlrpc.php \
    wp/
mv /var/www/index.php index.php
mv /var/www/wp-config.php wp-config.php
