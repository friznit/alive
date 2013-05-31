#include <\x\alive\addons\fnc_analysis\script_component.hpp>
SCRIPT(getMapBounds);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_getMapSize

Description:
Get the world bounds of a given map

Parameters:
None

Returns:
Scalar Map Size

Examples:
(begin example)
// get bounds of map 
_size = [] call ALIVE_fnc_getMapBounds;
(end)

See Also:


Author:
ARJay
---------------------------------------------------------------------------- */

private ["_result"];

_result = getNumber(configFile >> "CfgWorlds" >> worldName >> "MapSize");
_err = format["get map bounds config entry not vaild - %1",_result];
ASSERT_TRUE(typeName _result == "SCALAR",_err);

_result;
