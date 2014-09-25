#include <\x\alive\addons\sys_playertags\script_component.hpp>
SCRIPT(playertags);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_playertags
Description:
Creates the server side object to store settings

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array - The selected parameters

Returns:
Any - The new instance or the result of the selected function and parameters

Attributes:
Boolean - debug - Debug enabled
Boolean - group - Display player group enabled
Boolean - rank - Display player rank enabled
Boolean - invehicle - Display player tags in vehicles enabled
Number  - distance - Sets player name tag distance
Number  - tolerance - Sets player name tag tolerance
Number  - scale - Sets player name tag scale
String  - namecolour - Sets name colour
String  - groupcolour - Sets group colour
String  - thisgroupleadernamecolour - Sets player's group leader colour
String  - thisgroupcolour - Sets player's group colour

The popup menu will change to show status as function is enabled and disabled.


Examples:
(begin example)
// Create instance by placing editor module and specifiying name myModule
(end)

See Also:
- <ALIVE_fnc_playertagsInit>
- <ALIVE_fnc_playertagsMenuDef>

Author:
Jman

Peer reviewed:
nil
---------------------------------------------------------------------------- */

#define SUPERCLASS nil

private ["_logic","_operation","_args"];

PARAMS_1(_logic);
DEFAULT_PARAM(1,_operation,"");
DEFAULT_PARAM(2,_args,[]);
enable_playertags = false;

switch(_operation) do {
        case "init": {                
                /*
                MODEL - no visual just reference data
                */

                // Ensure only one module is used
                if (isServer && !(isNil QMOD(playertags))) exitWith {
                        ERROR_WITH_TITLE(str _logic, localize "STR_ALIVE_PLAYERTAGS_ERROR1");
                };
                
                //Only one init per instance is allowed
            	if !(isnil {_logic getVariable "initGlobal"}) exitwith {["ALiVE SYS PLAYERTAGS - Only one init process per instance allowed! Exiting..."] call ALiVE_fnc_Dump}; 
            
            	//Start init
            	_logic setVariable ["initGlobal", false];
                
                // Server init
                if (isServer) then {
                    
                	//Define logic
                    MOD(playertags) = _logic;

                    // if server, initialise module game logic
                    _logic setVariable ["super", SUPERCLASS];
                    _logic setVariable ["class", ALIVE_fnc_playertags];
                    _logic setVariable ["init", true, true];
                    
                    // and publicVariable to clients
                    publicVariable QMOD(playertags);
                
                // Client init    
                } else {
                        // any client side logic
                };
                
                // All localities init
                // wait for game logic to initialise
                waitUntil {!isNil QMOD(playertags) && {MOD(playertags) getVariable ["init", false]}};
                
                // Defaults
            	playertags_debug = call compile (_logic getvariable ["playertags_debug_setting","false"]);
				playertags_group = call compile (_logic getvariable ["playertags_displaygroup_setting","true"]);
				playertags_rank = call compile (_logic getvariable ["playertags_displayrank_setting","true"]);
				playertags_invehicle = call compile (_logic getvariable ["playertags_invehicle_setting","false"]);
				playertags_distance = _logic getvariable ["playertags_distance_setting",20];
				playertags_tolerance = _logic getvariable ["playertags_tolerance_setting",0.75];
				playertags_scale = _logic getvariable ["playertags_scale_setting",0.65];
				playertags_namecolour = _logic getvariable ["playertags_namecolour_setting","#FFFFFF"];       
				playertags_groupcolour = _logic getvariable ["playertags_groupcolour_setting","#A8F000"]; 
				playertags_thisgroupleadernamecolour = _logic getvariable ["playertags_thisgroupleadernamecolour_setting","#FFB300"]; 
				playertags_thisgroupcolour =_logic getvariable ["playertags_thisgroupcolour_setting","#009D91"]; 
				playertags_targetvehicles = call compile (_logic getvariable ["playertags_targets_setting","[""CAManBase"", ""Car"", ""Tank"", ""StaticWeapon"", ""Helicopter"", ""Plane""]"]);
				playertags_height = _logic getvariable ["playertags_height_setting",1.1];
            	
                GVAR(RADIUS) = _logic getvariable ["playertags_distance_setting",20];
                GVAR(STYLE) = _logic getvariable ["playertags_style_setting","default"];
                GVAR(DEBUG) = call compile (_logic getvariable ["playertags_debug_setting","false"]);
                GVAR(ONVIEW) = call compile (_logic getvariable ["playertags_onview_setting","false"]);

                // select method
                switch (GVAR(STYLE)) do {
                    case ("modern") : {GVAR(TRIGGER) = {[MOD(playertags),"active",_this] call ALiVE_fnc_playertags}};
                    case ("default") : {GVAR(TRIGGER) = {enable_playertags = _this}};
                    default {GVAR(TRIGGER) = {[MOD(playertags),"active",_this] call ALiVE_fnc_playertags}};
                };

                /*
                VIEW - purely visual
                - initialise menu
                - frequent check to modify menu and display status (ALIVE_fnc_playertagsMenuDef)
                */

                if(!isDedicated && !isHC) then {

                    // Initialise interaction key if undefined
                    if(isNil "SELF_INTERACTION_KEY") then {SELF_INTERACTION_KEY = [221,[false,false,false]];};

 
                    // initialise main menu
                    [
                            "player",
                            [SELF_INTERACTION_KEY],
                            -9500,
                            [
                                    "call ALIVE_fnc_playertagsMenuDef",
                                    "main"
                            ]
                    ] call ALIVE_fnc_flexiMenu_Add;
                };
                
                // Debug
                if (GVAR(DEBUG)) then {
					["ALIVE Player Tags - Menu Starting... Radius: %1, playertags_tolerance: %2, playertags_scale:, %3", playertags_distance, playertags_tolerance, playertags_scale] call ALIVE_fnc_dump;
            	};
                
                /*
                CONTROLLER  - coordination
                - frequent check if player is server admin (ALIVE_fnc_playertagsMenuDef)
                */
        };
        
        case "active": {
            if !(hasInterface) exitwith {};
            
            if (isnil "_args") then {
                _args = _logic getvariable [QGVAR(EH_DRAW3D),-1];
            } else {
                if (_args) then {
		        	_logic setvariable [QGVAR(EH_DRAW3D), addMissionEventHandler ["Draw3D", {

                        _onView = {true}; if (GVAR(ONVIEW)) then {_onView = {cursortarget == _x}};
                        
						{
                            if ((_x distance player < GVAR(RADIUS)) && {call _onView} && {!(lineIntersects [eyePos player, eyePos _x, player, _x])}) then {
					                
					                private ["_icon","_color"];
					                
									_pos = visiblePosition _x; _pos set [2, (getPosATL _x select 2) + 2.1];
									_width = 0.9; _height = 0.9;
						            _name = name _x;
                                    
                                    switch (side _x) do {
                                        case (WEST) : {_color = [0.259,0.235,0.941,1]};
                                        case (EAST) : {_color = [0.91,0.145,0.275,1]};
                                        case (RESISTANCE) : {_color = [0.278,0.788,0.404,1]};
                                        case (CIVILIAN) : {_color = [0.788,0.788,0.278,1]};
                                        default {_color = [0.259,0.235,0.941,1]};
                                    };
					                
					                switch (rank _x) do {
										case ("PRIVATE") : {_icon = "a3\UI_F\data\GUI\Cfg\Ranks\private_gs.paa"};
										case ("SERGEANT") : {_icon = "a3\UI_F\data\GUI\Cfg\Ranks\sergeant_gs.paa"};
										case ("LIEUTENANT") : {_icon = "a3\UI_F\data\GUI\Cfg\Ranks\lieutenant_gs.paa"};
										case ("CAPTAIN") : {_icon = "a3\UI_F\data\GUI\Cfg\Ranks\captain_gs.paa"};
										case ("MAJOR") : {_icon = "a3\UI_F\data\GUI\Cfg\Ranks\major_gs.paa"};
										case ("COLONEL") : {_icon = "a3\UI_F\data\GUI\Cfg\Ranks\colonel_gs.paa"};
										case ("CORPORAL") : {_icon = "a3\UI_F\data\GUI\Cfg\Ranks\general_gs.paa"};
					                    default {_icon = "a3\UI_F\data\GUI\Cfg\Ranks\private_gs.paa"};
					                };
                                    
                                    diag_log _color;
					                
									drawIcon3D [_icon,_color,_pos,_width,_height,0,_name,0,0.04];
								};
						} foreach (getPosATL player nearEntities ["CAManBase",GVAR(RADIUS)]);
					}]];
                    
                    _args = _logic getvariable [QGVAR(EH_DRAW3D),-1];
                } else {
                	removeMissionEventHandler ["Draw3D",_logic getvariable [QGVAR(EH_DRAW3D),-1]];
                };
            };
        };
        
        case "destroy": {
                if (isServer) then {
                        // if server
                        _logic setVariable ["super", nil];
                        _logic setVariable ["class", nil];
                        _logic setVariable ["init", nil];
                        // and publicVariable to clients
                        MOD(playertags) = _logic;
                        publicVariable QMOD(playertags);
                };
                
                if(!isDedicated && !isHC) then {
                        // remove main menu
                        [
                                "player",
                                [SELF_INTERACTION_KEY],
                                -9500,
                                [
                                        "call ALIVE_fnc_playertagsMenuDef",
                                        "main"
                                ]
                        ] call ALIVE_fnc_flexiMenu_Remove;
                };
        };
        default {
                private["_err"];
                _err = format["%1 does not support %2 operation", _logic, _operation];
                ERROR_WITH_TITLE(str _logic,_err);
        };
};

if !(isnil "_args") then {_args};