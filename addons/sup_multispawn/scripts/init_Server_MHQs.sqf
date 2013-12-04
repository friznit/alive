// Script used by the Server to build an array of all available MHQs
// State variable is also initialised as they are added to the list.
// Static HQ buildings will need the relevant actions manually added in the editor
// Author: WobbleyheadedBob aka CptNoPants
private ["_vehicles","_isMHQ"];
_vehicles = _this select 0;
PV_hqArray = [];

{
	_isMHQ = [_x] call ALIVE_fnc_multispawnMHQType;
	
	if (_isMHQ != "non_mhq_vehicle") then 
	{
		_x setVariable ["MHQState",0,true];
		PV_hqArray set [count PV_hqArray, _x];
	};
} forEach _vehicles;

//Broadcast the new list out to everyone.
publicvariable "PV_hqArray";