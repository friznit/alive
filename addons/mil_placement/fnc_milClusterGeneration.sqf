//#define DEBUG_MODE_FULL
#include <\x\alive\addons\mil_placement\script_component.hpp>
SCRIPT(milClusterGeneration);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_milClusterGeneration
Description:
Generates military clusters

Parameters:

Returns:

Examples:
(begin example)
[] call ALIVE_fnc_milClusterGeneration;

(end)

See Also:

Author:
Wolffy
ARJay
Peer Reviewed:
nil
---------------------------------------------------------------------------- */

private ["_obj_array","_types","_clusters","_clusters_tmp","_size"];
			
			
// Find HQ locations
// ------------------------------------------------------------------
private ["_clusters_hq","_clusters_copy_hq"];

"MO - Searching HQ locations" call ALiVE_fnc_logger;

_types = [
	"barrack",
	"cargo_hq_",
	"miloffices",
	"mil_house",
	"mil_controltower",
	"barrack",
	"miloffices",
	"cargo_tower"
];

_clusters_hq = [_types] call ALIVE_fnc_findTargets;
_clusters_hq = [_clusters_hq, "MIL", 50, "ColorRed"] call ALIVE_fnc_setTargets;
_clusters_hq = [_clusters_hq] call ALIVE_fnc_consolidateClusters;
			
// Save the non consolidated clusters
_clusters_copy_hq = [_clusters_hq] call ALIVE_fnc_copyClusters;

_clusters = +_clusters_hq;


// Find mil air locations
// ------------------------------------------------------------------
private ["_clusters_mil_air","_clusters_civ_air","_clusters_air","_clusters_copy_air"];

"MO - Searching airfield locations" call ALiVE_fnc_logger;
_types = [
	"tenthangar",
	"mil_hangar"				
];
_clusters_mil_air = [_types] call ALIVE_fnc_findTargets;
_clusters_mil_air = [_clusters_mil_air, "MIL", 20, "ColorOrange"] call ALIVE_fnc_setTargets;

// Find civ air locations
_types = [
	"ss_hangar",
	"hangar_2",
	"hangar",				
	"runway_beton",
	"runway_end",
	"runway_main",
	"runway_secondary",
	"runwayold"
];
_clusters_civ_air = [_types] call ALIVE_fnc_findTargets;
_clusters_civ_air = [_clusters_civ_air, "MIL", 10, "ColorOrange"] call ALIVE_fnc_setTargets;

// Consolidate locations
_clusters_air = _clusters_mil_air + _clusters_civ_air;
_clusters_air = [_clusters_air] call ALIVE_fnc_consolidateClusters;

// Save the non consolidated clusters
_clusters_copy_air = [_clusters_air] call ALIVE_fnc_copyClusters;			

_clusters = _clusters + _clusters_air;
_clusters = [_clusters] call ALIVE_fnc_consolidateClusters;

			

// Find mil heli locations
// ------------------------------------------------------------------
private ["_clusters_mil_heli","_clusters_civ_heli","_clusters_copy_heli"];

"MO - Searching helipad locations" call ALiVE_fnc_logger;
_types = [
	"helipadempty",
	"helipadsquare",
	"heli_h_army"
];
_clusters_mil_heli = [_types] call ALIVE_fnc_findTargets;
_clusters_mil_heli = [_clusters_mil_heli, "MIL", 20, "ColorYellow"] call ALIVE_fnc_setTargets;

// Find civ heli locations
_types = [
	"helipadempty",
	"heli_h_civil",
	"heli_h_rescue"
];
_clusters_civ_heli = [_types] call ALIVE_fnc_findTargets;
_clusters_civ_heli = [_clusters_civ_heli, "MIL", 10, "ColorYellow"] call ALIVE_fnc_setTargets;

// Consolidate locations
_clusters_heli = _clusters_mil_heli + _clusters_civ_heli;
_clusters_heli = [_clusters_heli] call ALIVE_fnc_consolidateClusters;

// Save the non consolidated clusters
_clusters_copy_heli = [_clusters_heli] call ALIVE_fnc_copyClusters;

_clusters = _clusters + _clusters_heli;
_clusters = [_clusters] call ALIVE_fnc_consolidateClusters;

		

// Find general military locations
// ------------------------------------------------------------------
private ["_clusters_mil"];

"MO - Searching military locations" call ALiVE_fnc_logger;

// Military targets
_types = [
	"airport_tower",
	"airport",
	"radar",
	"bunker",
	"cargo_house_v",
	"cargo_patrol_",
	"research",
	"deerstand",
	"hbarrier",
	"mil_wall",
	"fortification",
	//"mil_wired",
	"razorwire",
	"dome",
	"vez"
];
_clusters_mil = [_types] call ALIVE_fnc_findTargets;
_clusters_mil = [_clusters_mil, "MIL", 0, "ColorGreen"] call ALIVE_fnc_setTargets;

// Consolidate locations
_clusters = _clusters + _clusters_mil;
_clusters = [_clusters] call ALIVE_fnc_consolidateClusters;



// Final Consolidation 
// ------------------------------------------------------------------
"MO - Consolidating Clusters" call ALiVE_fnc_logger;
_clusters = [_clusters] call ALIVE_fnc_consolidateClusters;
"MO - Locations Completed" call ALiVE_fnc_logger;

{
	[_x, "debug", true] call ALIVE_fnc_cluster;
} forEach _clusters;



// Generate parking positions
// ------------------------------------------------------------------

"MO - Generating Parking Positions" call ALiVE_fnc_logger;
[true] call ALIVE_fnc_timer;
_types = [
	"airport",
	"bunker",
	"cargo_house_v",
	"cargo_patrol_",
	"research"
];
[_clusters,_types] call ALIVE_fnc_generateParkingPositions;
[] call ALIVE_fnc_timer;



private ["_worldName","_objectivesName","_exportString","_result","_clusterCount"];

_worldName = toLower(worldName);

_exportString = '';
_clusterCount = 0;

_objectivesName = 'ALIVE_clustersMil';
_result = [_clusters, _objectivesName, _clusterCount] call ALIVE_fnc_staticClusterOutput;

_clusterCount = _clusterCount + count _clusters;

_exportString = _result;

if(count _clusters_copy_hq > 0) then {
	_objectivesName = 'ALIVE_clustersMilHQ';
	_result = [_clusters_copy_hq, _objectivesName, _clusterCount] call ALIVE_fnc_staticClusterOutput;				
	_exportString = _exportString + _result;
};

_clusterCount = _clusterCount + count _clusters_copy_hq;

if(count _clusters_copy_air > 0) then {
	_objectivesName = 'ALIVE_clustersMilAir';
	_result = [_clusters_copy_air, _objectivesName, _clusterCount] call ALIVE_fnc_staticClusterOutput;			
	_exportString = _exportString + _result;
};

_clusterCount = _clusterCount + count _clusters_copy_air;

if(count _clusters_copy_heli > 0) then {
	_objectivesName = 'ALIVE_clustersMilHeli';
	_result = [_clusters_copy_heli, _objectivesName, _clusterCount] call ALIVE_fnc_staticClusterOutput;				
	_exportString = _exportString + _result;
};

_clusterCount = _clusterCount + count _clusters_copy_heli;	

copyToClipboard _exportString;
["Military Objectives generation complete, results have been copied to the clipboard"] call ALIVE_fnc_dump;
["Should be pasted in file: fnc_strategic\clusters\clusters.%1_mil.sqf", _worldName] call ALIVE_fnc_dump;
