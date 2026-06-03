#!/usr/local/bin/bash

if [[ $# -ne 3 ]]; then
 echo 'Wrong arguments!' >&2; exit 1; fi

ASSERTS_PATH="$1"

if [[ -z "${ASSERTS_PATH}" ]]; then
 echo 'No path!' >&2; exit 1
elif [[ -L "${ASSERTS_PATH}" ]]; then
 echo "\"${ASSERTS_PATH}\" is a symlink!" >&2; exit 1
elif [[ ! -e "${ASSERTS_PATH}" ]]; then
 echo "\"${ASSERTS_PATH}\" does not exist!" >&2; exit 1
elif [[ ! -f "${ASSERTS_PATH}" ]]; then
 echo "\"${ASSERTS_PATH}\" is not a file!" >&2; exit 1
elif [[ ! -s "${ASSERTS_PATH}" ]]; then
 echo "\"${ASSERTS_PATH}\" is empty!" >&2; exit 1
fi

ASSERTS_TEXT="$2"
ASSERTS_SUBTEXT="$3"

if [[ -z "${ASSERTS_SUBTEXT}" ]]; then
 echo 'No subtext!' >&2; exit 1; fi

echo 'Not implemented!'>&2; exit 1 # todo
