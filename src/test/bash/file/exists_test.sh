#!/usr/local/bin/bash

SCRIPT="src/main/bash/file/exists.sh"

if [[ ! -e "${SCRIPT}" ]]; then
 echo "No file \"${SCRIPT}\"!" >&2; exit 1
elif [[ -L "${SCRIPT}" ]]; then
 echo "The \"${SCRIPT}\" is symlink!" >&2; exit 1
elif [[ ! -f "${SCRIPT}" ]]; then
 echo "Not a regular file \"${SCRIPT}\"!" >&2; exit 1
elif [[ ! -s "${SCRIPT}" ]]; then
 echo "File \"${SCRIPT}\" is empty!" >&2; exit 1
elif [[ ! -x "${SCRIPT}" ]]; then
 echo "File \"${SCRIPT}\" is not executable!" >&2; exit 1
fi

STDERR="$(mktemp)"

"${SCRIPT}" '' 2>"${STDERR}"; CODE=$?
if test "${CODE}" != '1'; then
 echo "Code(${CODE}) error!" >&2; exit 1; fi
ACTUAL_VALUE="$(<"${STDERR}")"
if test "${ACTUAL_VALUE}" != 'Wrong arguments!'; then
 echo "Actual value(${#ACTUAL_VALUE}) is: \"${ACTUAL_VALUE}\"!" >&2; exit 1; fi

:> "${STDERR}"

"${SCRIPT}" 2>"${STDERR}"; CODE=$?
if test "${CODE}" != '1'; then
 echo "Code(${CODE}) error!" >&2; exit 1; fi
ACTUAL_VALUE="$(<"${STDERR}")"
if test "${ACTUAL_VALUE}" != 'No issuer!'; then
 echo "Actual value(${#ACTUAL_VALUE}) is: \"${ACTUAL_VALUE}\"!" >&2; exit 1; fi

:> "${STDERR}"

TMP_PATH="$(mktemp)"
rm "${TMP_PATH}"
ISSUER="${TMP_PATH}" "${SCRIPT}" 2>"${STDERR}"; CODE=$?
if test "${CODE}" != '1'; then
 echo "Code(${CODE}) error!" >&2; exit 1; fi
ACTUAL_VALUE="$(<"${STDERR}")"
if test "${ACTUAL_VALUE}" != "No file \"${TMP_PATH}\"!"; then
 echo "Actual value(${#ACTUAL_VALUE}) is: \"${ACTUAL_VALUE}\"!" >&2; exit 1; fi

:> "${STDERR}"

TMP_PATH="$(mktemp -d)"
ISSUER="${TMP_PATH}" "${SCRIPT}" 2>"${STDERR}"; CODE=$?
if test "${CODE}" != '1'; then
 echo "Code(${CODE}) error!" >&2; exit 1; fi
ACTUAL_VALUE="$(<"${STDERR}")"
if test "${ACTUAL_VALUE}" != "Not a regular file \"${TMP_PATH}\"!"; then
 echo "Actual value(${#ACTUAL_VALUE}) is: \"${ACTUAL_VALUE}\"!" >&2; exit 1; fi
rm -rf "${TMP_PATH}"

:> "${STDERR}"

TMP_PATH="$(mktemp)"
rm "${TMP_PATH}"
ln -s "${TMP_PATH}" "${TMP_PATH}" && [[ -L "${TMP_PATH}" ]] || exit 1
ISSUER="${TMP_PATH}" "${SCRIPT}" 2>"${STDERR}"; CODE=$?
if test "${CODE}" != '1'; then
 echo "Code(${CODE}) error!" >&2; exit 1; fi
ACTUAL_VALUE="$(<"${STDERR}")"
if test "${ACTUAL_VALUE}" != "The \"${TMP_PATH}\" is symlink!"; then
 echo "Actual value(${#ACTUAL_VALUE}) is: \"${ACTUAL_VALUE}\"!" >&2; exit 1; fi
rm "${TMP_PATH}"

:> "${STDERR}"

TMP_PATH="$(mktemp)"
ISSUER="${TMP_PATH}" "${SCRIPT}" 2>"${STDERR}"; CODE=$?
if test "${CODE}" != '0'; then
 echo "Code(${CODE}) error!" >&2; exit 1; fi
ACTUAL_VALUE="$(<"${STDERR}")"
if test -n "${ACTUAL_VALUE}"; then
 echo "Actual value(${#ACTUAL_VALUE}) is: \"${ACTUAL_VALUE}\"!" >&2; exit 1; fi
rm "${TMP_PATH}"

rm "${STDERR}"
