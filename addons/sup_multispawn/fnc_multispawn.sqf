#include <\x\alive\addons\sup_multispawn\script_component.hpp>
SCRIPT(multispawn);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_multispawn
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

The popup menu will change to show status as functions are enabled and disabled.

Examples:
(begin example)
Create instance by placing editor module and specifiying name myModule
(end)

See Also:
- <ALIVE_fnc_multispawnInit>
- <ALIVE_fnc_multispawnMenuDef>

Author:
WobbleyHeadedBob, Highhead

Peer reviewed:
nil
---------------------------------------------------------------------------- */

#define SUPERCLASS nil

private ["_logic","_operation","_args","_result"];

PARAMS_1(_logic);
DEFAULT_PARAM(1,_operation,"");
DEFAULT_PARAM(2,_args,[]);

//Listener for special purposes
if (!isnil QMOD(SUP_MULTISPAWN) && {MOD(SUP_MULTISPAWN) getvariable [QGVAR(LISTENER),false]}) then {
	_blackOps = ["id"];
    
	if !(_operation in _blackOps) then {
	    _check = "nothing"; if !(isnil "_args") then {_check = _args};
        
		["op: %1 | args: %2",_operation,_check] call ALiVE_fnc_DumpR;
	};
};

switch(_operation) do {
        case "init": {                
                /*
                MODEL - no visual just reference data
                - server side object only
				- enabled/disabled
                */

                // Ensure only one module is used
                if (isServer && !(isNil "ALIVE_SUP_multispawn")) exitWith {
                        ERROR_WITH_TITLE(str _logic, localize "STR_ALIVE_multispawn_ERROR1");
                };
                
                if (isServer) then {
                        // if server, initialise module game logic
                        _logic setVariable ["super",SUPERCLASS];
                        _logic setVariable ["class",ALIVE_FNC_MULTISPAWN];
                        
                        MOD(SUP_MULTISPAWN) = _logic;
                        
                        GVAR(DEBUG) = call compile (_logic getvariable ["debug","false"]);
                        GVAR(MULTISPAWN_TYPE) = _logic getvariable ["spawntype","forwardspawn"];
                        
                        PublicVariable QGVAR(DEBUG);
                        PublicVariable QGVAR(MULTISPAWN_TYPE);
                        
                        // Create Store
                        GVAR(STORE) = [] call ALIVE_fnc_hashCreate;
                        
                        {
                            // Create Default RespawnMarkers if not existing
                            if !((format["Respawn_%1",_x]) call ALIVE_fnc_markerExists) then {createMarker [format["Respawn_%1",_x], getposATL _logic]};

                            _id = str(_x);
                            _sideData = [] call ALIVE_fnc_hashCreate;
                            
                            [_sideData,QGVAR(RESPAWNPOSITION), getmarkerPos format["Respawn_%",_x]] call ALiVE_fnc_HashSet;
                            [_sideData,QGVAR(MULTISPAWN_TYPE),_logic getvariable ["spawntype","forwardspawn"]] call ALiVE_fnc_HashSet;
                            [_sideData,QGVAR(TIMEOUT),call compile (_logic getvariable ["timeout","60"])] call ALiVE_fnc_HashSet;
                            [_sideData,QGVAR(PLAYERQUEUE), []] call ALiVE_fnc_HashSet;
                            [_sideData,QGVAR(INSERTING), false] call ALiVE_fnc_HashSet;
                            [_sideData,QGVAR(INSERTION_TRANSPORT), nil] call ALiVE_fnc_HashSet;

                            [GVAR(STORE),_id,_sideData] call ALiVE_fnc_HashSet;
                        } foreach (([] call BIS_fnc_ListPlayers) call ALiVE_fnc_AllSides);

                        PublicVariable QMOD(SUP_MULTISPAWN);
                        _logic setVariable ["init",true,true];
                } else {
                    
                };
                
                // and wait for game logic to initialise
                // TODO merge into lazy evaluation
                waitUntil {!isNil QMOD(SUP_MULTISPAWN) && {MOD(SUP_MULTISPAWN) getVariable ["init",false]}};

                /*
                VIEW - purely visual
                - initialise menu
                - frequent check to modify menu and display status (ALIVE_fnc_multispawnsmenuDef)
                */
                
                //Initialise locals if client and not HC
                if(hasInterface) then {
                    Waituntil {!isnil QGVAR(MULTISPAWN_TYPE)};

                    switch (GVAR(MULTISPAWN_TYPE)) do {
                        //Initialise a local "killed"-EH
                        case ("forwardspawn") : {
                        	//Not compatible with revive
                        	if ([QMOD(SYS_REVIVE)] call ALiVE_fnc_isModuleAvailable) exitwith {["ALiVE SUP MULTISPAWN - Revive is enabled, exiting Multispawn!"] call ALiVE_fnc_Dump}; 
                        
                        	["ALiVE SUP MULTISPAWN - Forward Spawn EH placed at %1...", time] call ALiVE_fnc_Dump;
                        	player addEventHandler ["killed", {if !(isnil "ALiVE_fnc_setGear") then {pLOADOUT = ["", [_this select 0]] call ALiVE_fnc_setGear}}];
                            player addEventHandler ["respawn", {titleText ["Respawn in progress...", "BLACK IN", 9999]; [] spawn ALiVE_fnc_ForwardSpawn}];
                        };
                            
                        case ("insertion") : {
                            
                            waituntil {!isnull player};
                            
                            ["ALiVE SUP MULTISPAWN - Insertion EH placed at %1...", time] call ALiVE_fnc_Dump;
                            player addEventHandler ["respawn", {[[ALiVE_SUP_MULTISPAWN,"collect",_this select 0], "ALiVE_fnc_MultiSpawn", false, false] call BIS_fnc_MP}];

                            [[ALiVE_SUP_MULTISPAWN,"collect",player], "ALiVE_fnc_MultiSpawn", false, false] call BIS_fnc_MP;
                        };
                        
                        default {};
                    };
                };
        };
        
        case "loader": {
            if !(isServer) exitwith {};
            
            private ["_player","_transport","_timer"];
            
            _player = [[_args], 0, objNull, [objNull]] call BIS_fnc_param;
            _sideData = [GVAR(STORE),str((typeOf _player) call ALiVE_fnc_classSide)] call ALiVE_fnc_HashGet;
            
            [[_logic,"disablePlayer",_player], "ALiVE_fnc_MultiSpawn", owner _player, false] call BIS_fnc_MP;
            
            sleep 2; _player setpos [0,0,1000];
			waituntil {
                sleep 1;
                
                if (isnil "_timer" || {time - _timer > 30}) then {
                    ALiVE_SUP_MULTISPAWN_TXT_LISTENER = format["Time to liftoff: T %1 minutes!",ceil((call compile(format["ALiVE_SUP_MULTISPAWN_COUNTDOWN_%1",(typeOf _player) call ALiVE_fnc_classSide]))/60)];
                    (owner _player) PublicVariableClient "ALiVE_SUP_MULTISPAWN_TXT_LISTENER";
                    
                    _timer = time;
                };
                
                _transport = [_sideData,QGVAR(INSERTION_TRANSPORT)] call ALiVE_fnc_HashGet; !isnil "_transport" && {_player in _transport};
            };
            sleep 2;
            
            [[_logic,"enablePlayer",_player], "ALiVE_fnc_MultiSpawn", owner _player, false] call BIS_fnc_MP;
        };
        
        case "enablePlayer": {
            if !(hasInterface) exitwith {};
            
            private ["_player"];
            
            _player = [[_args], 0, objNull, [objNull]] call BIS_fnc_param;
            
            if !(player == _player) exitwith {};
            
            _player enableSimulation true; _player hideObject false;
            _player setcaptive false; 1 fadesound 1; // disableUserinput false;
            
            _player setvariable [QGVAR(LOADER),false,true];
        };
        
        case "disablePlayer": {
            if !(hasInterface) exitwith {};
            
            private ["_player","_tgts"];
            
            _player = [[_args], 0, objNull, [objNull]] call BIS_fnc_param;
            
            if !(player == _player) exitwith {};
            
            _player setvariable [QGVAR(LOADER),true,true];

            _player setcaptive true; 1 fadesound 0; // disableUserinput true;
            _player enableSimulation false; _player hideObject true;
            
            _tgts = []; {if !((leader _x) getvariable [QGVAR(LOADER),false]) then {_tgts set [count _tgts, leader _x]}} foreach allGroups;
            _loader = [
				_tgts,							
				"Preparing insertion vehicle...",			
				300,							
				300,							
				90,							
				1,							
				[],
				0,
				[[_player],{!((_this select 0) getvariable ["ALiVE_SUP_MULTISPAWN_LOADER",false])}]
			] spawn ALiVE_fnc_establishingShotCustom;
        };
        
        case "insert": {
            if !(isServer) exitwith {};

            private ["_StartPos","_EndPos","_transport","_TransportType","_side","_queue"];
            
            _startPos = [_args, 0, [0,0,100], [[]]] call BIS_fnc_param;
            _endPos = [_args, 1, getMarkerpos "Respawn_West", [[]]] call BIS_fnc_param;
            _side = [_args, 2, "WEST", [""]] call BIS_fnc_param;
            _timeOut = [_args, 3, 30, [-1]] call BIS_fnc_param;
            _time = time;
            
            //////////////////////////////////////////////
            // Pre Start Checks
            
            switch (_side) do {
                case ("WEST") : {_TransportType = "B_Heli_Transport_01_F"};
                case ("EAST") : {_TransportType = "O_Heli_Transport_01_F"};
                case ("GUER") : {_TransportType = "I_Heli_Transport_02_F"};
                default {_TransportType = "B_Heli_Transport_01_F"};
            };

            _sideData = [GVAR(STORE),_side] call ALiVE_fnc_HashGet;
            _queue = [_sideData, QGVAR(PLAYERQUEUE),[]] call ALiVE_fnc_HashGet;
            _cargoCount = getNumber(configFile >> "cfgVehicles" >> _TransportType >> "transportSoldier");
            
            if ([_sideData,QGVAR(INSERTING),false] call ALiVE_fnc_HashGet) exitwith {};
            [_sideData,QGVAR(INSERTING),true] call ALiVE_fnc_HashSet;
            //////////////////////////////////////////////


			//////////////////////////////////////////////
			// Conditions to be true to start insertion
            
            waituntil {
                sleep 1;
                
                call compile format["ALiVE_SUP_MULTISPAWN_COUNTDOWN_%1 = (time - _time - _timeOut)",_side];

                (
	                (count _queue > 0 && // There are players waiting for respawn
	                {time - _time > _timeOut}) // and timeout has passed
	                
	                || // or
	                
	                {count _queue >= _cargoCount} // Cargo is full
                )
                
                && // and
                
                {isNil {[_sideData, QGVAR(INSERTION_TRANSPORT)] call ALiVE_fnc_HashGet}} // former insertion is finished
			};
            //////////////////////////////////////////////

                        
            //////////////////////////////////////////////
            // Start Insertion
                  
            _dataSet = [_startpos, 0, _TransportType, _TransportType call ALiVE_fnc_classSide] call bis_fnc_spawnvehicle;
            _transport = _dataSet select 0;
            _units = _dataSet select 1;
            _group = _dataSet select 2;
            
            [_sideData,QGVAR(INSERTION_TRANSPORT), _transport] call ALiVE_fnc_HashSet;
            _transport setvariable [QGVAR(INSERTION_TRANSPORT),_dataSet];

            {[[[_x,_transport], {(_this select 0) moveInCargo (_this select 1)}], "BIS_fnc_spawn", owner _x, false] call BIS_fnc_MP; sleep 0.1; _queue set [_foreachIndex,objNull]} foreach _queue; [_sideData, QGVAR(PLAYERQUEUE),_queue - [objNull]] call ALiVE_fnc_HashSet;

            _wp = _group addWaypoint [_EndPos, 0];
            _wp setWaypointType "MOVE";
            _wp setWaypointSpeed "FULL";
            _wp setWaypointStatements ["true", "
            	(group this) setspeedmode 'LIMITED';
            	(vehicle this) land 'land';
			"];
            //////////////////////////////////////////////


            //////////////////////////////////////////////
            // Conditions for finished insertion            
            waituntil {
                sleep 1;
                !canMove _transport || 
                {
                    ((getpos _transport) select 2) < 1 && 
                    {{_x in _transport} count ([] call BIS_fnc_ListPlayers) == 0}
                }
			};
            //////////////////////////////////////////////

                        
            //////////////////////////////////////////////
            // Finalising

            [_sideData,QGVAR(INSERTING),false] call ALiVE_fnc_HashSet;
            
            if !(canMove _transport) then {
                _data = +(_transport getvariable [QGVAR(INSERTION_TRANSPORT),[objNull,[],grpNull]]);
                _sideData = [GVAR(STORE),_side] call ALiVE_fnc_HashGet;
                
                _transport setvariable [QGVAR(INSERTION_TRANSPORT),nil];
                [_sideData,QGVAR(INSERTION_TRANSPORT)] call ALiVE_fnc_HashRem;
                
                sleep 60;
                
            	{deleteVehicle _x} foreach (_data select 1);
                deleteGroup (_data select 2);
            } else {
	            _wp = _group addWaypoint [_StartPos, 0];
	            _wp setWaypointSpeed "FULL";
	            _wp setWaypointStatements ["true", "
	                _vehicle = vehicle this;
	                _data = +(_vehicle getvariable ['ALiVE_SUP_MULTISPAWN_INSERTION_TRANSPORT',[objNull,[],grpNull]]);
	                _sideData = [ALiVE_SUP_MULTISPAWN_STORE,str(side this)] call ALiVE_fnc_HashGet;
	                
	                _vehicle setvariable ['ALiVE_SUP_MULTISPAWN_INSERTION_TRANSPORT',nil];
	                [_sideData,'ALiVE_sup_multispawn_INSERTION_TRANSPORT'] call ALiVE_fnc_HashRem;
	                
	            	{deleteVehicle _x} foreach (_data select 1);
	                deleteGroup (_data select 2);
	                deleteVehicle (_data select 0);
				"];
        	};
            //////////////////////////////////////////////
        };
        
        case "collect": {
            if !(isServer) exitwith {};
            
            private ["_player","_insertion","_destination","_transport","_timeout"];
            
            _player = [[_args], 0, objNull, [objNull]] call BIS_fnc_param;
            
            _sideData = [GVAR(STORE),str(side _player)] call ALiVE_fnc_HashGet;
            _transport = [_sideData,QGVAR(INSERTION_TRANSPORT)] call ALiVE_fnc_HashGet;
            _inserting = [_sideData,QGVAR(INSERTING),false] call ALiVE_fnc_HashGet;
            _timeout = [_sideData,QGVAR(TIMEOUT),60] call ALiVE_fnc_HashGet;
            
            if ((format["ALiVE_SUP_MULTISPAWN_INSERTION_%1",side _player]) call ALiVE_fnc_markerExists) then {_insertion = getMarkerPos (format["ALiVE_SUP_MULTISPAWN_INSERTION_%1",side _player])} else {_insertion = [1000,1000,100]};
            if ((format["ALiVE_SUP_MULTISPAWN_DESTINATION_%1",side _player]) call ALiVE_fnc_markerExists) then {_destination = getMarkerPos (format["ALiVE_SUP_MULTISPAWN_DESTINATION_%1",side _player])} else {_destination = getMarkerPos format["Respawn_%1", side _player]};

			if (!isnil "_transport" && {_inserting}) then {
                [[[_player,_transport], {(_this select 0) moveInCargo (_this select 1)}], "BIS_fnc_spawn", owner _player, false] call BIS_fnc_MP;
            } else {
                [_sideData,QGVAR(PLAYERQUEUE),([_sideData,QGVAR(PLAYERQUEUE),[]] call ALiVE_fnc_HashGet) + [_player]] call ALiVE_fnc_HashSet;
                [_logic,"loader",_player] spawn ALiVE_fnc_MultiSpawn;
                
                [_logic,"insert",[_insertion,_destination,str(side _player),_timeout]] spawn ALiVE_fnc_MultiSpawn;
            };
        };
        
        case "destroy": {
                if (isServer) then {
                        // if server
                        _logic setVariable ["super", nil];
                        _logic setVariable ["class", nil];
                        _logic setVariable ["init", nil];
                        // and publicVariable to clients
                        
                        MOD(MULTISPAWN) = _logic;
                        publicVariable QMOD(MULTISPAWN);
                };
                
                if(!isDedicated && !isHC) then {
                        // remove main menu
                        [
                                "player",
                                [SELF_INTERACTION_KEY],
                                -9500,
                                [
                                        "call ALIVE_fnc_multispawnMenuDef",
                                        "main"
                                ]
                        ] call CBA_fnc_flexiMenu_Remove;
                };
        };
        default {
                private["_err"];
                _err = format["%1 does not support %2 operation", _logic, _operation];
                ERROR_WITH_TITLE(str _logic,_err);
        };
};

if !(isnil "_result") then {
    if (!isnil QMOD(SUP_MULTISPAWN) && {MOD(SUP_MULTISPAWN) getvariable [QGVAR(LISTENER),false]}) then {
        ["op: %1 | result: %2",_operation,_result] call ALiVE_fnc_DumpR;
    };
    
    _result;
};