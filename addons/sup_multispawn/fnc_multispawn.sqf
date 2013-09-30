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
WobbleyHeadedBob

Peer reviewed:
nil
---------------------------------------------------------------------------- */

#define SUPERCLASS nil

private ["_logic","_operation","_args"];

PARAMS_1(_logic);
DEFAULT_PARAM(1,_operation,"");
DEFAULT_PARAM(2,_args,[]);

switch(_operation) do {
        case "init": {                
                /*
                MODEL - no visual just reference data
                - server side object only
				- enabled/disabled
                */
                
                // Ensure only one module is used
                if (isServer && !(isNil "ALIVE_multispawn")) exitWith {
                        ERROR_WITH_TITLE(str _logic, localize "STR_ALIVE_multispawn_ERROR1");
                };
                
                if (isServer) then {
                        // if server, initialise module game logic
                        _logic setVariable ["super", SUPERCLASS];
                        _logic setVariable ["class", ALIVE_fnc_multispawn];
                        _logic setVariable ["init", true,true];
                        
                        _debug = call compile (_logic getvariable ["debug","false"]);
                        MULTISPAWN_TYPE = _logic getvariable ["spawntype","forwardspawn"]; PublicVariable "MULTISPAWN_TYPE";
                        
                        
                        // and publicVariable to clients
                        ALIVE_multispawn = _logic;
                        publicVariable "ALIVE_multispawn";
                        
                        /*
                        // Wobbleyehadedbob - New Code ------------------------------------------------------------------
                        private ["_isMHQ","_initMHQs","_mhqVehicles"];
                        
                        // Build the initial array of all MHQ Vehicles placed in the editor - THIS IS BORKED !!!
                        _initMHQs = [vehicles] call compile preprocessFile "\x\alive\addons\sup_multispawn\scripts\init_server_MHQs.sqf";
                                                                       
                        // Converts an MHQ object into either a static FOB building of mobile HQ vehicle
                        // ALIVE_fnc_multispawnConvert = compile preprocessFileLineNumbers "\x\alive\addons\sup_multispawn\functions\fnc_multispawnConvert.sqf";
                                
                        // Listens for MHQ state-change events from the client(s)
                        PV_server_syncHQState = [99, ""]; 
                        "PV_server_syncHQState" addPublicVariableEventHandler {(_this select 1) call ALIVE_fnc_multispawnSyncState;};
                        // ----------------------------------------------------------------------------------------------
                        */

                } else {
                        // if client clean up client side game logics as they will transfer
                        // to servers on client disconnect
                        
                        /*
                        deleteVehicle _logic;

                        // Wobbleyehadedbob - New Code ------------------------------------------------------------------
                        waituntil{!isNil "PV_hqArray"};

                        if (isNil "PV_client_syncHQState") then
                        {
                          // set the nil variable with a default value for server and both JIP & 'join at mission start' 
                          PV_client_syncHQState = [99, ""]; 
                        };
                        
                        // Listens for MHQ state-change events from the server
                        "PV_client_syncHQState" addPublicVariableEventHandler {(_this select 1) call ALIVE_fnc_multispawnSyncState};
                        // ----------------------------------------------------------------------------------------------
                        */
                };
                
                // and wait for game logic to initialise
                // TODO merge into lazy evaluation
                waitUntil {(!(isNil "ALIVE_multispawn") && {ALIVE_multispawn getVariable ["init", false]})};

                /*
                VIEW - purely visual
                - initialise menu
                - frequent check to modify menu and display status (ALIVE_fnc_multispawnsmenuDef)
                */
                
                //Initialise locals if client and not HC
                if(!isDedicated && !isHC) then {
                    Waituntil {!(isnil "MULTISPAWN_TYPE")};
                    
                    switch (MULTISPAWN_TYPE) do {
                        //Initialise a local "killed"-EH
                        case ("forwardspawn") : {diag_log format["Forward Spawn EH placed...",time]; player addEventHandler ["killed", {[] spawn ALiVE_fnc_ForwardSpawn}]};
                        default {};
                    };
                    
                    	/*
                        // Initialise interaction key if undefined
                        if(isNil "SELF_INTERACTION_KEY") then {SELF_INTERACTION_KEY = [221,[false,false,false]];};
                        // if ACE spectator enabled, seto to allow exit
                        if(!isNil "ace_fnc_startSpectator") then {ace_sys_spectator_can_exit_spectator = true;};
                        // initialise main menu
                        [
                                "player",
                                [SELF_INTERACTION_KEY],
                                -9500,
                                [
                                        "call ALIVE_fnc_multispawnMenuDef",
                                        "main"
                                ]
                        ] call CBA_fnc_flexiMenu_Add;
                        
                        // Wobbleyehadedbob - New Code ------------------------------------------------------------------
                        waituntil{!isNil "PV_hqArray"};
        
                        // Initialise the default spawn locations and Deploy/Undeploy/SignIn actions on all HQ objects.
                        {[_x] call ALIVE_fnc_multispawnAddAction} forEach PV_hqArray;
                        myRespawnPoint = (markerPos format["respawn_%1", faction player]);
                        if (str myRespawnPoint == "[0,0,0]") then
                        {
                                myRespawnPoint = (markerPos format["respawn_%1", side player]);
                        };
                        
                        // Event Handler that calls the player relocation on respawn
                        player addEventhandler ["respawn", {[player] call ALIVE_fnc_multispawnRelocatePlayer}];
                        // ----------------------------------------------------------------------------------------------
                        */
                };
                
        };
        case "destroy": {
                if (isServer) then {
                        // if server
                        _logic setVariable ["super", nil];
                        _logic setVariable ["class", nil];
                        _logic setVariable ["init", nil];
                        // and publicVariable to clients
                        ALIVE_multispawn = _logic;
                        publicVariable "ALIVE_multispawn";
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
