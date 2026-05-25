#!/usr/local/bin/bash

if [[ $# -ne 3 ]]; then
 echo 'Wrong arguments!' >&2; exit 1; fi

ASSERT_CONTEXT="$1"

if [[ -z "${ASSERT_CONTEXT}" ]]; then
 echo 'No assert context!' >&2; exit 1; fi

ACTUAL_TEXT="$2"
EXPECTED_SUBTEXT="$3"

if [[ -z "${EXPECTED_SUBTEXT}" ]]; then
 echo 'No expected subtext!' >&2; exit 1; fi

if [[ "${ACTUAL_TEXT}" != *"${EXPECTED_SUBTEXT}"* ]]; then
 printf '%s' "Assert context: \"${ASSERT_CONTEXT}\"
---(${#ACTUAL_TEXT})
${ACTUAL_TEXT}
---
...does not contain:
---(${#EXPECTED_SUBTEXT})
${EXPECTED_SUBTEXT}
---
" >&2; exit 1; fi
