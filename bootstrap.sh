#!/usr/bin/env bash

# The latest copy of this build script is available at:
#     https://raw.githubusercontent.com/chrisbouchard/neovide-nightly/main/bootstrap.sh

set -eux -o errtrace

curl --fail --output 'build.sh' --proto '=https' --show-error --silent --tlsv1.2 \
    'https://raw.githubusercontent.com/chrisbouchard/neovide-nightly/main/build.sh'

source 'build.sh'

