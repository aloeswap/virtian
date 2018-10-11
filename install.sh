#!/bin/bash

VM_SCRIPT_VERSION=0.01

apt-get update
apt-get -y upgrade
apt-get -y install mc ssh git net-tools nginx php-fpm php-imagick php-gd vnstat xfsprogs php-libvirt-php
alias ls="ls --color=always"
rm -rf /var/www/html
openssl req -x509 -newkey rsa:2048 -nodes -days $(expr '(' $(date -d 2999/01/01 +%s) - $(date +%s) + 86399 ')' / 86400) -subj "/" -keyout /etc/nginx/nginx.key -out /etc/nginx/nginx.crt
sed -i -e 's/display_errors = Off/display_errors = On/g' /etc/php/7.0/fpm/php.ini
sed -i -e 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
sed -i -e 's/#vnc_listen = "0.0.0.0"/vnc_listen = "0.0.0.0"/g' /etc/libvirt/qemu.conf
sed -i -e 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet/GRUB_CMDLINE_LINUX_DEFAULT="quiet consoleblank=0/g' /etc/default/grub
update-grub
echo -ne '' > /etc/motd
rm /etc/update-motd.d/10-uname
cd /usr/src/
git clone https://github.com/softsun-cz/vm-webui.git
mv vm-webui/src/* /var/www/
rm -rf vm-webui

cat << EOF > /etc/nginx/sites-enabled/default
server {
        listen 80 default_server;
        listen [::]:80 default_server;
        server_name _;
        return 301 https://\$host\$request_uri;
}

server {
        listen 443 ssl http2 default_server;
        listen [::]:443 ssl http2 default_server;
        server_name _;
        ssl_certificate /etc/nginx/nginx.crt;
        ssl_certificate_key /etc/nginx/nginx.key;
        root /var/www;
        index index.html index.htm index.php;
        location / {
                try_files \$uri \$uri/ =404;
        }
        location ~ \.php\$ {
                include snippets/fastcgi-php.conf;
                fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
        }
}
EOF

cat << EOF > /etc/issue
 [1;34m _   _  _        _    [1;33m_               
 [1;34m| | | |(_)      | |  [1;33m(_)              
 [1;34m| | | | _  _ __ | |_  [1;33m_   __ _  _ __  
 [1;34m| | | || || '__|| __|[1;33m| | / _\` || '_ \\\\ 
 [1;34m\\\\ \\\\_/ /| || |   | |_ [1;33m| || (_| || | | |
 [1;34m \\\\___/ |_||_|    \\\\__|[1;33m|_| \\\\__,_||_| |_|

 [1;39m       OS: [0m\v
 [1;39m   Kernel: [0m\s \r \m
 [1;39m     Date: [0m\d \t
 [1;39m Hostname: [0m\n
 [1;39m  Console: [0m\l

EOF
reboot
