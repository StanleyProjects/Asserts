#!/usr/local/bin/bash

REP_OWNER='StanleyProjects'
REP_NAME='Asserts'
VERSION='0.0.1'

mkdir -p 'build/yml'
ISSUER='build/yml/metadata.yml'
echo "repository:
 owner: '${REP_OWNER}'
 name: '${REP_NAME}'
version: '${VERSION}'" > "${ISSUER}"

if [[ ! -s 'LICENSE' ]]; then
 echo 'No license!'; exit 1; fi

if [[ ! -s 'README.md' ]]; then
 echo 'No readme!'; exit 1; fi

mkdir -p 'build/zip'
ISSUER="build/zip/${REP_NAME}-${VERSION}.zip"
zip -r "${ISSUER}" 'src/main/bash' 'LICENSE' 'README.md'
