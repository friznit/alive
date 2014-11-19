#include <\x\alive\addons\mil_ied\script_component.hpp>
SCRIPT(placeVBIED);

// Find vehicles in town to use as a VB-IED

private ["_location","_radius","_veh", "_vblist"];

_location = _this select 0;
_radius = _this select 1;

// Find all vehicles within radius
_veh = nearestObjects [_location, ["Car"], _radius];

if (count _veh > 0) then {

	// select vehicle(s)
	for "_i" = 0 to MOD(VB_IED_Threat) do {
		private ["_vb","_select"];
		// get a random vehicle
		_select = (ceil(random (count _veh)));
		_vb = _veh select _select;

		// Create VBIED
		[_vb] call ALiVE_fnc_createVBIED;

		// Add vehicle to list to return
		_vblist set [count _vblist, _vb];

		// remove from working list to avoid duplicates
		_veh set [_select, nil];
	};

};

_vblist;
