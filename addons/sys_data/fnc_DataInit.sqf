#include <\x\alive\addons\sys_data\script_component.hpp>
SCRIPT(DataInit);

// Sets up a system for data (separate from the fnc_data module = datahandler)

LOG(MSG_INIT);
private ["_response","_dictionaryName","_logic","_config"];

PARAMS_1(_logic);

// Confirm init function available
ASSERT_DEFINED("ALIVE_fnc_Data","Main function missing");

TRACE_2("SYS_DATA",isDedicated, _logic);

["ALiVE [%1] %2 INIT",(getNumber(configfile >> "CfgVehicles" >>  typeOf _logic >> "functionPriority")),typeof _logic] call ALIVE_fnc_dump;

if (isDedicated) then {

	// Setup OPC and OPD events
	//[QGVAR(OPD), "OnPlayerDisconnected","ALIVE_fnc_data_OnPlayerDisconnected"] call BIS_fnc_addStackedEventHandler;

	MOD(sys_data) = _logic;

	//Set Data logic defaults
	GVAR(DISABLED) = false;
	publicVariable QGVAR(DISABLED);

	GVAR(databaseName) = "arma3live";
	GVAR(source) = MOD(sys_data) getVariable "source";
	GVAR(GROUP_ID) = [] call ALIVE_fnc_getGroupID;

	TRACE_1("Group Name", GVAR(GROUP_ID));


	// Setup data handler
	GVAR(datahandler) = [nil, "create"] call ALIVE_fnc_Data;

	// Setup Data Dictionary
	ALIVE_DataDictionary = [] call CBA_fnc_hashCreate;

	// Get global config information
	_config = [GVAR(datahandler), "read", ["sys_data", [], "config"]] call ALIVE_fnc_Data;

	TRACE_1("Config",_config);

	// Check that the config loaded ok, if not then stop the data module
	if (typeName _config == "STRING") exitWith {
		["CANNOT CONNECT TO DATABASE, DISABLING DATA MODULE"] call ALIVE_fnc_logger;
		GVAR(DISABLED) = true;
		publicVariable QGVAR(DISABLED);
	};

	// Check to see if the service is off
	if ([_config, "On"] call ALIVE_fnc_hashGet == "false") exitWith {
		["CONNECTED TO DATABASE, BUT SERVICE HAS BEEN TURNED OFF"] call ALIVE_fnc_logger;
		GVAR(DISABLED) = true;
		publicVariable QGVAR(DISABLED);
		MOD(sys_data) setvariable ["disablePerf", "true"];
		ALIVE_sys_perf_ENABLED = false;
		MOD(sys_data) setvariable ["disableStats", "true"];
		ALIVE_sys_statistics_ENABLED = false;
	};

	["CONNECTED TO DATABASE OK"] call ALIVE_fnc_logger;

	// Global config overrides module settings
	if ([_config, "PerfData","false"] call ALIVE_fnc_hashGet != "none") then {
		if ([_config, "PerfData","false"] call ALIVE_fnc_hashGet == "true") then {
			["CONNECTED TO DATABASE AND PERFDATA HAS BEEN TURNED ON"] call ALIVE_fnc_logger;
			MOD(sys_data) setvariable ["disablePerf", "false"];
			ALIVE_sys_perf_ENABLED = true;
		} else {
			["CONNECTED TO DATABASE, BUT PERFDATA HAS BEEN TURNED OFF"] call ALIVE_fnc_logger;
			MOD(sys_data) setvariable ["disablePerf", "true"];
			ALIVE_sys_perf_ENABLED = false;
		};
	};

	if ([_config, "EventData","false"] call ALIVE_fnc_hashGet == "false") then {
		["CONNECTED TO DATABASE, BUT STAT DATA HAS BEEN TURNED OFF"] call ALIVE_fnc_logger;
		ALIVE_sys_statistics_ENABLED = false;
	};


	ALIVE_sys_statistics_level = [_config, "EventLevel",5] call ALIVE_fnc_hashGet;

	// Load Data Dictionary from central public database

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

	TRACE_2("SYS_DATA PERF VAR", MOD(sys_data) getVariable "disablePerf", ALIVE_sys_perf_ENABLED);
	// Start the perf monitoring module
	if (MOD(sys_data) getvariable ["disablePerf", "true"] == "false") then {
		[MOD(sys_data)] call ALIVE_fnc_perfInit;
	};
};
TRACE_2("SYS_DATA STAT VAR", MOD(sys_data) getVariable "disableStats", ALIVE_sys_statistics_ENABLED);
// Kickoff the stats module
if (_logic getvariable ["disableStats","false"] == "false") then {
	[_logic] call ALIVE_fnc_statisticsInit;
};

["ALiVE [%1] %2 INIT COMPLETE",(getNumber(configfile >> "CfgVehicles" >>  typeOf _logic >> "functionPriority")),typeof _logic] call ALIVE_fnc_dump;
