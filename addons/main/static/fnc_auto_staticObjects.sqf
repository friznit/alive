private ["_categories"];

_categories = [
	["ALIVE_Indexing_Blacklist","Blacklist"],
	["ALIVE_airBuildingTypes","Generic - Air"],
	["ALIVE_militaryAirBuildingTypes","Military - Air"],
	["ALIVE_militaryHeliBuildingTypes","Military - Heli"],
	["ALIVE_militaryBuildingTypes","Military - Generic"],
	["ALIVE_militaryParkingBuildingTypes","Military - Parking"],
	["ALIVE_militarySupplyBuildingTypes","Military - Supply"],
	["ALIVE_militaryHQBuildingTypes","Military - HQ"],
	["ALIVE_civilianAirBuildingTypes","Civilian - Air"],
	["ALIVE_civilianHeliBuildingTypes","Civilian - Heli"],
	["ALIVE_civilianPopulationBuildingTypes","Civilian - Population"],
	["ALIVE_civilianHQBuildingTypes","Civilian - HQ"],
	["ALIVE_civilianPowerBuildingTypes","Civilian - Power"],
	["ALIVE_civilianCommsBuildingTypes","Civilian - Comms"],
	["ALIVE_civilianMarineBuildingTypes","Civilian - Marine"],
	["ALIVE_civilianRailBuildingTypes","Civilian - Rail"],
	["ALIVE_civilianFuelBuildingTypes","Civilian - Fuel"],
	["ALIVE_civilianConstructionBuildingTypes","Civilian - Construction"],
	["ALIVE_civilianSettlementBuildingTypes","Civilian - Settlement"]
];

// Init arrays

{
	call compile format["%1 = []", _x select 0];
} foreach _categories;

createDialog "alive_indexing_list";
// noesckey = (findDisplay 1601) displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"];
{
	private ["_index"];
	_index = ((findDisplay 1601) displayCtrl 1) lbAdd (_x select 1);
} foreach _categories;

{

	private ["_model","_samples","_idc"];
	_model = _x select 0;
	_samples = _x select 1;
	ALiVE_wrp_model = _model;
	ALIVE_map_index_choice = 99;
	_i = 0;

	while {ALIVE_map_index_choice == 99} do
	{
		private ["_o","_id","_pos","_obj","_cam"];
		_o = _samples select _i;
		_id = _o select 0;
		_pos = _o select 1;
		_obj = _pos nearestObject _id;

		_cam = [_obj, false, "HIGH"] call ALiVE_fnc_addCamera;
		[_cam, true] call ALIVE_fnc_startCinematic;
		cutText [format["Progress:%3/%4 - Object: %1, Model: %2", typeof _obj, str(_model), _i, count wrp_objects],"PLAIN DOWN"];

		[_cam,_obj,2] call ALIVE_fnc_chaseShot;
		sleep 2;
		camDestroy _cam;
		_i = _i + 1;
		if (_i == count _samples) then {_i = 0;};
	};

	// Once choice made, record choice in array
	call compile format['%1 pushBack "%2"', ((_categories select ALIVE_map_index_choice) select 0), _model];

} foreach wrp_objects;

// (findDisplay 1601) displayRemoveEventHandler ["KeyDown", noesckey];
closeDialog 0;

// Dump arrays to extension that can write the staticData file
{
	private ["_array","_arrayActual"];
	_array = _x select 0;
	_arrayActual = call compile _array;
	diag_log format['staticData~%1|%2 = %2 + %3;',worldName,_array, _arrayActual];
	"ALiVEClient" callExtension format['staticData~%1|%2 = %2 + %3;',worldName,_array, _arrayActual];

} foreach _categories;

"ALiVEClient" callExtension format['staticData~%1|};',worldName];

true