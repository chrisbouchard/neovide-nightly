#!/usr/bin/env bash

# The latest copy of this build script is available at:
#     https://raw.githubusercontent.com/chrisbouchard/neovide-nightly/main/build.sh

set -eux -o errtrace

build_date="$(date +'%a %b %d %Y')"

git clone 'https://github.com/Kethku/neovide.git'
git clone 'https://github.com/chrisbouchard/neovide-nightly.git'

pushd neovide

    main_description="$(git describe --tags HEAD)"
    main_description="${main_description//-/ }"
    read main_tag main_commits main_hash <<<"$main_description"

    if [ -n "$main_commits" ] && [ -n "$main_hash" ]
    then
        version="$main_tag~dev.$main_commits.$main_hash"
    else
        version="$main_tag"
    fi

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

# Copy the temporary application icon out so we can include it as a source in
# our RPM spec.
cp 'neovide-nightly/neovide.svg' 'neovide.svg'

