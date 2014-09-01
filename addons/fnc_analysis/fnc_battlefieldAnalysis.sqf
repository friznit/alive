#include <\x\alive\addons\fnc_analysis\script_component.hpp>
SCRIPT(battlefieldAnalysis);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_battlefieldAnalysis

Description:
Analyse the current battlefied state

Parameters:
Array - Position center point for search
Scalar - Max Radius of search

Returns:
Array - hash of battlefield analysis results

Examples:
(begin example)
// run battlefield analysis around player
_result = [getPos player,1000] call ALIVE_fnc_battlefieldAnalysis;
(end)

See Also:


Author:
ARJay
---------------------------------------------------------------------------- */

private ["_position","_distance","_result","_err","_sectors","_sector","_center","_playersInRange"];
	
_position = _this select 0;
_radius = _this select 1;

_err = format["get closest inactive requires a position array - %1",_position];
ASSERT_TRUE(typeName _position == "ARRAY",_err);
_err = format["get closest sea requires a radius scalar - %1",_radius];
ASSERT_TRUE(typeName _radius == "SCALAR",_err);
