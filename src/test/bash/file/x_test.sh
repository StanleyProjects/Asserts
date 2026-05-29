#!/usr/local/bin/bash

SCRIPT="src/main/bash/file/x.sh"

echo "Running test of \"${SCRIPT}\"..."

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
if [[ "${CODE}" != '1' ]]; then
 echo "Code(${CODE}) error!" >&2; exit 1; fi
ACTUAL_VALUE="$(<"${STDERR}")"
if [[ "${ACTUAL_VALUE}" != 'Wrong arguments!' ]]; then
 echo "Actual value(${#ACTUAL_VALUE}) is: \"${ACTUAL_VALUE}\"!" >&2; exit 1; fi

:> "${STDERR}"

"${SCRIPT}" '' 2>"${STDERR}"; CODE=$?
if [[ "${CODE}" != '1' ]]; then
 echo "Code(${CODE}) error!" >&2; exit 1; fi
ACTUAL_VALUE="$(<"${STDERR}")"
if [[ "${ACTUAL_VALUE}" != 'No path!' ]]; then
 echo "Actual value(${#ACTUAL_VALUE}) is: \"${ACTUAL_VALUE}\"!" >&2; exit 1; fi

:> "${STDERR}"

TMP_PATH="$(mktemp)"
rm "${TMP_PATH}"
"${SCRIPT}" "${TMP_PATH}" 2>"${STDERR}"; CODE=$?
if [[ "${CODE}" != '1' ]]; then
 echo "Code(${CODE}) error!" >&2; exit 1; fi
ACTUAL_VALUE="$(<"${STDERR}")"
if [[ "${ACTUAL_VALUE}" != "No file \"${TMP_PATH}\"!" ]]; then
 echo "Actual value(${#ACTUAL_VALUE}) is: \"${ACTUAL_VALUE}\"!" >&2; exit 1; fi

:> "${STDERR}"

TMP_PATH="$(mktemp -d)"
"${SCRIPT}" "${TMP_PATH}" 2>"${STDERR}"; CODE=$?
if [[ "${CODE}" != '1' ]]; then
 echo "Code(${CODE}) error!" >&2; exit 1; fi
ACTUAL_VALUE="$(<"${STDERR}")"
if [[ "${ACTUAL_VALUE}" != "\"${TMP_PATH}\" is not a regular file!" ]]; then
 echo "Actual value(${#ACTUAL_VALUE}) is: \"${ACTUAL_VALUE}\"!" >&2; exit 1; fi
rm -rf "${TMP_PATH}"

:> "${STDERR}"

TMP_PATH="$(mktemp)"
rm "${TMP_PATH}"
ln -s "${TMP_PATH}" "${TMP_PATH}" && [[ -L "${TMP_PATH}" ]] || exit 1
"${SCRIPT}" "${TMP_PATH}" 2>"${STDERR}"; CODE=$?
if [[ "${CODE}" != '1' ]]; then
 echo "Code(${CODE}) error!" >&2; exit 1; fi
ACTUAL_VALUE="$(<"${STDERR}")"
if [[ "${ACTUAL_VALUE}" != "\"${TMP_PATH}\" is a symlink!" ]]; then
 echo "Actual value(${#ACTUAL_VALUE}) is: \"${ACTUAL_VALUE}\"!" >&2; exit 1; fi
rm "${TMP_PATH}"

:> "${STDERR}"

TMP_PATH="$(mktemp)"
"${SCRIPT}" "${TMP_PATH}" 2>"${STDERR}"; CODE=$?
if [[ "${CODE}" != '1' ]]; then
 echo "Code(${CODE}) error!" >&2; exit 1; fi
ACTUAL_VALUE="$(<"${STDERR}")"
if [[ "${ACTUAL_VALUE}" != "\"${TMP_PATH}\" is empty!" ]]; then
 echo "Actual value(${#ACTUAL_VALUE}) is: \"${ACTUAL_VALUE}\"!" >&2; exit 1; fi
rm "${TMP_PATH}"

:> "${STDERR}"

TMP_PATH="$(mktemp)"
printf "foo" > "${TMP_PATH}"
"${SCRIPT}" "${TMP_PATH}" 2>"${STDERR}"; CODE=$?
if [[ "${CODE}" != '1' ]]; then
 echo "Code(${CODE}) error!" >&2; exit 1; fi
ACTUAL_VALUE="$(<"${STDERR}")"
if [[ "${ACTUAL_VALUE}" != "\"${TMP_PATH}\" is not executable!" ]]; then
 echo "Actual value(${#ACTUAL_VALUE}) is: \"${ACTUAL_VALUE}\"!" >&2; exit 1; fi
rm "${TMP_PATH}"

:> "${STDERR}"

TMP_PATH="$(mktemp)"
printf "foo" > "${TMP_PATH}"
chmod +x "${TMP_PATH}"
"${SCRIPT}" "${TMP_PATH}" 2>"${STDERR}"; CODE=$?
if [[ "${CODE}" != '0' ]]; then
 echo "Code(${CODE}) error!" >&2; exit 1; fi
ACTUAL_VALUE="$(<"${STDERR}")"
if [[ -n "${ACTUAL_VALUE}" ]]; then
 echo "Actual value(${#ACTUAL_VALUE}) is: \"${ACTUAL_VALUE}\"!" >&2; exit 1; fi
rm "${TMP_PATH}"

rm "${STDERR}"
