#!/usr/local/bin/bash

if test $# -ne 0; then
 echo 'Wrong arguments!' >&2; exit 1; fi

if test -z "${ISSUER}"; then
 echo 'No issuer!' >&2; exit 1; fi

if [[ ! -e "${ISSUER}" ]]; then
 echo "No file \"${ISSUER}\"!" >&2; exit 1
elif [[ -L "${ISSUER}" ]]; then
 echo "The \"${ISSUER}\" is symlink!" >&2; exit 1
elif [[ ! -f "${ISSUER}" ]]; then
 echo "Not a regular file \"${ISSUER}\"!" >&2; exit 1
elif [[ ! -s "${ISSUER}" ]]; then
 echo "File \"${ISSUER}\" is empty!" >&2; exit 1
fi
