# Directory where the application icon will be installed
%global xdg_icon_dir %{_datadir}/icons/hicolor/scalable/apps

# Directory where the desktop entry will be installed
%global xdg_application_dir %{_datadir}/applications


Name:           neovide
Version:        {{version}}
Release:        {{release}}%{?dist}
Summary:        No Nonsense Neovim Client in Rust

License:        MIT
URL:            https://github.com/Kethku/neovide
Source0:        neovide.tar.gz
Source1:        neovide.svg

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
BuildRequires:  openssl-devel
BuildRequires:  vulkan-devel

# Base
Requires:       google-noto-sans-mono-fonts
Requires:       neovim >= 0.4.0

# Libraries
Requires:       SDL2
Requires:       expat
Requires:       freetype
Requires:       libXext
Requires:       openssl
Requires:       vulkan

%description

This is a simple graphical user interface for Neovim. Where possible there are
some graphical improvements, but it should act functionally like the terminal
UI.

%prep
%setup


%build
cargo build --release


%install
install --mode=755 --directory "%{buildroot}%{_bindir}"
install --mode=755 'target/release/neovide' "%{buildroot}%{_bindir}/neovide"

install --mode=755 --directory "%{buildroot}%{xdg_icon_dir}"
install --mode=644 "%{SOURCE1}" "%{buildroot}%{xdg_icon_dir}/neovide.svg"

install --mode=755 --directory "%{buildroot}%{xdg_application_dir}"
desktop-file-install --dir="%{buildroot}%{xdg_application_dir}" \
    'assets/neovide.desktop'


%files
%license LICENSE
%{_bindir}/neovide
%{xdg_icon_dir}/neovide.svg
%{xdg_application_dir}/neovide.desktop


%changelog
* {{build_date}} Chris Bouchard <chris@upliftinglemma.net>
- Nightly build from git main
