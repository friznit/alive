#include <\x\alive\addons\x_lib\script_component.hpp>
SCRIPT(updateBuildingGrid);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_updateBuildingGrid
Description:
Updates hostility state of given grid-sectors

Parameters:
array - grid (created with ALIVE_fnc_createBuildingGrid)

Returns:
array - grid

Examples:
(begin example)
	_grid call ALIVE_fnc_updateBuildingGrid;
(end)

See Also:
- <ALIVE_fnc_createBuildingGrid>

Author:
Highhead

Peer Reviewed:
nil
---------------------------------------------------------------------------- */

private ["_players","_grid"];

_grid = _this;
_players = [] call BIS_fnc_listPlayers;

{
    private ["_pos","_gridPos","_markerID","_side"];
    
    _pos = getposATL _x;
    
    If ((_pos select 2) < 2) then {
    	_gridPos = _pos call ALiVE_fnc_GridPos;
        _markerID = format["ALiVE_BuildGrid_%1%2",_gridpos select 0,_gridPos select 1];
        _nearEnemy = [_gridPos, str(side _x), 75] call ALiVE_fnc_isEnemyNear;

        {
            if (_markerID == _x) exitwith {
	        	if (_nearEnemy) then {
					[_markerID,_gridPos,"RECTANGLE",[50,50],"COLORRED","","EMPTY","FDiagonal",0,0.5] call ALIVE_fnc_createMarker;
	        	} else {
					[_markerID,_gridPos,"RECTANGLE",[50,50],"COLORGREEN","","EMPTY","FDiagonal",0,0.5] call ALIVE_fnc_createMarker;
	            };
            };
        } foreach _grid;
    };
} foreach _players;

_grid;
