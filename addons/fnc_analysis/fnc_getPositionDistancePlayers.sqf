#include <\x\alive\addons\fnc_analysis\script_component.hpp>
SCRIPT(getPositionDistancePlayers);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_getPositionDistancePlayers

Description:
Get closest position with no players present

Parameters:
Array - Position center point for search
Scalar - Max Radius of search

Returns:
Array - position

Examples:
(begin example)
// get closest position with no players present
_position = [getPos player] call ALIVE_fnc_getPositionDistancePlayers;
(end)

See Also:


Author:
ARJay
---------------------------------------------------------------------------- */

private ["_position","_distance","_result","_err", "_sector"];
	
_position = _this select 0;
_distance = _this select 1;

_err = format["get closest inactive requires a position array - %1",_position];
ASSERT_TRUE(typeName _position == "ARRAY",_err);
//_err = format["get closest sea requires a radius scalar - %1",_radius];
//ASSERT_TRUE(typeName _radius == "SCALAR",_err);

_sectors = [ALIVE_sectorGrid, "sectors"] call ALIVE_fnc_sectorGrid;
_sectors = [_sectors,_position] call ALIVE_fnc_sectorSortDistance;

scopeName "main";

{
    _sector = _x;
    _center = [_sector, "center"] call ALIVE_fnc_sector;
    _playersInRange = [_center, _distance] call ALiVE_fnc_anyPlayersInRange;

    if(_playersInRange == 0) then {

        _position = _center;
        breakTo "main";
    };
} forEach _sectors;

_result = _position;
//[_result] call ALIVE_fnc_placeDebugMarker;
_result