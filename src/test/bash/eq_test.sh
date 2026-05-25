#!/usr/local/bin/bash

SCRIPT="src/main/bash/eq.sh"

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

"${SCRIPT}" 2>"${STDERR}"; CODE=$?
if test "${CODE}" != '1'; then
 echo "Code(${CODE}) error!" >&2; exit 1; fi
ACTUAL_VALUE="$(<"${STDERR}")"
if test "${ACTUAL_VALUE}" != 'Wrong arguments!'; then
 echo "Actual value(${#ACTUAL_VALUE}) is: \"${ACTUAL_VALUE}\"!" >&2; exit 1; fi

:> "${STDERR}"

"${SCRIPT}" '' 2>"${STDERR}"; CODE=$?
if test "${CODE}" != '1'; then
 echo "Code(${CODE}) error!" >&2; exit 1; fi
ACTUAL_VALUE="$(<"${STDERR}")"
if test "${ACTUAL_VALUE}" != 'Wrong arguments!'; then
 echo "Actual value(${#ACTUAL_VALUE}) is: \"${ACTUAL_VALUE}\"!" >&2; exit 1; fi

:> "${STDERR}"

"${SCRIPT}" '' '' '' 2>"${STDERR}"; CODE=$?
if test "${CODE}" != '1'; then
 echo "Code(${CODE}) error!" >&2; exit 1; fi
ACTUAL_VALUE="$(<"${STDERR}")"
if test "${ACTUAL_VALUE}" != 'Wrong arguments!'; then
 echo "Actual value(${#ACTUAL_VALUE}) is: \"${ACTUAL_VALUE}\"!" >&2; exit 1; fi

:> "${STDERR}"

ACTUAL_VALUE="$(${SCRIPT} '' '' 2>&1)"; CODE=$?
if test "${CODE}" != '1'; then
 echo "Code(${CODE}) error!" >&2; exit 1
elif test "${ACTUAL_VALUE}" != 'No issuer!'; then
 echo "Actual value(${#ACTUAL_VALUE}) is: \"${ACTUAL_VALUE}\"!" >&2; exit 1
fi

ACTUAL_VALUE="$(ISSUER='foo' ${SCRIPT} 'a' 'b' 2>&1)"; CODE=$?
EXPECTED_VALUE='Issuer "foo" error!
Actual(1): "a"
Expected(1): "b"'
if test "${CODE}" != '1'; then
 echo "Code(${CODE}) error!" >&2; exit 1
elif test "${ACTUAL_VALUE}" != "${EXPECTED_VALUE}"; then
 echo "Actual value(${#ACTUAL_VALUE}) is: \"${ACTUAL_VALUE}\"!" >&2; exit 1
fi

ACTUAL_VALUE="$(ISSUER='foo' ${SCRIPT} 'value' 'value' 2>&1)"; CODE=$?
if test "${CODE}" != '0'; then
 echo "Code(${CODE}) error!" >&2; exit 1
elif test "${ACTUAL_VALUE}" != ''; then
 echo "Actual value(${#ACTUAL_VALUE}) is: \"${ACTUAL_VALUE}\"!" >&2; exit 1
fi

ACTUAL_VALUE="$(ISSUER='foo' ${SCRIPT} '' '' 2>&1)"; CODE=$?
if test "${CODE}" != '0'; then
 echo "Code(${CODE}) error!" >&2; exit 1
elif test "${ACTUAL_VALUE}" != ''; then
 echo "Actual value(${#ACTUAL_VALUE}) is: \"${ACTUAL_VALUE}\"!" >&2; exit 1
fi

rm "${STDERR}"
