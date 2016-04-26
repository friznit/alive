#include <\x\alive\addons\mil_opcom\script_component.hpp>
SCRIPT(OPCOMdropIntel);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_OPCOMdropIntel

Description:
Adds civilian actions

Parameters:
Array - [_unit,_chance 0-1]
Returns:
object or any

Examples:
(begin example)
//
_result = [_unit,0.1] call ALIVE_fnc_OPCOMdropIntel;
(end)

See Also:

Author:
Highhead
---------------------------------------------------------------------------- */

params [
    ["_data", [objNull,objNull], [[]]],
    ["_chance", 0, [-1]]
];

//Disable if OPCOM module not placed
_chance = if (!isnil QGVAR(INTELCHANCE)) then {GVAR(INTELCHANCE)} else {_chance};

if (random 1 > _chance) exitwith {};

// Set Data
_unit = _data select 0;
_side = (faction _unit) call ALiVE_fnc_FactionSide;

_type = selectRandom ["Land_File1_F","Land_FilePhotos_F","Land_File2_F","Land_File_research_F"];
_position = getposATL _unit;

_object = _type createVehicle _position;
_object setposATL ([_position,1] call CBA_fnc_Randpos);

_text = "Read Intel";
_params = [_position,_side];
_code = {_object = _this select 0; _caller = _this select 1; _params = _this select 3; openmap true; [_params select 0, 1500, _params select 1] call ALiVE_fnc_OPCOMToggleInstallations};
_condition = "alive _target";

_args = [
	_text,
	_code,
	_params,
	1,
	false,
	true,
	"",
	_condition
];

if (!isNull _object) then {
    [[_object, _args],"addAction",true,true] call BIS_fnc_MP;

	[_unit,_object] spawn {
	    
	    _unit = _this select 0;
	    _object = _this select 1;
	    
	    waituntil {sleep 10; isNil "_unit" || {isNull _unit}};
	    
	    deleteVehicle _object;
	};
	
	
	_object
};