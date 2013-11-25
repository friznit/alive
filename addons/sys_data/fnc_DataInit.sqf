#include <\x\alive\addons\sys_data\script_component.hpp>
SCRIPT(DataInit);

// Sets up a system for data (separate from the fnc_data module = datahandler)

LOG(MSG_INIT);
private ["_response","_dictionaryName","_logic"];

PARAMS_1(_logic);

// Confirm init function available
ASSERT_DEFINED("ALIVE_fnc_Data","Main function missing");

TRACE_2("SYS_DATA",isDedicated, _logic);

if (isDedicated) then {

	// Setup OPC and OPD events
	//[QGVAR(OPD), "OnPlayerDisconnected","ALIVE_fnc_data_OnPlayerDisconnected"] call BIS_fnc_addStackedEventHandler;

	MOD(sys_data) = _logic;

	//Set Data logic defaults
	GVAR(databaseName) = MOD(sys_data) getVariable "databaseName";
	GVAR(source) = MOD(sys_data) getVariable "source";
	GVAR(GROUP_ID) = [] call ALIVE_fnc_getGroupID;

	// Load Data Dictionary from central public database?
	// Setup data handler
	GVAR(datahandler) = [nil, "create"] call ALIVE_fnc_Data;

	// Setup Data Dictionary
	ALIVE_DataDictionary = [] call CBA_fnc_hashCreate;
	_dictionaryName = format["dictionary_%1_%2", GVAR(GROUP_ID), missionName];
	// Try loading dictionary from db
	_response = [GVAR(datahandler), "read", ["sys_data", [], _dictionaryName]] call ALIVE_fnc_Data;
	if ( typeName _response != "STRING") then {
		ALIVE_DataDictionary = _response;
		GVAR(dictionaryLoaded) = true;
		TRACE_1("DICTIONARY LOADED", ALIVE_DataDictionary);
	} else {
		TRACE_1("NO DICTIONARY AVAILABLE",_response);
		// Need to cancel loading data if there is no dictionary
		GVAR(dictionaryLoaded) = false;
	};

	TRACE_2("DATA DICTIONARY", ALIVE_DataDictionary, _response);

	TRACE_3("SYS_DATA MISSION", _logic, MOD(sys_data), MOD(sys_data) getVariable "saveDateTime");

	// Handle basic mission persistence - date/time
	GVAR(mission_data) = [] call CBA_fnc_hashCreate;
	if (GVAR(dictionaryLoaded) && (MOD(sys_data) getVariable ["saveDateTime","true"] == "true")) then {
		private ["_missionName","_response"];
		// Read in date/time for mission
		_missionName = format["%1_%2", GVAR(GROUP_ID), missionName];
		_response = [GVAR(datahandler), "read", ["sys_data", [], _missionName]] call ALIVE_fnc_Data;
		if ( typeName _response != "STRING") then {
			GVAR(mission_data) = _response;
			TRACE_1("MISSION DATA LOADED", _response);
			setdate ([GVAR(mission_data), "date", date] call CBA_fnc_hashGet);
		} else {
			TRACE_1("NO MISSION DATA AVAILABLE",_response);
		};
	} else {
		TRACE_1("EITHER DATA LOAD FAILED OR MISSION DATA PERSISTENCE TURNED OFF", GVAR(dictionaryLoaded));
	};


	// Spawn a process to handle async writes

	// loop and wait for queue to be updated
	// When queue changes process request, wait for response
	GVAR(ASYNC_QUEUE) = [];
	publicVariable QGVAR(ASYNC_QUEUE);

	[] spawn {
		while {true} do {
			TRACE_1("ASYNC QUEUE COUNT", count GVAR(ASYNC_QUEUE));
			{
				private ["_cmd","_response"];
				_cmd = _x;

				"Arma2Net.Unmanaged" callExtension _cmd;

				waitUntil {sleep 0.3; _response = ["SendJSONAsync []"] call ALIVE_fnc_sendToPlugIn; ([_response] call CBA_fnc_strLen) > 0};

				REM(GVAR(ASYNC_QUEUE),_cmd);

				TRACE_3("ASYNC WRITE LOOP", _cmd, _response, count GVAR(ASYNC_QUEUE));

				sleep 0.3;

			} foreach GVAR(ASYNC_QUEUE);
			sleep 5;
		};
	};

	// Start the perf monitoring module
	if !(MOD(sys_data) getvariable ["disablePerf", "true"] == "true" || ALIVE_sys_perf_disabled) then {
		[MOD(sys_data)] call ALIVE_fnc_perfInit;
	};
};

// Kickoff the stats module
if !(_logic getvariable ["disableStats","false"] == "true" || ALIVE_sys_statistics_disabled) then {
	[_logic] call ALIVE_fnc_statisticsInit;
};

