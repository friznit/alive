# ALiVEPlugIn

## Setup a build system w/Fedora 22
* `sudo dnf install clang cmake gcc gcc-c++ glibc-devel.i686 glibc-devel.x86_64 libcurl-devel.i686 libcurl-devel.x86_64 libstdc++-static.i686 libstdc++-static.x86_64 libtool libuuid-devel mingw32-gcc.x86_64 mingw32-gcc-c++.x86_64 mingw32-curl-static.noarch mingw32-gettext-static.noarch mingw32-libidn-static.noarch mingw32-libssh2-static.noarch mingw32-openssl-static.noarch mingw32-win-iconv-static.noarch mingw32-winpthreads-static.noarch mingw32-zlib-static.noarch sigar-devel.noarch`
* `git clone https://username@bitbucket.org/tupolov/alive-plugin.git`
* `cd alive-plugin`
* `git checkout linux`
* `cd build`
* `cmake ..`
* `make`


## Compiling

All compiling must be done from the directory ./build/

To compile aliveplugin.so:
`cmake .. && make aliveplugin.so`

To compile ALiVEPlugIn.dll:
`cmake .. && make ALiVEPlugIn.dll`

To compile the unit test:
`cmake .. && make aliveTest`

To compile everything:
`cmake .. && make`
