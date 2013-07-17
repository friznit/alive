// ----------------------------------------------------------------------------

#include "script_component.hpp"	
SCRIPT(test_parseJSON_couchdb);

// ----------------------------------------------------------------------------

private ["_result","_err","_logic","_timeStart","_timeEnd","_testData"];

LOG("Testing Data parseJSON - Couchdb");

ASSERT_DEFINED("ALIVE_fnc_data","Class not defined");

//========================================
// Defines
#define STAT(msg) sleep 3; \
diag_log ["TEST("+str player+": "+msg]; \
titleText [msg,"PLAIN"];

#define STAT1(msg) CONT = false; \
waitUntil{CONT}; \
diag_log ["TEST("+str player+": "+msg]; \
titleText [msg,"PLAIN"];

#define DEBUGON STAT("Setup debug parameters"); \
_result = [_logic, "debug", true] call ALIVE_fnc_Data; \
_err = "enabled debug"; \
ASSERT_TRUE(typeName _result == "BOOL", _err); \
ASSERT_TRUE(_result, _err);

#define DEBUGOFF STAT("Disable debug"); \
_result = [_logic, "debug", false] call ALIVE_fnc_Data; \
_err = "disable debug"; \
ASSERT_TRUE(typeName _result == "BOOL", _err); \
ASSERT_TRUE(!_result, _err);

#define TIMERSTART \
_timeStart = diag_tickTime; \
diag_log "Timer Start";

#define TIMEREND \
_timeEnd = diag_tickTime - _timeStart; \
diag_log format["Timer End %1",_timeEnd];

//========================================
// Functions

//========================================
// Main

//DEBUGON

STAT("TEST JSON STRING CONVERSION TO CBA HASH");

// Convert JSON string to CBA Hash
_testData = [ 
	"{""_id"": ""2c8182f7ae935e655d52f3cdc80070fa"",""_rev"": ""1-efe34647c04a77464d1bac47af08bbd5"",""realTime"": ""12/07/2013 21:52:09"",""Server"": ""86.158.100.190"",""Operation"": ""MedicTest"",""Map"": ""Stratis"",""gameTime"": ""1415"",""Event"": ""OperationStart""}",
	"{""_id"": ""2c8182f7ae935e655d52f3cdc8008382"",""_rev"": ""1-685d3dc1ef673a05b9365c46f364f247"",""realTime"": ""12/07/2013 21:52:24"",""Server"": ""86.158.100.190"",""Operation"": ""MedicTest"",""Map"": ""Stratis"",""gameTime"": ""1415"",""Event"": ""Kill"",""KilledSide"": ""WEST"",""Killedfaction"": ""NATO"",""KilledType"": ""Combat Life Saver"",""KilledClass"": ""Infantry"",""KilledPos"": ""017057"",""KillerSide"": ""WEST"",""Killerfaction"": ""NATO"",""KillerType"": ""Combat Life Saver"",""KillerClass"": ""Infantry"",""KillerPos"": ""017057"",""Weapon"": ""MX 6.5Â mm"",""Distance"": 25,""Killed"": ""B Alpha 1-1:3"",""Killer"": ""B Alpha 1-1:2 (Matt) REMOTE"",""Player"": ""76561197982137286"",""PlayerName"": ""Matt"",""testArray"":[""string1"",""2"",""true""]}",
	"{""_id"": ""2c8182f7ae935e655d52f3cdc80062c1"",""_rev"": ""1-bb8d403becd9349e30c93c00f7072235"",""realTime"": ""12/07/2013 21:50:30"",""Server"": ""86.158.100.190"",""Operation"": ""TupolovRevenge"",""Map"": ""Stratis"",""gameTime"": ""0817"",""Event"": ""PlayerFinish"",""PlayerSide"": ""WEST"",""PlayerFaction"": ""BLU_F"",""PlayerName"": ""Matt"",""PlayerType"": ""B_Soldier_F"",""PlayerClass"": ""Rifleman"",""Player"": ""76561197982137286"",""shotsFired"": [{""weaponMuzzle"": ""arifle_MX_ACO_pointer_F"",""count"": 0,""weaponType"": ""arifle_MX_ACO_pointer_F"",""weaponName"": ""MX 6.5Â mm""},{""weaponMuzzle"": ""gatling_20mm"",""count"": 10,""weaponType"": ""gatling_20mm"",""weaponName"": ""Gatling Cannon 20Â mm""}],""timePlayed"": 2,""score"": 0,""rating"": 0}",
	"{""_id"": ""2c8182f7ae935e655d52f3cdc80062c2"",""_rev"": ""1-bb8d403becd9349e30c93c00f7072235"",""realTime"": ""16/07/2013 07:49:14"",""Server"":""86.158.100.190"",""Operation"":""TupolovRevenge"",""Map"":""Stratis"",""gameTime"":""0816"",""Event"":""PlayerFinish"",""PlayerSide"":""WEST"",""PlayerFaction"":""BLU_F"",""PlayerName"":""Matt"",""PlayerType"":""B_Soldier_F"",""PlayerClass"":""Rifleman"",""Player"":""76561197984147486"",""shotsFired"":{""weaponMuzzle"":""arifle_MX_ACO_pointer_F"",""count"":567,""weaponType"":""arifle_MX_ACO_pointer_F"",""weaponName"":""MX 6.5Ã‚Â mm""},""timePlayed"":1e+013,""score"":1e+014,""rating"":5e-007,""testArray"":[""test string"",0.5,1,12345.1,[""this is text"",""text"",5e-009,234.567,12345,""CIV"",""true"",""false""]]}"
];

{
	private ["_type","_msg","_converted"];
	_type = typeName _x;
	_msg = format["Test %1 - %2",_type, _x];
	STAT(_msg);
	sleep 1;
	TIMERSTART
	_converted = [_x] call ALIVE_fnc_parseJSON;
	TIMEREND
	ASSERT_TRUE([_converted] call CBA_fnc_isHash, str(_converted));
	STAT(str(_converted));
	sleep 1;
} foreach _testData;


STAT("Sleeping before destroy");
sleep 10;

nil;