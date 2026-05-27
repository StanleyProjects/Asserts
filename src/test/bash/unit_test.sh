#!/usr/local/bin/bash

tests='src/test/bash'

. $tests/contains_test.sh
. $tests/eq_test.sh
. $tests/empty_test.sh
. $tests/file/not/empty_test.sh
. $tests/file/empty_test.sh
. $tests/file/exists_test.sh
. $tests/ne_test.sh
. $tests/regex_test.sh

. $tests/check_coverage.sh

. $tests/license_test.sh
. $tests/readme_test.sh

echo 'All tests were successful.'
