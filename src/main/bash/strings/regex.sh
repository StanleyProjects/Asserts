#!/usr/local/bin/bash

if [[ $# -eq 4 ]]; then
 ASSERTS_LOCALE="$4"
elif [[ $# -ne 3 ]]; then
 echo 'Wrong arguments!' >&2; exit 1
else
 ASSERTS_LOCALE='C'
fi

if LC_ALL="${ASSERTS_LOCALE}" locale charmap >/dev/null 2>&1 \
 && locale -a | grep -Fx -- "${ASSERTS_LOCALE}" >/dev/null 2>&1; then
 LC_ALL="${ASSERTS_LOCALE}"
else
 echo "Locale \"${ASSERTS_LOCALE}\" is not supported!" >&2; exit 1
fi

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
