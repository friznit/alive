#include <\x\alive\addons\sys_marker\script_component.hpp>
SCRIPT(marker);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_marker
Description:
Creates the server side object to store settings

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array,String,Number,Boolean - The selected parameters

Returns:
Array, String, Number, Any - The expected return value

Examples:
(begin example)
// Create instance by placing editor module
[_logic,"init"] call ALiVE_fnc_marker;
(end)

See Also:
- <ALIVE_fnc_markerInit>

Author:
Tupolov

Peer reviewed:
nil
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClass
#define MAINCLASS ALIVE_fnc_marker

private ["_result", "_operation", "_args", "_logic"];

PARAMS_1(_logic);
DEFAULT_PARAM(1,_operation,"");
DEFAULT_PARAM(2,_args,nil);

TRACE_3("SYS_marker",_logic, _operation, _args);

switch (_operation) do {

    	case "create": {
            if (isServer) then {

	            // Ensure only one module is used
	            if !(isNil QMOD(SYS_marker)) then {
                	_logic = MOD(SYS_marker);
                    ERROR_WITH_TITLE(str _logic, localize "STR_ALIVE_marker_ERROR1");
	            } else {
	        		_logic = (createGroup sideLogic) createUnit ["ALiVE_SYS_MARKER", [0,0], [], 0, "NONE"];
                    MOD(SYS_marker) = _logic;
                };

                //Push to clients
	            PublicVariable QMOD(SYS_marker);
            };

            TRACE_1("Waiting for object to be ready",true);

            waituntil {!isnil QMOD(SYS_marker)};

            TRACE_1("Creating class on all localities",true);

			// initialise module game logic on all localities
			MOD(SYS_marker) setVariable ["super", QUOTE(SUPERCLASS)];
			MOD(SYS_marker) setVariable ["class", QUOTE(MAINCLASS)];

            _result = MOD(SYS_marker);
        };

        case "init": {

            ["%1 - Initialisation started...",_logic] call ALiVE_fnc_Dump;

            /*
            MODEL - no visual just reference data
            - module object datastorage parameters
            - Establish data handler on server
            - Establish data model on server and client
            */

            TRACE_1("Creating data store",true);

	        // Create logistics data storage in memory on all localities
	        GVAR(STORE) = [] call ALIVE_fnc_hashCreate;

            // Define module basics on server
			if (isServer) then {
                _errorMessage = "Please include either the Requires ALiVE module! %1 %2";
                _error1 = ""; _error2 = ""; //defaults
                if(
                    !(["ALiVE_require"] call ALiVE_fnc_isModuleavailable)
                    ) exitwith {
                    [_errorMessage,_error1,_error2] call ALIVE_fnc_dumpR;
                };

				// Wait for disable log module to set module parameters
                if (["AliVE_SYS_markerPARAMS"] call ALiVE_fnc_isModuleavailable) then {
                    waituntil {!isnil {MOD(SYS_marker) getvariable "DEBUG"}};
                };

                // Reset states with provided data;
                if !(_logic getvariable ["DISABLEPERSISTENCE",false]) then {
                    if (isDedicated && {[QMOD(SYS_DATA)] call ALiVE_fnc_isModuleAvailable}) then {
                        waituntil {!isnil QMOD(SYS_DATA) && {MOD(SYS_DATA) getvariable ["startupComplete",false]}};
                    };

                    _state = call ALiVE_fnc_markerLoadData;

                    if !(typeName _state == "BOOL") then {
                        GVAR(STORE) = _state;

                        // Restore Markers on map
                        [_logic, "restoreMarkers", [GVAR(STORE)]] call ALiVE_fnc_marker;
                    } else {
                        // Add markers from editor to the store
                        private ["_markersHash"];
                        {
                            _markersHash = [] call ALIVE_fnc_hashCreate;
                            [_markersHash, QGVAR(color), getMarkerColor _x] call ALIVE_fnc_hashSet;
                            [_markersHash, QGVAR(size), getMarkerSize _x] call ALIVE_fnc_hashSet;
                            [_markersHash, QGVAR(pos), getMarkerPos _x] call ALIVE_fnc_hashSet;
                            [_markersHash, QGVAR(type), getMarkerType _x] call ALIVE_fnc_hashSet;
                            [_markersHash, QGVAR(alpha), markerAlpha _x] call ALIVE_fnc_hashSet;
                            [_markersHash, QGVAR(brush), markerBrush _x] call ALIVE_fnc_hashSet;
                            [_markersHash, QGVAR(dir), markerDir _x] call ALIVE_fnc_hashSet;
                            [_markersHash, QGVAR(text), markerText _x] call ALIVE_fnc_hashSet;
                            [_markersHash, QGVAR(shape), MarkerShape _x] call ALIVE_fnc_hashSet;
                            [_markersHash, QGVAR(locality), "GLOBAL"] call ALIVE_fnc_hashSet;

                            [GVAR(STORE), _x, _markersHash] call ALiVE_fnc_hashSet;
                        } foreach allMapMarkers;
                    };


                };

                GVAR(STORE) call ALIVE_fnc_inspectHash;

            	[_logic,"state",GVAR(STORE)] call ALiVE_fnc_marker;

                _logic setVariable ["init", true, true];
			};

            /*
            CONTROLLER  - coordination
            */

            // Wait until server init is finished
            waituntil {_logic getvariable ["init",false]};

            TRACE_1("Spawning Server processes",isServer);

            if (isServer) then {
                // Start any server-side processes that are needed
            };

			TRACE_1("Spawning clientside processes",hasInterface);

            if (hasInterface) then {
                // Start any client-side processes that are needed

                // Add eventhandler for creating markers
                ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["MouseButtonClick", "[ALiVE_SYS_MARKER,'createMarker',[player, _this]] call ALiVE_fnc_marker;"];
                ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["MouseButtonDblClick", "hint 'Only ALIVE Advanced Markers will be stored. Default BIS markers are not supported by ALIVE. CTRL-MOUSE BUTTON to create an Advanced Marker.'"];

            };


            TRACE_1("After module init",_logic);

            // Indicate Init is finished on server
            if (isServer) then {
                _logic setVariable ["startupComplete", true, true];
            };

            ["%1 - Initialisation Completed...",MOD(SYS_marker)] call ALiVE_fnc_Dump;

            _result = MOD(SYS_marker);
        };

        case "state": {

            TRACE_1("ALiVE SYS marker state called",_logic);

        	if ((isnil "_args") || {!isServer}) exitwith {
                _result = GVAR(STORE)
            };

            // State is being set - restore markers



            _result = GVAR(STORE);
	    };

        case "restoreMarkers": {
            // Create markers from the store
            private "_restoreMarkers";
            _restoreMarkers = {
                [
                    _key,
                    [_value, QGVAR(pos)] call ALiVE_fnc_getHash,
                    [_value, QGVAR(pos)] call ALiVE_fnc_getHash,
                    [_value, QGVAR(shape)] call ALiVE_fnc_getHash,
                    [_value, QGVAR(size)] call ALiVE_fnc_getHash,
                    "BRUSH:", [_value, QGVAR(brush)] call ALiVE_fnc_getHash,
                    "COLOR:", [_value, QGVAR(color)] call ALiVE_fnc_getHash,
                    "TEXT:", [_value, QGVAR(text)] call ALiVE_fnc_getHash,
                    "TYPE:", [_value, QGVAR(type)] call ALiVE_fnc_getHash
                ] call CBA_fnc_createMarker;

                [_args, _restoreMarkers] call CBA_fnc_hashEachPair;
            };

        };

        case "createMarker": { // Runs locally on client

            private ["_player","_shift","_alt","_ctr","_ok"];
            _player = player;
            _params = _args select 1;

            _shift = _params select 4;
            _ctr = _params select 5;
            _alt = _params select 6;

            // Check to see if CTRL is held down
            if (_ctr && !_shift && !_alt) then {
                private ["_side","_xy","_pos"];
                _side = side (group _player);
                _xy = [_params select 2, _params select 3];

                _pos = ((findDisplay 12) displayCtrl 51) ctrlMapScreenToWorld _xy;

                uiNamespace setVariable [QGVAR(pos), _pos];

                // Open Dialog
                _ok = createDialog "RscDisplayALiVEInsertMarker";
                if !(_ok) then {
                    hint "Could not open Marker Dialog!";
                };

                _result = true;

            } else {

                _result = false;
            };
        };

        case "deleteMarker": {
            // Handles deleting a marker on the map
        };

        case "deleteAllMarkers": {
            // Delete all markers on the map
        };

        case "editMarker": {
            // Handles editing a marker on the map
        };

        case "destroy": {
            [[_logic, "destroyGlobal",_args],"ALIVE_fnc_marker",true, false] call BIS_fnc_MP;
        };

        case "destroyGlobal": {

                [_logic, "debug", false] call MAINCLASS;

                if (isServer) then {
                		// if server
                        MOD(SYS_marker) = _logic;

                        MOD(SYS_marker) setVariable ["super", nil];
                        MOD(SYS_marker) setVariable ["class", nil];
                        MOD(SYS_marker) setVariable ["init", nil];

                        // and publicVariable to clients

                        publicVariable QMOD(SYS_marker);
                        [_logic, "destroy"] call SUPERCLASS;
                };

                if (hasInterface) then {
                };
        };

        default {
            _result = [_logic, _operation, _args] call SUPERCLASS;
        };
};


TRACE_1("ALiVE SYS marker - output",_result);

if !(isnil "_result") then {
    _result;
};
