#!/usr/bin/env sh
set -eux

CODE_EXEC=${1:-code}

while read -r extension; do
    $CODE_EXEC --install-extension "$extension"
done < extensions.txt
