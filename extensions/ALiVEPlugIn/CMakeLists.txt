cmake_minimum_required (VERSION 2.6)
project (ALiVEPlugIn)

# which compilers to use for C and C++
set (CMAKE_C_COMPILER       clang)
set (CMAKE_CXX_COMPILER     clang++)

# Include directories
include_directories ("include")
include_directories ("rapidjson/include")
include_directories ("sigar/include")
include_directories ("spdlog/include")

# Add src directory 
add_subdirectory (src)

# Executable
add_executable (aliveplugin.so ./src/aliveplugin.cpp)
target_link_libraries (aliveplugin.so alive sigar-x86-linux)

set_target_properties (aliveplugin.so PROPERTIES
    "COMPILE_FLAGS" "-O2 -m32 -fPIC -std=gnu++11"
    "LINK_FLAGS" "-s -O2 -m32 -shared -static-libgcc -static-libstdc++"
)

####################
### UNIT TESTING ###
####################

# We need thread support
find_package (Threads REQUIRED)

# Enable ExternalProject CMake module
include (ExternalProject)

# Download and install GoogleTest
ExternalProject_Add (
    gtest
    URL https://googletest.googlecode.com/files/gtest-1.7.0.zip
    PREFIX ${CMAKE_CURRENT_BINARY_DIR}/gtest
    # Disable install step
    INSTALL_COMMAND ""
)

# Create a libgtest target to be used as a dependency by test programs
add_library (libgtest IMPORTED STATIC GLOBAL)
add_dependencies (libgtest gtest)

# Set gtest properties
ExternalProject_Get_Property (gtest source_dir binary_dir)
    set_target_properties (libgtest PROPERTIES
    "IMPORTED_LOCATION" "${binary_dir}/libgtest.a"
    "IMPORTED_LINK_INTERFACE_LIBRARIES" "${CMAKE_THREAD_LIBS_INIT}"
)
include_directories ("${source_dir}/include")

# Download and install GoogleMock
ExternalProject_Add (
    gmock
    URL https://googlemock.googlecode.com/files/gmock-1.7.0.zip
    PREFIX ${CMAKE_CURRENT_BINARY_DIR}/gmock
    # Disable install step
    INSTALL_COMMAND ""
)

# Create a libgmock target to be used as a dependency by test programs
add_library (libgmock IMPORTED STATIC GLOBAL)
add_dependencies (libgmock gmock)

# Set gmock properties
ExternalProject_Get_Property (gmock source_dir binary_dir)
    set_target_properties (libgmock PROPERTIES
    "IMPORTED_LOCATION" "${binary_dir}/libgmock.a"
    "IMPORTED_LINK_INTERFACE_LIBRARIES" "${CMAKE_THREAD_LIBS_INIT}"
)
include_directories ("${source_dir}/include")
        
set (unit_src
    ./src/alltests.cpp
    ./src/alive.cpp
    ./src/alive_test.cpp
    ./src/aliveplugin.cpp
    ./src/aliveplugin_test.cpp
    ./src/commands/cmdDateTime.cpp
    ./src/commands/cmdGetBulkJSON.cpp
    ./src/commands/cmdSendBulkJSON.cpp
    ./src/commands/cmdSendJSON.cpp
    ./src/commands/cmdSendJSONAsync.cpp
    ./src/commands/cmdServerAddress.cpp
    ./src/commands/cmdServerName.cpp
    ./src/commands/cmdStartALiVE.cpp
    ./src/logger.cpp
)

add_executable (aliveTest ${unit_src})
target_link_libraries (aliveTest libgtest libgmock curl uuid sigar-amd64-linux)

set_target_properties (aliveTest PROPERTIES
    "COMPILE_FLAGS" "-ccc-gcc-name g++ -std=gnu++11 -g"
    "LINK_FLAGS" "-ccc-gcc-name g++ -target x86 -g"
)

# Additional clean file(s)
set_directory_properties (PROPERTY ADDITIONAL_MAKE_CLEAN_FILES "ALiVEPlugIn.dll")

ExternalProject_Add (ALiVEPlugIn_Windows
    SOURCE_DIR .windows/
)
ExternalProject_Add_Step (ALiVEPlugIn_Windows forceconfigure
    COMMAND ${CMAKE_COMMAND} -E echo "Force configure of ALiVEPlugIn_Windows"
    DEPENDEES update
    DEPENDERS configure
    ALWAYS 1
)
