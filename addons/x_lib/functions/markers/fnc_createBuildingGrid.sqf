#include <\x\alive\addons\x_lib\script_component.hpp>
SCRIPT(createBuildingGrid);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_createBuildingGrid
Description:
Marks all grid-sectors with buildings within the given radius of a position

Parameters:
array - position
number - radius

Returns:
array - grid

Examples:
(begin example)
            [
				getpos player,
                500
            ] call ALIVE_fnc_createBuildingGrid;
(end)

See Also:
- <ALIVE_fnc_updateBuildingGrid>

Author:
Highhead

Peer Reviewed:
nil
---------------------------------------------------------------------------- */

private ["_pos","_radius","_houses","_grid"];

_pos = _this select 0;
_radius = _this select 1;
_grid = [];
_fill = if (count _this > 2) then {_this select 2} else {"Solid"};

_houses = [_pos,_radius] call ALiVE_fnc_getEnterableHouses;

{
    private ["_gridPos","_markerID"];

    _gridPos = (getposATL _x) call ALiVE_fnc_GridPos;
    _markerID = format["ALiVE_BuildGrid_%1%2",_gridpos select 0,_gridPos select 1];

    if !(_markerID in _grid) then {
        [_markerID,_gridPos,"RECTANGLE", [50,50],"COLORRED","", "EMPTY", _fill,0,0.5 ] call ALIVE_fnc_createMarkerGlobal;
        _grid pushBack _markerID;
    };
} foreach _houses;

_grid