#include <\x\alive\addons\x_lib\script_component.hpp>
SCRIPT(indexMap);

/* ----------------------------------------------------------------------------
Function: ALiVE_fnc_indexMap

Description:
Manages the indexing of a map for ALiVE. Requires ALiVEClient.dll

Parameters:
String - Addon path

Returns:
String - Result

Examples:
(begin example)
_success = ["Addons\map_Stratis.pbo"] call ALiVE_fnc_indexMap;
(end)

See Also:
- nil

Author:
Tupolov

Peer reviewed:
nil
---------------------------------------------------------------------------- */

private ["_path"];

_path = _this select 0;

[_path] spawn {
	private ["_path","_file","_objects","_result","_handle"];
	_path = _this select 0;

	waitUntil{!isNull player};

	["Tuplindexinator","Starting Map Index"] call ALiVE_fnc_sendHint;

	[">>>>>>>>>>>>>>>>>> Starting indexing for %1 map", worldName] call ALiVE_fnc_dump;

	// Create parsed objects file for map
	_result = "ALiVEClient" callExtension format["StartIndex~%1|%2",_path, worldName];

	If (_result != "SUCCESS") exitwith {
		[">>>>>>>>>>>>>>>>>> There was a problem, exiting indexing"] call ALiVE_fnc_dump;
		["Tuplindexinator","There was a problem, exiting indexing"] call ALiVE_fnc_sendHint;
	};

	["Tuplindexinator","Starting Object Categorization"] call ALiVE_fnc_sendHint;
	[">>>>>>>>>>>>>>>>>> Starting Object Categorization"] call ALiVE_fnc_dump;

	// Load in new object array
	_file = format["@ALiVE\indexing\%1\fnc_strategic\indexes\objects.%1.sqf", worldName];
	call compile (preprocessFile _file);

	// Check for static data
	_result = "ALiVEClient" callExtension format["checkStatic~%1", worldName];

	If (_result == "SUCCESS") then {

		{

			private ["_model","_samples"];
			_model = _x select 0;
			_samples = _x select 1;
			ALIVE_map_index_choice = "";
			// createDialog "ALiVE_map_index";
			_i = 0;
			while {ALIVE_map_index_choice == ""} do
			{
				_o = _samples select _i;
				_id = _o select 0;
				_pos = _o select 1;
				_obj = _pos nearestObject _id;
				[_obj, false] call ALiVE_fnc_addCamera;
				sleep 5;
				_i = _i + 1;
				if (_i == count _samples) then {_i = 0;};
			};

		} foreach wrp_objects;

	};

	sleep 2;

	// Generate Map Clusters

	forceMap true;

	["Tuplindexinator","Generating Sector Data"] call ALiVE_fnc_sendHint;
	[">>>>>>>>>>>>>>>>>> Generating Sector Data"] call ALiVE_fnc_dump;

	_result = "ALiVEClient" callExtension format["startClusters~%1", worldName];

	_handle = [] execVM "\x\alive\addons\fnc_analysis\tests\auto_runMapAnalysis.sqf";
	waitUntil {sleep 0.3; scriptDone _handle};

	["Tuplindexinator","Generating Clusters: Military Objectives."] call ALiVE_fnc_sendHint;
	[">>>>>>>>>>>>>>>>>> Generating Clusters:  Military Objectives."] call ALiVE_fnc_dump;

	_handle = [] execVM "\x\alive\addons\mil_placement\tests\auto_clusterGeneration.sqf";
	waitUntil {sleep 0.3; scriptDone _handle};

	["Tuplindexinator","Generating Clusters: Civilian Objectives."] call ALiVE_fnc_sendHint;
	[">>>>>>>>>>>>>>>>>> Generating Clusters: Civilian Objectives."] call ALiVE_fnc_dump;

	_handle =  [] execVM "\x\alive\addons\civ_placement\tests\auto_clusterGeneration.sqf";
	waitUntil {sleep 0.3; scriptDone _handle};

	// Merge sector/cluster data

	["Tuplindexinator","Generating Clusters: Merging Military Sector/Cluster Data."] call ALiVE_fnc_sendHint;
	[">>>>>>>>>>>>>>>>>> Generating Clusters: Merging Military Sector/Cluster Data."] call ALiVE_fnc_dump;

	_handle = [] execVM "\x\alive\addons\fnc_analysis\tests\auto_appendClustersMil.sqf";
	waitUntil {sleep 0.3; scriptDone _handle};

	["Tuplindexinator","Generating Clusters: Merging Civilian Sector/Cluster Data."] call ALiVE_fnc_sendHint;
	[">>>>>>>>>>>>>>>>>> Generating Clusters: Merging Civilian Sector/Cluster Data."] call ALiVE_fnc_dump;

	_handle = [] execVM "\x\alive\addons\fnc_analysis\tests\auto_appendClustersCiv.sqf";
	waitUntil {sleep 0.3; scriptDone _handle};

	["Tuplindexinator","Map Indexing Completed!"] call ALiVE_fnc_sendHint;
	[">>>>>>>>>>>>>>>>>> Map Indexing Completed!"] call ALiVE_fnc_dump;

	forceMap false;
};