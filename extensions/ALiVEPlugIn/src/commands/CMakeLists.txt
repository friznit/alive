# ALiVE Library
set (alive_cmd_src
    cmdDateTime.cpp
    cmdGetBulkJSON.cpp
    cmdSendBulkJSON.cpp
    cmdSendJSON.cpp
    cmdSendJSONAsync.cpp
    cmdServerAddress.cpp
    cmdServerName.cpp
    cmdStartALiVE.cpp
)

add_library (alive_cmd ${alive_cmd_src})

if (${PROJECT_NAME} STREQUAL "ALiVEPlugIn_Windows")
    set_target_properties (alive_cmd PROPERTIES
        "COMPILE_FLAGS" "-s -O2 -D_WIN32_WINNT=0x600"
        "LINK_FLAGS" "-s -O2 -std=c++11"
    )
    target_link_libraries (alive_cmd curl ssh2 ssl crypto z ws2_32 gdi32 wldap32 idn iconv intl)
else ()
    set_target_properties (alive_cmd PROPERTIES
        "COMPILE_FLAGS" "-O2 -m32 -fPIC -std=gnu++11"
        "LINK_FLAGS" "-O2 -m32 -shared"
    )
    target_link_libraries (alive_cmd curl)
endif ()
