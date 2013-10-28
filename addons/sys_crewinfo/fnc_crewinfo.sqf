#include <\x\alive\addons\sys_crewinfo\script_component.hpp>
SCRIPT(crewinfo);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_crewinfo
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
Boolean - enabled - Enabled or disable module

Parameters:
none

The popup menu will change to show status as functions are enabled and disabled.

Examples:
(begin example)
// Create instance by placing editor module and specifiying name myModule
(end)

See Also:
- <ALIVE_fnc_crewinfoInit>


Author:
[KH]Jman
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
                if (isServer && !(isNil QMOD(crewinfo))) exitWith {
                        ERROR_WITH_TITLE(str _logic, localize "STR_ALIVE_CREWINFO_ERROR1");
                };
                
                if (isServer) then {
                        MOD(crewinfo) = _logic;
                        publicVariable QMOD(crewinfo);

                        // if server, initialise module game logic
                        _logic setVariable ["super", SUPERCLASS];
                        _logic setVariable ["class", ALIVE_fnc_crewinfo];
                        _logic setVariable ["init", true, true];
                        CREWINFO_DEBUG = call compile (_logic getvariable ["crewinfo_debug_setting","false"]);
                        CREWINFO_UILOC = call compile (_logic getvariable ["crewinfo_ui_setting",1]);
                        // and publicVariable to clients
                        publicVariable "CREWINFODEBUG";
                } else {
                        // if client clean up client side game logics as they will transfer
                        // to servers on client disconnect
                       // deleteVehicle _logic;
                };
                
                // and wait for game logic to initialise
                // TODO merge into lazy evaluation
                waitUntil {!isNil QMOD(crewinfo)};
                waitUntil {MOD(crewinfo) getVariable ["init", false]};        

                /*
                VIEW - purely visual
                - initialise 
                */
               
                
                if(!isDedicated && !isHC) then {
                	 		Waituntil {!(isnil "CREWINFO_DEBUG")};
                	 		Waituntil {!(isnil "CREWINFO_UILOC")};
                	 		private ["_ui","_HudNames","_vehicleID","_picture","_vehicle","_vehname","_weapname","_weap","_wepdir","_Azimuth"];
                				
                				// DEBUG -------------------------------------------------------------------------------------
													if(CREWINFO_DEBUG) then {
														["ALIVE Crew Info - Starting..."] call ALIVE_fnc_dump;
															if (CREWINFO_UILOC == 1) then {
																["ALIVE Crew Info - Drawing UI right (%1)", CREWINFO_UILOC] call ALIVE_fnc_dump;
															} else {
																["ALIVE Crew Info - Drawing UI left (%1)", CREWINFO_UILOC] call ALIVE_fnc_dump;
															};
													};
												// DEBUG -------------------------------------------------------------------------------------

											  disableSerialization;
											  while {true} do  {
											  	if (CREWINFO_UILOC == 1) then {
											   	 1000 cutRsc ["HudNamesRight","PLAIN"]; _ui = uiNameSpace getVariable "HudNamesRight";
											  	} else {
											  	 1000 cutRsc ["HudNamesLeft","PLAIN"]; _ui = uiNameSpace getVariable "HudNamesLeft";
											  	};
											 	   _HudNames = _ui displayCtrl 99999;
													    if (player != vehicle player) then {
													        _name = "";
													        _vehicleID = "";
													        _picture = ""; 
													        _vehicle = assignedVehicle player;
													        _vehname= getText (configFile >> "CfgVehicles" >> (typeOf vehicle player) >> "DisplayName");
													        _weapname = getarray (configFile >> "CfgVehicles" >> typeOf (vehicle player) >> "Turrets" >> "MainTurret" >> "weapons"); 
													         if (count(_weapname) >0) then {_weap = _weapname select 0; } else { _weap = objNull; };
													        _name = format ["<t size='1.25' color='#556b2f'>%1</t><br/>", _vehname];
													        {
													            if((driver _vehicle == _x) || (gunner _vehicle == _x)) then
													            {
														                
													                if(driver _vehicle == _x) then
													                {
													
													                    _name = format ["<t size='0.85' color='#f0e68c'>%1 %2</t> <img size='0.7' color='#6b8e23' image='a3\ui_f\data\IGUI\Cfg\Actions\getindriver_ca.paa'/><br/>", _name, (name _x)];
													                }
													                else {
																	            _target = cursorTarget;
																	            if (_target isKindOf "Car" || _target isKindOf "Motorcycle" || _target isKindOf "Tank" || _target isKindOf "Air" || _target isKindOf "Ship") then {
																			       			_vehicleID = getText (configFile >> "cfgVehicles" >> typeOf _target >> "displayname");		             
																			       			_picture = getText (configFile >> "cfgVehicles" >> typeOf _target >> "picture");
																			      		};
																							if ( typeOf vehicle player == "O_SDV_01_F" || typeOf vehicle player == "B_SDV_01_F" ||  typeOf vehicle player == "I_G_Offroad_01_armed_F") then {
																      		      	  if (!isNull _weap) then {
																	              _wepdir =  (vehicle player) weaponDirection _weap;
																			 					_Azimuth = round  (((_wepdir select 0) ) atan2 ((_wepdir select 1) ) + 360) % 360;
																                _name = format ["<t size='0.85' color='#f0e68c'>%1 %2</t> <img size='0.7' color='#6b8e23' image='a3\ui_f\data\IGUI\Cfg\Actions\getingunner_ca.paa'/><br/> <t size='0.85' color='#f0e68c'>Heading :<t/> <t size='0.85' color='#ff0000'>%3</t><br/><t size='0.85' color='#f0e68c'> Target :<t/> <t size='0.85' color='#ff0000'>%4</t><br/><t size='0.85' color='#f0e68c'> Display : </t><t size='0.85' color='#f0e68c'><img size='1' image='%5'/></t><br/>", _name, (name _x), _Azimuth,_vehicleID, _picture];
																								 } else {
																								  _name = format ["<t size='0.85' color='#f0e68c'>%1 %2</t> <img size='0.7' color='#6b8e23' image='a3\ui_f\data\IGUI\Cfg\Actions\getingunner_ca.paa'/><br/>", _name, (name _x)];
																								}
																							}	else {
																	      		     if (!isNil _weap) then {
																	              _wepdir =  (vehicle player) weaponDirection _weap;
																			 					_Azimuth = round  (((_wepdir select 0) ) atan2 ((_wepdir select 1) ) + 360) % 360;
																                _name = format ["<t size='0.85' color='#f0e68c'>%1 %2</t> <img size='0.7' color='#6b8e23' image='a3\ui_f\data\IGUI\Cfg\Actions\getingunner_ca.paa'/><br/> <t size='0.85' color='#f0e68c'>Heading :<t/> <t size='0.85' color='#ff0000'>%3</t><br/><t size='0.85' color='#f0e68c'> Target :<t/> <t size='0.85' color='#ff0000'>%4</t><br/><t size='0.85' color='#f0e68c'> Display : </t><t size='0.85' color='#f0e68c'><img size='1' image='%5'/></t><br/>", _name, (name _x), _Azimuth,_vehicleID, _picture];
																								 } else {
																								  _name = format ["<t size='0.85' color='#f0e68c'>%1 %2</t> <img size='0.7' color='#6b8e23' image='a3\ui_f\data\IGUI\Cfg\Actions\getingunner_ca.paa'/><br/>", _name, (name _x)];
																								}
																							};					 
													                 };
													            }
													            else {
													              _name = format ["<t size='0.85' color='#f0e68c'>%1 %2</t> <img size='0.7' color='#6b8e23' image='a3\ui_f\data\IGUI\Cfg\Actions\getincargo_ca.paa'/><br/>", _name, (name _x)];
													            };  
													              
													        } forEach crew _vehicle;
													        
													      	_HudNames ctrlSetStructuredText parseText  _name;
													      	_HudNames ctrlCommit 0;
													    };
											    sleep 1;
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
                        MOD(crewinfo) = _logic;
                        publicVariable QMOD(crewinfo);
                };
        };
        default {
                private["_err"];
                _err = format["%1 does not support %2 operation", _logic, _operation];
                ERROR_WITH_TITLE(str _logic,_err);
        };
};

