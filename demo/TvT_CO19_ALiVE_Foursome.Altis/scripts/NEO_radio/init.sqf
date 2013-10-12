publicVariable "NEO_radioLogic";


private ["_exit"];
_exit = false;
if (count _this < 2) exitWith { hint "Support Radio\n\nNot enough parameters..." };
if (typeName (_this select 0) != typeName objNull) exitWith { hint "Support Radio\n\nParameter 0 must be an OBJECT..." };
for "_i" from 1 to (count _this - 1) do
{
	if (typeName (_this select _i) != typeName []) exitWith 
	{
		_exit = true;
		hint format ["Support Radio\n\nParameter %1 must be an ARRAY...", _i];
	};
};
if (_exit) exitWith {};

//Do not allow multiple executions
if (!isNil { NEO_supportRadioInitialized }) exitWith {};
NEO_supportRadioInitialized = true;

//Functions module
waitUntil { !isNil { BIS_fnc_init } };

//Create Centers
createCenter WEST;
createCenter EAST;
createCenter CIVILIAN;
createCenter RESISTANCE;

//Functions
#include "functions\fn_init.sqf"

//Game Logic
NEO_radioLogic = _this select 0;

_array = _this;

//Server
if (isServer) then 
{
	_this execVM "scripts\NEO_radio\init_server.sqf";
};

//JIP Client
if (!isDedicated) then 
{
	waitUntil { !isNil { player } };
	waitUntil { !isNull player };
	waitUntil { !(player != player) };
	
    //Define available actions locally
	NEO_radioLogic setVariable ["NEO_radioPlayerActionArray",
	    [ 
			[
				"Support Radio",
				"scripts\NEO_radio\radio_action.sqf",
				"radio",
				-1,
				false,
				true,
				"", 
				"
		        	_this == _target
					&&
					_this hasWeapon ""LaserDesignator""
				"
			],
			[
		    	"Talk with pilot",
		        "scripts\NEO_radio\radio_action.sqf",
		        "talk",
		        -1,
		        false,
		        true,
		        "",
				"
					(vehicle _this) in ((NEO_radioLogic getVariable format ['NEO_radioTrasportArray_%1', side _this]) select 0)
					&&
					{alive (driver (vehicle _this))}
		        "
		    ]
	    ]
    ];
	
    //Add Actions and eventhandler locally
	{player addAction _x} foreach (NEO_radioLogic getVariable "NEO_radioPlayerActionArray");
	player addEventHandler ["Respawn", { {(_this select 0) addAction _x } foreach (NEO_radioLogic getVariable "NEO_radioPlayerActionArray") }];
	
	//player addaction ["CALL CAS","\x\alive\addons\sup_cas\cas\radio_action.sqf","radio",-1,	false,true,	"", ""];
	//player addEventHandler ["Respawn", { ["ALIVE_radioPlayerActionArray",["CALL CAS","\x\alive\addons\sup_cas\cas\radio_action.sqf","radio",-1,	false,true,	"", ""]]}];
	
	player createDiarySubject ["About", "About"];
	player createDiaryRecord  ["About", ["Support Radio", 
	"
		<br/>
		Developer: Gunny port to A3 with _NEO_ kind permission
		<br/>
		Version: 1.00
		<br/>
		Credits: Neo, Highead the Roller Coaster, Frizzle for making me do it!
		<br/>
		<br/>
		<br/>
		Support Radio:
		<br/>
		- Support Radio is a interface that will help you control Artificial Intelligent units for support such as Transport (Air Taxi), Close Air Support and Artillery. Only units with an itemRadio and itemGps can access the Support Radio, if someone carriyng a Radio and Gps dies, someone else should pick it up so communication with support units become available.
		<br/>
		- To bring up the radio interface use your action menu Support Radio
		<br/>
		<br/>
		Transport:
		<br/>
		- Move - Make unit move to location and wait for further orders
		<br/>
		- Land - Make unit land at given location, if LZ is not safe enough, unit will find a near but safe LZ
		<br/>
		- Land (Eng Off) - Same as Land Task but unit will shutdown the engine
		<br/>
		- Circle - Make unit go to location and circle the area giving overwatch
		<br/>
		- Pickup - Make unit go to LZ, the unit will wait for visual on friendly smoke and will ask if it is correct smoke, player needs to use interface to confirm the smoke or that is wrong smoke
		<br/>
		- When inside a Transport unit you can talk with the pilot, where youll be able to control that vehicle only
		<br/>
		<br/>
		Close Air Support:
		<br/>
		- SAD - Seek and destroy enemy targets and unit will also engage all laser marked targets
		<br/>
		<br/>
		Artillery:
		<br/>
		- There are two types of Artillery batteries, static and non-static
		<br/>
		- If the battery is non-static it will be able to move around the map to get in range of target
		<br/>
		- It will wait for player interface before doing so
		<br/>
		- When near a artillery unit you can talk with the crew, where youll be able to control that artillery group only
		<br/>
	"]];
	if (!isNil { NEO_notes }) then { NEO_notes = NEO_notes + 1 };
};
