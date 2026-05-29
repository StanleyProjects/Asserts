#!/usr/local/bin/bash

if [[ $# -ne 1 ]]; then
 echo 'Wrong arguments!' >&2; exit 1; fi

ASSERTS_PATH="$1"

if [[ -z "${ASSERTS_PATH}" ]]; then
 echo 'No path!' >&2; exit 1
elif [[ -L "${ASSERTS_PATH}" ]]; then
 echo "The \"${ASSERTS_PATH}\" is a symlink!" >&2; exit 1
elif [[ ! -e "${ASSERTS_PATH}" ]]; then
 echo "No file \"${ASSERTS_PATH}\"!" >&2; exit 1
elif [[ ! -f "${ASSERTS_PATH}" ]]; then
 echo "The \"${ASSERTS_PATH}\" is not a regular file!" >&2; exit 1
elif [[ ! -s "${ASSERTS_PATH}" ]]; then
 echo "The \"${ASSERTS_PATH}\" is empty!" >&2; exit 1
elif [[ ! -x "${ASSERTS_PATH}" ]]; then
 echo "The \"${ASSERTS_PATH}\" is not executable!" >&2; exit 1
elif ! /usr/local/bin/bash -n "${ASSERTS_PATH}" 2>/dev/null; then
 echo "Syntax validation of the \"${ASSERTS_PATH}\" failed!" >&2; exit 1
fi
