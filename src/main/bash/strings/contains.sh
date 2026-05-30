#!/usr/local/bin/bash

if [[ $# -ne 3 ]]; then
 echo 'Wrong arguments!' >&2; exit 1; fi

ASSERTS_CONTEXT="$1"

if [[ -z "${ASSERTS_CONTEXT}" ]]; then
 echo 'No context!' >&2; exit 1; fi

ASSERTS_TEXT="$2"
ASSERTS_SUBTEXT="$3"

if [[ -z "${ASSERTS_SUBTEXT}" ]]; then
 echo 'No subtext!' >&2; exit 1; fi

if [[ "${ASSERTS_TEXT}" != *"${ASSERTS_SUBTEXT}"* ]]; then
 printf '%s' "Context: \"${ASSERTS_CONTEXT}\"
---(${#ASSERTS_TEXT})
${ASSERTS_TEXT}
---
does not contain:
---(${#ASSERTS_SUBTEXT})
${ASSERTS_SUBTEXT}
---
" >&2; exit 1; fi
