#include <\x\alive\addons\sys_data\script_component.hpp>
SCRIPT(DataInit);

#define AAR_DEFAULT_INTERVAL 10

// Sets up a system for data (separate from the fnc_data module = datahandler)

LOG(MSG_INIT);
private ["_response","_dictionaryName","_logic","_config","_moduleID"];

PARAMS_1(_logic);

// Confirm init function available
ASSERT_DEFINED("ALIVE_fnc_Data","Main function missing");

TRACE_2("SYS_DATA",isDedicated, _logic);

_moduleID = [_logic, true] call ALIVE_fnc_dumpModuleInit;

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
	ALIVE_DataDictionary = [] call ALIVE_fnc_hashCreate;

	// Get global config information
	_config = [GVAR(datahandler), "read", ["sys_data", [], "config"]] call ALIVE_fnc_Data;

	TRACE_1("Config",_config);

	// Check that the config loaded ok, if not then stop the data module
	if (typeName _config == "STRING") exitWith {
		["CANNOT CONNECT TO DATABASE, DISABLING DATA MODULE"] call ALIVE_fnc_logger;
		GVAR(DISABLED) = true;
		publicVariable QGVAR(DISABLED);
		MOD(sys_data) setvariable ["disableStats", "true"];
		ALIVE_sys_statistics_ENABLED = false;
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

	if ([_config, "AAR","false"] call ALIVE_fnc_hashGet == "false") then {
		["CONNECTED TO DATABASE, BUT AAR HAS BEEN TURNED OFF"] call ALIVE_fnc_logger;
		ALIVE_sys_AAR_ENABLED = false;
	} else {
		ALIVE_sys_AAR_ENABLED = true;
	};

	// Set event level on data module
 	ALIVE_sys_statistics_EventLevel = parseNumber([_config, "EventLevel","5"] call ALIVE_fnc_hashGet);
	// Set stats level
	MOD(sys_data) setVariable ["EventLevel", ALIVE_sys_statistics_EventLevel, true];

	// Load Data Dictionary from central public database
	_dictionaryName = format["dictionary_%1_%2", GVAR(GROUP_ID), missionName];

	GVAR(DictionaryRevs) = [];

	// Try loading dictionary from db
	_response = [GVAR(datahandler), "read", ["sys_data", [], _dictionaryName]] call ALIVE_fnc_Data;
	if ( typeName _response != "STRING") then {
		ALIVE_DataDictionary = _response;

		// Capture Dictionary revision information
		GVAR(DictionaryRevs) set [count GVAR(DictionaryRevs), [ALIVE_DataDictionary, "_rev"] call CBA_fnc_hashGet];

		// Try loading more dictionary entries
		private ["_i","_newresponse","_addResponse"];
		_i = 1;
		while {_dictionaryName = format["dictionary_%1_%2_%3", GVAR(GROUP_ID), missionName, _i]; _newresponse = [GVAR(datahandler), "read", ["sys_data", [], _dictionaryName]] call ALIVE_fnc_Data; typeName _newresponse != "STRING"} do {

			_addResponse = {
				[ALIVE_DataDictionary, _key, _value] call CBA_fnc_hashSet;
			};

			[_newresponse, _addResponse] call CBA_fnc_hashEachPair;
			GVAR(DictionaryRevs) set [count GVAR(DictionaryRevs), [_newresponse, "_rev"] call CBA_fnc_hashGet];
			_i = _i + 1;
		};

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

	TRACE_2("SYS_DATA AAR VAR", MOD(sys_data) getVariable "disableAAR", ALIVE_sys_AAR_ENABLED);
	// Start the AAR monitoring module
	if (MOD(sys_data) getvariable ["disableAAR", "true"] == "false") then {

		[] spawn {
			// Thread running on server to report state/pos of every playable unit and group every 60 seconds
			private ["_count","_docId","_missionName","_result","_year","_month","_day","_hour","_min","_datet"];

			// Set up hash of unit positions for each minute
			GVAR(AAR) = [] call ALIVE_fnc_hashCreate;

			// Count minutes since last save to DB
			_count = 0;

			_datet = [] call ALIVE_fnc_getServerTime;
			_day = parseNumber ([_datet, 1, 2] call bis_fnc_trimString);
			_month = parseNumber ([_datet, 4, 5] call bis_fnc_trimString);
			_year = parseNumber ([_datet, 7, 11] call bis_fnc_trimString);
			_hour = parseNumber ([_datet, 13, 14] call bis_fnc_trimString);
			_min = parseNumber ([_datet, 16, 17] call bis_fnc_trimString);

			GVAR(AARdocId) = [[_year,_month,_day,_hour,_min]] call ALIVE_fnc_dateToDTG;

			waitUntil {sleep 60; count playableUnits > 0};

			while {MOD(sys_data) getVariable "disableAAR" == "false"} do {

				private ["_hash","_dateTime","_currenttime","_minutes","_hours","_gametime"];

				//diag_log format["Units: %1",count allUnits];

				// Get local time and format please.
				_currenttime = date;

				// Work out time in 4 digits
				if ((_currenttime select 4) < 10) then {
					_minutes = "0" + str(_currenttime select 4);
				} else {
					_minutes = str(_currenttime select 4);
					};
				if ((_currenttime select 3) < 10) then {
					_hours = "0" + str(_currenttime select 3);
				} else {
					_hours = str(_currenttime select 3);
				};

				_gametime = format["%1%2", _hours, _minutes];

				_hash = [] call ALIVE_fnc_hashCreate;

				{
					private ["_unit"];
					_unit = vehicle _x;
					if (alive _unit && (isplayer _x || _unit == leader (group _unit))) then {
						private ["_id","_playerHash","_icon"];

						_id = netid _unit;

						_playerHash = [] call ALIVE_fnc_hashCreate;

						[_playerHash, "AAR_name", name _unit] call ALIVE_fnc_hashSet;
						[_playerHash, "AAR_pos", getpos _unit] call ALIVE_fnc_hashSet;
						[_playerHash, "AAR_weapon", primaryWeapon _unit] call ALIVE_fnc_hashSet;
						[_playerHash, "AAR_dir", ceil(getdir _unit)] call ALIVE_fnc_hashSet;
						[_playerHash, "AAR_class", getText (configFile >> "cfgVehicles" >> (typeof _unit) >> "displayName")] call ALIVE_fnc_hashSet;
						[_playerHash, "AAR_damage", damage _unit] call ALIVE_fnc_hashSet;
						[_playerHash, "AAR_side", side (group _unit)] call ALIVE_fnc_hashSet;
						[_playerHash, "AAR_fac", getText (configFile >> "cfgFactionClasses" >> (faction _unit) >> "displayName")] call ALIVE_fnc_hashSet;
						[_playerHash, "AAR_isLeader", _unit == leader (group _unit)] call ALIVE_fnc_hashSet;
						[_playerHash, "AAR_isPlayer", isPlayer _unit] call ALIVE_fnc_hashSet;
						[_playerHash, "AAR_group", str (group _unit)] call ALIVE_fnc_hashSet;
						[_playerHash, "AAR_gametime", _gametime] call ALIVE_fnc_hashSet;

						if (isPlayer _unit) then {
							[_playerHash, "AAR_playerUID", getPlayerUID _unit] call ALIVE_fnc_hashSet;
						};

						[_hash, _id, _playerHash] call ALIVE_fnc_hashSet;

					};
				} forEach allUnits;

				_dateTime = [] call ALIVE_fnc_getServerTime;

				[GVAR(AAR), _dateTime, _hash] call ALIVE_fnc_hashSet;

				if (_count > AAR_DEFAULT_INTERVAL) then {

					// Send the data to DB
					_missionName = format["%1_%2_%3", GVAR(GROUP_ID), missionName, GVAR(AARdocId)];

					_result = [GVAR(datahandler), "write", ["sys_aar", GVAR(AAR), true, _missionName] ] call ALIVE_fnc_Data;
					TRACE_1("SYS_AAR",_result);

					// Reset
					GVAR(AAR) = [] call ALIVE_fnc_hashCreate;
					_count = 0;
					GVAR(AARdocId) = [date] call ALIVE_fnc_dateToDTG;
				};

				sleep 60;

				_count = _count + 1;

			};
			Diag_log "AAR system stopped";
		};
	};
};

TRACE_2("SYS_DATA STAT VAR", MOD(sys_data) getVariable "disableStats", ALIVE_sys_statistics_ENABLED);
// Kickoff the stats module
if (_logic getvariable ["disableStats","false"] == "false") then {
	[_logic] call ALIVE_fnc_statisticsInit;
};

if (isDedicated && {!isnil QMOD(SYS_DATA)}) then {
	MOD(sys_data) setvariable ["startupComplete",true,true];
};

[_logic, false, _moduleID] call ALIVE_fnc_dumpModuleInit;