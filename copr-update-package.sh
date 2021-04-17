#!/usr/bin/env bash

# This script assumes that you have already configured copr with your login
# credentials.

set -eux -o errtrace

copr edit-package-custom \
    --name neovide \
    --script bootstrap.sh \
    --script-builddeps 'bash curl git' \
    --script-chroot fedora-latest-x86_64 \
    --webhook-rebuild on \
    neovide-nightly

