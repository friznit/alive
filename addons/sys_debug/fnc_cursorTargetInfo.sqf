#include <\x\alive\addons\sys_debug\script_component.hpp>
SCRIPT(cursorTargetInfo);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_cursorTargetInfo

Description:
Inspect an object under the cursor to the RPT

Parameters:

Returns:

Examples:
(begin example)
// inspect config class
[] call ALIVE_fnc_cursorTargetInfo;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

[] spawn 
{		
	private ["_hold", "_text", "_instanceName", "_name", "_typeOf"];

	_hold = 0;

	while {
		!(isNull cursorTarget) 
		&& (alive cursorTarget) 
		&& ((cursorTarget distance player) <= 200)
	} do {
		_instanceName = vehicleVarName cursorTarget;
		_typeOf = typeOf cursorTarget;
		_name = typeName cursorTarget;
		
		if(_name == "Error: No Unit") then {_name = "";};
		
		_text = format ["%1 | %3", _instanceName, _name, _typeOf];
				
		titleText [_text, "PLAIN", 0.3];
		sleep 1;
		titleFadeOut 0.3;
		
		if(((cursorTarget isKindOf "Man") || (cursorTarget isKindOf "StaticWeapon") || (cursorTarget isKindOf "Air") || (cursorTarget isKindOf "Car") || (cursorTarget isKindOf "Armored") || (cursorTarget isKindOf "Ship"))) then {
			if(_hold > 2) then {
				[cursorTarget] call ALIVE_fnc_inspectObject;
				_hold = 0;
			};
			
			_hold = _hold + 1;
		};
		
		if(cursorTarget isKindOf "House") then {
			if(_hold > 2) then {
				[cursorTarget] call ALIVE_fnc_inspectObject;
				[cursorTarget] call ALIVE_fnc_debugBuildingPositions;
				_hold = 0;
			};
			
			_hold = _hold + 1;				
		};
		
		sleep 1;
	};		
	sleep 1;
	
	[] call ALIVE_fnc_cursorTargetInfo;
};