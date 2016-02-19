private ["_categories"];

_categories = [
	"Blacklist",
	"ALIVE_airBuildingTypes",
	"ALIVE_militaryAirBuildingTypes",
	"ALIVE_militaryHeliBuildingTypes",
	"ALIVE_militaryBuildingTypes",
	"ALIVE_militaryParkingBuildingTypes",
	"ALIVE_militarySupplyBuildingTypes",
	"ALIVE_militaryHQBuildingTypes",
	"ALIVE_civilianAirBuildingTypes",
	"ALIVE_civilianHeliBuildingTypes",
	"ALIVE_civilianPopulationBuildingTypes",
	"ALIVE_civilianHQBuildingTypes",
	"ALIVE_civilianPowerBuildingTypes",
	"ALIVE_civilianCommsBuildingTypes",
	"ALIVE_civilianMarineBuildingTypes",
	"ALIVE_civilianRailBuildingTypes",
	"ALIVE_civilianFuelBuildingTypes",
	"ALIVE_civilianConstructionBuildingTypes",
	"ALIVE_civilianSettlementBuildingTypes"
];

{

	private ["_model","_samples","_idc"];
	_model = _x select 0;
	_samples = _x select 1;
	ALIVE_map_index_choice = "";
	_i = 0;



	/* createDialog "alive_indexing_list";
	{
		lbAdd [(findDisplay 1601) displayCtrl 1, _x];
	} foreach _categories; */

	while {ALIVE_map_index_choice == ""} do
	{
		private ["_o","_id","_pos","_obj","_cam"];
		_o = _samples select _i;
		_id = _o select 0;
		_pos = _o select 1;
		_obj = _pos nearestObject _id;

		_cam = [_obj, false, "HIGH"] call ALiVE_fnc_addCamera;
		[_cam, true] call ALIVE_fnc_startCinematic;

		diag_log str(_obj);
		hint str(typeof _obj);

		// ["ALiVE Indexer", format["Object: %2<br/>Model: %1", _model, typeof _obj]] call ALiVE_fnc_sendHint;

		[_cam,_obj,4] call ALIVE_fnc_staticShot;
		sleep 4;
		camDestroy _cam;
		_i = _i + 1;
		if (_i == count _samples) then {ALIVE_map_index_choice = "1";};
	};

} foreach wrp_objects;