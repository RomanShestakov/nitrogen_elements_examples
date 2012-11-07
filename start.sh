#!/bin/sh
cd `dirname $0`

exec erl -pa $PWD/ebin -pa $PWD/deps/*/ebin -name web"@"$HOSTNAME \
    -s nitrogen_elements_test_app start -config ebin/nitrogen_elements_test
