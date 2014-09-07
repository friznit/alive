/*
 * Filename:
 * fnc_data_onPlayerDisconnected.sqf
 *
 * Description:
 * handled onPlayerDisconnected event for sys_data, saving dictionary data when the server disconnects
 *
 * Created by Tupolov
 * Creation date: 06/07/2013
 *
 * */

// ====================================================================================
// MAIN

#include <\x\alive\addons\sys_data\script_component.hpp>
SCRIPT(data_onPlayerDisconnected);

private ["_result","_name"];

TRACE_1("DATA SERVER DISCONNECT", _this);

_result = objNull;
_name = _this select 1;

if (_name == "__SERVER__") then {

	// Save mission date / time

	TRACE_2("LOGIC STATE MISSION", MOD(sys_data), MOD(sys_data) getVariable "saveDateTime");

	if !(GVAR(DISABLED)) then {

		diag_log[format["SYS_DATA: SERVER EXIT SAVING DATA"]];

		if (MOD(sys_data) getVariable ["saveDateTime","true"] == "true") then {

			[GVAR(mission_data), "date", date] call ALIVE_fnc_hashSet;
			[GVAR(mission_data), "Group", GVAR(GROUP_ID)] call ALIVE_fnc_hashSet;

			_missionName = format["%1_%2", GVAR(GROUP_ID), missionName];

			_result = [GVAR(datahandler), "write", ["sys_data", GVAR(mission_data), false, _missionName] ] call ALIVE_fnc_Data;
		};

		if (MOD(sys_data) getVariable ["disableAAR","true"] == "false") then {

			// Send the data to DB
			_missionName = format["%1_%2_%3", GVAR(GROUP_ID), missionName, GVAR(AARdocId)];

			_result = [GVAR(datahandler), "write", ["sys_aar", GVAR(AAR), false, _missionName] ] call ALIVE_fnc_Data;
			TRACE_1("SYS_AAR",_result);
		};

		// Save Data Dictionary
		TRACE_2("DATA DICTIONARY SIZE ",_missionName, [str(ALIVE_DataDictionary)] call CBA_fnc_strLen);
		if (([str(ALIVE_DataDictionary)] call CBA_fnc_strLen) > DATA_INBOUND_LIMIT) then {

			private ["_tempHash","_saveHash","_dictionaryName"];

			GVAR(tempHash) = [] call CBA_fnc_hashCreate;
			GVAR(hashCount) = 0;

			_saveHash = {

					if(([str(GVAR(tempHash))] call CBA_fnc_strLen) < DATA_INBOUND_LIMIT) then {
						TRACE_1("DICTIONARY HASH", [str(GVAR(tempHash))] call CBA_fnc_strLen);
						[GVAR(tempHash), _key, _value] call CBA_fnc_hashSet;
					} else {
						private ["_dictionaryName"];
						if (GVAR(hashCount) == 0) then {
							_dictionaryName = format["dictionary_%1_%2", GVAR(GROUP_ID), missionName];
						} else {
							_dictionaryName = format["dictionary_%1_%2_%3", GVAR(GROUP_ID), missionName, GVAR(hashCount)];
						};
						if (GVAR(hashCount) < count GVAR(DictionaryRevs)) then {
							[GVAR(tempHash), "_rev", GVAR(DictionaryRevs) select GVAR(hashCount)] call CBA_fnc_hashSet;
						};
						_result = [GVAR(datahandler), "write", ["sys_data", GVAR(tempHash), false, _dictionaryName] ] call ALIVE_fnc_Data;
						TRACE_2("SAVING DATA DICTIONARY ",_dictionaryName,_result);
						GVAR(tempHash) = [] call CBA_fnc_hashCreate;
						[GVAR(tempHash), _key, _value] call CBA_fnc_hashSet;
						GVAR(hashCount) = GVAR(hashCount) + 1;
					};

			};

			[ALIVE_DataDictionary, _saveHash] call CBA_fnc_hashEachPair;

			// Save the final dictionary entry

			if (GVAR(hashCount) == 0) then {
				_dictionaryName = format["dictionary_%1_%2", GVAR(GROUP_ID), missionName];
			} else {
				_dictionaryName = format["dictionary_%1_%2_%3", GVAR(GROUP_ID), missionName, GVAR(hashCount)];
			};
			if (GVAR(hashCount) < count GVAR(DictionaryRevs)) then {
				[GVAR(tempHash), "_rev", GVAR(DictionaryRevs) select GVAR(hashCount)] call CBA_fnc_hashSet;
			};
			_result = [GVAR(datahandler), "write", ["sys_data", GVAR(tempHash), false, _dictionaryName] ] call ALIVE_fnc_Data;
			TRACE_2("SAVING DATA DICTIONARY ",_dictionaryName,_result);


		} else {
			private ["_dictionaryName"];
			_dictionaryName = format["dictionary_%1_%2", GVAR(GROUP_ID), missionName];

			_result = [GVAR(datahandler), "write", ["sys_data", ALIVE_DataDictionary, false, _dictionaryName] ] call ALIVE_fnc_Data;

			TRACE_2("SAVING DATA DICTIONARY ",_dictionaryName,_result);
		};


	} else {
		diag_log[format["SYS_DATA: SERVER EXIT BUT DATA DISABLED"]];
	};
};

_result;


// ====================================================================================