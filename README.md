# Neovide Nightly

[![Copr build status][copr-status-image]][copr-neovide-nightly]

Build script and RPM spec for a nightly build of [Neovide][neovide]


## Installing Neovide from Copr

The nightly build of Neovide is available from the
[chrisbouchard/neovide-nightly][neovide-nightly-project] Copr. Assuming you're
using a recent version of Fedora, you can install it using `dnf`.

```console
$ dnf copr enable chrisbouchard/neovide-nightly
$ dnf install neovide
```

You may have to agree to some prompts if this is the first Copr you've enabled.

I currently use Neovide from this repository as my daily driver, so I'm eating
my own dogfood. I also use [nightly Neovim][neovim-nightly] from Copr as well
(which inspired me to create this project).


## Build Process

The `build.sh` script in this project runs on [Fedora Copr][fedora-copr]. The
script will configure a source RPM based on the [`main` branch in
Kethku/neovide][neovide-main-branch], which the Copr pipeline will build into
binary RPMs for various OS targets.

I have a server set up using
[chrisbouchard/copr-nightly-trigger][copr-nightly-trigger] to trigger a build
every night around midnight EST. ~~The Copr project is also configured to
rebuild whenever I push a new commit to this project.~~ (This is not currently
working.)

The RPM's version is similar to (but not the same as) running `git describe
--tags HEAD` in the Neovide project. It will be something like
`0.7.0~dev.13.gd8d6f4e`, where

* `0.7.0` is the last Neovide tag,
* `13` is the number of commits on `main` since that tag, and
* `d8d6f4e` is the `HEAD` commit (with a `g` prefix indicating it's a git
  project)

The revision will be something like `24.fc34.x86_64`, where

* `24` is the number of commits on the `main` branch in this project and
* `fc34.x86_64` is the standard dist tag (OS version and architecture)

Right now (as of April 2021), I'm building for Fedora 32&ndash;34 on x86-64,
mostly because those are the OS versions and architecture I needed. If I do add
other options, I'll have to offer them as-is because I won't be able to test
them.

All builds are on a best-effort basis. I'll continue to tweak the build script
and RPM spec. I can't guarantee it will run on every system (or _any_ system
for that matter). If it runs, I can't guarantee it will run _correctly_. If you
run into trouble, feel free to open an issue or pull request.


[copr-neovide-nightly]: https://copr.fedorainfracloud.org/coprs/chrisbouchard/neovide-nightly/package/neovide/
[copr-nightly-trigger]: https://github.com/chrisbouchard/copr-nightly-trigger
[copr-status-image]: https://copr.fedorainfracloud.org/coprs/chrisbouchard/neovide-nightly/package/neovide/status_image/last_build.png
[fedora-copr]: https://copr.fedorainfracloud.org/
[neovide-nightly-project]: https://copr.fedorainfracloud.org/coprs/chrisbouchard/neovide-nightly
[neovide]: https://github.com/Kethku/neovide
[neovide-main-branch]: https://github.com/Kethku/neovide/commits/main
[neovim-nightly]: https://copr.fedorainfracloud.org/coprs/agriffis/neovim-nightly/
