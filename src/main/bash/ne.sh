#!/usr/local/bin/bash

if test $# -ne 2; then
 echo 'Wrong arguments!' >&2; exit 1; fi

if test -z "${ISSUER}"; then
 echo 'No issuer!' >&2; exit 1; fi

VALUE_ACTUAL="$1"
VALUE_EXPECTED="$2"

if [[ "${VALUE_ACTUAL}" == "${VALUE_EXPECTED}" ]]; then
 echo -n "Issuer \"${ISSUER}\" error!
Values(${#VALUE_ACTUAL}) equal: \"${VALUE_ACTUAL}\"
" >&2; exit 1; fi
