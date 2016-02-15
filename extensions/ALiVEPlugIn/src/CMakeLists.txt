# ALiVE Library
set (alive_src
    alive.cpp
    logger.cpp
)

include_directories ("../spdlog/include")

add_subdirectory (commands)

add_library (alive ${alive_src})
target_link_libraries (alive alive_cmd)

if (${PROJECT_NAME} STREQUAL "ALiVEPlugIn_Windows")
    set_target_properties (alive PROPERTIES
        "COMPILE_FLAGS" "-s -O2 -D_WIN32_WINNT=0x600"
        "LINK_FLAGS" "-s -O2 -std=c++11"
    )
else ()
    set_target_properties (alive PROPERTIES
        "COMPILE_FLAGS" "-O2 -m32 -fPIC -std=gnu++11"
        "LINK_FLAGS" "-O2 -m32 -shared"
    )
endif ()
