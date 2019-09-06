#!/bin/bash
#
# This script is supposed to output the b64 decoded value of a given secret and field
# e.g. ./getKubeSecret.sh -s dbSecret -f username

usage() {
    cat <<EOF
usage: $0 options

This script run the test1 or test2 over a machine.

OPTIONS:
   -h      Show this message
   -s      Specify the kube secret
   -f      Specify the exact field to decode
EOF
}

SECRET_NAME=
FIELD_NAME=

while getopts "hs:f:" OPTION; do
    case $OPTION in
    h)
        usage
        exit 1
        ;;
    s)
        SECRET_NAME=$OPTARG
        ;;
    f)
        FIELD_NAME=$OPTARG
        ;;
    esac
done

if [[ -z $SECRET_NAME ]] || [[ -z $FIELD_NAME ]]; then
    echo empty
    usage
    exit 1
fi

kubectl get secret ${SECRET_NAME} -o yaml | grep "${FIELD_NAME}" | awk '{print $2}' | base64 --decode
