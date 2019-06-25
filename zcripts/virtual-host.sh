printf "\e[0;32mOpen all files in Visual Studio Code!\e[0m \n"

code /usr/local/etc/httpd/extra/httpd-vhosts.conf
sleep 1
code /etc/hosts

printf "\e[0;32mDon't forget: \e[0m sudo apachectl restart\n"

