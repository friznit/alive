//Do not allow multiple executions
if (!isNil { ALIVE_supportCasInitialized }) exitWith {};
ALIVE_supportRadioInitialized = true;

//Functions module
waitUntil { !isNil { BIS_fnc_init } };

//Create Centers
createCenter WEST;
createCenter EAST;
createCenter CIVILIAN;
createCenter RESISTANCE;

//Functions
#include "\x\alive\addons\sup_cas\cas\functions\fn_init.sqf"

//Game Logic
ALIVE_radioLogic = _this select 0;
	 diag_log format ["Variable Radio Logic: %1", ALIVE_radioLogic];
//Server
//if (isServer) then 
//{
[ALIVE_radioLogic] execVM "\x\alive\addons\sup_cas\cas\init_server.sqf";
	 diag_log format ["Init Server: %1",ALIVE_radioLogic];
//};

//Client
if (!isDedicated) then 
{
	waitUntil { !isNil { player } };
	waitUntil { !isNull player };
	waitUntil { !(player != player) };
	
	//ALIVE_radioLogic setvariable ["ALIVE_radioPlayerActionArray",["CALL CAS","cas\radio_action.sqf","radio",-1,	false,true,	"", ""]];

	player addaction ["CALL CAS","\x\alive\addons\sup_cas\cas\radio_action.sqf","radio",-1,	false,true,	"", ""];
	player addEventHandler ["Respawn", { ["ALIVE_radioPlayerActionArray",["CALL CAS","\x\alive\addons\sup_cas\cas\radio_action.sqf","radio",-1,	false,true,	"", ""]]}];

	//player addAction (ALIVE_radioLogic getVariable "ALIVE_radioPlayerActionArray");
	//player addEventHandler ["Respawn", { (_this select 0) addAction (ALIVE_radioLogic getVariable "ALIVE_radioPlayerActionArray") }];
	
	player createDiarySubject ["About", "About"];
	player createDiaryRecord  ["About", ["Support Radio", 
	"
		
	"]];
	if (!isNil { ALIVE_notes }) then { ALIVE_notes = ALIVE_notes + 1 };
};
