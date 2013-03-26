#include <\x\alive\addons\main\script_component.hpp>
SCRIPT(getAllEnterableHouses);

/* ----------------------------------------------------------------------------
Function: MSO_fnc_getAllEnterableHouses

Description:
Returns an array of all enterable Houses on the map

Returns:
Array - List of all enterable houses across the map

Examples:
(begin example)
// get array of all enterable houses across the map
_spawnhouses = call MSO_fnc_getAllEnterableHouses;
(end)

See Also:
- <MSO_fnc_getObjectsByType>
- <MSO_fnc_getMaxBuildingPositions>
- <MSO_fnc_getEnterableHouses>

Author:
Wolffy.au
---------------------------------------------------------------------------- */

private ["_center","_allhouses"];

ISNILS(GVAR(getAllEnterableHouses),[]);
_allhouses = GVAR(getAllEnterableHouses);

if(count _allhouses == 0) then {
	_center = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");
	_allhouses = [_center, ((_center select 0) min (_center select 1))*2] call ALIVE_fnc_getEnterableHouses;
	
	GVAR(getAllEnterableHouses) = _allhouses;
};

_allhouses;
