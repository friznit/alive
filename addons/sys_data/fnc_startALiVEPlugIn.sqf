#include "script_component.hpp"
SCRIPT(startALiVEPlugIn);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_startALiVEPlugIn

Description:
Starts the plugin and returns debug output

Parameters:
None

Returns:
String - Returns startup info

Examples:
(begin example)
 _group = [] call ALIVE_fnc_startALiVEPlugIn
(end)

Author:
Tupolov
Peer Reviewed:

---------------------------------------------------------------------------- */
private ["_response"];

_response = ["StartALiVE"] call ALIVE_fnc_sendToPlugIn;

_response;