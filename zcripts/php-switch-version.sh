# For more php here : https://php-osx.liip.ch/

PS3='Which PHP version do you want ? '
options=("PHP-5.6" "php-7.2" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "PHP-5.6")
            printf "\e[0;32mYou chose PHP-5.6... \e[0m \n\n"
            sudo rm /usr/local/php5
            sudo ln -s /usr/local/php5-5.6.33-20180201-140154 /usr/local/php5
            printf "\e[0;32mRestarting the webserver...\e[0m \n\n"
            sudo apachectl restart
            break
            ;;

        "php-7.2")
            printf "\e[0;32mYou chose php-7.2... \e[0m \n\n"
            sudo rm /usr/local/php5
            sudo ln -s /usr/local/php5-7.2.0RC2-20171002-085104 /usr/local/php5
            printf "\e[0;32mRestarting the webserver...\e[0m \n\n"
            sudo apachectl restart
            break
            ;;

        "Quit")
            printf "\e[0;32mNo changes, bye bye! \e[0m \n\n"
            break
            ;;
        *) echo invalid option;;
    esac
done
