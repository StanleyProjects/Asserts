#!/usr/local/bin/bash

tests='src/test/bash'

. $tests/eq_test.sh
. $tests/file/exists_test.sh
. $tests/file/filled_test.sh
. $tests/ne_test.sh

. $tests/license_test.sh
. $tests/readme_test.sh

echo 'All tests were successful.'
