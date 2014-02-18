#include <\x\alive\addons\main\script_component.hpp>
SCRIPT(anyPlayersInRangeIncludeAir);

/* ----------------------------------------------------------------------------
Function: ALiVE_fnc_anyPlayersInRangeIncludeAir

Description:
Return if any players are within range of a position, including any players in planes or helicopters

Parameters:
Array - Position measuring from
Number - Distance being measured (optional)
Bool - Include Jets
Number - Jet spawn distance
Bool - Include Helicopter
Number - Helicopter spawn distance

Returns:
Boolean - Returns if players within range

Examples:
(begin example)
// No players in range
([_pos, 2500, 3500, 2500] call ALiVE_fnc_anyPlayersInRangeIncludeAir == false)
(end)

Author:
ARJay

Peer Reviewed:
---------------------------------------------------------------------------- */

private ["_position","_spawnDistance","_jetSpawnDistance","_helicopterSpawnDistance","_players","_player","_position","_anyInRange"];
PARAMS_1(_position);
DEFAULT_PARAM(1,_spawnDistance,1500);
DEFAULT_PARAM(2,_jetSpawnDistance,0);
DEFAULT_PARAM(3,_helicopterSpawnDistance,1500);

_players = [] call BIS_fnc_listPlayers;
_anyInRange = false;

scopeName "main";

{
    if(
        (!(vehicle _x isKindOf "Plane") && {!(vehicle _x isKindOf "Helicopter")} && {(_x distance _position < _spawnDistance)}) ||
        ({(vehicle _x isKindOf "Plane") && {(_x distance _position < _jetSpawnDistance)}}) ||
        ({(vehicle _x isKindOf "Helicopter") && {(_x distance _position < _helicopterSpawnDistance)}})
    ) then {
        _anyInRange = true;
        breakTo "main";
    };

} forEach _players;

/*
if!(_anyInRange) then {
    ["NONE IN RANGE"] call ALIVE_fnc_dump;
    if!(isNil "ALIVE_curatorPositions") then {
        ["CURATOR POSITIONS EXISTS"] call ALIVE_fnc_dump;
        if(count (ALIVE_curatorPositions select 2) > 0) then {
            ["COUNT CURATOR POSITIONS: %1",count (ALIVE_curatorPositions select 2)] call ALIVE_fnc_dump;
            {
                ["DISTANCE: %1",_position distance _x] call ALIVE_fnc_dump;
                if(_position distance _x < _spawnDistance) then {
                    _anyInRange = true;
                };
            } forEach (ALIVE_curatorPositions select 2);
        };
    };
};
*/

_anyInRange