#include "script_component.hpp"
SCRIPT(getGroupID);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_getGroupID

Description:
Gets the group ID set in the alive.cfg file

Parameters:
None

Returns:
String - Returns the group name/id

Examples:
(begin example)
 _group = [] call ALIVE_fnc_getGroupID
(end)

Author:
Tupolov
Peer Reviewed:

---------------------------------------------------------------------------- */
private ["_response"];

_response = ["GroupName"] call ALIVE_fnc_sendToPlugIn;

_response;