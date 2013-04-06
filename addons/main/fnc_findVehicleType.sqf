#include <\x\alive\addons\main\script_component.hpp>
SCRIPT(findVehicleType);

/* ----------------------------------------------------------------------------
Function: ALiVE_fnc_findVehicleType

Description:
Used to find vehicles for specific type, side and free cargo slots

Parameters:
Number - Minimum number of cargo slots in the vehicle
String - Faction of the vehicle (optional)
String - Type of the vehicle (optional)

Returns:
Array - A list of vehicles matching the parameters supplied.

Examples:
(begin example)
_types = [0, ALiVE_FACTIONS,"Man"] call ALiVE_fnc_findVehicleType;
_group = [_pos, east, _types] call BIS_fnc_spawnGroup;
(end)

Author:
Wolffy.au
---------------------------------------------------------------------------- */

private ["_fac","_allvehs","_vehx","_fx","_cx","_cargoslots","_type","_nonconfigs","_nonsims"];

PARAMS_1(_cargoslots);
_err = "cargo slots not valid";
ASSERT_DEFINED("_cargoslots",_err);
ASSERT_TRUE(typeName _cargoslots == "SCALAR",_err);

DEFAULT_PARAM(1,_fac,nil);
DEFAULT_PARAM(2,_type,nil);
_nonConfigs = ["StaticWeapon","CruiseMissile1","CruiseMissile2","Chukar_EP1","Chukar","Chukar_AllwaysEnemy_EP1"];
_nonSims = ["parachute","house"];

_allvehs = [];
for "_y" from 1 to count(configFile >> "CfgVehicles") - 1 do {
	_vehx = (configFile >> "CfgVehicles") select _y;
	if(getNumber (_vehx >> "scope") > 1) then {
		if (!(getText(_vehx >> "simulation") in _nonsims)) then {
			_cx = configName _vehx;
			if ({(_cx isKindOf _x)} count _nonconfigs == 0) then {
				if (getNumber(_vehx >> "TransportSoldier") >= _cargoslots) then {
					if (!isNil "_fac") then {
						_fx = getText(_vehx >> "faction");
						switch(toUpper(typeName _fac)) do {
							case "STRING": {
								if(_fx == _fac) then {
									if (!isnil "_type") then {
										if (_cx isKindOf _type) then {
											_allvehs set [count _allvehs, _cx];
										};
									} else {
										_allvehs set [count _allvehs, _cx];
									};
								};
							};
							case "ARRAY": {
								if(_fx in _fac) then {
									if (!isnil "_type") then {
										if (_cx isKindOf _type) then {
											_allvehs set [count _allvehs, _cx];
										};
									} else {
										_allvehs set [count _allvehs, _cx];
									};
								};
							};
						};
					};
				};
			};
		};
	};
};

_allvehs;
