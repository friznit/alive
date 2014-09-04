#include <\x\alive\addons\mil_C2ISTAR\script_component.hpp>
SCRIPT(taskCreateMarker);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_taskCreateMarker

Description:
Create a local marker

Parameters:

Returns:

Examples:
(begin example)
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_position","_markerID","_type","_markers","_m"];

_position = _this select 0;
_markerID = _this select 1;
_markerColour = _this select 2;
_type = if(count _this > 3) then {_this select 3} else {0};

_markers = ["waypoint","mil_dot","mil_box","mil_triangle","mil_flag"];

_m = createMarkerLocal [_markerID, _position];
_m setMarkerShapeLocal "ICON";
_m setMarkerSizeLocal [.65, .65];
_m setMarkerTypeLocal (_markers select _type);
_m setMarkerColorLocal _markerColour;
_m setMarkerAlphaLocal 1;