#!/bin/bash

set -ex

cd $(dirname $0)

if [ "$1" = "--release" ]; then
  CFLAGS="-Wall"
else
  # To get debugging symbols in PHP itself, build PHP with:
  #   $ ./configure --enable-debug CFLAGS='-g -O0'
  CFLAGS="-g -O0 -Wall"
fi

pushd  ../ext/google/protobuf
phpize --clean
rm -f configure.in configure.ac
php make-preload.php
phpize && ./configure --with-php-config=$(which php-config) CFLAGS="$CFLAGS" && make
popd
