#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(configGetRandomGroup);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_configGetRandomGroup

Description:
Get a group from the config files by group name

Parameters:
String - type Infantry,Motorized,Mechanized,Armored,Air
String - faction
String - side East,West,Guer,Civ

Returns:
String group name

Examples:
(begin example)
// get random group config group
_result = [] call ALIVE_fnc_configGetRandomGroup;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_type","_faction","_side","_factionConfig","_factionSide","_typeConfig","_groups","_class","_countUnits","_unit","_group","_groupName"];

_type = if(count _this > 0) then {_this select 0} else {"Infantry"};
_faction = if(count _this > 1) then {_this select 1} else {"OPF_F"};
_side = if(count _this > 2) then {_this select 2} else {"EAST"};

if!(_faction == "OPF_F") then {
	_factionConfig = (configFile >> "CfgFactionClasses" >> _faction);
	_factionSide = getNumber(_factionConfig >> "side");
	_side = _factionSide call ALIVE_fnc_sideNumberToText;
};

if(_side == "GUER") then {
	_side = "INDEP";
};

_typeConfig = (configFile >> "CfgGroups" >> _side >> _faction >> _type);
_groups = [];

for "_i" from 0 to count _typeConfig -1 do {
	_class = _typeConfig select _i;
		
	if (isClass _class) then {
	
		_countUnits = 0;
		for "_y" from 0 to count _class -1 do {
			_unit = _class select _y;
			
			if (isClass _unit) then {
				_countUnits = _countUnits + 1;
			};
		};
		
		if(_countUnits > 0) then {
			_groups set [count _groups, _class];
		};		
	};
};

if(count _groups > 0) then {
	_group = _groups select floor(random count _groups);
	_groupName = configName _group;
}else{
	_groupName = "FALSE";
};

_groupName