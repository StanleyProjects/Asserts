#!/usr/local/bin/bash

if [[ $# -ne 3 ]]; then
 echo 'Wrong arguments!' >&2; exit 1; fi

ASSERTS_CONTEXT="$1"

if [[ -z "${ASSERTS_CONTEXT}" ]]; then
 echo 'No context!' >&2; exit 1; fi

ASSERTS_TEXT="$2"
ASSERTS_REGEX="$3"

if [[ -z "${ASSERTS_REGEX}" ]]; then
 echo 'No regex!' >&2; exit 1; fi

[[ "${ASSERTS_TEXT}" =~ ${ASSERTS_REGEX} ]]; CODE=$?

if [[ "${CODE}" == '2' ]]; then
 echo "Context: \"${ASSERTS_CONTEXT}\"
Invalid regex:
---(${#ASSERTS_REGEX})
${ASSERTS_REGEX}
---" >&2
 exit 1
elif [[ "${CODE}" != '0' ]]; then
 echo "Context: \"${ASSERTS_CONTEXT}\"
---(${#ASSERTS_TEXT})
${ASSERTS_TEXT}
---
does not satisfy the regex:
---(${#ASSERTS_REGEX})
${ASSERTS_REGEX}
---" >&2
 exit 1
fi
