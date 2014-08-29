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

Properties:
drawToggle - returns the map drawing toggle state

EventHandlers:
keyDown - handles key press while on map screen
mouseMoving - handles the movement of the mouse while on map screen

Methods:
create - creates the game logic
init - initialises game logic
state - returns the state of the marker STORE?
destroy - destroys the game logic
destroyGlobal - destroys the game logic globally

onMarker - checks to see if a marker exists at a specified position
isAuthorized - checks to see if a player may add, edit or delete a marker
getMarker - returns extended marker information
loadMarkers - loads markers from the database
saveMarkers - saves markers to the database
restoreMarkers - restores the markers loaded to the map
openDialog - opens the advanced marker user interface
addMarker - adds a marker to the store
removeMarker - removes a marker from the store
createMarker - creates a marker on the client machine
updateMarker - updates a marker
deleteMarker - deletes a marker
deleteAllMarkers - deletes all markers on the map (Admin Only)

Examples:
(begin example)
// Create instance by placing editor module
[_logic,"init"] call ALiVE_fnc_marker;
(end)

See Also:
- <ALIVE_fnc_markerInit>

Author:
Tupolov

In memory of Peanut

Peer reviewed:
nil
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClass
#define MAINCLASS ALIVE_fnc_marker

#define NO_DRAW 0
#define FREE_DRAW 1
#define ARROW_DRAW 2
#define ELLIPSE_DRAW 3
#define RECTANGLE_DRAW 4

#define DEFAULT_TOGGLE 0

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
	        //GVAR(STORE) = [] call ALIVE_fnc_hashCreate;

             [_logic, "drawToggle", DEFAULT_TOGGLE] call ALIVE_fnc_marker;

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

                // Create store initially on server
                GVAR(STORE) = [] call ALIVE_fnc_hashCreate;

                // Reset states with provided data;
                if !(_logic getvariable ["DISABLEPERSISTENCE",false]) then {
                    if (isDedicated && {[QMOD(SYS_DATA)] call ALiVE_fnc_isModuleAvailable}) then {
                        waituntil {!isnil QMOD(SYS_DATA) && {MOD(SYS_DATA) getvariable ["startupComplete",false]}};
                    };

                    _state = [_logic, "loadMarkers"] call ALIVE_fnc_marker;

                    if !(typeName _state == "BOOL") then {
                        GVAR(STORE) = _state;
                    } else {
                        LOG("No markers loaded...");
                    };

                };

                GVAR(STORE) call ALIVE_fnc_inspectHash;

            	[_logic,"state",GVAR(STORE)] call ALiVE_fnc_marker;

                //Push to clients
                PublicVariable QGVAR(STORE);

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

                 waituntil {!isnil QGVAR(store)};
                // Restore Markers on map
                [_logic, "restoreMarkers", [GVAR(STORE)]] call ALiVE_fnc_marker;

                waitUntil {
                    sleep 1;
                    ((str side player) != "UNKNOWN")
                };


                // Add eventhandler for creating markers
                ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["MouseButtonClick", "[ALiVE_SYS_MARKER,'mouseButton',[player, _this]] call ALiVE_fnc_marker;"];
                ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["MouseButtonDblClick", "hint 'Only ALIVE Advanced Markers will be stored. Default BIS markers are not supported by ALIVE. CTRL-MOUSE BUTTON to create an Advanced Marker.'"];

 //   			((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["keyDown", "[ALiVE_SYS_MARKER,'keyDown',[player, _this]] call ALiVE_fnc_marker;"];
//				((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["MouseMoving", "[ALiVE_SYS_MARKER,'mouseMoving',[player, _this]] call ALiVE_fnc_marker;"];
            };


            TRACE_1("After module init",_logic);

            // Indicate Init is finished on server
            if (isServer) then {
                _logic setVariable ["startupComplete", true, true];
            };

            ["%1 - Initialisation Completed...",MOD(SYS_marker)] call ALiVE_fnc_Dump;

            _result = MOD(SYS_marker);
        };

         case "mouseButton": { // Runs locally on client

            private ["_player","_shift","_alt","_ctr","_ok"];
            _player = player;
            _params = _args select 1;
            _button = _params select 1;
            _shift = _params select 4;
            _ctr = _params select 5;
            _alt = _params select 6;

            // Check to see if CTRL is held down
            if (_ctr && !_shift && !_alt) then {
                private ["_side","_xy","_pos","_check"];
                _xy = [_params select 2, _params select 3];

                _pos = ((findDisplay 12) displayCtrl 51) ctrlMapScreenToWorld _xy;
                uiNamespace setVariable [QGVAR(pos), _pos];

                // Check to see if Marker exists at location, if so change the mode
                _check = [_logic, "onMarker", [_pos]] call ALIVE_fnc_marker;

                if (_button == 0) then {
                    uiNamespace setVariable [QGVAR(edit), _check];

    				if ([_logic, "isAuthorized", [_check]] call ALIVE_fnc_marker) then {
    					// Open Dialog
    					_ok = createDialog "RscDisplayALiVEAdvancedMarker";
    					if !(_ok) then {
    						hint "Could not open Marker Dialog!";
    					};
    				} else {
    					hint "You are not authorized to add/edit this marker";
    				};
                } else {
                    if (typeName _check != "BOOL") then {
                        if ([_logic, "isAuthorized", [_check]] call ALIVE_fnc_marker) then {
                            // delete marker
                            [_logic, "removeMarker",[_check]] call ALIVE_fnc_marker;
                        } else {
                            hint "You are not authorized to delete this marker";
                        };
                        _result = false;
                    };
                };

                _result = false;

            } else {

                _result = true;
            };
        };

		case "keyDown": {
			// Handles pressing of certain keys on map
            private ["_player","_shift","_alt","_ctr","_key","_toggle"];
			_params = _args select 1;

			_key = _params select 1;
			_shift = _params select 2;
            _ctr = _params select 3;
            _alt = _params select 4;

            _result = true;

 //           _toggle = [_logic, "drawToggle"] call ALIVE_fnc_marker;

			switch _key do {
				case 52: { 			// Press . to place a dot icon
                    hint "dot pressed";
                                    _result = false;
				};
				case 45: { 			// Press x to place objective marker
                                    hint "x pressed";
                                    _result = false;
				};

	/*			case "57":{ 			// Press Space bar to toggle free drawing
                                    hint "space bar pressed";
                    if (_toggle == FREE_DRAW) then {[_logic, "drawToggle", [NO_DRAW]] call ALIVE_fnc_marker;} else {[_logic, "drawToggle", [FREE_DRAW]] call ALIVE_fnc_marker;};
				};
				case "30":{ 			// Press a to toggle arrow drawing
                                    hint "a pressed";
                    if (_toggle == ARROW_DRAW) then {[_logic, "drawToggle", [NO_DRAW]] call ALIVE_fnc_marker;} else {[_logic, "drawToggle", [ARROW_DRAW]] call ALIVE_fnc_marker;};
				};
				case "18":{ 			// Press e to toggle ellipse drawing
                    if (_toggle == ELLIPSE_DRAW) then {[_logic, "drawToggle", [NO_DRAW]] call ALIVE_fnc_marker;} else {[_logic, "drawToggle", [ELLIPSE_DRAW]] call ALIVE_fnc_marker;};
                                    hint "e pressed";
				};
				case "19":{ 			// Press r to toggle rectangle drawing
                    if (_toggle == RECTANGLE_DRAW) then {[_logic, "drawToggle", [NO_DRAW]] call ALIVE_fnc_marker;} else {[_logic, "drawToggle", [RECTANGLE_DRAW]] call ALIVE_fnc_marker;};
                                    hint "r pressed";
				};*/
				default { _result = false };
			};
		};

		case "mouseMoving": {
            private "_toggle";
			// Handles free draw on map
			_toggle = [_logic, "drawToggle", []] call ALIVE_fnc_marker;

			// Check drawing toggle
			switch _toggle do {
				case FREE_DRAW: {			// Free Draw
                    hint "free draw";
				};
				case ARROW_DRAW: {			// Free Arrow Draw
                    hint "arrow draw";
				};
				case ELLIPSE_DRAW: {			// Free Ellipse Draw
                    hint "ellipse draw";
				};
				case RECTANGLE_DRAW: {			// Free Rectangle Draw
                    hint "rectangle draw";
				};
			};
		};

       case "state": {

            TRACE_1("ALiVE SYS marker state called",_logic);

            if ((isnil "_args") || {!isServer}) exitwith {
                _result = GVAR(STORE)
            };

            // State is being set - restore markers

            _result = GVAR(STORE);
        };

        case "drawToggle": {
            _result = [_logic,_operation,_args,DEFAULT_TOGGLE] call ALIVE_fnc_OOsimpleOperation;
        };

        case "isAuthorized": {
            private "_marker";
            _marker = _args select 0;

            if (typeName _marker == "BOOL") then {
                _result = isPlayer player;
            } else {
                // If player owns marker, or player is admin or player is higher rank than owner
                _result = true;
            };


        };

        case "onMarker": {
            // Check to see if cursor is on a marker

            private ["_markerName", "_markerPos", "_marker","_obj","_pos"];

            _pos = _args select 0;
            _result = false;

            // Find nearest marker
            _markerName = "";
            _markerPos = [0,0,0];
            {
                _marker = _x;
                if ((getmarkerpos _marker) distance _pos < _markerPos distance _pos) then {
                    _markerName = _marker;
                    _markerPos = getmarkerPos _marker;
                };
            } foreach (GVAR(STORE) select 1);

            LOG(_markerName);

            // See if position is inside nearest marker
            if (markerShape _markerName != "ICON") then {
                _obj = "Land_Can_Rusty_F" createVehicleLocal _pos;
                _result = [_obj, _markerName] call ALIVE_fnc_inArea;
                deleteVehicle _obj;
                if (_result) then {_result = _markerName};
            } else {
                _scale = ctrlMapScale ((findDisplay 12) displayCtrl 51);
                if (_scale * 160 > ((getmarkerpos _markerName) distance _pos)) then {
                    _result = _markerName;
                };
            };

        };

        case "loadMarkers": {
            // Get markers from DB
            _result = call ALIVE_fnc_markerLoadData;
        };

        case "restoreMarkers": {
            // Create markers from the store locally (run on clients only)
            private ["_restoreMarkers","_hash","_i"];

            _hash = _args select 0;


            _restoreMarkers = {
                private "_locality";
                LOG(str _this);
                _locality = [_value, QGVAR(locality),"SIDE"] call ALIVE_fnc_hashGet;
                switch _locality do {
                    case "SIDE": {
                        if ( str(side (group player)) == [_value, QGVAR(localityValue), ""] call ALiVE_fnc_hashGet) then {
                            [MOD(SYS_marker), "createMarker", [_key,_value]] call ALIVE_fnc_marker;
                        };
                    };
                    case "GROUP": {
                        if (str(group player) == [_value, QGVAR(localityValue),""] call ALiVE_fnc_hashGet) then {
                            [MOD(SYS_marker), "createMarker", [_key,_value]] call ALIVE_fnc_marker;
                        };
                    };
                    case "FACTION": {
                        [MOD(SYS_marker), "createMarker", [_key,_value,  [_value, QGVAR(localityValue)] call ALiVE_fnc_hashGet]] call ALIVE_fnc_marker;
                    };
                    case "LOCAL": {
                        if ( (getPlayerUID player) == [_value, QGVAR(player), ""] call ALiVE_fnc_hashGet) then {
                            [MOD(SYS_marker), "createMarker", [_key,_value]] call ALIVE_fnc_marker;
                        };
                    };
                    case default {
                        [MOD(SYS_marker), "createMarker", [_key,_value]] call ALIVE_fnc_marker;
                    };
                };

            };

            [_hash, _restoreMarkers] call CBA_fnc_hashEachPair;

            _result = true;

        };

        case "createMarker": {
            // Handles creating a marker on the map
            // Accepts a hash as input (either from loading or from UI)
            private ["_markerName","_markerHash","_check"];
            _markerName = _args select 0;
            _markerHash = _args select 1;
            _check = false;
            _result = false;

            if (hasInterface) then {

                if (count _args > 2) then {
                    if (faction player == (_args select 2)) then {_check = true};
                } else {
                    _check = true;
                };

                if (_check) then {
                    [
                        _markerName,
                        [_markerHash, QGVAR(pos)] call ALiVE_fnc_hashGet,
                        [_markerHash, QGVAR(shape)] call ALiVE_fnc_hashGet,
                        [_markerHash, QGVAR(size)] call ALiVE_fnc_hashGet,
                        [_markerHash, QGVAR(color)] call ALiVE_fnc_hashGet,
                        [_markerHash, QGVAR(text)] call ALiVE_fnc_hashGet,
                        [_markerHash, QGVAR(type),""] call ALiVE_fnc_hashGet,
                        [_markerHash, QGVAR(brush),""] call ALiVE_fnc_hashGet,
                        [_markerHash, QGVAR(dir),0] call ALiVE_fnc_hashGet,
                        [_markerHash, QGVAR(alpha),1] call ALiVE_fnc_hashGet
                    ] call ALIVE_fnc_createMarker;

                    _result = true;
                };
            };

        };

        case "addMarker": {
        	// Adds a marker to the store on the server and creates markers on necessary clients
            // Expects a markername and hash as input.

            private ["_markerName","_markerHash","_marker"];
            _markerName = _args select 0;
            _markerHash = _args select 1;

            // Add marker to marker store on all localities
            [[_logic, "addMarkerToStore", [_markerName, _markerHash]], "ALIVE_fnc_marker",true,false,true] call BIS_fnc_MP;


            // Create Marker

            switch ([_markerHash, QGVAR(locality), "SIDE"] call ALIVE_fnc_hashGet) do {
                case "GLOBAL": {
                    [[_logic,"createMarker",[_markerName,_markerHash]], "ALIVE_fnc_marker", nil, false, true] call BIS_fnc_MP;
                };
                case "SIDE": {
                    [[_logic,"createMarker",[_markerName,_markerHash]], "ALIVE_fnc_marker", side (group player), false, true] call BIS_fnc_MP;
                };
                case "GROUP": {
                    [[_logic,"createMarker",[_markerName,_markerHash]], "ALIVE_fnc_marker", group player, false, true] call BIS_fnc_MP;
                };
                case "FACTION": {
                    [[_logic,"createMarker",[_markerName,_markerHash, faction player]], "ALIVE_fnc_marker", nil, false, true] call BIS_fnc_MP;
                };
                case "LOCAL": {
                    [_logic,"createMarker",[_markerName,_markerHash]] call ALIVE_fnc_marker;
                };
            };
            _result = _markerName;
        };

        case "addStandardMarker": {
            // Adds a marker to the store on the server
            // Expects marker and locality as input
            private "_marker";
            _marker = _args select 0;

            _markersHash = [] call ALIVE_fnc_hashCreate;
            [_markersHash, QGVAR(color), getMarkerColor _marker] call ALIVE_fnc_hashSet;
            [_markersHash, QGVAR(size), getMarkerSize _marker] call ALIVE_fnc_hashSet;
            [_markersHash, QGVAR(pos), getMarkerPos _marker] call ALIVE_fnc_hashSet;
            [_markersHash, QGVAR(type), getMarkerType _marker] call ALIVE_fnc_hashSet;
            [_markersHash, QGVAR(alpha), markerAlpha _marker] call ALIVE_fnc_hashSet;
            [_markersHash, QGVAR(brush), markerBrush _marker] call ALIVE_fnc_hashSet;
            [_markersHash, QGVAR(dir), markerDir _marker] call ALIVE_fnc_hashSet;
            [_markersHash, QGVAR(text), markerText _marker] call ALIVE_fnc_hashSet;
            [_markersHash, QGVAR(shape), MarkerShape _marker] call ALIVE_fnc_hashSet;
            [_markersHash, QGVAR(locality), _args select 1] call ALIVE_fnc_hashSet;

            _result = _markersHash;
        };

        case "addMarkerToStore": {
             private ["_markerName","_markerHash"];
            _markerName = _args select 0;
            _markerHash = _args select 1;

            [GVAR(STORE), _markerName, _markerHash] call ALIVE_fnc_hashSet;

            _result = GVAR(STORE);
        };


        case "editMarker": {
            // Handles editing a marker on the map
        };

        case "removeMarker": {
            // Removes a marker from the store
            private ["_markerName","_markerHash","_marker"];
            _markerName = _args select 0;

            _markerHash = [GVAR(STORE),_markerName] call ALIVE_fnc_hashGet;

            // Remove SITREP if necessary
            if ([_markerHash, QGVAR(hasSITREP), false] call ALIVE_fnc_hashGet) then {
                private "_sitrep";
               _sitrep = [_markerHash, QGVAR(sitrep)] call ALIVE_fnc_hashGet;
                [MOD(sys_sitrep), "removesitrep",[_sitrep]] call ALIVE_fnc_sitrep;
            };

            _result = false;

            // Delete Marker
            switch ([_markerHash, QGVAR(locality), "SIDE"] call ALIVE_fnc_hashGet) do {
                case "SIDE": {
                    [[_logic,"deleteMarker",[_markerName]], "ALIVE_fnc_marker", side (group player), false, true] call BIS_fnc_MP;
                };
                case "GROUP": {
                    [[_logic,"deleteMarker",[_markerName]], "ALIVE_fnc_marker", group player, false, true] call BIS_fnc_MP;
                };
                case "FACTION": {
                   [[_logic,"deleteMarker",[_markerName, faction player]], "ALIVE_fnc_marker", true, false, true] call BIS_fnc_MP;
                };
                case "LOCAL": {
                    [_logic,"deleteMarker",[_markerName]] call ALIVE_fnc_marker;
                };
                case default {
                    [[_logic,"deleteMarker",[_markerName]], "ALIVE_fnc_marker", true, false, true] call BIS_fnc_MP;
                };
            };

            // Remove marker from store on all localities
            [[_logic, "deleteMarkerFromStore", [_markerName, _markerHash]], "ALIVE_fnc_marker",true,false,true] call BIS_fnc_MP;


            _result = GVAR(STORE);

        };

        case "deleteMarker": {
            // Handles deleting a marker on the map
            // Expects a markername as input
            private ["_markerName","_check"];
            _markerName = _args select 0;

            LOG(str _this);
            _check = false;

            if (hasInterface) then {

                if (count _args > 1) then {
                    if (faction player == (_args select 1)) then {_check = true};
                } else {
                    _check = true;
                };

                if (_check) then {
                    LOG("Deleting marker...");
                    LOG(_markerName);
                    deleteMarkerLocal _markerName;
                };
            };

            _result = _check;
        };

        case "deleteMarkerFromStore": {
             private ["_markerName"];
            _markerName = _args select 0;
            _markerHash = _args select 1;

            If (isDedicated) then {
                private "_response";
                _response = [_markerName, _markerHash] call ALIVE_fnc_markerDeleteData;
                TRACE_1("Delete Marker", _response);
            };

            [GVAR(STORE), _markerName] call ALIVE_fnc_hashRem;

            _result = GVAR(STORE);
        };

        case "deleteAllMarkers": {
            // Delete all markers on the map
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
