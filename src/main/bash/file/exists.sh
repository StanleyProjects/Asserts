#!/usr/local/bin/bash

if [[ $# -ne 1 ]]; then
 echo 'Wrong arguments!' >&2; exit 1; fi

ASSERT_PATH="$1"

if [[ -z "${ASSERT_PATH}" ]]; then
 echo 'No assert path!' >&2; exit 1
elif [[ -L "${ASSERT_PATH}" ]]; then
 echo "The \"${ASSERT_PATH}\" is symlink!" >&2; exit 1
elif [[ ! -e "${ASSERT_PATH}" ]]; then
 echo "No file \"${ASSERT_PATH}\"!" >&2; exit 1
elif [[ ! -f "${ASSERT_PATH}" ]]; then
 echo "Not a regular file \"${ASSERT_PATH}\"!" >&2; exit 1
fi
