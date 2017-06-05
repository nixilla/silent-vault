#!/usr/bin/env bash

VERSION="0.1"

if [ -e $HOME/.vault.config ]; then
    source $HOME/.vault.config;
else
    printf "\e[33mIt looks like the Silent Vault has not been initialized yet, please initialize it with -i\e[0m\n"
fi

declare -a options=("SV_MAIN_FOLDER" "SV_GPG_KEY_ID" "SV_BACKUP_FOLDERS")

usage="$(basename "$0") [-h] [-v] [-i] [-o] [-c] [-a]

where:
    -h    show this help text
    -a    about this script
    -v    verify existing configuration
    -i    initialize configuration
    -o    opens Vault (requires PGP key password)
    -c    closes Vault, locks and makes a backup (if backup is configured)"

function about {

cat << EOM

Silent Vault - Encrypted Backup Script (version $VERSION)
https://github.com/nixilla/silent-vault

Small bash script which automates creation and maintainance of the secure local folder,
where you can keep your sensitive information, like cryptocurrency wallets, secret files, etc.

It uses your GPG keys for encryption and signing and can be configured to use Dropbox
and/or other cloud storage provider for backups.

More information can be found at https://github.com/nixilla/silent-vault/blob/master/README.md
EOM
}

function verify {

    DONE=1

    echo "Verifying current configuration ..."

    if type gpg &> /dev/null; then
        printf "gpg available, \e[95m`gpg --version | head -1 | tail -1`\e[0m\n"
    else
        printf "\e[31mgpg not available\e[0m, please install GPG and generate (or import) a key, otherwise this software will not work\n"
        DONE=0
    fi

    SV_MAIN_FOLDER="$HOME/Vault"

    for i in "${options[@]}"
    do
        if [ ${!i} ]; then
	        printf "$i = \e[95m${!i}\e[0m\n"
        else
            DONE=0
            printf "$i \e[31mhas not been set\e[0m\n"
        fi
    done

    if [ $DONE == 0 ]; then
        printf "\nThe script is not configured, please initialize it with -i \n\n"
    fi
}

function init {
    echo "Initializing new configuration ..."
}

function open {
    echo "Opening the Vault ..."
}

function close {
    echo "Closing the Vault ..."
}

while getopts ':chivoa' option; do
  case "$option" in
    h) echo "$usage"
       exit
       ;;
    a) about
       exit
       ;;
    v) verify
       exit
       ;;
    i) init
       exit
       ;;
    o) open
       exit
       ;;
    c) close
       exit
       ;;
    \?) printf "Unrecognized option: -%s\n" "$OPTARG,  please use following options:"
       echo "$usage"
       exit 1
       ;;
  esac
done
shift $((OPTIND - 1))

