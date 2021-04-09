#!/usr/bin/env bash

# This script assumes that you have already configured copr with your login
# credentials.

set -eux -o errtrace

copr build-package --name neovide neovide-nightly

