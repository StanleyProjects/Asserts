#!/usr/local/bin/bash

if test $# -ne 2; then
 echo 'Wrong arguments!'; exit 1; fi

if test -z "${ISSUER}"; then
 echo 'No issuer!'; exit 1; fi

VALUE_ACTUAL="$1"
VALUE_EXPECTED="$2"

if [ "${VALUE_ACTUAL}" != "${VALUE_EXPECTED}" ]; then
 echo "Issuer \"${ISSUER}\" error!"
 echo "Actual(${#VALUE_ACTUAL}): \"${VALUE_ACTUAL}\""
 echo "Expected(${#VALUE_EXPECTED}): \"${VALUE_EXPECTED}\""
 exit 1
fi
