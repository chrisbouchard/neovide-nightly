#!/usr/bin/env bash

# The latest copy of this build script is available at:
#     https://raw.githubusercontent.com/chrisbouchard/neovide-nightly/main/build.sh

set -eux -o errtrace

build_date="$(date +'%a %b %d %Y')"

git clone 'https://github.com/Kethku/neovide.git'
git clone 'https://github.com/chrisbouchard/neovide-nightly.git'

pushd neovide

    # The result here should be similar to parsing `git describe --tags HEAD`,
    # except we don't have to worry about string parsing. The results of `git
    # describe` are ambiguous if the tag name contains any dashes.

    main_tag=$(git describe --abbrev=0 --tags HEAD)
    main_commits=$(git rev-list --count "$main_tag..HEAD")
    main_hash=$(git rev-parse --short HEAD)

    # If the tag does contain any dashes, we need to remove them because RPM
    # uses dash to separate the version and release.
    safe_main_tag="${main_tag//-/.}"

    # Note that we insert a "g" before the hash, just like `git describe` does.
    # This is for backwards compatibility with our older versioning scheme that
    # did use `git describe`.
    version="$safe_main_tag~dev.$main_commits.g$main_hash"

    git archive \
        --prefix="neovide-$version/" \
        --format=tar.gz \
        --output='../neovide.tar.gz' \
        HEAD

popd

pushd neovide-nightly

    release="$(git rev-list --count HEAD)"

popd

# Copy the RPM spec out and do some simple text replacement to patch in dynamic
# values.
cat 'neovide-nightly/neovide.spec' \
    | sed "s/{{build_date}}/$build_date/" \
    | sed "s/{{release}}/$release/" \
    | sed "s/{{version}}/$version/" \
    >'neovide.spec'

