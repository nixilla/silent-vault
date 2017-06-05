#!/usr/bin/env bash

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

Silent Vault - Encrypted Backup Script
https://github.com/nixilla/silent-vault

Small bash script which automates creation and maintainance of the secure local folder,
where you can keep your sensitive information, like cryptocurrency wallets, secret files, etc.

It uses your GPG keys for encryption and signing and can be configured to use Dropbox
and/or other cloud storage provider for backups.

More information can be found at https://github.com/nixilla/silent-vault/README.md
EOM
}

function verify {
    echo "Verifying current configuration ..."
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

