#!/usr/bin/env sh
set -eux

CODE_EXEC=${1:-code}

$CODE_EXEC --list-extensions > extensions.txt
