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
_success = ["Addons\map_Stratis.pbo",false] call ALiVE_fnc_indexMap;
(end)

See Also:
- nil

Author:
Tupolov

Peer reviewed:
nil
---------------------------------------------------------------------------- */

private ["_path","_default"];

_path = _this select 0;
_default = _this select 1;

[_path,_default] spawn {
	private ["_path","_file","_objects","_result","_handle","_default"];
	_path = _this select 0;
	_default = _this select 1;

	waitUntil{!isNull player};

	["ALiVE Map Indexer","Starting Map Index"] call ALiVE_fnc_sendHint;

	[">>>>>>>>>>>>>>>>>> Starting indexing for %1 map", worldName] call ALiVE_fnc_dump;

	// Create parsed objects file for map
	[">>>>>>>>>>>>>>>>>> Calling DeWRP to get list of objects"] call ALiVE_fnc_dump;
	_result = "ALiVEClient" callExtension format["StartIndex~%1|%2",_path, worldName];
	//_result = "SUCCESS";

	If (_result != "SUCCESS") exitwith {
		[">>>>>>>>>>>>>>>>>> There was a problem, exiting indexing"] call ALiVE_fnc_dump;
		["ALiVE Map Indexer","There was a problem, exiting indexing"] call ALiVE_fnc_sendHint;
	};

	// Load in new object array
	[">>>>>>>>>>>>>>>>>> Compiling list of objects from deWRP in wrp_objects array"] call ALiVE_fnc_dump;
	_file = format["@ALiVE\indexing\%1\fnc_strategic\indexes\objects.%1.sqf", tolower(worldName)];
	call compile (preprocessFile _file);

	// Check for static data
	[">>>>>>>>>>>>>>>>>> Checking for existing static data..."] call ALiVE_fnc_dump;
	_result = "ALiVEClient" callExtension format["checkStatic~%1", worldName];

	If (_result != "SUCCESS") then {
		[">>>>>>>>>>>>>>>>>> No static data found"] call ALiVE_fnc_dump;
		["ALiVE Map Indexer","Starting Object Categorization"] call ALiVE_fnc_sendHint;
		[">>>>>>>>>>>>>>>>>> Starting Object Categorization"] call ALiVE_fnc_dump;

		[_default] call ALiVE_fnc_auto_staticObjects;

	};

	sleep 2;

	// Generate Map Clusters

	forceMap true;

	["ALiVE Map Indexer","Generating Sector Data"] call ALiVE_fnc_sendHint;
	[">>>>>>>>>>>>>>>>>> Generating Sector Data"] call ALiVE_fnc_dump;

	_result = "ALiVEClient" callExtension format["startClusters~%1", worldName];

	_handle = [] execVM "\x\alive\addons\fnc_analysis\tests\auto_runMapAnalysis.sqf";
	waitUntil {sleep 0.3; scriptDone _handle};

	["ALiVE Map Indexer","Generating Clusters: Military Objectives."] call ALiVE_fnc_sendHint;
	[">>>>>>>>>>>>>>>>>> Generating Clusters:  Military Objectives."] call ALiVE_fnc_dump;

	_handle = [] execVM "\x\alive\addons\mil_placement\tests\auto_clusterGeneration.sqf";
	waitUntil {sleep 0.3; scriptDone _handle};

	["ALiVE Map Indexer","Generating Clusters: Civilian Objectives."] call ALiVE_fnc_sendHint;
	[">>>>>>>>>>>>>>>>>> Generating Clusters: Civilian Objectives."] call ALiVE_fnc_dump;

	_handle =  [] execVM "\x\alive\addons\civ_placement\tests\auto_clusterGeneration.sqf";
	waitUntil {sleep 0.3; scriptDone _handle};

	// Merge sector/cluster data

	["ALiVE Map Indexer","Generating Clusters: Merging Military Sector/Cluster Data."] call ALiVE_fnc_sendHint;
	[">>>>>>>>>>>>>>>>>> Generating Clusters: Merging Military Sector/Cluster Data."] call ALiVE_fnc_dump;

	_handle = [] execVM "\x\alive\addons\fnc_analysis\tests\auto_appendClustersMil.sqf";
	waitUntil {sleep 0.3; scriptDone _handle};

	["ALiVE Map Indexer","Generating Clusters: Merging Civilian Sector/Cluster Data."] call ALiVE_fnc_sendHint;
	[">>>>>>>>>>>>>>>>>> Generating Clusters: Merging Civilian Sector/Cluster Data."] call ALiVE_fnc_dump;

	_handle = [] execVM "\x\alive\addons\fnc_analysis\tests\auto_appendClustersCiv.sqf";
	waitUntil {sleep 0.3; scriptDone _handle};

	["ALiVE Map Indexer","Map Indexing Completed!"] call ALiVE_fnc_sendHint;
	[">>>>>>>>>>>>>>>>>> Map Indexing Completed!"] call ALiVE_fnc_dump;

	forceMap false;
};