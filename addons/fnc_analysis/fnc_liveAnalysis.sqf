#include <\x\alive\addons\fnc_analysis\script_component.hpp>
SCRIPT(liveAnalysis);

/* ----------------------------------------------------------------------------
Function: MAINCLASS
Description:
Performs analysis task while in game

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array - The selected parameters
String - id - ID name of the grid

Returns:
Any - The new instance or the result of the selected function and parameters

Attributes:

Examples:
(begin example)
// create a live analysis
_logic = [nil, "create"] call ALIVE_fnc_liveAnalysis;

// start analysis
_result = [_logic, "start"] call ALIVE_fnc_liveAnalysis;

See Also:

Author:
ARJay

Peer reviewed:
nil
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClassHash
#define MAINCLASS ALIVE_fnc_liveAnalysis

private ["_logic","_operation","_args","_result"];

TRACE_1("liveAnalysis - input",_this);

_logic = [_this, 0, objNull, [objNull,[]]] call BIS_fnc_param;
_operation = [_this, 1, "", [""]] call BIS_fnc_param;
_args = [_this, 2, objNull, [objNull,[],"",0,true,false]] call BIS_fnc_param;
_result = true;

#define MTEMPLATE "ALiVE_LIVEANALYSIS_%1"

switch(_operation) do {
        case "init": {                
               
			if (isServer) then {
					// if server, initialise module game logic
					[_logic,"super"] call ALIVE_fnc_hashRem;
					[_logic,"class"] call ALIVE_fnc_hashRem;
					TRACE_1("After module init",_logic);
					
					[_logic,"debug", false] call ALIVE_fnc_hashSet;
					[_logic,"analysisJobs", [] call ALIVE_fnc_hashCreate] call ALIVE_fnc_hashSet;
			};
               
        };
        case "destroy": {
				
			if (isServer) then {
			
					// clear plots
					[_logic, "clear"] call MAINCLASS;
											
					// if server
					[_logic,"super"] call ALIVE_fnc_hashRem;
					[_logic,"class"] call ALIVE_fnc_hashRem;
					
					[_logic, "destroy"] call SUPERCLASS;					
			};
                
        };
		case "debug": {
			if(typeName _args != "BOOL") then {
					_args = [_logic,"debug"] call ALIVE_fnc_hashGet;
			} else {
					[_logic,"debug",_args] call ALIVE_fnc_hashSet;
			};
			ASSERT_TRUE(typeName _args == "BOOL",str _args);

			_result = _args;
        };
		case "registerAnalysisJob": {
			private ["_analysisJobs","_job","_jobID"];
			
			_debug = [_logic,"debug"] call ALIVE_fnc_hashGet;
		
			if(typeName _args == "ARRAY") then {
				_job = [] call ALIVE_fnc_hashCreate;
				[_job, "args", _args] call ALIVE_fnc_hashSet;
				[_job, "lastRun", time] call ALIVE_fnc_hashSet;
				[_job, "runCount", 0] call ALIVE_fnc_hashSet;
				_analysisJobs = [_logic,"analysisJobs"] call ALIVE_fnc_hashGet;
				_jobID = _args select 3;
				[_analysisJobs,_jobID,_job] call ALIVE_fnc_hashSet;
				
				
				// DEBUG -------------------------------------------------------------------------------------
				if(_debug) then {
					["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
					["ALIVE Live Analysis - register job"] call ALIVE_fnc_dump;
					_job call ALIVE_fnc_inspectHash;
				};
				// DEBUG -------------------------------------------------------------------------------------
				
			};
                
        };
		case "cancelAnalysisJob": {
			private ["_analysisJobs","_job","_jobID","_jobMethod","_jobArgs"];
			
			_debug = [_logic,"debug"] call ALIVE_fnc_hashGet;
		
			if(typeName _args == "STRING") then {
			
				_jobID = _args;
				_analysisJobs = [_logic,"analysisJobs"] call ALIVE_fnc_hashGet;				
				_job = [_analysisJobs,_jobID] call ALIVE_fnc_hashGet;
				_args = [_job, "args"] call ALIVE_fnc_hashGet;
				_jobMethod = _args select 2;
				_jobArgs = _args select 4;
				
				
				// DEBUG -------------------------------------------------------------------------------------
				if(_debug) then {
					["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
					["ALIVE Live Analysis - cancel job: %1",_jobID] call ALIVE_fnc_dump;
				};
				// DEBUG -------------------------------------------------------------------------------------
				
				
				switch(_jobMethod) do {
					case "gridProfileEntity":{
						[_logic, "cleanupGridProfileEntityAnalysis", [_jobID,_jobArgs]] call MAINCLASS;
					};
					case "intelligenceItem":{
						[_logic, "cleanupIntelligenceItemAnalysis", [_jobID,_jobArgs]] call MAINCLASS;
					};
				};			
				
				[_analysisJobs,_jobID] call ALIVE_fnc_hashRem;				
			};
                
        };
		case "getAnalysisJobs": {
			_result = [_logic, "analysisJobs"] call ALIVE_fnc_hashGet;
		};
		case "start": {
			private ["_analysisJobs"];
			
			_debug = [_logic,"debug"] call ALIVE_fnc_hashGet;
			_analysisJobs = [_logic,"analysisJobs"] call ALIVE_fnc_hashGet;
			
			[_logic, _analysisJobs, _debug] spawn { 
			
				private ["_analysisJobs","_debug","_job","_args","_lastRun","_runEvery","_jobID","_jobMethod","_jobArgs"];
				
				_logic = _this select 0;
				_analysisJobs = _this select 1;
				_debug = _this select 2;
				
				waituntil {
					sleep 10;
					
					_jobsToCancel = [];
				
					{
						_job = _x;
						_args = [_job, "args"] call ALIVE_fnc_hashGet;
						_lastRun = [_job, "lastRun"] call ALIVE_fnc_hashGet;
						_runCount = [_job, "runCount"] call ALIVE_fnc_hashGet;
						_runEvery = _args select 0;
						_maxRunCount = _args select 1;
						_jobMethod = _args select 2;
						_jobID = _args select 3;
						_jobArgs = _args select 4;
						
						//["ALIVE Live Analysis - job: %1 lastRun: %2 runEvery: %3 timer: %4 runTimes: %5 of %6",_jobID,_lastRun,_runEvery,(time - _lastRun),_runCount,_maxRunCount] call ALIVE_fnc_dump;
						
						// run count maxed cancel the job
						if(_runCount > _maxRunCount && !(_maxRunCount == 0)) then {
							_jobsToCancel set [count _jobsToCancel, _jobID];
						}else{
							if((time - _lastRun) > _runEvery) then {		
							
							
								// DEBUG -------------------------------------------------------------------------------------
								if(_debug) then {
									["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
									["ALIVE Live Analysis - job: %1 lastRun: %2 runEvery: %3 runTimes: %4 of %5",_jobID,_lastRun,_runEvery,_runCount,_maxRunCount] call ALIVE_fnc_dump;
								};
								// DEBUG -------------------------------------------------------------------------------------
								
								
								switch(_jobMethod) do {
									case "gridProfileEntity":{
										[_logic, "runGridProfileEntityAnalysis", [_jobID,_jobArgs,_runCount]] call MAINCLASS;
									};
									case "intelligenceItem":{
										[_logic, "runIntelligenceItemAnalysis", [_jobID,_jobArgs,_runCount]] call MAINCLASS;
									};
								};
								
								[_job, "lastRun", time] call ALIVE_fnc_hashSet;
								[_job, "runCount", (_runCount + 1)] call ALIVE_fnc_hashSet;
							
							};					
							
							sleep 10;
						};					
				
					} forEach (_analysisJobs select 2);
					
					{
						[_logic, "cancelAnalysisJob", _x] call MAINCLASS;
					} forEach _jobsToCancel;
					
					false 
				};				
			};
		};
		case "runGridProfileEntityAnalysis": {
			
			private ["_jobID","_jobArgs","_sectors","_plotSectors","_debug"];
		
			if(typeName _args == "ARRAY") then {
			
				_jobID = _args select 0;
				_jobArgs = _args select 1;
				_plotSectors = _jobArgs select 0;
				
				_debug = [_logic,"debug"] call ALIVE_fnc_hashGet;
				
					
				// DEBUG -------------------------------------------------------------------------------------
				if(_debug) then {
					["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
					["ALIVE Live Analysis - grid entity profile positions"] call ALIVE_fnc_dump;
				};
				// DEBUG -------------------------------------------------------------------------------------
				
								
				// run profile analysis on all sectors
				_sectors = [ALIVE_sectorGrid] call ALIVE_fnc_gridAnalysisProfileEntity;

				if(_plotSectors) then {
					// clear the sector data plot
					[ALIVE_sectorPlotter, "clear"] call ALIVE_fnc_plotSectors;
					
					// plot the sector data
					[ALIVE_sectorPlotter, "plot", [_sectors, "entitiesBySide"]] call ALIVE_fnc_plotSectors;
				};
			
			};
        };
		case "cleanupGridProfileEntityAnalysis": {
			
			private ["_jobID","_jobArgs","_sectors","_plotSectors","_debug"];
		
			if(typeName _args == "ARRAY") then {
			
				_jobID = _args select 0;
				_jobArgs = _args select 1;
				_plotSectors = _jobArgs select 0;
				
				_debug = [_logic,"debug"] call ALIVE_fnc_hashGet;					
					
				// DEBUG -------------------------------------------------------------------------------------
				if(_debug) then {
					["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
					["ALIVE Live Analysis - cleanup grid entity profile positions"] call ALIVE_fnc_dump;
				};
				// DEBUG -------------------------------------------------------------------------------------
								

				// clear the sector data plot
				[ALIVE_sectorPlotter, "clear"] call ALIVE_fnc_plotSectors;
			
			};
        };
		case "runIntelligenceItemAnalysis": {
			
			private ["_jobID","_jobArgs","_runCount","_debug","_intelItem","_side","_sides","_objective",
			"_sector","_priority","_size","_center","_type","_state","_section","_objectiveID"];
		
			if(typeName _args == "ARRAY") then {
			
				_jobID = _args select 0;
				_jobArgs = _args select 1;
				_runCount = _args select 2;
				
				_debug = [_logic,"debug"] call ALIVE_fnc_hashGet;
				
					
				// DEBUG -------------------------------------------------------------------------------------
				if(_debug) then {
					["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
					["ALIVE Live Analysis - intelligence item id: %1", _jobID] call ALIVE_fnc_dump;
				};
				// DEBUG -------------------------------------------------------------------------------------
				
				
				_intelItem = _jobArgs select 0;
				
				_side = _intelItem select 0;
				_sides = _intelItem select 1;
				_objective = _intelItem select 3;
				_sector = _intelItem select 4;
				
				_center = [_objective,"center"] call ALIVE_fnc_hashGet;
				_size = [_objective,"size"] call ALIVE_fnc_hashGet;
				_priority = [_objective,"priority"] call ALIVE_fnc_hashGet;
				_type = [_objective,"type"] call ALIVE_fnc_hashGet;
				_state = [_objective,"tacom_state"] call ALIVE_fnc_hashGet;
				_section = [_objective,"section"] call ALIVE_fnc_hashGet;
				_objectiveID = [_objective,"objectiveID"] call ALIVE_fnc_hashGet;
				
				private ["_profiles","_markers","_profileID","_profile","_alpha","_marker","_color","_dir","_position","_icon"];
				
				// on the first run create all the markers
				if(_runCount == 0) then {

					_profiles = [];
					_markers = [];
					_alpha = 1;
					
					// create the profile marker
					{
						_profileID = _x;
						_profile = [ALIVE_profileHandler, "getProfile", _profileID] call ALIVE_fnc_profileHandler;
						if !(isnil "_profile") then {
							_marker = [_profile, "createMarker", [_alpha]] call ALIVE_fnc_profileEntity;
							_markers = _markers + _marker;
							_profiles set [count _profiles, _profileID];
							
							_position = _profile select 2 select 2;
							_dir = [_position, _center] call BIS_fnc_dirTo;
						};			
					} forEach _section;
					
					// set the side color
					switch(_side) do {
						case "EAST":{
							_color = "ColorRed";
						};
						case "WEST":{
							_color = "ColorBlue";
						};
						case "CIV":{
							_color = "ColorYellow";
						};
						case "GUER":{
							_color = "ColorGreen";
						};
						default {
							_color = [_logic,"debugColor","ColorGreen"] call ALIVE_fnc_hashGet;
						};
					};					
					
					// create the objective area marker					
					_m = createMarker [format[MTEMPLATE, _objectiveID], _center];
					_m setMarkerShape "Ellipse";
					_m setMarkerBrush "FDiagonal";
					_m setMarkerSize [_size, _size];
					_m setMarkerColor _color;
					_m setMarkerAlpha _alpha;
					
					_markers = _markers + [_m];			
				
					_icon = "mil_unknown";
					switch(_state) do {
						case "reserve":{
							_icon = "mil_marker";
						};
						case "recon":{
						
							// create direction marker
							_m = createMarker [format[MTEMPLATE, format["%1_dir", _objectiveID]], [_position, 100, _dir] call BIS_fnc_relPos];
							_m setMarkerShape "ICON";
							_m setMarkerSize [0.5,0.5];
							_m setMarkerType "mil_arrow";
							_m setMarkerColor _color;
							_m setMarkerAlpha _alpha;
							_m setMarkerDir _dir;							
							
							_markers = _markers + [_m];
						
							_icon = "mil_unknown";
						};
						case "capture":{
						
							// create direction marker
							_m = createMarker [format[MTEMPLATE, format["%1_dir", _objectiveID]], [_position, 100, _dir] call BIS_fnc_relPos];
							_m setMarkerShape "ICON";
							_m setMarkerSize [0.5,0.5];
							_m setMarkerType "mil_arrow2";
							_m setMarkerColor _color;
							_m setMarkerAlpha _alpha;
							_m setMarkerDir _dir;							
							
							_markers = _markers + [_m];
						
							_icon = "mil_warning";
						};
					};
					
					// create type marker
					_m = createMarker [format[MTEMPLATE, format["%1_type", _objectiveID]], _center];
					_m setMarkerShape "ICON";
					_m setMarkerSize [0.5, 0.5];
					_m setMarkerType _icon;
					_m setMarkerColor _color;
					_m setMarkerAlpha _alpha;					
					
					_markers = _markers + [_m];
					
					_jobArgs set [count _jobArgs, [_markers, _profiles]];
					
				// on subsequent runs lower marker alpha	
				} else {
				
					_markers = _jobArgs select 1 select 0;
					_profiles = _jobArgs select 1 select 1;
					
					// set alpha based on age of intel item
					if(_runCount <= 1) then {
						_alpha = 1;
					};
					if(_runCount == 2) then {
						_alpha = 0.75;
					};
					if(_runCount == 3) then {
						_alpha = 0.5;
					};
					if(_runCount > 3) then {
						_alpha = 0.2;
					};
					
					{
						_x setMarkerAlpha _alpha;
					} forEach _markers;
					
				};
			};
        };
		case "cleanupIntelligenceItemAnalysis": {
			
			private ["_jobID","_jobArgs","_runCount","_debug","_intelItem","_side","_sides","_objective","_sector","_center","_type","_state"];
		
			if(typeName _args == "ARRAY") then {
			
				_jobID = _args select 0;
				_jobArgs = _args select 1;
				
				_debug = [_logic,"debug"] call ALIVE_fnc_hashGet;
				
				_intelItem = _jobArgs select 0;
				
				// set item as completed
				_intelItem set [5, true];
				
					
				// DEBUG -------------------------------------------------------------------------------------
				if(_debug) then {
					["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
					["ALIVE Live Analysis - intelligence item id: %1", _jobID] call ALIVE_fnc_dump;
				};
				// DEBUG -------------------------------------------------------------------------------------
				
				
				private ["_profiles","_markers","_profileID","_profile","_alpha","_marker"];
				
				_markers = _jobArgs select 1 select 0;
				_profiles = _jobArgs select 1 select 1;
				
				{
					_profileID = _x;
					_profile = [ALIVE_profileHandler, "getProfile", _profileID] call ALIVE_fnc_profileHandler;
					if !(isnil "_profile") then {
						[_profile, "deleteMarker"] call ALIVE_fnc_profileEntity;
					};					
				} forEach _profiles;
				
				{
					deleteMarker _x;
				} forEach _markers;
			
			};
        };
        default {
                _result = [_logic, _operation, _args] call SUPERCLASS;
        };
};
TRACE_1("liveAnalysis - output",_result);
_result;