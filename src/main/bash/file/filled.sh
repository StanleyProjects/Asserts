#!/usr/local/bin/bash

if [[ $# -ne 1 ]]; then
 echo 'Wrong arguments!' >&2; exit 1; fi

TESTED_PATH="$1"

if [[ -z "${TESTED_PATH}" ]]; then
 echo 'No tested path!' >&2; exit 1
elif [[ -L "${TESTED_PATH}" ]]; then
 echo "The \"${TESTED_PATH}\" is symlink!" >&2; exit 1
elif [[ ! -e "${TESTED_PATH}" ]]; then
 echo "No file \"${TESTED_PATH}\"!" >&2; exit 1
elif [[ ! -f "${TESTED_PATH}" ]]; then
 echo "Not a regular file \"${TESTED_PATH}\"!" >&2; exit 1
elif [[ ! -s "${TESTED_PATH}" ]]; then
 echo "File \"${TESTED_PATH}\" is empty!" >&2; exit 1
fi
