#!/usr/bin/env sh
set -euo pipefail
set -x

while read -r extension; do
    code --install-extension "$extension"
done < extensions.txt
