#!/usr/local/bin/bash

if [[ $# -ne 3 ]]; then
 echo 'Wrong arguments!' >&2; exit 1; fi

TESTED_CONTEXT="$1"

if [[ -z "${TESTED_CONTEXT}" ]]; then
 echo 'No tested context!' >&2; exit 1; fi

VALUE_ACTUAL="$2"
VALUE_EXPECTED="$3"

if [[ "${VALUE_ACTUAL}" != "${VALUE_EXPECTED}" ]]; then
 printf "Tested context: \"${TESTED_CONTEXT}\"
Actual(${#VALUE_ACTUAL}): \"${VALUE_ACTUAL}\"
Expected(${#VALUE_EXPECTED}): \"${VALUE_EXPECTED}\"
" >&2; exit 1; fi
