#include <\x\alive\addons\main\script_component.hpp>
SCRIPT(exMP);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_exMP

Description:
Function for MP execution optimized for the usage of PVS and PVC.

Parameters:

- Locality (Number, Client-Object):
0, all
1, server
2, all clients
3, only local
Object, will execute on the given player-locality (accessible f.e. with bis_fnc_listplayers or playableunits)

- Parameters (Array)
- Code ({Code})

Examples:

Intialisation:
Ensure that // [] call ALiVE_fnc_exMP // was executed on all localities once (fe. init.sqf or initfield of an object in editor)

Sender Gunny (player) transfers the hint to receiver Highhead (playableunits select 0):
[(playableunits select 0),[player,"Get your high head down!"],{hint format["Here comes %1s hint: %2!",(_this select 0),(_this select 1)]}] call ALiVE_fnc_exMP;

Client executes code on server (nice example):
[1,[],{#shutdown}] call ALiVE_fnc_exMP;

Global execution:
[0,[],{hint "All read this!"}] call ALiVE_fnc_exMP;

See Also:

Author:
ALiVE Dev Team
---------------------------------------------------------------------------- */
//Initialise an Eventhandler the first time this function is run
if (isnil "ALiVE_exMPEH") then {
    ALiVE_exMPEH = true;
    
	"ALiVE_exMP" addPublicVariableEventHandler {
	        private ["_this","_dataStack","_locality","_params","_code","_sender","_receiver","_remote"];
			_dataStack = _this select 1;
	        _locality = _dataStack select 0;
	        _params = _dataStack select 1;
	        _code = _dataStack select 2;
	        _sender = _dataStack select 3;
            
	        if (typeName _locality == "OBJECT") then {
                _receiver = _locality;
                _locality = 3;
            };
	        
	        if (switch (_locality) do {
	                case 0: {true};
	                case 1: {isServer};
	                case 2: {!(isDedicated)};
                    case 3: {(local _receiver)};
	                default {false};
	        	}) then {
                	//execute
	                if (isnil "_params") then {call _code} else {_params call _code};
	        };
            
            // server is only bypassing event to client and not executing it if object is passed
            if (_locality == 3) then {
	            if (isServer && !(local _receiver) && !(str(_sender) == "Server")) then {
		            (owner _receiver) PublicVariableClient "ALiVE_exMP";
	                diag_log format["Sending data %1 from server to client %2!",_dataStack,_receiver];
		        };
            };
	};
};

//Exit if no params are given
if (isnil {_this select 0}) exitwith {diag_log "No params given for ALiVE_fnc_ExMP - exiting..."};

//Execute
private ["_this","_locality","_params","_code","_sender","_dataStack"];

_sender = if !(isDedicated) then {player} else {"Server"};
_locality = _this select 0;
_params = _this select 1;
_code = _this select 2;
_dataStack = [_locality,_params,_code,_sender];

if ((!(isDedicated) && (typeName _locality == "OBJECT")) || {!(isServer) && (_locality == 1)}) exitwith {
    //diag_log format ["Sending PVS data %1 to server!",_dataStack];
	ALiVE_exMP = _dataStack;
	PublicVariableServer "ALiVE_exMP";
};

if (isServer && (typeName _locality == "OBJECT")) exitwith {
    //diag_log format ["Sending PVC data %1 from server directly to client!",_dataStack];
	ALiVE_exMP = _dataStack;
	(owner _locality) PublicVariableClient "ALiVE_exMP";
};

if (_locality in [0,2]) then {
	//diag_log format ["Sending PV data %1!",_dataStack];
    ALiVE_exMP = _dataStack;
	publicvariable "ALiVE_exMP";
};

if ((isServer && (_locality == 1)) || (_locality in [0,3]) || (!(isdedicated) && (_locality == 2))) then {
    //diag_log format ["Executing code %1 locally!",_dataStack];
	if (isnil "_params") then {call _code} else {_params call _code};
};
