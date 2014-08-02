#include <\x\alive\addons\sup_player_resupply\script_component.hpp>
SCRIPT(sortCFGVehiclesByClass);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_sortCFGVehiclesByClass

Description:
Sorts CFGVehicles into a hash categorised by vehicleClass

Parameters:

STRING - side to filter by

Returns:
Array - hash of categorised vehicles

Examples:
(begin example)
//
_result = [] call ALIVE_fnc_sortCFGVehiclesByClass;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_configPath","_sideNumber","_sortedVehicles","_item","_configName","_vehicleClass","_scope","_subSorted"];

_side = _this select 0;

_sideNumber = [_side] call ALIVE_fnc_sideTextToNumber;

_configPath = configFile >> "CFGVehicles";
_sortedVehicles = [] call ALIVE_fnc_hashCreate;

for "_i" from 0 to ((count _configPath) - 1) do
{

    private ["_item","_configName","_name"];

    _item = _configPath select _i;

    if (isClass _item) then {

        _configName = configName _item;
        _vehicleClass = getText(_item >> "vehicleClass");
        _scope = getNumber(_item >> "scope");
        _side = getNumber(_item >> "side");

        if(_scope == 2 && (_side == _sideNumber || _side == 3)) then {

            if(isNil "_vehicleClass") then {
                _vehicleClass = "Unknown";
            };

            if!(_vehicleClass in (_sortedVehicles select 1)) then {
                [_sortedVehicles,_vehicleClass,[_configName]] call ALIVE_fnc_hashSet;
            }else{
                _subSorted = [_sortedVehicles,_vehicleClass] call ALIVE_fnc_hashGet;
                _subSorted set [count _subSorted,_configName];
                [_sortedVehicles,_vehicleClass,_subSorted] call ALIVE_fnc_hashSet;
            };

        };
    };
};

_sortedVehicles
