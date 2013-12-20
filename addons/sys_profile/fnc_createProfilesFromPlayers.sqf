#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(createProfilesFromPlayers);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_createProfilesFromPlayers

Description:
Create profiles for all players on the map that don't have profiles

Parameters:

Returns:

Examples:
(begin example)
// get profiles from all players
[] call ALIVE_fnc_createProfilesFromPlayers;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_debug","_players","_entityCount","_group","_leader","_units","_unitClasses","_positions","_ranks",
"_damages","_unitCount","_profileID","_unit","_eventID","_profileID","_position","_side"];

_debug = if(count _this > 0) then {_this select 0} else {false};

_players = [];
_entityCount = 0;

if (isMultiplayer) then {
	_players = playableUnits;
} else {
    _players = [player];
};

// DEBUG -------------------------------------------------------------------------------------
if(_debug) then {
	["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
	["ALIVE Remove existing profiles with no players"] call ALIVE_fnc_dump;
	[true] call ALIVE_fnc_timer;
};
// DEBUG -------------------------------------------------------------------------------------

_playerProfiles = [ALIVE_profileHandler, "getPlayerEntities"] call ALIVE_fnc_profileHandler;
_countRemoved = 0;

if(count (_playerProfiles select 1) > 0) then {
    {
        _profile = _x;
        _units = _profile select 2 select 21;
        _countPlayers = 0;
        {
            _unit = _x;
            if!(isNull _unit) then {
                if(isPlayer _unit) then {
                    _countPlayers = _countPlayers + 1;
                };
            };
        } forEach _units;

        if(_countPlayers == 0) then {
            [ALIVE_profileHandler, "unregisterProfile", _profile] call ALIVE_fnc_profileHandler;
            _countRemoved = _countRemoved + 1;
        }else{
            _entityCount = _entityCount + 1;
        };

    } forEach (_playerProfiles select 2);
};

// DEBUG -------------------------------------------------------------------------------------
if(_debug) then {
    [] call ALIVE_fnc_timer;
    ["ALIVE Removed %1 player profiles",_countRemoved] call ALIVE_fnc_dump;
	["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
	["ALIVE Create profiles from players"] call ALIVE_fnc_dump;
	[true] call ALIVE_fnc_timer;
};
// DEBUG -------------------------------------------------------------------------------------

{
	_group = group _x;
	_leader = leader _group;
	_units = units _group;

	if(_leader getVariable ["profileID",""] == "") then {

		_unitClasses = [];
		_positions = [];
		_ranks = [];
		_damages = [];
        _unitCount = 0;
        _profileID = format["player_%1",_entityCount];

        {
            _unit = _x;
            _unitClasses set [count _unitClasses, typeOf _x];
            _positions set [count _positions, getPosATL _x];
            _ranks set [count _ranks, rank _x];
            _damages set [count _damages, getDammage _x];

            // set profile id on the unit
            _unit setVariable ["profileID", _profileID];
            _unit setVariable ["profileIndex", _unitCount];

            // killed event handler
            if!(isPlayer _unit) then {
                _eventID = _unit addEventHandler["Killed", ALIVE_fnc_profileKilledEventHandler];
            };

            _unitCount = _unitCount + 1;

        } foreach (_units);

        _position = getPosATL _leader;
        _side = str(side _leader);

        _profileEntity = [nil, "create"] call ALIVE_fnc_profileEntity;
        [_profileEntity, "init"] call ALIVE_fnc_profileEntity;
        [_profileEntity, "profileID", _profileID] call ALIVE_fnc_profileEntity;
        [_profileEntity, "unitClasses", _unitClasses] call ALIVE_fnc_profileEntity;
        [_profileEntity, "position", _position] call ALIVE_fnc_profileEntity;
        [_profileEntity, "despawnPosition", _position] call ALIVE_fnc_profileEntity;
        [_profileEntity, "positions", _positions] call ALIVE_fnc_profileEntity;
        [_profileEntity, "damages", _damages] call ALIVE_fnc_profileEntity;
        [_profileEntity, "ranks", _ranks] call ALIVE_fnc_profileEntity;
        [_profileEntity, "side", _side] call ALIVE_fnc_profileEntity;
        [_profileEntity, "faction", faction _leader] call ALIVE_fnc_profileEntity;
        [_profileEntity, "isPlayer", true] call ALIVE_fnc_profileEntity;
        [_profileEntity, "leader", _leader] call ALIVE_fnc_hashSet;
        [_profileEntity, "group", _group] call ALIVE_fnc_hashSet;
        [_profileEntity, "units", _units] call ALIVE_fnc_hashSet;
        [_profileEntity, "active", true] call ALIVE_fnc_hashSet;

        [ALIVE_profileHandler, "registerProfile", _profileEntity] call ALIVE_fnc_profileHandler;

        _entityCount = _entityCount + 1;
	
	};
	
} forEach _players;

[ALIVE_profileHandler, "debug", true] call ALIVE_fnc_profileHandler;

// DEBUG -------------------------------------------------------------------------------------
if(_debug) then {
	["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
	["ALIVE Create profiles from players Complete - entity profiles created: [%1]",_entityCount] call ALIVE_fnc_dump;
	[] call ALIVE_fnc_timer;
};
// DEBUG -------------------------------------------------------------------------------------