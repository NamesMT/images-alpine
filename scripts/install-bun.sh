#!/bin/bash

set -e

# Note: Currently latest (2.35) won't work with bun.

cd /tmp
wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.34-r0/glibc-2.34-r0.apk
wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.34-r0/glibc-bin-2.34-r0.apk
apk add --no-cache --allow-untrusted --force-overwrite bash glibc-2.34-r0.apk glibc-bin-2.34-r0.apk
curl -fsSL https://bun.sh/install | bash
