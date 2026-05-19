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

ACTUAL_VALUE="$(${SCRIPT} '' 2>&1)"; CODE=$?
if test "${CODE}" != '1'; then
 echo "Code(${CODE}) error!" >&2; exit 1
elif test "${ACTUAL_VALUE}" != 'Wrong arguments!'; then
 echo "Actual value(${#ACTUAL_VALUE}) is: \"${ACTUAL_VALUE}\"!" >&2; exit 1
fi

ACTUAL_VALUE="$(${SCRIPT} 2>&1)"; CODE=$?
if test "${CODE}" != '1'; then
 echo "Code(${CODE}) error!" >&2; exit 1
elif test "${ACTUAL_VALUE}" != 'No issuer!'; then
 echo "Actual value(${#ACTUAL_VALUE}) is: \"${ACTUAL_VALUE}\"!" >&2; exit 1
fi

POINTER="$(date +%s)"
rm -rf "/tmp/${POINTER}"

ACTUAL_VALUE="$(ISSUER="/tmp/${POINTER}" ${SCRIPT} 2>&1)"; CODE=$?
if test "${CODE}" != '1'; then
 echo "Code(${CODE}) error!" >&2; exit 1
elif test "${ACTUAL_VALUE}" != "No file \"/tmp/${POINTER}\"!"; then
 echo "Actual value(${#ACTUAL_VALUE}) is: \"${ACTUAL_VALUE}\"!" >&2; exit 1
fi

mkdir "/tmp/${POINTER}"
ACTUAL_VALUE="$(ISSUER="/tmp/${POINTER}" ${SCRIPT} 2>&1)"; CODE=$?
if test "${CODE}" != '1'; then
 echo "Code(${CODE}) error!" >&2; exit 1
elif test "${ACTUAL_VALUE}" != "Not a regular file \"/tmp/${POINTER}\"!"; then
 echo "Actual value(${#ACTUAL_VALUE}) is: \"${ACTUAL_VALUE}\"!" >&2; exit 1
fi
rm -rf "/tmp/${POINTER}"

touch "/tmp/${POINTER}"
ln -s "/tmp/${POINTER}" "/tmp/${POINTER}.link"
ACTUAL_VALUE="$(ISSUER="/tmp/${POINTER}.link" ${SCRIPT} 2>&1)"; CODE=$?
if test "${CODE}" != '1'; then
 echo "Code(${CODE}) error!" >&2; exit 1
elif test "${ACTUAL_VALUE}" != "The \"/tmp/${POINTER}.link\" is symlink!"; then
 echo "Actual value(${#ACTUAL_VALUE}) is: \"${ACTUAL_VALUE}\"!" >&2; exit 1
fi
rm "/tmp/${POINTER}.link"

ACTUAL_VALUE="$(ISSUER="/tmp/${POINTER}" ${SCRIPT} 2>&1)"; CODE=$?
if test "${CODE}" != '0'; then
 echo "Code(${CODE}) error!" >&2; exit 1
elif test "${ACTUAL_VALUE}" != ''; then
 echo "Actual value(${#ACTUAL_VALUE}) is: \"${ACTUAL_VALUE}\"!" >&2; exit 1
fi
rm "/tmp/${POINTER}"
