#!/usr/local/bin/bash

tests='src/test/bash'

while IFS= read -r -d '' SCRIPT; do
 if [[ "${SCRIPT}" == "${tests}/unit_test.sh" || "${SCRIPT}" =~ ^"${tests}/check_".+\.sh$ ]]; then
  continue
 elif [[ -L "${SCRIPT}" ||  ! -f "${SCRIPT}" || ! -x "${SCRIPT}" || ! "${SCRIPT}" =~ ^"${tests}/".+\_test.sh$ ]]; then
  echo "Script \"${SCRIPT}\" is not supported!" >&2; exit 1
 fi
 . "${SCRIPT}"
done < <(find "${tests}" -depth -type f -print0)

. $tests/check_coverage.sh

. $tests/check_license.sh
. $tests/check_readme.sh

echo 'All tests were successful.'
