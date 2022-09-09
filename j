Skip to content
aircrack-ng
/
aircrack-ng
Public
WiFi security auditing tools suite

aircrack-ng.org
License
 GPL-2.0, Unknown licenses found
 3.2k stars  703 forks
Code
Issues
375
Pull requests
17
Discussions
Actions
Security
Insights
aircrack-ng/aircrack-ng
Latest commit
@jbenden
jbenden
…
28 days ago
Git stats
Files
README.md
Aircrack-ng
Alpine Linux Build Status Kali Linux Build Status Armel Kali Linux Build Status Armhf Kali Linux Build Status DragonFly BSD Build Status FreeBSD 11 Build Status FreeBSD 12 Build Status OpenBSD 6 Build Status NetBSD 8.1 Build Status Coverity Scan Build Status PackageCloud DEB PackageCloud RPM

Aircrack-ng is a complete suite of tools to assess WiFi network security.

It focuses on different areas of WiFi security:

Monitoring: Packet capture and export of data to text files for further processing by third party tools.
Attacking: Replay attacks, deauthentication, fake access points and others via packet injection.
Testing: Checking WiFi cards and driver capabilities (capture and injection).
Cracking: WEP and WPA PSK (WPA 1 and 2).
All tools are command line which allows for heavy scripting. A lot of GUIs have taken advantage of this feature. It works primarily on Linux but also Windows, macOS, FreeBSD, OpenBSD, NetBSD, as well as Solaris and even eComStation 2.

Building
Requirements
Autoconf
Automake
Libtool
shtool
OpenSSL development package or libgcrypt development package.
Airmon-ng (Linux) requires ethtool, usbutils, and often pciutils.
On Windows, cygwin has to be used and it also requires w32api package.
On Windows, if using clang, libiconv and libiconv-devel
Linux: LibNetlink 1 or 3. It can be disabled by passing --disable-libnl to configure.
pkg-config (pkgconf on FreeBSD)
FreeBSD, OpenBSD, NetBSD, Solaris and OS X with Macports: gmake
Linux/Cygwin: make and Standard C++ Library development package (Debian: libstdc++-dev)
Note: Airmon-ng only requires pciutils if the system has a PCI/PCIe bus and it is populated. Such bus can be present even if not physically visible. For example, it is present, and populated on the Raspberry Pi 4, therefore pciutils is required on that device.

Optional stuff
If you want SSID filtering with regular expression in airodump-ng (-essid-regex) PCRE development package is required.
If you want to use airolib-ng and '-r' option in aircrack-ng, SQLite development package >= 3.3.17 (3.6.X version or better is recommended)
If you want to use Airpcap, the 'developer' directory from the CD/ISO/SDK is required.
In order to build besside-ng, besside-ng-crawler, easside-ng, tkiptun-ng and wesside-ng, libpcap development package is required (on Cygwin, use the Airpcap SDK instead; see above)
rfkill
If you want Airodump-ng to log GPS coordinates, gpsd is needed
For best performance on SMP machines, ensure the hwloc library and headers are installed. It is strongly recommended on high core count systems, it may give a serious speed boost
CMocka for unit testing
For integration testing on Linux only: tcpdump, HostAPd, WPA Supplicant and screen
Installing required and optional dependencies
Below are instructions for installing the basic requirements to build aircrack-ng for a number of operating systems.

Note: CMocka, tcpdump, screen, HostAPd and WPA Supplicant should not be dependencies when packaging Aircrack-ng.

Linux
Arch Linux
sudo pacman -Sy base-devel libnl openssl ethtool util-linux zlib libpcap sqlite pcre hwloc cmocka hostapd wpa_supplicant tcpdump screen iw usbutils pciutils
Debian/Ubuntu
sudo apt-get install build-essential autoconf automake libtool pkg-config libnl-3-dev libnl-genl-3-dev libssl-dev ethtool shtool rfkill zlib1g-dev libpcap-dev libsqlite3-dev libpcre3-dev libhwloc-dev libcmocka-dev hostapd wpasupplicant tcpdump screen iw usbutils
Fedora
sudo yum install libtool pkgconfig sqlite-devel autoconf automake openssl-devel libpcap-devel pcre-devel rfkill libnl3-devel gcc gcc-c++ ethtool hwloc-devel libcmocka-devel make file expect hostapd wpa_supplicant iw usbutils tcpdump screen zlib-devel
CentOS/RHEL 7
sudo yum install epel-release
sudo ./centos_autotools.sh
# Remove older installation of automake/autoconf
sudo yum remove autoconf automake
sudo yum install sqlite-devel openssl-devel libpcap-devel pcre-devel rfkill libnl3-devel ethtool hwloc-devel libcmocka-devel make file expect hostapd wpa_supplicant iw usbutils tcpdump screen zlib-devel
Note: autoconf, automake, libtool, and pkgconfig in the repositories are too old. The script centos_autotools.sh automatically installs dependencies to compile then install the tools.

CentOS/RHEL 8
sudo yum config-manager --set-enabled powertools
sudo yum install epel-release
sudo yum install libtool pkgconfig sqlite-devel autoconf automake openssl-devel libpcap-devel pcre-devel rfkill libnl3-devel gcc gcc-c++ ethtool hwloc-devel libcmocka-devel make file expect hostapd wpa_supplicant iw usbutils tcpdump screen zlib-devel
openSUSE
sudo zypper install autoconf automake libtool pkg-config libnl3-devel libopenssl-1_1-devel zlib-devel libpcap-devel sqlite3-devel pcre-devel hwloc-devel libcmocka-devel hostapd wpa_supplicant tcpdump screen iw gcc-c++ gcc ethtool pciutils usbutils
Mageia
sudo urpmi autoconf automake libtool pkgconfig libnl3-devel libopenssl-devel zlib-devel libpcap-devel sqlite3-devel pcre-devel hwloc-devel libcmocka-devel hostapd wpa_supplicant tcpdump screen iw gcc-c++ gcc make
Alpine
sudo apk add gcc g++ make autoconf automake libtool libnl3-dev openssl-dev ethtool libpcap-dev cmocka-dev hostapd wpa_supplicant tcpdump screen iw pkgconf util-linux sqlite-dev pcre-dev linux-headers zlib-dev pciutils usbutils
Note: Community repository needs to be enabled for iw

Clear Linux
sudo swupd bundle-add c-basic devpkg-openssl devpkg-libgcrypt devpkg-libnl devpkg-hwloc devpkg-libpcap devpkg-pcre devpkg-sqlite-autoconf ethtool wget network-basic software-testing sysadmin-basic wpa_supplicant
Note: hostapd must be compiled manually, it is not present in the repository

BSD
FreeBSD
pkg install pkgconf shtool libtool gcc9 automake autoconf pcre sqlite3 openssl gmake hwloc cmocka
DragonflyBSD
pkg install pkgconf shtool libtool gcc8 automake autoconf pcre sqlite3 libgcrypt gmake cmocka
OpenBSD
pkg_add pkgconf shtool libtool gcc automake autoconf pcre sqlite3 openssl gmake cmocka
macOS
XCode, Xcode command line tools and HomeBrew are required.

brew install autoconf automake libtool openssl shtool pkg-config hwloc pcre sqlite3 libpcap cmocka
Windows
Cygwin
Cygwin requires the full path to the setup.exe utility, in order to automate the installation of the necessary packages. In addition, it requires the location of your installation, a path to the cached packages download location, and a mirror URL.

An example of automatically installing all the dependencies is as follows:

c:\cygwin\setup-x86.exe -qnNdO -R C:/cygwin -s http://cygwin.mirror.constant.com -l C:/cygwin/var/cache/setup -P autoconf -P automake -P bison -P gcc-core -P gcc-g++ -P mingw-runtime -P mingw-binutils -P mingw-gcc-core -P mingw-gcc-g++ -P mingw-pthreads -P mingw-w32api -P libtool -P make -P python -P gettext-devel -P gettext -P intltool -P libiconv -P pkg-config -P git -P wget -P curl -P libpcre-devel -P libssl-devel -P libsqlite3-devel
MSYS2
pacman -Sy autoconf automake-wrapper libtool msys2-w32api-headers msys2-w32api-runtime gcc pkg-config git python openssl-devel openssl libopenssl msys2-runtime-devel gcc binutils make pcre-devel libsqlite-devel
Compiling
To build aircrack-ng, the Autotools build system is utilized. Autotools replaces the older method of compilation.

NOTE: If utilizing a developer version, eg: one checked out from source control, you will need to run a pre-configure script. The script to use is one of the following: autoreconf -i or env NOCONFIGURE=1 ./autogen.sh.

First, ./configure the project for building with the appropriate options specified for your environment:

./configure <options>
TIP: If the above fails, please see above about developer source control versions.

Next, compile the project (respecting if make or gmake is needed):

Compilation:

make

Compilation on *BSD or Solaris:

gmake

Finally, the additional targets listed below may be of use in your environment:

Execute all unit testing:

make check

Execute all integration testing (requires root):

make integration

Installing:

make install

Uninstall:

make uninstall

./configure flags
When configuring, the following flags can be used and combined to adjust the suite to your choosing:

with-airpcap=DIR: needed for supporting airpcap devices on windows (cygwin or msys2 only) Replace DIR above with the absolute location to the root of the extracted source code from the Airpcap CD or downloaded SDK available online. Required on Windows to build besside-ng, besside-ng-crawler, easside-ng, tkiptun-ng and wesside-ng when building experimental tools. The developer pack (Compatible with version 4.1.1 and 4.1.3) can be downloaded at https://support.riverbed.com/content/support/software/steelcentral-npm/airpcap.html

with-experimental: needed to compile tkiptun-ng, easside-ng, buddy-ng, buddy-ng-crawler, airventriloquist and wesside-ng. libpcap development package is also required to compile most of the tools. If not present, not all experimental tools will be built. On Cygwin, libpcap is not present and the Airpcap SDK replaces it. See --with-airpcap option above.

with-ext-scripts: needed to build airoscript-ng, versuck-ng, airgraph-ng and airdrop-ng. Note: Each script has its own dependencies.

with-gcrypt: Use libgcrypt crypto library instead of the default OpenSSL. And also use internal fast sha1 implementation (borrowed from GIT) Dependency (Debian): libgcrypt20-dev

with-duma: Compile with DUMA support. DUMA is a library to detect buffer overruns and under-runs. Dependencies (debian): duma

disable-libnl: Set-up the project to be compiled without libnl (1 or 3). Linux option only.

without-opt: Do not enable stack protector (on GCC 4.9 and above).

enable-shared: Make OSdep a shared library.

disable-shared: When combined with enable-static, it will statically compile Aircrack-ng.

with-avx512: On x86, add support for AVX512 instructions in aircrack-ng. Only use it when the current CPU supports AVX512.

with-static-simd=: Compile a single optimization in aircrack-ng binary. Useful when compiling statically and/or for space-constrained devices. Valid SIMD options: x86-sse2, x86-avx, x86-avx2, x86-avx512, ppc-altivec, ppc-power8, arm-neon, arm-asimd. Must be used with --enable-static --disable-shared. When using those 2 options, the default is to compile the generic optimization in the binary. --with-static-simd merely allows to choose another one.

enable-maintainer-mode: It is important to enable this flag when developing with Aircrack-ng. This flag enables additional compile warnings and safety features.

Examples:
Configure and compiling:

./configure --with-experimental
make
Compiling with gcrypt:

./configure --with-gcrypt
make
Installing:

make install

Installing (strip binaries):

make install-strip

Installing, with external scripts:

./configure --with-experimental --with-ext-scripts
make
make install
Testing (with sqlite, experimental and pcre)

./configure --with-experimental
make
make check
Compiling on OS X with macports (and all options):

./configure --with-experimental
gmake
Compiling on macOS running on M1/AARCH64 and Homebrew:

autoreconf -vif
env CPPFLAGS="-Wno-deprecated-declarations" ./configure --with-experimental
make
make check
Compiling on OS X 10.10 with XCode 7.1 and Homebrew:

env CC=gcc-4.9 CXX=g++-4.9 ./configure
make
make check
NOTE: Older XCode ships with a version of LLVM that does not support CPU feature detection; which causes the ./configure to fail. To work around this older LLVM, it is required that a different compile suite is used, such as GCC or a newer LLVM from Homebrew.

If you wish to use OpenSSL from Homebrew, you may need to specify the location to its' installation. To figure out where OpenSSL lives, run:

brew --prefix openssl

Use the output above as the DIR for --with-openssl=DIR in the ./configure line:

env CC=gcc-4.9 CXX=g++-4.9 ./configure --with-openssl=DIR
make
make check
Compiling on FreeBSD with gcc9

env CC=gcc9 CXX=g++9 MAKE=gmake ./configure
gmake
Compiling on Cygwin with Airpcap (assuming Airpcap devpack is unpacked in Aircrack-ng directory)

cp -vfp Airpcap_Devpack/bin/x86/airpcap.dll src
cp -vfp Airpcap_Devpack/bin/x86/airpcap.dll src/aircrack-osdep
cp -vfp Airpcap_Devpack/bin/x86/airpcap.dll src/aircrack-crypto
cp -vfp Airpcap_Devpack/bin/x86/airpcap.dll src/aircrack-util
dlltool -D Airpcap_Devpack/bin/x86/airpcap.dll -d build/airpcap.dll.def -l Airpcap_Devpack/bin/x86/libairpcap.dll.a
autoreconf -i
./configure --with-experimental --with-airpcap=$(pwd)
make
Compiling on DragonflyBSD with gcrypt using GCC 8

autoreconf -i
env CC=gcc8 CXX=g++8 MAKE=gmake ./configure --with-experimental --with-gcrypt
gmake
Compiling on OpenBSD (with autoconf 2.69 and automake 1.16)

export AUTOCONF_VERSION=2.69
export AUTOMAKE_VERSION=1.16
autoreconf -i
env MAKE=gmake CC=cc CXX=c++ ./configure
gmake
Compiling and debugging aircrack-ng

export CFLAGS='-O0 -g'
export CXXFLAGS='-O0 -g'
./configure --with-experimental --enable-maintainer-mode --without-opt
make
LD_LIBRARY_PATH=.libs gdb --args ./aircrack-ng [PARAMETERS]
IDE development
VS Code - devcontainers
A VS Code development environment is provided, as is, for rapid setup of a development environment. This additionally adds support for GitHub Codespaces.

Requirements
The first requirement is a working Docker Engine environment.

Next, an installation of VS Code with the following extension(s):

Remote - Containers by Microsoft.
The "Remote - Containers" extension will refuse to work with OSS Code.

Usage
Clone this repository to your working folder:
$ git clone --recursive https://github.com/aircrack-ng/aircrack-ng.git
$ cd aircrack-ng
After cloning this repository, open the folder inside VS Code.
$ code .
IMPORTANT: You should answer "Yes", if it asks if the folder should be opened inside a remote container. If it does not ask, then press Ctrl+Shift+P and type open in container. This should bring up the correct command, for which pressing enter will run said command.

A number of warnings might appear about a missing compile_commands.json file. These are safe to ignore for a moment, as this file is automatically generated after the initial compilation.
Now build the entire project by pressing Ctrl+R and selecting Build Full from the pop-up menu that appears.
VS Code should detect the compile_commands.json file and ask if it should be used; selecting "Yes, always" will complete the initial setup of a fully working IDE.
IMPORTANT: If it doesn't detect the file, pressing Ctrl+Shift+P and typing reload window will bring up the selection to fully reload the environment.

At this point, nearly all features of VS Code will function; from Intellisense, auto-completion, live documentation, to code formatting. Additionally, there are pre-configured tasks for builds and tests, as well as an example GDB/LLDB configuration for debugging aircrack-ng.
Packaging
Automatic detection of CPU optimization is done at run time. This behavior is desirable when packaging Aircrack-ng (for a Linux or other distribution.)

Also, in some cases it may be desired to provide your own flags completely and not having the suite auto-detect a number of optimizations. To do this, add the additional flag --without-opt to the ./configure line:

./configure --without-opt

Using pre-compiled binaries
Linux/BSD
Aircrack-ng is available in most distributions repositories. However, it is not always up to date.

We provide up to date versions via PackageCloud for a number of Linux distributions:

development (each commit in this repo): https://packagecloud.io/aircrack-ng/git
stable releases: https://packagecloud.io/aircrack-ng/release
Windows
Install the appropriate "monitor" driver for your card; standard drivers don't work for capturing data.
Aircrack-ng suite is command line tools. So, you have to open a command-line Start menu -> Run... -> cmd.exe then use them
Run the executables without any parameters to have help
Continuous integration
Linux CI (GitHub actions): https://github.com/aircrack-ng/aircrack-ng/actions/workflows/linux.yml
Windows CI (Github actions): https://github.com/aircrack-ng/aircrack-ng/actions/workflows/windows.yml
macOS CI (GitHub actions): https://github.com/aircrack-ng/aircrack-ng/actions/workflows/macos.yml
Code style and consistency (GitHub actions): https://github.com/aircrack-ng/aircrack-ng/actions/workflows/style.yml
PVS-Studio static analysis (GitHub actions): https://github.com/aircrack-ng/aircrack-ng/actions/workflows/pvs-studio.yml
Coverity Scan static analysis: https://scan.coverity.com/projects/aircrack-ng
Buildbots
URL: https://buildbot.aircrack-ng.org/

Linux buildbots:

CentOS
AArch64
Kali Linux
Armel Kali Linux
Armhf Kali Linux
Alpine Linux
BSD buildbots:

OpenBSD
FreeBSD
NetBSD
DragonflyBSD
Documentation
Some more information is present in the README file.

Documentation, tutorials, ... can be found on https://aircrack-ng.org

Support is available in the forum and on IRC (in #aircrack-ng on Libera Chat).

Every tool has its own manpage. For aircrack-ng, man aircrack-ng

Infrastructure sponsors
Releases 9
Aircrack-ng 1.7
Latest
on 11 May
+ 8 releases
Packages
No packages published
Contributors 48
@Mister-X-
@jbenden
@ZeroChaos-
@jmberg
@aircrack-ng
@Googulator
@ChrisLundquist
@clopez
@XayOn
@daouid
@alonbl
+ 37 contributors
Languages
C
71.4%
 
M4
7.7%
 
C#
6.8%
 
Shell
4.4%
 
Python
4.0%
 
Roff
2.9%
 
Other
2.8%
Footer
© 2022 GitHub, Inc.
Footer navigation
Terms
Privacy
Security
Status
Docs
Contact GitHub
Pricing
API
Training
Blog
About
You have no unread notifications
