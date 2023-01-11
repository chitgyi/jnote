#!/bin/bash
set -e
fvm flutter pub get
fvm flutter test --coverage
lcov --remove coverage/lcov.info \
'lib/src/*.config.dart' \
'lib/src/*.freezed.dart' \
'lib/src/*.g.dart' \
'lib/src/di/*.dart' \
-o coverage/lcov.info
genhtml coverage/lcov.info -o coverage
open coverage/index.html