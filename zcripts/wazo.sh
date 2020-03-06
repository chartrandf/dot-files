# --------------------------------------------------
# -- CONSTANTS--------------------------------------
# --------------------------------------------------
action=$1
ip=$2
service_name=`basename "$PWD"`


# --------------------------------------------------
# -- HELPERS ---------------------------------------
# --------------------------------------------------
RESTORE='\033[0m'

RED='\033[00;31m'
GREEN='\033[00;32m'
YELLOW='\033[00;33m'
BLUE='\033[00;34m'
PURPLE='\033[00;35m'
CYAN='\033[00;36m'
LIGHTGRAY='\033[00;37m'

LRED='\033[01;31m'
LYELLOW='\033[01;32m'
LYELLOW='\033[01;33m'
LBLUE='\033[01;34m'
LPURPLE='\033[01;35m'
LCYAN='\033[01;36m'
WHITE='\033[01;37m'

function throwError() {
    echo "${RED}[ERROR] $1"
    exit;
}

# --------------------------------------------------
# -- VALIDATIONS -----------------------------------
# --------------------------------------------------

# Action is required
if [[ -n "$action" ]]; then
    continue
else
    throwError "First argument is required : action (init | push | remove)"
fi

# IP is required
if [[ -n "$ip" ]]; then
    continue
else
    throwError "Second argument is required : ip (192.168.X.X)"
    exit;
fi

# Wazo / Xivo service name
if [[ $service_name =~ ^(xivo-|wazo-) ]]; then
    continue
else
    throwError "Current folder do not seems to be a Wazo service."
    exit;
fi

# --------------------------------------------------
# -- LOGIC------------------------------------------
# --------------------------------------------------
echo "${GREEN}Action  : ${RESTORE}$action"
echo "${GREEN}IP Addr : ${RESTORE}$ip"
echo "${GREEN}Service : ${RESTORE}$service_name"
echo ""

case $action in
    # Init will configure the VM to allow rsyncing
    "init")
        echo "${GREEN}Initializing..."

        echo "${LYELLOW}- Copy SSH Key${LIGHTGRAY}"
        ssh-copy-id root@$ip

        echo "${LYELLOW}- Installing rsync${LIGHTGRAY}"
        ssh root@$ip 'apt install rsync'

        echo "${LYELLOW}- Create mount folder${LIGHTGRAY}"
        ssh root@$ip 'mkdir -p /usr/src/wazo'

        echo "\n${GREEN}[SUCCESS] $ip is now ready!"
        break
        ;;

    # Will push and mount the code on the VM
    "push"|"mount")
        echo "${GREEN}Pushing & Mounting code..."

        echo "${LYELLOW}- RSYNC local folder${LIGHTGRAY}"
        rsync -av root@$ip:/usr/src/wazo

        echo "${LYELLOW}- Mounting code${LIGHTGRAY}"
        ssh root@$ip "cd /usr/src/wazo/$service_name/ && python3 setup.py develop"

        echo "${LYELLOW}- Restarting service${LIGHTGRAY}"
        ssh root@$ip "systemctl restart $service_name"

        echo "\n${GREEN}[SUCCESS] Code have been pushed!"
        break
        ;;

    # Will unmount the code on the VM
    "remove"|"unmount")
        echo "${GREEN}Unmounting code..."

        echo "${LYELLOW}- Unmounting code${LIGHTGRAY}"
        ssh root@$ip "cd /usr/src/wazo/$service_name/ && python3 setup.py develop --uninstall"

        echo "${LYELLOW}- Restarting service${LIGHTGRAY}"
        ssh root@$ip "systemctl restart $service_name"

        echo "\n${GREEN}[SUCCESS] Code have been unmounted!"
        break
        ;;
    *)
        throwError "Invalid action, accepted values are : init, (push|mount) or (remove|unmount)"
        ;;
esac