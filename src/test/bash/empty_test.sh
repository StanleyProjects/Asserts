#!/usr/local/bin/bash

SCRIPT="src/main/bash/empty.sh"

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
if [[ "${ACTUAL_VALUE}" != 'Wrong arguments!' ]]; then
 echo "Actual value(${#ACTUAL_VALUE}) is: \"${ACTUAL_VALUE}\"!" >&2; exit 1; fi

:> "${STDERR}"

"${SCRIPT}" '' '' '' 2>"${STDERR}"; CODE=$?
if [[ "${CODE}" != '1' ]]; then
 echo "Code(${CODE}) error!" >&2; exit 1; fi
ACTUAL_VALUE="$(<"${STDERR}")"
if [[ "${ACTUAL_VALUE}" != 'Wrong arguments!' ]]; then
 echo "Actual value(${#ACTUAL_VALUE}) is: \"${ACTUAL_VALUE}\"!" >&2; exit 1; fi

:> "${STDERR}"

"${SCRIPT}" '' '' 2>"${STDERR}"; CODE=$?
if [[ "${CODE}" != '1' ]]; then
 echo "Code(${CODE}) error!" >&2; exit 1; fi
ACTUAL_VALUE="$(<"${STDERR}")"
if [[ "${ACTUAL_VALUE}" != 'No context!' ]]; then
 echo "Actual value(${#ACTUAL_VALUE}) is: \"${ACTUAL_VALUE}\"!" >&2; exit 1; fi

:> "${STDERR}"

"${SCRIPT}" '42' 'foo' 2>"${STDERR}"; CODE=$?
if [[ "${CODE}" != '1' ]]; then
 echo "Code(${CODE}) error!" >&2; exit 1; fi
EXPECTED_VALUE='Context: "42"
---(3)
foo
---'
ACTUAL_VALUE="$(<"${STDERR}")"
if [[ "${ACTUAL_VALUE}" != "${EXPECTED_VALUE}" ]]; then
 echo "Actual value(${#ACTUAL_VALUE}) is: \"${ACTUAL_VALUE}\"!" >&2; exit 1; fi

ACTUAL_TEXTS=(
 'a' ' ' $'\t' $'\n' $'\r' $'\v' $'\f' $'\x01'
 '!' '"' '#' '$' '%' '&' "'" '(' ')' '*' '+' ',' '-' '.' '/'
 ':' ';' '<' '=' '>' '?' '@' '[' ']' '^' '_' '`' '{' '|' '}' '~' '\'
)
for ACTUAL_TEXT in "${ACTUAL_TEXTS[@]}"; do
 :> "${STDERR}"
 "${SCRIPT}" '42' "${ACTUAL_TEXT}" 2>"${STDERR}"; CODE=$?
 if [[ "${CODE}" != '1' ]]; then
  echo "Code(${CODE}) error!" >&2; exit 1; fi
 EXPECTED_VALUE="Context: \"42\"
---(1)
${ACTUAL_TEXT}
---"
 ACTUAL_VALUE="$(<"${STDERR}")"
 if [[ "${ACTUAL_VALUE}" != "${EXPECTED_VALUE}" ]]; then
  echo "Actual value(${#ACTUAL_VALUE}) is: \"${ACTUAL_VALUE}\"!" >&2; exit 1; fi
done

:> "${STDERR}"

"${SCRIPT}" '42' '' 2>"${STDERR}"; CODE=$?
if [[ "${CODE}" != '0' ]]; then
 echo "Code(${CODE}) error!" >&2; exit 1; fi
ACTUAL_VALUE="$(<"${STDERR}")"
if [[ -n "${ACTUAL_VALUE}" ]]; then
 echo "Actual value(${#ACTUAL_VALUE}) is: \"${ACTUAL_VALUE}\"!" >&2; exit 1; fi

rm "${STDERR}"
