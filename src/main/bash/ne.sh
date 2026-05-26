#!/usr/local/bin/bash

if [[ $# -ne 3 ]]; then
 echo 'Wrong arguments!' >&2; exit 1; fi

ASSERTS_CONTEXT="$1"

if [[ -z "${ASSERTS_CONTEXT}" ]]; then
 echo 'No context!' >&2; exit 1; fi

ASSERTS_ACTUAL="$2"
ASSERTS_EXPECTED="$3"

if [[ "${ASSERTS_ACTUAL}" == "${ASSERTS_EXPECTED}" ]]; then
 printf '%s' "Context: \"${ASSERTS_CONTEXT}\"
Values(${#ASSERTS_ACTUAL}) equal: \"${ASSERTS_ACTUAL}\"
" >&2; exit 1; fi
