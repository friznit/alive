#include <\x\alive\addons\x_lib\script_component.hpp>
SCRIPT(factionCreateStaticData);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_factionCreateStaticData

Description:
Creates static data entries for a 3rd party faction

Parameters:
Config - config file

Returns:

Examples:
(begin example)
// inspect config class
["BLU_F"] call ALIVE_fnc_factionCreateStaticData;

// inspect all factions
_factions = configfile >> "CfgFactionClasses";
for "_i" from 0 to count _factions -1 do {

    _faction = _factions select _i;
    if(isClass _faction) then {
        _configName = configName _faction;
        _side = getNumber(_faction >> "side");
        if(_side < 3) then {
            [configName (_factions select _i)] call ALIVE_fnc_factionCreateStaticData;
        };
    };
}
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_cfgFindFaction","_faction"];

_cfgFindFaction = {
    private ["_cfg","_faction","_detailed","_item","_text","_result","_findRecurse","_className"];

    _cfg = _this select 0;
    _faction = _this select 1;

    _result = [];

    _findRecurse = {
    	private ["_root","_class","_path","_currentPath","_currentFaction"];

    	_root = (_this select 0);
    	_path = +(_this select 1);

        _currentFaction = [_root >> "faction"] call ALIVE_fnc_getConfigValue;

    	if!(isNil "_currentFaction") then {
    	    if(_currentFaction == _faction) then {
    	        _result set [count _result, _root];
    	    };
    	};

    	for "_i" from 0 to count _root -1 do {

    		_class = _root select _i;

    		if (isClass _class) then {
    			_currentPath = _path + [_i];

    			_className = configName _class;

    			_class = _root >> _className;

    			[_class, _currentPath] call _findRecurse;
    		};
    	};
    };

    [_cfg, []] call _findRecurse;

    _result
};



_faction = _this select 0;

[""] call ALIVE_fnc_dump;
[""] call ALIVE_fnc_dump;
_text = " ----------------------------------------------------------------------------------------------------------- ";
[_text] call ALIVE_fnc_dump;
[""] call ALIVE_fnc_dump;
[""] call ALIVE_fnc_dump;
_text = " ----------- Faction Static Data Generation ----------- ";
[_text] call ALIVE_fnc_dump;
["Creating static data entries for faction: %1",_faction] call ALIVE_fnc_dump;



// first check the faction

private ["_factionOK","_text","_config","_displayName","_side","_sideToText"];

_factionOK = false;

_config = configfile >> "CfgFactionClasses" >> _faction;

if(count _config > 0) then {
    _displayName = [_config >> "displayName"] call ALIVE_fnc_getConfigValue;
    _side = [_config >> "side"] call ALIVE_fnc_getConfigValue;
    _sideToText = [_side] call ALIVE_fnc_sideNumberToText;
    _factionOK = true;
};



// check groups matching the faction

private ["_factionToGroupMappingOK","_factionGroups"];

_factionToGroupMappingOK = false;

_config = configfile >> "CfgGroups" >> _sideToText >> _faction;

if(count _config > 0) then {
    _factionToGroupMappingOK = true;
    _factionGroups = [_config,_faction] call _cfgFindFaction;
};


// if the direct mapping check failed try reverse lookup groups > faction

private ["_groupToFactionMappingOK"];

_groupToFactionMappingOK = false;

if!(_factionToGroupMappingOK) then {

    _config = configfile >> "CfgGroups" >> _sideToText;
    _factionGroups = [_config,_faction] call _cfgFindFaction;

    if(count _factionGroups > 0) then {
        _groupToFactionMappingOK = true;
    };
};


// found some groups for the faction - investigate them

private ["_standardVehicleTypes","_groupSide","_groupFaction","_groupConfigName","_unitConfigName","_unitSide","_unitVehicle",
"_unitRank","_vehicleConfigName","_vehicleType","_vehicleCrew","_crewConfig","_crewConfigName","_crewFaction","_crewSide"];

if(_groupToFactionMappingOK || _factionToGroupMappingOK && (count _factionGroups > 0)) then {

    {
        _groupSide = [_x >> "side"] call ALIVE_fnc_getConfigValue;
        _groupFaction = [_x >> "faction"] call ALIVE_fnc_getConfigValue;
        _groupConfigName = configName _x;

        for "_i" from 0 to count _x -1 do {

            _class = _x select _i;

            if (isClass _class) then {

                _unitConfigName = configName _class;
                _unitSide = [_class >> "side"] call ALIVE_fnc_getConfigValue;
                _unitVehicle = [_class >> "vehicle"] call ALIVE_fnc_getConfigValue;
                _unitRank = [_class >> "rank"] call ALIVE_fnc_getConfigValue;

                if!(isNil "_unitVehicle") then {

                    _vehicleConfig = configfile >> "CfgVehicles" >> _unitVehicle;

                    if(count _vehicleConfig > 0) then {

                        _vehicleConfigName = configName _vehicleConfig;

                        if(_vehicleConfigName isKindOf "Man") then {

                        }else{

                            _vehicleType = [_vehicleConfig >> "vehicleClass"] call ALIVE_fnc_getConfigValue;
                            _vehicleCrew = [_vehicleConfig >> "crew"] call ALIVE_fnc_getConfigValue;

                        };
                    };
                };
            };
        };

    } forEach _factionGroups;

};


private ["_factionVehicles","_factionMen","_class","_configName","_currentFaction","_vehicleType","_factionVehicleTypes"];

_factionVehicles = [] call ALIVE_fnc_hashCreate;
_factionMen = [];

_config = configfile >> "CfgVehicles";

for "_i" from 0 to count _config -1 do {
    _class = _config select _i;
    if (isClass _class) then {
        _configName = configName _class;
        _currentFaction = [_class >> "faction"] call ALIVE_fnc_getConfigValue;
        if!(isNil "_currentFaction") then {
            if(_currentFaction == _faction) then {
                if(_configName isKindOf "Man") then {
                    if([_class >> "scope"] call ALIVE_fnc_getConfigValue == 2) then {
                        _factionMen set [count _factionMen, _class];
                    };
                }else{
                    if([_class >> "scope"] call ALIVE_fnc_getConfigValue == 2) then {
                        _vehicleType = [_class >> "vehicleClass"] call ALIVE_fnc_getConfigValue;

                        if!(_vehicleType in (_factionVehicles select 1)) then {
                            [_factionVehicles,_vehicleType,[]] call ALIVE_fnc_hashSet;
                        };

                        _factionVehicleTypes = [_factionVehicles,_vehicleType] call ALIVE_fnc_hashGet;
                        _factionVehicleTypes set [count _factionVehicleTypes, _class];

                        [_factionVehicles,_vehicleType,_factionVehicleTypes] call ALIVE_fnc_hashSet;
                    };
                };
            };
        };
    };
};


private ["_vehicleType","_vehicleClasses","_array","_vehicleClass","_configName"];

{

    _vehicleType = _x;

    _vehicleClasses = [_factionVehicles,_vehicleType] call ALIVE_fnc_hashGet;

    [" "] call ALIVE_fnc_dump;
    ["-- Type: %1",_vehicleType] call ALIVE_fnc_dump;

    _arrayContent = "";

    {

        _vehicleClass = _x;

        _configName = configName _vehicleClass;

        _arrayContent = format['%1,"%2"',_arrayContent,_configName];

    } forEach _vehicleClasses;

    {

    } forEach _array;

    _supports = format['[ALIVE_factionDefaultSupports, "%1", [%2]] call ALIVE_fnc_hashSet;',_faction,_arrayContent];
    _supplies = format['[ALIVE_factionDefaultSupplies, "%1", [%2]] call ALIVE_fnc_hashSet;',_faction,_arrayContent];
    _transport = format['[ALIVE_factionDefaultTransport, "%1", [%2]] call ALIVE_fnc_hashSet;',_faction,_arrayContent];
    _air = format['[ALIVE_factionDefaultAirTransport, "%1", [%2]] call ALIVE_fnc_hashSet;',_faction,_arrayContent];

    [_supports] call ALIVE_fnc_dump;
    [_supplies] call ALIVE_fnc_dump;
    [_transport] call ALIVE_fnc_dump;
    [_air] call ALIVE_fnc_dump;

} forEach (_factionVehicles select 1);