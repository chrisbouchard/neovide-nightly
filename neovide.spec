Name:           neovide
Version:        {{version}}
Release:        {{release}}%{?dist}
Summary:        No Nonsense Neovim Client in Rust

License:        MIT
URL:            https://github.com/Kethku/neovide
Source0:        neovide.tar.gz

# Tools
BuildRequires:  cargo
BuildRequires:  cmake
BuildRequires:  desktop-file-utils
BuildRequires:  gcc
BuildRequires:  gcc-c++

# Libraries
BuildRequires:  SDL2-devel
BuildRequires:  expat-devel
BuildRequires:  freetype-devel
BuildRequires:  libXext-devel
BuildRequires:  mesa-vulkan-devel
BuildRequires:  openssl-devel

# Base
Requires:       google-noto-sans-mono-fonts
Requires:       neovim >= 0.4.0

# Libraries
Requires:       SDL2
Requires:       expat
Requires:       freetype
Requires:       libXext
Requires:       mesa-vulkan
Requires:       openssl

%description

This is a simple graphical user interface for Neovim. Where possible there are
some graphical improvements, but it should act functionally like the terminal
UI.

%prep
%setup


%build
cargo build --release


%install
install -p -m 755 'target/release/neovide' "%{buildroot}%{_bindir}/neovide"
desktop-file-install --dir="%{buildroot}%{_datadir}/applications" \
    'assets/neovide.desktop'


%files
%license LICENSE
%{_bindir}/neovide
%{_datadir}/applications/neovide.desktop


%changelog
* {{build_date}} Chris Bouchard <chris@upliftinglemma.net>
- Nightly build from git main
