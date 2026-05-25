#!/usr/local/bin/bash

if [[ $# -ne 3 ]]; then
 echo 'Wrong arguments!' >&2; exit 1; fi

ASSERT_CONTEXT="$1"

if [[ -z "${ASSERT_CONTEXT}" ]]; then
 echo 'No assert context!' >&2; exit 1; fi

VALUE_ACTUAL="$2"
VALUE_EXPECTED="$3"

if [[ "${VALUE_ACTUAL}" == "${VALUE_EXPECTED}" ]]; then
 printf "Assert context: \"${ASSERT_CONTEXT}\"
Values(${#VALUE_ACTUAL}) equal: \"${VALUE_ACTUAL}\"
" >&2; exit 1; fi
