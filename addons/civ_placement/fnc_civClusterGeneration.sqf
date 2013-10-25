//#define DEBUG_MODE_FULL
#include <\x\alive\addons\civ_placement\script_component.hpp>
SCRIPT(civClusterGeneration);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_civClusterGeneration
Description:
Generates civilian clusters

Parameters:

Returns:

Examples:
(begin example)
[] call ALIVE_fnc_civClusterGeneration;
(end)

See Also:

Author:
Wolffy
ARJay
Peer Reviewed:
nil
---------------------------------------------------------------------------- */

private ["_obj_array","_types","_clusters","_clusters_tmp","_size"];

if(isNil "ALIVE_civilianHQBuildingTypes") then {
	_file = "\x\alive\addons\mil_placement\static\staticData.sqf";
	call compile preprocessFileLineNumbers _file;
};


// Find HQ locations
// ------------------------------------------------------------------
private ["_clusters_hq","_clusters_copy_hq"];

"CO - Searching HQ locations" call ALiVE_fnc_logger;

_clusters_hq = [ALIVE_civilianHQBuildingTypes] call ALIVE_fnc_findTargets;
_clusters_hq = [_clusters_hq, "CIV", 50, "ColorBlack"] call ALIVE_fnc_setTargets;
_clusters_hq = [_clusters_hq] call ALIVE_fnc_consolidateClusters;
			
// Save the non consolidated clusters
_clusters_copy_hq = [_clusters_hq] call ALIVE_fnc_copyClusters;		

_clusters = +_clusters_hq;



// Find civ power
// ------------------------------------------------------------------
private ["_clusters_power","_clusters_copy_power"];

"CO - Searching Power locations" call ALiVE_fnc_logger;

_clusters_power = [ALIVE_civilianPowerBuildingTypes] call ALIVE_fnc_findTargets;
_clusters_power = [_clusters_power, "CIV", 40, "ColorYellow"] call ALIVE_fnc_setTargets;

// Consolidate locations
_clusters_power = [_clusters_power] call ALIVE_fnc_consolidateClusters;

// Save the non consolidated clusters
_clusters_copy_power = [_clusters_power] call ALIVE_fnc_copyClusters;

_clusters = _clusters + _clusters_power;
_clusters = [_clusters] call ALIVE_fnc_consolidateClusters;



// Find civ comms
// ------------------------------------------------------------------
private ["_clusters_comms","_clusters_copy_comms"];

"CO - Searching Comms locations" call ALiVE_fnc_logger;

_clusters_comms = [ALIVE_civilianCommsBuildingTypes] call ALIVE_fnc_findTargets;
_clusters_comms = [_clusters_comms, "CIV", 40, "ColorWhite"] call ALIVE_fnc_setTargets;

// Consolidate locations
_clusters_comms = [_clusters_comms] call ALIVE_fnc_consolidateClusters;

// Save the non consolidated clusters
_clusters_copy_comms = [_clusters_comms] call ALIVE_fnc_copyClusters;

_clusters = _clusters + _clusters_comms;
_clusters = [_clusters] call ALIVE_fnc_consolidateClusters;



// Find civ marine
// ------------------------------------------------------------------
private ["_clusters_marine","_clusters_copy_marine"];

"CO - Searching Marine locations" call ALiVE_fnc_logger;

_clusters_marine = [ALIVE_civilianMarineBuildingTypes] call ALIVE_fnc_findTargets;
_clusters_marine = [_clusters_marine, "CIV", 30, "ColorBlue"] call ALIVE_fnc_setTargets;

// Consolidate locations
_clusters_marine = [_clusters_marine] call ALIVE_fnc_consolidateClusters;

// Save the non consolidated clusters
_clusters_copy_marine = [_clusters_marine] call ALIVE_fnc_copyClusters;

// Consolidate locations
_clusters = _clusters + _clusters_marine;
_clusters = [_clusters] call ALIVE_fnc_consolidateClusters;



// Find civ rail
// ------------------------------------------------------------------
private ["_clusters_rail","_clusters_copy_rail"];

"CO - Searching Rail locations" call ALiVE_fnc_logger;

_clusters_rail = [ALIVE_civilianRailBuildingTypes] call ALIVE_fnc_findTargets;
_clusters_rail = [_clusters_rail, "CIV", 10, "ColorKhaki"] call ALIVE_fnc_setTargets;

// Consolidate locations
_clusters_rail = [_clusters_rail] call ALIVE_fnc_consolidateClusters;

// Save the non consolidated clusters
_clusters_copy_rail = [_clusters_rail] call ALIVE_fnc_copyClusters;

// Consolidate locations
_clusters = _clusters + _clusters_rail;
_clusters = [_clusters] call ALIVE_fnc_consolidateClusters;



// Find civ fuel
// ------------------------------------------------------------------
private ["_clusters_fuel","_clusters_copy_fuel"];

"CO - Searching Fuel locations" call ALiVE_fnc_logger;

_clusters_fuel = [ALIVE_civilianFuelBuildingTypes] call ALIVE_fnc_findTargets;
_clusters_fuel = [_clusters_fuel, "CIV", 30, "ColorOrange"] call ALIVE_fnc_setTargets;

// Consolidate locations
_clusters_fuel = [_clusters_fuel] call ALIVE_fnc_consolidateClusters;

// Save the non consolidated clusters
_clusters_copy_fuel = [_clusters_fuel] call ALIVE_fnc_copyClusters;

// Consolidate locations
_clusters = _clusters + _clusters_fuel;
_clusters = [_clusters] call ALIVE_fnc_consolidateClusters;



// Find civ construction
// ------------------------------------------------------------------
private ["_clusters_construction","_clusters_copy_construction"];

"CO - Searching Construction locations" call ALiVE_fnc_logger;

_clusters_construction = [ALIVE_civilianConstructionBuildingTypes] call ALIVE_fnc_findTargets;
_clusters_construction = [_clusters_construction, "CIV", 10, "ColorPink"] call ALIVE_fnc_setTargets;

// Consolidate locations
_clusters_construction = [_clusters_construction] call ALIVE_fnc_consolidateClusters;

// Save the non consolidated clusters
_clusters_copy_construction = [_clusters_construction] call ALIVE_fnc_copyClusters;

// Consolidate locations
_clusters = _clusters + _clusters_construction;
_clusters = [_clusters] call ALIVE_fnc_consolidateClusters;



// Find civ settlements
// ------------------------------------------------------------------
private ["_clusters_settlement","_clusters_copy_settlement"];

"CO - Searching Settlement locations" call ALiVE_fnc_logger;

_clusters_settlement = [ALIVE_civilianSettlementBuildingTypes] call ALIVE_fnc_findTargets;
_clusters_settlement = [_clusters_settlement, "CIV", 0, "ColorGreen"] call ALIVE_fnc_setTargets;

// Consolidate locations
_clusters_settlement = [_clusters_settlement] call ALIVE_fnc_consolidateClusters;

// Save the non consolidated clusters
_clusters_copy_settlement = [_clusters_settlement] call ALIVE_fnc_copyClusters;

// Consolidate locations
_clusters = _clusters + _clusters_settlement;
_clusters = [_clusters] call ALIVE_fnc_consolidateClusters;

			

// Final Consolidation 
// ------------------------------------------------------------------
"CO - Consolidating Clusters" call ALiVE_fnc_logger;
_clusters = [_clusters] call ALIVE_fnc_consolidateClusters;
"CO - Locations Completed" call ALiVE_fnc_logger;

{
	[_x, "debug", true] call ALIVE_fnc_cluster;
} forEach _clusters;



private ["_worldName","_objectivesName","_exportString","_result"];

_worldName = toLower(worldName);
_exportString = '';

_objectivesName = 'ALIVE_clustersCiv';
_result = [_clusters, _objectivesName] call ALIVE_fnc_staticClusterOutput;

_exportString = _result;

if(count _clusters_copy_hq > 0) then {
	["HQ"] call ALIVE_fnc_dump;
	_objectivesName = 'ALIVE_clustersCivHQ';
	_result = [_clusters_copy_hq, _objectivesName] call ALIVE_fnc_staticClusterOutput;				
	_exportString = _exportString + _result;
};

if(count _clusters_copy_power > 0) then {
	["POWER"] call ALIVE_fnc_dump;
	_objectivesName = 'ALIVE_clustersCivPower';
	_result = [_clusters_copy_power, _objectivesName] call ALIVE_fnc_staticClusterOutput;			
	_exportString = _exportString + _result;
};

if(count _clusters_copy_comms > 0) then {
	["COMMS"] call ALIVE_fnc_dump;
	_objectivesName = 'ALIVE_clustersCivComms';
	_result = [_clusters_copy_comms, _objectivesName] call ALIVE_fnc_staticClusterOutput;				
	_exportString = _exportString + _result;
};

if(count _clusters_copy_marine > 0) then {
	["MARINE"] call ALIVE_fnc_dump;
	_objectivesName = 'ALIVE_clustersCivMarine';
	_result = [_clusters_copy_marine, _objectivesName] call ALIVE_fnc_staticClusterOutput;
	_exportString = _exportString + _result;
};

if(count _clusters_copy_rail > 0) then {
	["RAIL"] call ALIVE_fnc_dump;
	_objectivesName = 'ALIVE_clustersCivRail';
	_result = [_clusters_copy_rail, _objectivesName] call ALIVE_fnc_staticClusterOutput;
	_exportString = _exportString + _result;
};	

if(count _clusters_copy_fuel > 0) then {
	["FUEL"] call ALIVE_fnc_dump;
	_objectivesName = 'ALIVE_clustersCivFuel';
	_result = [_clusters_copy_fuel, _objectivesName] call ALIVE_fnc_staticClusterOutput;
	_exportString = _exportString + _result;
};

if(count _clusters_copy_construction > 0) then {
	["CON"] call ALIVE_fnc_dump;
	_objectivesName = 'ALIVE_clustersCivConstruction';
	_result = [_clusters_copy_construction, _objectivesName] call ALIVE_fnc_staticClusterOutput;
	_exportString = _exportString + _result;
};

if(count _clusters_copy_settlement > 0) then {
	["SET"] call ALIVE_fnc_dump;
	_objectivesName = 'ALIVE_clustersCivSettlement';
	_result = [_clusters_copy_settlement, _objectivesName] call ALIVE_fnc_staticClusterOutput;
	_exportString = _exportString + _result;
};

copyToClipboard _exportString;
["Civilian Objectives generation complete, results have been copied to the clipboard"] call ALIVE_fnc_dump;
["Should be pasted in file: civ_placement\clusters\clusters.%1_civ.sqf", _worldName] call ALIVE_fnc_dump;