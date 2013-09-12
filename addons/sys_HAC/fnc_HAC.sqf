#include <\x\alive\addons\sys_HAC\script_component.hpp>
SCRIPT(HAC);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_HAC
Description:
XXXXXXXXXX

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array - The selected parameters

Returns:
Any - The new instance or the result of the selected function and parameters

Attributes:
Boolean - debug - Debug enabled
Boolean - enabled - Enabled or disable module

Parameters:
none

Description:
HAC Controller! Detailed description to follow

Examples:
[_logic, "active", true] call ALiVE_fnc_HAC;

See Also:
- <ALIVE_fnc_HAC_init>

Author:
Highhead
---------------------------------------------------------------------------- */
private ["_logic","_operation","_args"];

PARAMS_1(_logic);
DEFAULT_PARAM(1,_operation,"");
DEFAULT_PARAM(2,_args,nil);

switch(_operation) do {
	default {
			private["_err"];
			_err = format["%1 does not support %2 operation", _logic, _operation];
			ERROR_WITH_TITLE(str _logic,_err);
	};
	case "init": {
		/*
		MODEL - no visual just reference data
		- server side object only
		- enabled/disabled
		*/
		
		//Waiting for missionnamespace
		waituntil {!(isnil "BIS_fnc_init")};
			
		if (isServer) then {
			private ["_LogicSide","_group"];
			// if server, initialise module game logic
			_logic setVariable ["super", SUPERCLASS];
			_logic setVariable ["class", ALIVE_fnc_HAC];
			
			//Add synchronized units from map and detect side
			_LogicSide = side ((synchronizedObjects _logic) select 0);
			_group = createGroup _LogicSide;
			[_logic] joinsilent _group;

			//Set default variables
			switch (_logicSide) do {
				case (EAST): {_LogicSide = "ColorRed"};
				case (WEST): {_LogicSide = "ColorBlue"};
				case (RESISTANCE): {_LogicSide = "ColorGreen"};
				case (CIVILIAN): {_LogicSide = "ColorYellow"};
				default {_LogicSide = "ColorRed"};
			};
				
		_logic setvariable ["HAC_HQ_Color",_LogicSide]; //Comment this line to have old debug colors
		_logic setvariable ["HAC_HQ_IdleOrd", true];
		_logic setvariable ["HAC_HQ_CargoFind", 200];
		_logic setvariable ["HAC_HQ_Rush", true];
		_logic setvariable ["HAC_HQ_MAtt", true];
		_logic setvariable ["HAC_HQ_Personality", (_logic getvariable ["HAC_HQ_Personality", "GENIUS"])];
		_logic setvariable ["HAC_HQ_SubAll", false];
		_logic setvariable ["HAC_HQ_SubSynchro", true];
		_logic setvariable ["HAC_HQ_ReSynchro", true];
		_logic setvariable ["HAC_BBa_HQs", [_logic]];
		_logic setvariable ["HAC_BB_Active", true];
		_logic setvariable ["HAC_BB_BBOnMap", false];
		_logic setvariable ["HAC_HQ_Wait", 15];
		_logic setvariable ["HAC_HQ_LZ",true];
		//_logic setvariable ["HAC_HQ_PathFinding",500];
				
			//Enable Debug
			if (call compile (_logic getvariable "HAC_Debug_Param_1")) then {
				_logic setvariable ["HAC_BB_Debug", true];   
			};
			if (call compile (_logic getvariable "HAC_Debug_Param_2")) then {
				_logic setvariable ["HAC_HQ_Debug", true];
			};
			if (call compile (_logic getvariable "HAC_Debug_Param_3")) then {
				_logic setvariable ["HAC_HQ_DebugII",true];
			};
			
			//Initialize Libraries
			[_logic] call (compile preprocessfile "\x\alive\addons\sys_HAC\HAC_Library.sqf");

			// and publicVariable Main class to clients
			private ["_id"];
			_id = count (missionNameSpace getvariable ["HAC_instances",[]]); 
			call compile format["HAC_TACOM_%1 = _logic",_id];
			missionNameSpace setVariable ["HAC_instances",(missionNameSpace getvariable ["HAC_instances",[]]) + [_logic]];
			
			Publicvariable (format["HAC_TACOM_%1",_id]);
			_logic setVariable ["init", true, true];

			format["HAC Module init finished: Logic %1...", _logic] call ALiVE_fnc_logger;
		} else {
			// if client clean up client side game logics as they will transfer
			// to servers on client disconnect
		};
			
	TRACE_2("After module init",_logic,_logic getVariable "init");
		// and wait for game logic to initialise
		// TODO merge into lazy evaluation
		waitUntil {!isNil "_logic"};
		waitUntil {_logic getVariable ["init", false]};
		
		/*
		CONTROLLER  - coordination
		- Start HAC Controller on Server
		*/

		if (isServer) then {
			waitUntil {_logic getVariable ["init", false]};
			[_logic, "active", true] call ALiVE_fnc_HAC;
			format["HAC activated on logic %1...", _logic] call ALiVE_fnc_logger;
		};
		
		/*
		VIEW - purely visual
		*/
	};
	
	case "destroy": {
		if (isServer) then {
			// if server
			_logic setVariable ["super", nil];
			_logic setVariable ["class", nil];
			_logic setVariable ["init", nil];
			// and publicVariable to clients
			
			for "_i" from 0 to ((count (missionNameSpace getvariable ["HAC_instances",[]])) - 1) do {
				private ["_id","_instance"];
				_id = _i;
				_instance = (missionNameSpace getvariable ["HAC_instances",[]]) select _i;
				if (_instance == _logic) exitwith {
					Publicvariable (format["HAC_TACOM_%1",_id]);
				};
			};
		};
		
		if(!isDedicated && !isHC) then {
				// TODO: remove 
		};
	};
	
	case "personality": {
		if(isNil "_args") then {
			// if no new personality was provided return current setting
			_args = _logic getVariable ["HAC_HQ_Personality", "GENIUS"];
		} else {
			// if a new personality setting was provided set personality
			ASSERT_TRUE(typeName _args == "STRING",str typeName _args);
			_logic setVariable ["HAC_HQ_Personality", _args, true];
			[_logic] call ALiVE_fnc_HAC_Personality;
		};
		_args;
	};
	
	case "addGroups": {
		if(isNil "_args") then {
			// if no list was provided return current setting
			_args = synchronizedObjects _logic;
		} else {
			// if a list was provided add groups
			ASSERT_TRUE(typeName _args == "ARRAY",str typeName _args);
			{
				private ["_grpL"];
				_grpL = leader (group _x);
				if !(_grpL in (synchronizedObjects _logic)) then {
					_logic synchronizeObjectsAdd [_grpL];
				};
				
			} foreach _args;
			_args = synchronizedObjects _logic;
		};
		_args;
	};
	
	case "delGroups": {
		if(isNil "_args") then {
			// if no new list was provided return current setting
			_args = synchronizedObjects _logic;
		} else {
			// if a new list was provided remove groups
			ASSERT_TRUE(typeName _args == "ARRAY",str typeName _args);
			{
				private ["_grp","_grpL"];
				if (typename _x == "GROUP") then {
					_grp = _x;
					_grpL = leader _x;
				} else {
					_grp = group _x;
					_grpL = leader (group _x);
				};
				if (({(group _x) == _grp} count (synchronizedObjects _logic)) > 0) then {
					_logic synchronizeObjectsRemove [_grpL];
					_logic setvariable ["HAC_HQ_Subordinated",((_logic getvariable "HAC_HQ_Subordinated") - [_grp])];
					_logic setvariable ["HAC_HQ_Friends",((_logic getvariable "HAC_HQ_Friends") - [_grp])];
					_logic setvariable ["HAC_HQ_LastSub",((_logic getvariable "HAC_HQ_LastSub") - [_grp])];
				};
			} foreach _args;
		};
		_args;
	};
	
	case "active": {
		if(isNil "_args") exitWith {
			_logic getVariable ["active", false];
		};
		ASSERT_TRUE(typeName _args == "BOOL",str _args);		
		
		// xor check args is different to current debug setting
		if(((_args || (_logic getVariable ["active", false])) && !(_args && (_logic getVariable ["active", false])))) then {
			ASSERT_TRUE(typeName _args == "BOOL",str _args);
			_logic setVariable ["active", _args];
			
			// if active
			if (_args) then {
				_logic setvariable ["HAC_BBa_InitDone", false];
				_logic setvariable ["HAC_BBa_Init", false];
				_logic setvariable ["HAC_xHQ_AllLeaders", (_logic getvariable ["HAC_xHQ_AllLeaders",[]]) + [_logic]];

				[_logic] call ALiVE_fnc_HAC_Front;
				[[(_logic getvariable "HAC_BBa_HQs"),"A"],_logic] spawn ALiVE_fnc_HAC_OPCOM;
				[_logic] spawn ALiVE_fnc_HAC_HQSitRep;
			}; // end if active
		};
	};
};
