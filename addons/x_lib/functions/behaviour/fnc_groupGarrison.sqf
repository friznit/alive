#include <\x\alive\addons\x_lib\script_component.hpp>
SCRIPT(groupGarrison);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_groupGarrison

Description:
Garrisons units in defensible structures and static weapons

Parameters:
Group - group
Scalar - radius
Boolean - move to position instantly (no animation)

Returns:


Examples:
(begin example)
[_group,_position,200,true] call ALIVE_fnc_groupGarrison;
(end)

See Also:

Author:
ARJay, Highhead
---------------------------------------------------------------------------- */

private ["_group","_radius","_moveInstantly","_units","_leader","_units"];

_group = _this select 0;
_position = _this select 1;
_radius = _this select 2;
_moveInstantly = _this select 3;

_units = units _group;
_leader = leader (group (_units select 0));
_units = _units - [_leader];

if (count _units == 0) exitwith {};

// load static data
if(isNil "ALiVE_STATIC_DATA_LOADED") then {
    _file = "\x\alive\addons\main\static\staticData.sqf";
    call compile preprocessFileLineNumbers _file;
};

if(!_moveInstantly) then {
    _group setCombatMode "RED";
};

private ["_staticWeapons","_weapon","_positionCount","_unit"];

_staticWeapons = nearestObjects [_position, ["StaticWeapon"], _radius];

if(count _staticWeapons > 0) then
{
    {
        _weapon = _x;

        _positionCount = [_weapon] call ALIVE_fnc_vehicleCountEmptyPositions;

        _unit = _units select (count _units - _foreachIndex - 1);

        if(_positionCount > 0) then
        {
            if(_moveInstantly) then {

                _unit assignAsGunner _weapon;
                _unit moveInGunner _weapon;

            }else{

                _unit assignAsGunner _weapon;
                [_unit] orderGetIn true;

            };

        };

        _units = _units - [_unit];

    } forEach _staticWeapons;
};

if (count _units == 0) exitwith {};

private ["_buildings","_building","_class","_buildingPositions"];

_buildings = nearestObjects [_position,ALIVE_garrisonPositions select 1,_radius];

if(count _buildings > 0) then {
    {
        _building = _x;
        _class = typeOf _building;

        _buildingPositions = [ALIVE_garrisonPositions,_class] call ALIVE_fnc_hashGet;

        {
            if (_foreachIndex > ((count _units)-1)) exitwith {};

            _unit = _units select (count _units - _foreachIndex - 1);

            if(_moveInstantly) then {
                _unit setposATL (_building buildingpos _x);
                _unit setdir (([_unit,_building] call BIS_fnc_DirTo)-180);
                _unit setUnitPos "UP";
                _unit disableAI "MOVE";
                sleep 0.03;
            }else{
                doStop _unit;
                _unit doMove (_building buildingpos _x);
            };

            _units = _units - [_unit];

        } foreach _buildingPositions;


    } forEach _buildings;

}else{

    _buildings = [_position, _radius] call ALIVE_fnc_getEnterableHouses;

    {
        _building = _x;

        _buildingPositions = [_building] call ALIVE_fnc_getBuildingPositions;

        {
            if (_foreachIndex > ((count _units)-1)) exitwith {};

            _unit = _units select (count _units - _foreachIndex - 1);

            if(_moveInstantly) then {
                _unit setposATL (_building buildingpos _x);
                _unit setdir (([_unit,_building] call BIS_fnc_DirTo)-180);
                _unit setUnitPos "UP";
                _unit disableAI "MOVE";
                sleep 0.03;
            }else{
                doStop _unit;
                _unit doMove _x;
            };

            _units = _units - [_unit];

        } foreach _buildingPositions;

    } forEach _buildings;

};


