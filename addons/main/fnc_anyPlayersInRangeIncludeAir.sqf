#include <\x\alive\addons\main\script_component.hpp>
SCRIPT(anyPlayersInRangeIncludeAir);

/* ----------------------------------------------------------------------------
Function: ALiVE_fnc_anyPlayersInRangeIncludeAir

Description:
Return the number of players within range of a position, including any players in planes or helicopters

Parameters:
Array - Position measuring from
Number - Distance being measured (optional)
Bool - Include Jets
Number - Jet spawn distance
Bool - Include Helicopter
Number - Helicopter spawn distance

Returns:
Number - Returns number of players within range

Examples:
(begin example)
// No players in range
([_pos, 2500, true, 3500, true 2500] call ALiVE_fnc_anyPlayersInRangeIncludeAir == 0)
(end)

Author:
ARJay

Peer Reviewed:
---------------------------------------------------------------------------- */

private ["_pos","_dist","_includeJets","_jetSpawnDistance","_includeHelicopters","_helicopterSpawnDistance","_players","_player","_position","_anyInRange",
"_vehicleClass","_vehicleKind","_vehicle","_isHelicopter","_isJet","_normalSpawn"];
PARAMS_1(_pos);
DEFAULT_PARAM(1,_dist,2500);
DEFAULT_PARAM(2,_includeJets,false);
DEFAULT_PARAM(3,_jetSpawnDistance,2500);
DEFAULT_PARAM(4,_includeHelicopters,true);
DEFAULT_PARAM(5,_helicopterSpawnDistance,2500);

_players = [] call BIS_fnc_listPlayers;
_anyInRange = false;
_isHelicopter = false;
_isJet = false;

scopeName "main";

{
	_player = _x;
	_vehicle = vehicle _player;
	_position = getPos _player;

	// air check
    if!(_vehicle == _player) then {

        _vehicleClass = typeOf _vehicle;
        _vehicleKind = _vehicleClass call ALIVE_fnc_vehicleGetKindOf;

        _normalSpawn = true;

        if(_vehicleKind == "Helicopter") then {
            _isHelicopter = true;
        };

        if(_vehicleKind == "Plane") then {
            _isJet = true;
        };

        // spawn in helicopter check
        if(_includeHelicopters) then {
            if(_isHelicopter) then {
                if((getPos _player) distance _pos < _helicopterSpawnDistance) then {
                    _anyInRange = true;
                    breakTo "main";
                };
            };
        };

        // disabled spawn in helicopter check
        if(!(_includeHelicopters) && _isHelicopter) then {
            _normalSpawn = false;
        };

        // jet check
        if(_includeJets) then {
            if(_isJet) then {
                if((getPos _player) distance _pos < _jetSpawnDistance) then {
                    _anyInRange = true;
                    breakTo "main";
                };
            };
        };

        // disabled spawn in jet check
        if(!(_includeJets) && _isJet) then {
            _normalSpawn = false;
        };

        // normal player
        if(_normalSpawn) then {
            if(_position distance _pos < _dist) then {
                _anyInRange = true;
                breakTo "main";
            };
        };
    }else{

        // normal player
        if(_position distance _pos < _dist) then {
            _anyInRange = true;
            breakTo "main";
        };
    };
} forEach _players;

_anyInRange
