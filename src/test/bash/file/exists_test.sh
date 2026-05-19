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

TMP_DIR="$(mktemp -d)" || exit 1

ACTUAL_VALUE="$(ISSUER="${TMP_DIR}/foo" ${SCRIPT} 2>&1)"; CODE=$?
if test "${CODE}" != '1'; then
 echo "Code(${CODE}) error!" >&2; exit 1
elif test "${ACTUAL_VALUE}" != "No file \"${TMP_DIR}/foo\"!"; then
 echo "Actual value(${#ACTUAL_VALUE}) is: \"${ACTUAL_VALUE}\"!" >&2; exit 1
fi

ACTUAL_VALUE="$(ISSUER="${TMP_DIR}" ${SCRIPT} 2>&1)"; CODE=$?
if test "${CODE}" != '1'; then
 echo "Code(${CODE}) error!" >&2; exit 1
elif test "${ACTUAL_VALUE}" != "Not a regular file \"${TMP_DIR}\"!"; then
 echo "Actual value(${#ACTUAL_VALUE}) is: \"${ACTUAL_VALUE}\"!" >&2; exit 1
fi

ln -s "${TMP_DIR}/foo" "${TMP_DIR}/link"
ACTUAL_VALUE="$(ISSUER="${TMP_DIR}/link" ${SCRIPT} 2>&1)"; CODE=$?
if test "${CODE}" != '1'; then
 echo "Code(${CODE}) error!" >&2; exit 1
elif test "${ACTUAL_VALUE}" != "The \"${TMP_DIR}/link\" is symlink!"; then
 echo "Actual value(${#ACTUAL_VALUE}) is: \"${ACTUAL_VALUE}\"!" >&2; exit 1
fi

touch "${TMP_DIR}/foo"
ACTUAL_VALUE="$(ISSUER="${TMP_DIR}/link" ${SCRIPT} 2>&1)"; CODE=$?
if test "${CODE}" != '1'; then
 echo "Code(${CODE}) error!" >&2; exit 1
elif test "${ACTUAL_VALUE}" != "The \"${TMP_DIR}/link\" is symlink!"; then
 echo "Actual value(${#ACTUAL_VALUE}) is: \"${ACTUAL_VALUE}\"!" >&2; exit 1
fi

ACTUAL_VALUE="$(ISSUER="${TMP_DIR}/foo" ${SCRIPT} 2>&1)"; CODE=$?
if test "${CODE}" != '0'; then
 echo "Code(${CODE}) error!" >&2; exit 1
elif test "${ACTUAL_VALUE}" != ''; then
 echo "Actual value(${#ACTUAL_VALUE}) is: \"${ACTUAL_VALUE}\"!" >&2; exit 1
fi

rm -rf "${TMP_DIR}"
