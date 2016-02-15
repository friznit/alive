cmake_minimum_required (VERSION 2.6)
project (ALiVEPlugIn_Windows)

# which compilers to use for C and C++
set (CMAKE_C_COMPILER       i686-w64-mingw32-gcc)
set (CMAKE_CXX_COMPILER     i686-w64-mingw32-g++)
set (CMAKE_RC_COMPILER      i686-w64-mingw32-windres)
set (CMAKE_AR               i686-w64-mingw32-ar)
set (CMAKE_RANLIB           i686-w64-mingw32-ranlib)

set (CMAKE_C_FLAGS "-s -O2"
    CACHE INTERNAL "c compiler flags")
set (CMAKE_CXX_FLAGS "-s -O2 -std=c++11 -D_WIN32_WINNT=0x600 -DBUILDING_LIBCURL -DCURL_STATICLIB"
    CACHE INTERNAL "cxx compiler flags")

set(CMAKE_RC_COMPILER_INIT i686-w64-mingw32-windres)
ENABLE_LANGUAGE(RC)
SET(CMAKE_RC_COMPILE_OBJECT
"<CMAKE_RC_COMPILER> <FLAGS> -O coff <DEFINES> -i <SOURCE> -o <OBJECT>")

# Linker flags
set (CMAKE_EXE_LINKER_FLAGS "-shared -static-libgcc -static-libstdc++ -Wl,-Bstatic"
    CACHE INTERNAL "exe linker flags")
set (CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS "")

# Include directories
include_directories ("../../include")
include_directories ("../../rapidjson/include")
include_directories ("../../spdlog/include")

add_subdirectory (../../src "${CMAKE_CURRENT_SOURCE_DIR}/src")

set (unit_src
    ../../src/aliveplugin.cpp
    ../../include/aliveplugin.rc
)

add_executable (ALiVEPlugIn.dll ${unit_src})

#target_link_libraries (ALiVEPlugIn.dll alive winpthread sigar.dll)
target_link_libraries (ALiVEPlugIn.dll alive winpthread)

INSTALL (TARGETS ALiVEPlugIn.dll DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/../)
