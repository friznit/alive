#include <\x\alive\addons\mil_strategic\script_component.hpp>
SCRIPT(validateLocations);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_validateLocations
Description:
Ensure locations are in or out of a markers area

Parameters:
array - The markers defining the perimeter
Array - An array of objects to validate
Bool - Return if inside or outside of defined marker (true if inside)

Returns:
Array - An array of objects meeting the requirements

Examples:
(begin example)
_obj_array = ["areaOfOperation", _obj_array, true] call ALIVE_fnc_validateLocations;
(end)

See Also:
- <ALIVE_fnc_SEP>

Author:
Wolffy.au
Peer Reviewed:
nil
---------------------------------------------------------------------------- */

private ["_markers","_marker","_obj_array","_result","_marker","_insideOnly"];
PARAMS_3(_markers,_obj_array,_insideOnly);

_result = _obj_array;

{
	_marker = _x;
	if(_marker != "") then {
		if(!(_marker call ALIVE_fnc_markerExists)) then {
			[format["Validate locations marker (""%1"") does not exist",_marker]] call BIS_fnc_errorMsg;
		} else {
			_marker setMarkerAlpha 0;
			_result = [];
			{
				private["_in"];
				_in =[_marker, _x] call BIS_fnc_inTrigger;
				if((!_insideOnly || _in) && !(!_insideOnly && _in)) then {
					_result set [count _result, _x];
				};
			} forEach _obj_array;
		};
	};
} forEach _markers;

_result;
