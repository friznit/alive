#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(profileGetAnyLinkedInRange);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_vehicleAssignmentsGetLinkedProfiles

Description:
Check entities and vehicles via vehicle assignment linkages and return if any are within range

Parameters:
Vehicle - The vehicle

Returns:
Array - Hash of profiles linked via vehicle assignments

Examples:
(begin example)
// return a count of vehicles within range
_result = [_vehicle] call ALIVE_fnc_profileGetAnyLinkedInRange;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_profile","_spawnDistance","_result","_profiles","_position"];

_profile = _this select 0;
_spawnDistance = _this select 1;

_result = 0;
scopeName "MAIN";

_profiles = [_profile] call ALIVE_fnc_vehicleAssignmentsGetLinkedProfiles;

{
    _position = getposATL (_x select 2 select 10);
    if(([_position, _spawnDistance] call ALiVE_fnc_anyPlayersInRange > 0) || ([_position, _spawnDistance] call ALiVE_fnc_anyAutonomousInRange > 0)) then {
        _result = _result + 1;
        breakTo "MAIN";
    };
} forEach (_profiles select 2);
//[] call ALIVE_fnc_timer;



/*
["LOOPED"] call ALIVE_fnc_dump;
[true] call ALIVE_fnc_timer;

private ["_profileType","_entitiesInCommandOf","_entitiesInCargoOf","_linked","_vehiclesInCommandOf","_vehiclesInCargoOf",
"_subProfile","_sublinked","_subSubProfile","_subSublinked","_outOfRange","_linkedProfile","_profilePosition"];

_result = 0;

_profileType = _profile select 2 select 5;

if(_profileType == "vehicle") then {
    _entitiesInCommandOf = [_profile,"entitiesInCommandOf",[]] call ALiVE_fnc_HashGet;
    _entitiesInCargoOf = [_profile,"entitiesInCargoOf",[]] call ALiVE_fnc_HashGet;

    _linked = _entitiesInCommandOf + _entitiesInCargoOf;

}else{
    _vehiclesInCommandOf = [_profile,"vehiclesInCommandOf",[]] call ALiVE_fnc_HashGet;
    _vehiclesInCargoOf = [_profile,"vehiclesInCargoOf",[]] call ALiVE_fnc_HashGet;

    _linked = _vehiclesInCommandOf + _vehiclesInCargoOf;
};


if (count _linked > 0) then {


    {
        _subProfile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;

        if !(isnil "_subProfile") then {
            _profileType = _subProfile select 2 select 5;

            if(_profileType == "vehicle") then {
                _entitiesInCommandOf = [_subProfile,"entitiesInCommandOf",[]] call ALiVE_fnc_HashGet;
                _entitiesInCargoOf = [_subProfile,"entitiesInCargoOf",[]] call ALiVE_fnc_HashGet;

                _sublinked = _entitiesInCommandOf + _entitiesInCargoOf;
            }else{
                _vehiclesInCommandOf = [_subProfile,"vehiclesInCommandOf",[]] call ALiVE_fnc_HashGet;
                _vehiclesInCargoOf = [_subProfile,"vehiclesInCargoOf",[]] call ALiVE_fnc_HashGet;

                _sublinked = _vehiclesInCommandOf + _vehiclesInCargoOf;
            };
        };
    } foreach _linked;



    {
        _subSubProfile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
        if !(isnil "_subSubProfile") then {
            _profileType = _subSubProfile select 2 select 5;

            if(_profileType == "vehicle") then {
                _entitiesInCommandOf = [_subSubProfile,"entitiesInCommandOf",[]] call ALiVE_fnc_HashGet;
                _entitiesInCargoOf = [_subSubProfile,"entitiesInCargoOf",[]] call ALiVE_fnc_HashGet;

                _subSublinked = _entitiesInCommandOf + _entitiesInCargoOf;
            }else{
                _vehiclesInCommandOf = [_subSubProfile,"vehiclesInCommandOf",[]] call ALiVE_fnc_HashGet;
                _vehiclesInCargoOf = [_subSubProfile,"vehiclesInCargoOf",[]] call ALiVE_fnc_HashGet;

                _subSublinked = _vehiclesInCommandOf + _vehiclesInCargoOf;
            };
        };
    } foreach _sublinked;

    _linked = _linked + _sublinked + _subSublinked;



    _outOfRange = {
        _linkedProfile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
        _profilePosition = getposATL (_linkedProfile select 2 select 10);
        !([_profilePosition, _spawnDistance] call ALiVE_fnc_anyPlayersInRange == 0)
    } count _linked;

    if (_outOfRange > 0) then {
        _result = _result + 1;
    };
};


["RES: %1",_result] call ALIVE_fnc_dump;

[] call ALIVE_fnc_timer;
*/

_result