#include <\x\alive\addons\main\script_component.hpp>
SCRIPT(getDominantFaction);

/* ----------------------------------------------------------------------------
Function: ALiVE_fnc_getDominantFaction

Description:
Returns the dominant faction within given radius, Takes into account profiles

Parameters:
Array - Position measuring from
Number - Distance being measured (optional)

Returns:
Number - Faction ConfigName ("BLU_F","OPF_F",etc.)

Examples:
(begin example)
[getposATL player, 500] call ALiVE_fnc_getDominantFaction
(end)

Author:
Highhead
---------------------------------------------------------------------------- */

private ["_pos","_radius","_faction","_factions","_profiles","_side","_result","_countGroups","_countProfiles"];

PARAMS_1(_pos);
DEFAULT_PARAM(1,_radius,500);

_factions = (configfile >> "CfgFactionClasses");
_countGroups = 0;
_countProfiles = 0;

//Virtual Profiles activated?
if !(isnil "ALIVE_profileHandler") then {
	_profiles = [ALIVE_profileHandler, "profiles"] call ALIVE_fnc_hashGet;
} else {
    _profiles = [[],[],[]];
};

//Start Counting
_result = [];
for "_i" from 1 to ((count _factions)-1) do //access 0 has no side therfore start from 1
{
    _faction = configName(_factions select _i);
    _side = getNumber(_factions select _i >> "side");
    
    //Get faction from Config classes
    if (_side <= 3) then {
        
        //Count troops
        _countGroups = {(_pos distance (getposATL (leader _x)) < _radius) && {{isPlayer _x} count (units _x) < 1} && {toLower(faction leader _x) == toLower(_faction)}} count allgroups;
		_countProfiles = {((_x select 2 select 5) == "entity") && {(_x select 2 select 2) distance _pos < _radius} && {tolower(_x select 2 select 29) == tolower(_faction)}} count (_profiles select 2);
        
        _result set [count _result,[_faction,_countGroups + _countProfiles]];
    };
};
//Sort Faction by count
_result = [_result,[],{_x select 1},"DESCEND"] call BIS_fnc_sortBy;

if ((count _result > 0) && {(_result select 0 select 1) > 0}) then {
	(_result select 0) select 0;
} else {nil};