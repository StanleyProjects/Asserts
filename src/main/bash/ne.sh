#!/usr/local/bin/bash

if [[ $# -ne 3 ]]; then
 echo 'Wrong arguments!' >&2; exit 1; fi

TESTED_CONTEXT="$1"

if [[ -z "${TESTED_CONTEXT}" ]]; then
 echo 'No tested context!' >&2; exit 1; fi

VALUE_ACTUAL="$1"
VALUE_EXPECTED="$2"

if [[ "${VALUE_ACTUAL}" == "${VALUE_EXPECTED}" ]]; then
 printf "Tested context: \"${TESTED_CONTEXT}\"
Values(${#VALUE_ACTUAL}) equal: \"${VALUE_ACTUAL}\"
" >&2; exit 1; fi
