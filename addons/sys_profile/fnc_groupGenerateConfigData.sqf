#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(groupGenerateConfigData);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_groupGenerateConfigData

Description:
Generates a config group hash to store path to config by group name

Parameters:

Returns:


Examples:
(begin example)
[] call ALIVE_fnc_groupGenerateConfigData;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_class"];

ALIVE_groupConfig = [] call ALIVE_fnc_hashCreate;

_findRecurse = {
	private ["_root","_class","_path","_currentPath","_className"];
	
	_root = (_this select 0);
	_path = +(_this select 1);
	
	for "_i" from 0 to count _root -1 do {
	
		_class = _root select _i;
		
		if (isClass _class) then {
			_currentPath = _path + [_i];
			_className = configName _class;
			
			if(count _currentPath == 4) then {
				[ALIVE_groupConfig, _className, _currentPath] call ALIVE_fnc_hashSet;
			};
			
			[_class, _currentPath] call _findRecurse;
		};
	};
};

_class = (configFile >> "CfgGroups");

[_class, []] call _findRecurse;