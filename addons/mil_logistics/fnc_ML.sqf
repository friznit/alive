//#define DEBUG_MPDE_FULL
#include <\x\alive\addons\mil_logistics\script_component.hpp>
SCRIPT(ML);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_ML
Description:
Military objectives 

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array - The selected parameters

Returns:
Any - The new instance or the result of the selected function and parameters

Attributes:
Nil - init - Initiate instance
Nil - destroy - Destroy instance
Boolean - debug - Debug enabled
Array - state - Save and restore module state
Array - faction - Faction associated with module

Examples:
[_logic, "debug", true] call ALiVE_fnc_ML;

See Also:
- <ALIVE_fnc_MLInit>

Author:
ARJay
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClass
#define MAINCLASS ALIVE_fnc_ML
#define MTEMPLATE "ALiVE_ML_%1"
#define DEFAULT_FACTIONS []
#define DEFAULT_OBJECTIVES []
#define DEFAULT_EVENT_QUEUE []
#define DEFAULT_REINFORCEMENT_ANALYSIS []
#define DEFAULT_SIDE "EAST"
#define DEFAULT_FORCE_POOL_TYPE "FIXED"
#define DEFAULT_FORCE_POOL "1000"
#define DEFAULT_ALLOW true
#define DEFAULT_TYPE "DYNAMIC"
#define PARADROP_HEIGHT 500
#define DESTINATION_VARIANCE 150
#define DESTINATION_RADIUS 300
#define WAIT_TIME_AIR 10
#define WAIT_TIME_HELI 20
#define WAIT_TIME_MARINE 30
#define WAIT_TIME_DROP 40

private ["_logic","_operation","_args","_result"];

TRACE_1("ML - input",_this);

_logic = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_operation = [_this, 1, "", [""]] call BIS_fnc_param;
_args = [_this, 2, objNull, [objNull,[],"",0,true,false]] call BIS_fnc_param;
_result = true;

switch(_operation) do {
	default {
		_result = [_logic, _operation, _args] call SUPERCLASS;
	};
	case "destroy": {
		[_logic, "debug", false] call MAINCLASS;
		if (isServer) then {
			// if server
			_logic setVariable ["super", nil];
			_logic setVariable ["class", nil];
			_logic setVariable ["markers", []];

			[_logic, "destroy"] call SUPERCLASS;
		};
	};
	case "debug": {
		if (typeName _args == "BOOL") then {
			_logic setVariable ["debug", _args];
		} else {
			_args = _logic getVariable ["debug", false];
		};
		if (typeName _args == "STRING") then {
				if(_args == "true") then {_args = true;} else {_args = false;};
				_logic setVariable ["debug", _args];
		};
		ASSERT_TRUE(typeName _args == "BOOL",str _args);

		_result = _args;
	};
	case "pause": {
        if(typeName _args != "BOOL") then {
            // if no new value was provided return current setting
            _args = [_logic,"pause",objNull,false] call ALIVE_fnc_OOsimpleOperation;
        } else {
                // if a new value was provided set groups list
                ASSERT_TRUE(typeName _args == "BOOL",str typeName _args);

                private ["_state"];
                _state = [_logic,"pause",objNull,false] call ALIVE_fnc_OOsimpleOperation;
                if (_state && _args) exitwith {};

                //Set value
                _args = [_logic,"pause",_args,false] call ALIVE_fnc_OOsimpleOperation;
                ["ALiVE Pausing state of %1 instance set to %2!",QMOD(ADDON),_args] call ALiVE_fnc_DumpR;
        };
        _result = _args;
    };
	case "createMarker": {
	    private["_position","_faction","_markers","_debugColor","_markerID","_m"];

        _position = _args select 0;
        _faction = _args select 1;
        _text = _args select 2;

        _markers = _logic getVariable ["markers", []];

        if(count _markers > 10) then {
            {
                deleteMarker _x;
            } forEach _markers;
            _markers = [];
        };

        _debugColor = "ColorPink";

        switch(_faction) do {
            case "OPF_F":{
                _debugColor = "ColorRed";
            };
            case "BLU_F":{
                _debugColor = "ColorBlue";
            };
            case "IND_F":{
                _debugColor = "ColorGreen";
            };
            case "BLU_G_F":{
                _debugColor = "ColorBrown";
            };
            default {
                _debugColor = "ColorGreen";
            };
        };

        _markerID = time;

        if(count _position > 0) then {
            _m = createMarker [format["%1_%2",MTEMPLATE,_markerID], _position];
            _m setMarkerShape "ICON";
            _m setMarkerSize [0.5, 0.5];
            _m setMarkerType "mil_join";
            _m setMarkerColor _debugColor;
            _m setMarkerText _text;

            _markers set [count _markers, _m];
        };

        _logic setVariable ["markers", _markers];
	};
	case "side": {
        _result = [_logic,_operation,_args,DEFAULT_SIDE] call ALIVE_fnc_OOsimpleOperation;
    };
    case "factions": {
        _result = [_logic,_operation,_args,DEFAULT_FACTIONS] call ALIVE_fnc_OOsimpleOperation;
    };
    case "objectives": {
        _result = [_logic,_operation,_args,DEFAULT_OBJECTIVES] call ALIVE_fnc_OOsimpleOperation;
    };
    case "eventQueue": {
        _result = [_logic,_operation,_args,DEFAULT_EVENT_QUEUE] call ALIVE_fnc_OOsimpleOperation;
    };
    case "reinforcementAnalysis": {
        _result = [_logic,_operation,_args,DEFAULT_REINFORCEMENT_ANALYSIS] call ALIVE_fnc_OOsimpleOperation;
    };
    case "forcePoolType": {
        _result = [_logic,_operation,_args,DEFAULT_FORCE_POOL_TYPE] call ALIVE_fnc_OOsimpleOperation;
    };
    case "allowInfantryReinforcement": {
        if (typeName _args == "BOOL") then {
            _logic setVariable ["allowInfantryReinforcement", _args];
        } else {
            _args = _logic getVariable ["allowInfantryReinforcement", false];
        };
        if (typeName _args == "STRING") then {
            if(_args == "true") then {_args = true;} else {_args = false;};
            _logic setVariable ["allowInfantryReinforcement", _args];
        };
        ASSERT_TRUE(typeName _args == "BOOL",str _args);

        _result = _args;
    };
    case "allowMechanisedReinforcement": {
        if (typeName _args == "BOOL") then {
            _logic setVariable ["allowMechanisedReinforcement", _args];
        } else {
            _args = _logic getVariable ["allowMechanisedReinforcement", false];
        };
        if (typeName _args == "STRING") then {
            if(_args == "true") then {_args = true;} else {_args = false;};
            _logic setVariable ["allowMechanisedReinforcement", _args];
        };
        ASSERT_TRUE(typeName _args == "BOOL",str _args);

        _result = _args;
    };
    case "allowMotorisedReinforcement": {
        if (typeName _args == "BOOL") then {
            _logic setVariable ["allowMotorisedReinforcement", _args];
        } else {
            _args = _logic getVariable ["allowMotorisedReinforcement", false];
        };
        if (typeName _args == "STRING") then {
            if(_args == "true") then {_args = true;} else {_args = false;};
            _logic setVariable ["allowMotorisedReinforcement", _args];
        };
        ASSERT_TRUE(typeName _args == "BOOL",str _args);

        _result = _args;
    };
    case "allowArmourReinforcement": {
        if (typeName _args == "BOOL") then {
            _logic setVariable ["allowArmourReinforcement", _args];
        } else {
            _args = _logic getVariable ["allowArmourReinforcement", false];
        };
        if (typeName _args == "STRING") then {
            if(_args == "true") then {_args = true;} else {_args = false;};
            _logic setVariable ["allowArmourReinforcement", _args];
        };
        ASSERT_TRUE(typeName _args == "BOOL",str _args);

        _result = _args;
    };
    case "allowHeliReinforcement": {
        if (typeName _args == "BOOL") then {
            _logic setVariable ["allowHeliReinforcement", _args];
        } else {
            _args = _logic getVariable ["allowHeliReinforcement", false];
        };
        if (typeName _args == "STRING") then {
            if(_args == "true") then {_args = true;} else {_args = false;};
            _logic setVariable ["allowHeliReinforcement", _args];
        };
        ASSERT_TRUE(typeName _args == "BOOL",str _args);

        _result = _args;
    };
    case "allowPlaneReinforcement": {
        if (typeName _args == "BOOL") then {
            _logic setVariable ["allowPlaneReinforcement", _args];
        } else {
            _args = _logic getVariable ["allowPlaneReinforcement", false];
        };
        if (typeName _args == "STRING") then {
            if(_args == "true") then {_args = true;} else {_args = false;};
            _logic setVariable ["allowPlaneReinforcement", _args];
        };
        ASSERT_TRUE(typeName _args == "BOOL",str _args);

        _result = _args;
    };
    case "type": {
        if(typeName _args == "STRING") then {
            _logic setVariable [_operation, parseNumber _args];
        };

        _result = _logic getVariable [_operation, DEFAULT_TYPE];
    };
    case "forcePool": {
        if(typeName _args == "STRING") then {
            _logic setVariable [_operation, parseNumber _args];
        };

        if(typeName _args == "SCALAR") then {
            _logic setVariable [_operation, _args];
        };

        _result = _logic getVariable [_operation, DEFAULT_FORCE_POOL];

        ["FORCE POOL: %1",_result] call ALIVE_fnc_dump;

        // update the global force pool

        private["_moduleFactions","_debug","_factions"];

        _moduleFactions = _logic getVariable ["factions", []];
        _debug = _logic getVariable ["debug", false];

        {
            _factions = _x select 1;
            {
                [ALIVE_globalForcePool,_x,_result] call ALIVE_fnc_hashSet;
            } forEach _factions;
        } forEach _moduleFactions;

        // DEBUG -------------------------------------------------------------------------------------
        if(_debug) then {
            if!(isNil "ALIVE_globalForcePool") then {
                ["ALIVE ML - Global force pool:"] call ALIVE_fnc_dump;
                ALIVE_globalForcePool call ALIVE_fnc_inspectHash;
            };
        };
        // DEBUG -------------------------------------------------------------------------------------

        ["FORCE POOL: %1",_result] call ALIVE_fnc_dump;

    };
	// Main process
	case "init": {
        if (isServer) then {

            private ["_debug","_forcePool","_type","_allowInfantry","_allowMechanised","_allowMotorised","_allowArmour","_allowHeli","_allowPlane"];

			// if server, initialise module game logic
			_logic setVariable ["super", SUPERCLASS];
			_logic setVariable ["class", MAINCLASS];
			_logic setVariable ["moduleType", "ALIVE_ML"];
			_logic setVariable ["startupComplete", false];
			_logic setVariable ["listenerID", ""];
			_logic setVariable ["analysisInProgress", false];
			_logic setVariable ["eventQueue", [] call ALIVE_fnc_hashCreate];

			_debug = [_logic, "debug"] call MAINCLASS;
			_forcePool = [_logic, "forcePool"] call MAINCLASS;
			_type = [_logic, "type"] call MAINCLASS;

			if(typeName _forcePool == "STRING") then {
                _forcePool = parseNumber _forcePool;
            };

			if(_forcePool == 10) then {
                [_logic, "forcePool", 1000] call MAINCLASS;
                [_logic, "forcePoolType", "DYNAMIC"] call MAINCLASS;
			};

			_allowInfantry = [_logic, "allowInfantryReinforcement"] call MAINCLASS;
            _allowMechanised = [_logic, "allowMechanisedReinforcement"] call MAINCLASS;
            _allowMotorised = [_logic, "allowMotorisedReinforcement"] call MAINCLASS;
            _allowArmour = [_logic, "allowArmourReinforcement"] call MAINCLASS;
            _allowHeli = [_logic, "allowHeliReinforcement"] call MAINCLASS;
            _allowPlane = [_logic, "allowPlaneReinforcement"] call MAINCLASS;

            // DEBUG -------------------------------------------------------------------------------------
            if(_debug) then {
                ["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
                ["ALIVE ML - Init"] call ALIVE_fnc_dump;
                ["ALIVE ML - Type: %1",_type] call ALIVE_fnc_dump;
                ["ALIVE ML - Force pool type: %1 limit: %2",[_logic, "forcePool"] call MAINCLASS,[_logic, "forcePoolType"] call MAINCLASS] call ALIVE_fnc_dump;
                ["ALIVE ML - Allow infantry requests: %1",_allowInfantry] call ALIVE_fnc_dump;
                ["ALIVE ML - Allow mechanised requests: %1",_allowMechanised] call ALIVE_fnc_dump;
                ["ALIVE ML - Allow motorised requests: %1",_allowMotorised] call ALIVE_fnc_dump;
                ["ALIVE ML - Allow armour requests: %1",_allowArmour] call ALIVE_fnc_dump;
                ["ALIVE ML - Allow heli requests: %1",_allowHeli] call ALIVE_fnc_dump;
                ["ALIVE ML - Allow plane requests: %1",_allowPlane] call ALIVE_fnc_dump;
            };
            // DEBUG -------------------------------------------------------------------------------------

			TRACE_1("After module init",_logic);

            [_logic,"start"] call MAINCLASS;
        };
	};
	case "start": {
        if (isServer) then {
		
			private ["_debug","_modules","_module"];
			
			_debug = [_logic, "debug"] call MAINCLASS;			
			
			
			// DEBUG -------------------------------------------------------------------------------------
			if(_debug) then {
				["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
				["ALIVE ML - Startup"] call ALIVE_fnc_dump;
			};
			// DEBUG -------------------------------------------------------------------------------------


			// check modules are available
            if !(["ALiVE_sys_profile","ALiVE_mil_opcom"] call ALiVE_fnc_isModuleAvailable) exitwith {
                ["Profile module or OPCOM module not placed! Exiting..."] call ALiVE_fnc_DumpR;
            };
			waituntil {!(isnil "ALiVE_ProfileHandler") && {[ALiVE_ProfileSystem,"startupComplete",false] call ALIVE_fnc_hashGet}};

			// set the global force pool
			if(isNil "ALIVE_globalForcePool") then {
                ALIVE_globalForcePool = [] call ALIVE_fnc_hashCreate;
            };

            // if civ cluster data not loaded, load it
			if(isNil "ALIVE_clustersCiv" && isNil "ALIVE_loadedCivClusters") then {
                _worldName = toLower(worldName);
                _file = format["\x\alive\addons\civ_placement\clusters\clusters.%1_civ.sqf", _worldName];
                call compile preprocessFileLineNumbers _file;
                ALIVE_loadedCIVClusters = true;
            };
            waituntil {!(isnil "ALIVE_loadedCIVClusters") && {ALIVE_loadedCIVClusters}};

            // if mil cluster data not loaded, load it
            if(isNil "ALIVE_clustersMil" && isNil "ALIVE_loadedMilClusters") then {
                _worldName = toLower(worldName);
                _file = format["\x\alive\addons\mil_placement\clusters\clusters.%1_mil.sqf", _worldName];
                call compile preprocessFileLineNumbers _file;
                ALIVE_loadedMilClusters = true;
            };
            waituntil {!(isnil "ALIVE_loadedMilClusters") && {ALIVE_loadedMilClusters}};

            // get all synced modules
            _modules = [];
					
			for "_i" from 0 to ((count synchronizedObjects _logic)-1) do {
				_moduleObject = (synchronizedObjects _logic) select _i;
               
                waituntil {_module = _moduleObject getVariable "handler"; !(isnil "_module")};
                _module = _moduleObject getVariable "handler";
				_modules set [count _modules, _module];
			};


			// DEBUG -------------------------------------------------------------------------------------
			if(_debug) then {
				["ALIVE ML - Startup completed"] call ALIVE_fnc_dump;
				["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
			};
			// DEBUG -------------------------------------------------------------------------------------
			
			
			_logic setVariable ["startupComplete", true];
			
			if(count _modules > 0) then {
				[_logic, "initialAnalysis", _modules] call MAINCLASS;
			}else{
				["ALIVE ML - Warning no OPCOM modules synced to Military Logistics module, nothing to do.."] call ALIVE_fnc_dumpR;
			};					
        };
	};
	case "initialAnalysis": {
        if (isServer) then {
		
			private ["_debug","_modules","_module","_modulesFactions","_moduleSide","_moduleFactions","_modulesObjectives","_moduleFactionBreakdowns",
			"_faction","_factionBreakdown","_objectives","_forcePool"];

			_modules = _args;
			
			_debug = [_logic, "debug"] call MAINCLASS;
			_modulesFactions = [];
			_modulesObjectives = [];

			// get objectives and modules settings from syncronised OPCOM instances
			// should only be 1...
			{
				_module = _x;
				_moduleSide = [_module,"side"] call ALiVE_fnc_HashGet;
				_moduleFactions = [_module,"factions"] call ALiVE_fnc_HashGet;

                // store side
				[_logic, "side", _moduleSide] call MAINCLASS;

                // get the objectives from the module
				_objectives = [];

                waituntil {
                    sleep 10;
                    _objectives = nil;
                    _objectives = [_module,"objectives"] call ALIVE_fnc_hashGet;
                    (!(isnil "_objectives") && {count _objectives > 0})
                };

                _modulesFactions set [count _modulesFactions, [_moduleSide,_moduleFactions]];
                _modulesObjectives set [count _modulesObjectives, _objectives];

                // set the faction force pools
                {
                    [ALIVE_globalForcePool,_x,0] call ALIVE_fnc_hashSet;
                } forEach _moduleFactions;

			} forEach _modules;


			[_logic, "factions", _modulesFactions] call MAINCLASS;
			[_logic, "objectives", _modulesObjectives] call MAINCLASS;

            // start listening for logcom events
            [_logic,"listen"] call MAINCLASS;

            // trigger main processing loop
            [_logic, "monitor"] call MAINCLASS;
		};		
	};
	case "listen": {
        private["_listenerID"];

        _listenerID = [ALIVE_eventLog, "addListener",[_logic, ["LOGCOM_REQUEST"]]] call ALIVE_fnc_eventLog;
        _logic setVariable ["listenerID", _listenerID];
    };
    case "handleEvent": {

        private["_debug","_event","_eventQueue","_side","_factions","_eventFaction","_factionFound","_forcePool","_type","_eventID",
        "_eventData","_eventType","_eventForceMakeup","_eventForceInfantry","_eventForceMotorised","_eventForceMechanised","_eventForceArmour",
        "_eventForcePlane","_eventForceHeli","_forceMakeupTotal","_allowInfantry","_allowMechanised","_allowMotorised",
        "_allowArmour","_allowHeli","_allowPlane","_playerID","_requestID","_logEvent"];

        if(typeName _args == "ARRAY") then {

            _debug = [_logic, "debug"] call MAINCLASS;
            _event = _args;

            _side = [_logic, "side"] call MAINCLASS;
            _factions = [_logic, "factions"] call MAINCLASS;

            _eventFaction = ([_event, "data"] call ALIVE_fnc_hashGet) select 1;

            // check if the faction in the event is handled
            // by this module
            _factionFound = false;

            {
                _moduleFactions = _x select 1;
                if(_eventFaction in _moduleFactions) then {
                    _factionFound = true;
                };
            } forEach _factions;


            if(_factionFound) then {

                _forcePool = [_logic, "forcePool"] call MAINCLASS;
                _type = [_logic, "type"] call MAINCLASS;

                if(typeName _forcePool == "STRING") then {
                    _forcePool = parseNumber _forcePool;
                };

                ["FORCE POOL: %1",_forcePool] call ALIVE_fnc_dump;

                // if there are still forces available
                if(_forcePool > 0) then {

                    _eventID = [_event, "id"] call ALIVE_fnc_hashGet;
                    _eventData = [_event, "data"] call ALIVE_fnc_hashGet;
                    _eventForceMakeup = _eventData select 3;
                    _eventType = _eventData select 4;

                    _forceMakeupTotal = 0;

                    if(_eventType == "STANDARD" || _eventType == "AIRDROP" || _eventType == "HELI_INSERT") then {

                        _allowInfantry = [_logic, "allowInfantryReinforcement"] call MAINCLASS;
                        _allowMechanised = [_logic, "allowMechanisedReinforcement"] call MAINCLASS;
                        _allowMotorised = [_logic, "allowMotorisedReinforcement"] call MAINCLASS;
                        _allowArmour = [_logic, "allowArmourReinforcement"] call MAINCLASS;
                        _allowHeli = [_logic, "allowHeliReinforcement"] call MAINCLASS;
                        _allowPlane = [_logic, "allowPlaneReinforcement"] call MAINCLASS;

                        _eventForceInfantry = _eventForceMakeup select 0;
                        _eventForceMotorised = _eventForceMakeup select 1;
                        _eventForceMechanised = _eventForceMakeup select 2;
                        _eventForceArmour = _eventForceMakeup select 3;
                        _eventForcePlane = _eventForceMakeup select 4;
                        _eventForceHeli = _eventForceMakeup select 5;

                        _forceMakeupTotal = _eventForceInfantry + _eventForceMotorised + _eventForceMechanised + _eventForceArmour + _eventForcePlane + _eventForceHeli;

                        //["CHECK AI: %1 AM: %2 AM: %3 AA: %4 AH: %5 AP: %6",_allowInfantry,_allowMechanised,_allowMotorised,_allowArmour,_allowHeli,_allowPlane] call ALIVE_fnc_dump;
                        //["FORCE MAKEUP BEFORE: %1", _eventForceMakeup] call ALIVE_fnc_dump;

                        if!(_allowInfantry) then {
                            _forceMakeupTotal = _forceMakeupTotal - _eventForceInfantry;
                            _eventForceMakeup set [0,0];
                        };

                        if!(_allowMotorised) then {
                            _forceMakeupTotal = _forceMakeupTotal - _eventForceMotorised;
                            _eventForceMakeup set [1,0];
                        };

                        if!(_allowMechanised) then {
                            _forceMakeupTotal = _forceMakeupTotal - _eventForceMechanised;
                            _eventForceMakeup set [2,0];
                        };

                        if!(_allowArmour) then {
                            _forceMakeupTotal = _forceMakeupTotal - _eventForceArmour;
                            _eventForceMakeup set [3,0];
                        };

                        if!(_allowPlane) then {
                            _forceMakeupTotal = _forceMakeupTotal - _eventForcePlane;
                            _eventForceMakeup set [4,0];
                        };

                        if!(_allowHeli) then {
                            _forceMakeupTotal = _forceMakeupTotal - _eventForceHeli;
                            _eventForceMakeup set [5,0];
                        };

                        _eventData set [3, _eventForceMakeup];
                        [_event, "data", _eventData] call ALIVE_fnc_hashSet;

                        // set the state of the event
                        [_event, "state", "requested"] call ALIVE_fnc_hashSet;

                        // set the player requested flag on the event
                        [_event, "playerRequested", false] call ALIVE_fnc_hashSet;

                    }else{

                        _playerID = _eventData select 5;
                        _requestID = _eventForceMakeup select 0;

                        // if it's a player request
                        // accept automatically

                        _forceMakeupTotal = 1;

                        // set the state of the event
                        [_event, "state", "playerRequested"] call ALIVE_fnc_hashSet;

                        // set the player requested flag on the event
                        [_event, "playerRequested", true] call ALIVE_fnc_hashSet;

                        // respond to player request
                        _logEvent = ['LOGCOM_RESPONSE', [_requestID,_playerID],"Logistics","ACKNOWLEDGED"] call ALIVE_fnc_event;
                        [ALIVE_eventLog, "addEvent",_logEvent] call ALIVE_fnc_eventLog;

                    };


                    //["FORCE MAKEUP AFTER: %1 FORCE MAKEUP TOTAL: %2", _eventForceMakeup, _forceMakeupTotal] call ALIVE_fnc_dump;
                    //_event call ALIVE_fnc_inspectHash;

                    if(_forceMakeupTotal > 0) then {

                        // set the time the event was received
                        [_event, "time", time] call ALIVE_fnc_hashSet;

                        // set the state data array of the event
                        [_event, "stateData", []] call ALIVE_fnc_hashSet;

                        // set the profiles array of the event
                        [_event, "cargoProfiles", [] call ALIVE_fnc_hashCreate] call ALIVE_fnc_hashSet;
                        [_event, "transportProfiles", []] call ALIVE_fnc_hashSet;
                        [_event, "transportVehiclesProfiles", []] call ALIVE_fnc_hashSet;
                        [_event, "playerRequestProfiles", [] call ALIVE_fnc_hashCreate] call ALIVE_fnc_hashSet;

                        // store the event on the event queue
                        _eventQueue = [_logic, "eventQueue"] call MAINCLASS;
                        [_eventQueue, _eventID, _event] call ALIVE_fnc_hashSet;


                        // DEBUG -------------------------------------------------------------------------------------
                        if(_debug) then {
                            ["ALIVE ML - Reinforce event received"] call ALIVE_fnc_dump;
                            ["ALIVE ML - Current force pool for side: %2 available: %3", _side, _forcePool] call ALIVE_fnc_dump;
                            _event call ALIVE_fnc_inspectHash;
                        };
                        // DEBUG -------------------------------------------------------------------------------------


                        // trigger analysis
                        [_logic,"onDemandAnalysis"] call MAINCLASS;


                    }else{

                        // nothing left after non allowed types ruled out

                    };

                }else{


                    // DEBUG -------------------------------------------------------------------------------------
                    if(_debug) then {
                        ["ALIVE ML - Reinforce event denied, force pool for side: %1 exhausted : %2", _side, _forcePool] call ALIVE_fnc_dump;
                    };
                    // DEBUG -------------------------------------------------------------------------------------

                    if(_eventType == "PR_STANDARD" || _eventType == "PR_AIRDROP" || _eventType == "PR_HELI_INSERT") then {

                        // respond to player request
                        _logEvent = ['LOGCOM_RESPONSE', [_requestID,_playerID],"Logistics","DENIED_FORCEPOOL"] call ALIVE_fnc_event;
                        [ALIVE_eventLog, "addEvent",_logEvent] call ALIVE_fnc_eventLog;

                    };


                };

            }else{

                // faction not handled by this module, ignored..

            };

        };
    };

    case "onDemandAnalysis": {
        private["_debug","_analysisInProgress","_type","_forcePoolType","_forcePool","_objectives"];

        if (isServer) then {

            _debug = [_logic, "debug"] call MAINCLASS;
            _analysisInProgress = _logic getVariable ["analysisInProgress", false];

            // if analysis not already underway
            if!(_analysisInProgress) then {

                _logic setVariable ["analysisInProgress", true];

                _type = [_logic, "type"] call MAINCLASS;
                _forcePoolType = [_logic, "forcePoolType"] call MAINCLASS;
                _forcePool = [_logic, "forcePool"] call MAINCLASS;
                if(typeName _forcePool == "STRING") then {
                    _forcePool = parseNumber _forcePool;
                };

                _objectives = [_logic, "objectives"] call MAINCLASS;
                _objectives = _objectives select 0;


                // DEBUG -------------------------------------------------------------------------------------
                if(_debug) then {
                    ["ALIVE ML - On demand dynamic analysis started"] call ALIVE_fnc_dump;
                };
                // DEBUG -------------------------------------------------------------------------------------


                private["_reserve","_tacom_state","_priorityTotal","_priority"];

                _reserve = [];
                _priorityTotal = 0;

                // sort OPCOM objective states to find
                // reserved objectives
                {
                    _tacom_state = '';
                    if("tacom_state" in (_x select 1)) then {
                        _tacom_state = [_x,"tacom_state"] call ALIVE_fnc_hashGet;
                    };

                    switch(_tacom_state) do {
                        case "reserve":{

                            // increase the priority count by adding
                            // all held objective priorities
                            _priority = [_x,"priority"] call ALIVE_fnc_hashGet;
                            _priorityTotal = _priorityTotal + _priority;

                            // store the objective
                            _reserve set [count _reserve, _x];
                        };
                    };

                } forEach _objectives;

                private["_previousReinforcementAnalysis","_previousReinforcementAnalysisPriorityTotal"];

                _previousReinforcementAnalysis = [_logic, "reinforcementAnalysis"] call MAINCLASS;

                // if the force pool type is dynamic
                // calculate the new pool
                if(_forcePoolType == "DYNAMIC") then {

                    //["DYNAMIC FORCE POOL"] call ALIVE_fnc_dump;
                    //["CURRENT FORCE POOL: %1",_forcePool] call ALIVE_fnc_dump;

                    // if there is a previous analysis
                    if(count _previousReinforcementAnalysis > 0) then {

                        //["PREVIOUS ANALYSIS FOUND"] call ALIVE_fnc_dump;

                        _previousReinforcementAnalysisPriorityTotal = [_previousReinforcementAnalysis, "priorityTotal"] call ALIVE_fnc_hashGet;

                        // if the current priority total is greater
                        // than the previous priority total
                        // objectives have been captured
                        // increase the available pool
                        if(_priorityTotal > _previousReinforcementAnalysisPriorityTotal) then {

                            //["CURRENT PRIORITY TOTAL IS GREATER THAN PREVIOUS"] call ALIVE_fnc_dump;

                            _forcePool = _forcePool + (_priorityTotal - _previousReinforcementAnalysisPriorityTotal);

                        }else{

                            if(_priorityTotal < _previousReinforcementAnalysisPriorityTotal) then {

                                // objectives have been lost
                                // reduce the force pool

                                if(_forcePool > 0) then {

                                    //["CURRENT PRIORITY TOTAL IS LESS THAN PREVIOUS"] call ALIVE_fnc_dump;

                                    _forcePool = _forcePool - (_previousReinforcementAnalysisPriorityTotal - _priorityTotal);

                                };

                            };

                        };

                    }else{

                        //["NO PREVIOUS ANALYSIS"] call ALIVE_fnc_dump;

                        // set the force pool as the
                        // current total
                        _forcePool = _priorityTotal;

                    };

                    //["NEW FORCE POOL: %1",_forcePool] call ALIVE_fnc_dump;

                    [_logic, "forcePool", _forcePool] call MAINCLASS;

                };


                private["_primaryReinforcementObjective","_reinforcementType","_sortedClusters",
                "_sortedObjectives","_primaryReinforcementObjectivePriority","_reinforcementAnalysis",
                "_previousPrimaryObjective","_available"];

                _primaryReinforcementObjective = [] call ALIVE_fnc_hashCreate;
                _reinforcementType = "";
                _available = false;

                if(_type == "STATIC") then {

                    // Static analysis, only one insertion point
                    // may be held. This point is dictated
                    // by the placement location
                    // once lost the insertion point is
                    // deactivated until recaptured

                    // if there is no previous analysis
                    if(count _previousReinforcementAnalysis == 0) then {

                        if(count _objectives > 0) then {

                            // sort objectives by distance to module
                            _sortedObjectives = [_objectives,[],{(position _logic) distance (_x select 2 select 1)},"DESCEND"] call BIS_fnc_sortBy;

                            // get the highest priority objective
                            _primaryReinforcementObjective = _sortedObjectives select ((count _sortedObjectives)-1);

                            // determine the type of reinforcement according to priority
                            _primaryReinforcementObjectivePriority = [_primaryReinforcementObjective,"priority"] call ALIVE_fnc_hashGet;

                            // if the state of the objective is reserved
                            // objective is available for use
                            _tacom_state = '';
                            if("tacom_state" in (_primaryReinforcementObjective select 1)) then {
                                _tacom_state = [_primaryReinforcementObjective,"tacom_state"] call ALIVE_fnc_hashGet;
                            };

                            if(_tacom_state == "reserve") then {
                                _available = true;
                            };

                            _reinforcementType = "DROP";

                            if(_primaryReinforcementObjectivePriority > 50) then {
                                _reinforcementType = "AIR";
                            };

                            if(_primaryReinforcementObjectivePriority > 40 && _primaryReinforcementObjectivePriority < 51) then {
                                _reinforcementType = "HELI";
                            };

                        }else{

                            // no objectives nothing available
                            _available = false;
                        }

                    }else{

                        // there is previous analysis

                        _primaryReinforcementObjective = [_previousReinforcementAnalysis, "primary"] call ALIVE_fnc_hashGet;
                        _reinforcementType = [_previousReinforcementAnalysis, "type"] call ALIVE_fnc_hashGet;

                        // if the state of the objective is reserved
                        // objective is available for use
                        _tacom_state = '';
                        if("tacom_state" in (_primaryReinforcementObjective select 1)) then {
                            _tacom_state = [_primaryReinforcementObjective,"tacom_state"] call ALIVE_fnc_hashGet;
                        };

                        if(_tacom_state == "reserve") then {
                            _available = true;
                        };

                    };

                }else{

                    _available = true;

                    // Dynamic analysis, primary insertion objective
                    // will fall back to held objectives, finally
                    // falling back to non held marine or bases

                    if(count _reserve > 0) then {

                        // OPCOM controls some objectives
                        // reinforcements can be delivered
                        // directly assuming heli pads or
                        // airstrips are available


                        // sort reserved objectives by priority
                        _sortedObjectives = [_reserve,[],{([_x, "priority"] call ALIVE_fnc_hashGet)},"ASCEND"] call BIS_fnc_sortBy;

                        // get the highest priority objective
                        _primaryReinforcementObjective = _sortedObjectives select ((count _sortedObjectives)-1);

                        // determine the type of reinforcement according to priority
                        _primaryReinforcementObjectivePriority = [_primaryReinforcementObjective,"priority"] call ALIVE_fnc_hashGet;

                        _reinforcementType = "DROP";

                        if(_primaryReinforcementObjectivePriority > 50) then {
                            _reinforcementType = "AIR";
                        };

                        if(_primaryReinforcementObjectivePriority > 40 && _primaryReinforcementObjectivePriority < 51) then {
                            _reinforcementType = "HELI";
                        };


                    }else{

                        // OPCOM controls no objectives
                        // reinforcements must be delivered
                        // via paradrops and or marine landings
                        // near to location of any existing troops

                        // randomly pick between marine and mil location for start position
                        if(random 1 > 0.5) then {

                            if(count(ALIVE_clustersCivMarine select 2) > 0) then {

                                // there are marine objectives available

                                // pick a primary one
                                _primaryReinforcementObjective = (ALIVE_clustersCivMarine select 2) call BIS_fnc_selectRandom;

                                _reinforcementType = "MARINE";

                            }else{

                                // no marine objectives available
                                // pick a low priority location for airdrops

                                if(count(ALIVE_clustersMil select 2) > 0) then {

                                    _sortedClusters = [ALIVE_clustersMil select 2,[],{([_x, "priority"] call ALIVE_fnc_hashGet)},"DESCEND"] call BIS_fnc_sortBy;

                                    // get the highest priority objective
                                    _primaryReinforcementObjective = _sortedClusters select ((count _sortedClusters)-1);

                                    _reinforcementType = "DROP";

                                };

                            };

                        }else{

                            // pick a low priority location for airdrops

                            if(count(ALIVE_clustersMil select 2) > 0) then {

                                _sortedClusters = [ALIVE_clustersMil select 2,[],{([_x, "priority"] call ALIVE_fnc_hashGet)},"DESCEND"] call BIS_fnc_sortBy;

                                // get the highest priority objective
                                _primaryReinforcementObjective = _sortedClusters select ((count _sortedClusters)-1);

                                _reinforcementType = "DROP";

                            };

                        };

                    };
                };

                // store the analysis results
                _reinforcementAnalysis = [] call ALIVE_fnc_hashCreate;
                [_reinforcementAnalysis, "priorityTotal", _priorityTotal] call ALIVE_fnc_hashSet;
                [_reinforcementAnalysis, "type", _reinforcementType] call ALIVE_fnc_hashSet;
                [_reinforcementAnalysis, "available", _available] call ALIVE_fnc_hashSet;
                [_reinforcementAnalysis, "primary", _primaryReinforcementObjective] call ALIVE_fnc_hashSet;

                [_logic, "reinforcementAnalysis", _reinforcementAnalysis] call MAINCLASS;

                // DEBUG -------------------------------------------------------------------------------------
                if(_debug) then {
                    ["ALIVE ML - On demand analysis complete"] call ALIVE_fnc_dump;
                    ["ALIVE ML - Priority total: %1",_priorityTotal] call ALIVE_fnc_dump;
                    ["ALIVE ML - Reinforcement type: %1",_reinforcementType] call ALIVE_fnc_dump;
                    ["ALIVE ML - Primary reinforcement objective available: %1",_available] call ALIVE_fnc_dump;
                    ["ALIVE ML - Primary reinforcement objective:"] call ALIVE_fnc_dump;
                    _primaryReinforcementObjective call ALIVE_fnc_inspectHash;
                };
                // DEBUG -------------------------------------------------------------------------------------


                _logic setVariable ["analysisInProgress", false];
            };
        };
    };

    case "monitor": {
        if (isServer) then {

            // spawn monitoring loop

            [_logic] spawn {

                private ["_logic","_debug"];

                _logic = _this select 0;
                _debug = [_logic, "debug"] call MAINCLASS;


                // DEBUG -------------------------------------------------------------------------------------
                if(_debug) then {
                    ["ALIVE ML - Monitoring loop started"] call ALIVE_fnc_dump;
                };
                // DEBUG -------------------------------------------------------------------------------------


                waituntil {

                    sleep (10);

                    if!([_logic, "pause"] call MAINCLASS) then {

                        private ["_reinforcementAnalysis","_analysisInProgress","_eventQueue"];

                        _reinforcementAnalysis = [_logic, "reinforcementAnalysis"] call MAINCLASS;

                        // analysis has run
                        if(count _reinforcementAnalysis > 0) then {

                            _analysisInProgress = _logic getVariable ["analysisInProgress", false];

                            // if analysis not processing
                            if!(_analysisInProgress) then {

                                // loop the event queue
                                // and manage each event
                                _eventQueue = [_logic, "eventQueue"] call MAINCLASS;

                                if((count (_eventQueue select 2)) > 0) then {

                                    {
                                        [_logic,"monitorEvent",[_x, _reinforcementAnalysis]] call MAINCLASS;
                                    } forEach (_eventQueue select 2);

                                };

                            };

                        };

                    };

                    false
                };

            };

        };

    };

    case "monitorEvent": {

         private ["_debug","_event","_reinforcementAnalysis","_side","_eventID","_eventData","_eventPosition","_eventSide","_eventFaction",
         "_eventForceMakeup","_eventType","_eventForceInfantry","_eventForceMotorised","_eventForceMechanised","_eventForceArmour",
         "_eventForcePlane","_eventForceHeli","_eventForceSpecOps","_eventTime","_eventState","_eventStateData","_eventCargoProfiles",
         "_eventTransportProfiles","_eventTransportVehiclesProfiles","_playerRequested","_playerRequestProfiles","_reinforcementPriorityTotal"
         ,"_reinforcementType","_reinforcementAvailable","_reinforcementPrimaryObjective","_event",
         "_eventID","_eventQueue","_forcePool","_logEvent","_playerID","_requestID","_payload","_emptyVehicles",
         "_staticIndividuals","_joinIndividuals","_reinforceIndividuals","_staticGroups","_joinGroups","_reinforceGroups"];

        _debug = [_logic, "debug"] call MAINCLASS;
        _event = _args select 0;
        _reinforcementAnalysis = _args select 1;

        _side = [_logic, "side"] call MAINCLASS;
        _eventQueue = [_logic, "eventQueue"] call MAINCLASS;
        _forcePool = [_logic, "forcePool"] call MAINCLASS;
        if(typeName _forcePool == "STRING") then {
            _forcePool = parseNumber _forcePool;
        };

        _eventID = [_event, "id"] call ALIVE_fnc_hashGet;
        _eventData = [_event, "data"] call ALIVE_fnc_hashGet;
        _eventTime = [_event, "time"] call ALIVE_fnc_hashGet;
        _eventState = [_event, "state"] call ALIVE_fnc_hashGet;
        _eventStateData = [_event, "stateData"] call ALIVE_fnc_hashGet;
        _eventCargoProfiles = [_event, "cargoProfiles"] call ALIVE_fnc_hashGet;
        _eventTransportProfiles = [_event, "transportProfiles"] call ALIVE_fnc_hashGet;
        _eventTransportVehiclesProfiles = [_event, "transportVehiclesProfiles"] call ALIVE_fnc_hashGet;
        _playerRequested = [_event, "playerRequested"] call ALIVE_fnc_hashGet;
        _playerRequestProfiles = [_event, "playerRequestProfiles"] call ALIVE_fnc_hashGet;

        _reinforcementPriorityTotal = [_reinforcementAnalysis, "priorityTotal"] call ALIVE_fnc_hashGet;
        _reinforcementType = [_reinforcementAnalysis, "type"] call ALIVE_fnc_hashGet;
        _reinforcementAvailable = [_reinforcementAnalysis, "available"] call ALIVE_fnc_hashGet;
        _reinforcementPrimaryObjective = [_reinforcementAnalysis, "primary"] call ALIVE_fnc_hashGet;

        _eventPosition = _eventData select 0;
        _eventFaction = _eventData select 1;
        _eventSide = _eventData select 2;
        _eventForceMakeup = _eventData select 3;
        _eventType = _eventData select 4;


        if(_playerRequested) then {

            _playerID = _eventData select 5;
            _requestID = _eventForceMakeup select 0;
            _payload = _eventForceMakeup select 1;
            _emptyVehicles = _eventForceMakeup select 2;
            _staticIndividuals = _eventForceMakeup select 3;
            _joinIndividuals = _eventForceMakeup select 4;
            _reinforceIndividuals = _eventForceMakeup select 5;
            _staticGroups = _eventForceMakeup select 6;
            _joinGroups = _eventForceMakeup select 7;
            _reinforceGroups = _eventForceMakeup select 8;


        }else{

            _eventForceInfantry = _eventForceMakeup select 0;
            _eventForceMotorised = _eventForceMakeup select 1;
            _eventForceMechanised = _eventForceMakeup select 2;
            _eventForceArmour = _eventForceMakeup select 3;
            _eventForcePlane = _eventForceMakeup select 4;
            _eventForceHeli = _eventForceMakeup select 5;

        };

        // DEBUG -------------------------------------------------------------------------------------
        if(_debug) then {
            ["ALIVE ML - Monitoring Event"] call ALIVE_fnc_dump;
            _event call ALIVE_fnc_inspectHash;
            //_reinforcementAnalysis call ALIVE_fnc_inspectHash;
        };
        // DEBUG -------------------------------------------------------------------------------------


        // react according to current event state
        switch(_eventState) do {

            // AI REQUEST ---------------------------------------------------------------------------------------------------------------------------------

            // the units have been requested
            // spawn the units at the insertion point
            case "requested": {

                private ["_waitTime"];

                // according to the type of reinforcement
                // adjust wait time for creation of profiles

                switch(_reinforcementType) do {
                    case "AIR": {
                        _waitTime = WAIT_TIME_AIR;
                    };
                    case "HELI": {
                        _waitTime = WAIT_TIME_HELI;
                    };
                    case "MARINE": {
                        _waitTime = WAIT_TIME_MARINE;
                    };
                    case "DROP": {
                        _waitTime = WAIT_TIME_DROP;
                    };
                };


                // DEBUG -------------------------------------------------------------------------------------
                if(_debug) then {
                    ["ALIVE ML - Event state: %1 event timer: %2 wait time on event: %3 ",_eventState, (time - _eventTime), _waitTime] call ALIVE_fnc_dump;
                };
                // DEBUG -------------------------------------------------------------------------------------


                // if the reinforcement objective is
                // not available, cancel the event
                if(_reinforcementAvailable) then {

                    if((time - _eventTime) > _waitTime) then {

                        private ["_reinforcementPosition","_playersInRange","_paraDrop","_remotePosition"];

                        if(_eventType == "STANDARD" || _eventType == "HELI_INSERT") then {

                            _reinforcementPosition = [_reinforcementPrimaryObjective,"center"] call ALIVE_fnc_hashGet;

                        }else{
                            _reinforcementPosition = _eventPosition;
                        };

                        // if heli insert allow only air and
                        // infantry groups
                        if(_eventType == "HELI_INSERT") then {
                            _eventForceMotorised = 0;
                            _eventForceMechanised = 0;
                            _eventForceArmour = 0;
                        };

                        // players near check

                        _playersInRange = [_reinforcementPosition, 1500] call ALiVE_fnc_anyPlayersInRange;

                        // if players are in visible range
                        // para drop groups instead of
                        // spawning on the ground

                        _paraDrop = false;
                        if(_playersInRange > 0) then {
                            _paraDrop = true;

                            _remotePosition = [_reinforcementPosition, 2000] call ALIVE_fnc_getPositionDistancePlayers;
                        }else{
                            _remotePosition = _reinforcementPosition;
                        };


                        // wait time complete create profiles
                        // get groups according to requested force makeup

                        private ["_infantryGroups","_infantryProfiles","_transportGroups","_transportProfiles",
                        "_transportVehicleProfiles","_group","_groupCount","_totalCount","_vehicleClass",
                        "_profiles","_profileIDs","_profileID"];

                        _groupCount = 0;
                        _totalCount = 0;

                        // infantry

                        _infantryGroups = [];
                        _infantryProfiles = [];

                        for "_i" from 0 to _eventForceInfantry -1 do {
                            _group = ["Infantry",_eventFaction] call ALIVE_fnc_configGetRandomGroup;
                            if!(_group == "FALSE") then {
                                _infantryGroups set [count _infantryGroups, _group];
                            }
                        };

                        _infantryGroups = _infantryGroups - ALiVE_PLACEMENT_GROUPBLACKLIST;
                        _groupCount = count _infantryGroups;
                        _totalCount = _totalCount + _groupCount;

                        // create profiles

                        for "_i" from 0 to _groupCount -1 do {

                            _group = _infantryGroups select _i;

                            _position = [_reinforcementPosition, (random(200)), random(360)] call BIS_fnc_relPos;

                            if(_paraDrop) then {

                                if(_eventType == "HELI_INSERT") then {
                                    _position = _remotePosition;
                                }else{
                                    _position set [2,PARADROP_HEIGHT];
                                };
                            };

                            if!(surfaceIsWater _position) then {

                                _profiles = [_group, _position, random(360), false, _eventFaction, true] call ALIVE_fnc_createProfilesFromGroupConfig;

                                _profileIDs = [];
                                {
                                    _profileID = _x select 2 select 4;
                                    _profileIDs set [count _profileIDs, _profileID];
                                } forEach _profiles;

                                _infantryProfiles set [count _infantryProfiles, _profileIDs];

                            };
                        };

                        [_eventCargoProfiles, "infantry", _infantryProfiles] call ALIVE_fnc_hashSet;


                        if(_eventType == "STANDARD") then {

                            // create ground transport vehicles for the profiles

                            _transportGroups = [ALIVE_factionDefaultTransport,_eventFaction,[]] call ALIVE_fnc_hashGet;
                            _transportProfiles = [];
                            _transportVehicleProfiles = [];

                            if(count _transportGroups == 0) then {
                                _transportGroups = [ALIVE_sideDefaultTransport,_side] call ALIVE_fnc_hashGet;
                            };

                            if(count _transportGroups > 0) then {
                                for "_i" from 0 to _groupCount -1 do {

                                    _position = [_reinforcementPosition, (random(200)), random(360)] call BIS_fnc_relPos;

                                    if(_paraDrop) then {
                                        _position set [2,PARADROP_HEIGHT];
                                    };

                                    if(count _transportGroups > 0) then {

                                        _vehicleClass = _transportGroups call BIS_fnc_selectRandom;

                                        _profiles = [_vehicleClass,_side,_eventFaction,"CAPTAIN",_position,random(360),false,_eventFaction,false,true] call ALIVE_fnc_createProfilesCrewedVehicle;

                                        _transportProfiles set [count _transportProfiles, _profiles select 0 select 2 select 4];
                                        _transportVehicleProfiles set [count _transportVehicleProfiles, _profiles select 1 select 2 select 4];

                                    }

                                };
                            };

                            _eventTransportProfiles = _transportProfiles;
                            _eventTransportVehiclesProfiles = _transportVehicleProfiles;

                        };

                        if(_eventType == "HELI_INSERT") then {

                            private ["_infantryProfileID","_infantryProfile","_profileWaypoint","_profile"];

                            // create air transport vehicles for the profiles

                            _transportGroups = [ALIVE_factionDefaultAirTransport,_eventFaction,[]] call ALIVE_fnc_hashGet;
                            _transportProfiles = [];
                            _transportVehicleProfiles = [];

                            if(count _transportGroups == 0) then {
                                _transportGroups = [ALIVE_sideDefaultAirTransport,_side] call ALIVE_fnc_hashGet;
                            };

                            if(count _transportGroups > 0) then {

                                for "_i" from 0 to _groupCount -1 do {

                                    _position = [_remotePosition, (random(200)), random(360)] call BIS_fnc_relPos;

                                    if(_paraDrop) then {
                                        _position set [2,PARADROP_HEIGHT];
                                    };

                                    if(count _transportGroups > 0) then {

                                        _vehicleClass = _transportGroups call BIS_fnc_selectRandom;

                                        _profiles = [_vehicleClass,_side,_eventFaction,"CAPTAIN",_position,random(360),false,_eventFaction,true,true] call ALIVE_fnc_createProfilesCrewedVehicle;

                                        _transportProfiles set [count _transportProfiles, _profiles select 0 select 2 select 4];
                                        _transportVehicleProfiles set [count _transportVehicleProfiles, _profiles select 1 select 2 select 4];

                                        _infantryProfileID = _infantryProfiles select _i select 0;
                                        if!(isNil "_infantryProfileID") then {
                                            _infantryProfile = [ALIVE_profileHandler, "getProfile", _infantryProfileID] call ALIVE_fnc_profileHandler;
                                            if!(isNil "_infantryProfile") then {
                                                [_infantryProfile,_profiles select 1] call ALIVE_fnc_createProfileVehicleAssignment;
                                            };
                                        };

                                        _profileWaypoint = [_reinforcementPosition, 100, "MOVE", "LIMITED", 300, [], "LINE"] call ALIVE_fnc_createProfileWaypoint;
                                        _profile = _profiles select 0;
                                        [_profile, "addWaypoint", _profileWaypoint] call ALIVE_fnc_profileEntity;

                                    };

                                };

                            };

                            _eventTransportProfiles = _transportProfiles;
                            _eventTransportVehiclesProfiles = _transportVehicleProfiles;

                        };


                        // armour

                        private ["_armourGroups","_armourProfiles"];

                        _armourGroups = [];
                        _armourProfiles = [];

                        for "_i" from 0 to _eventForceArmour -1 do {
                            _group = ["Armored",_eventFaction] call ALIVE_fnc_configGetRandomGroup;
                            if!(_group == "FALSE") then {
                                _armourGroups set [count _armourGroups, _group];
                            };
                        };

                        _armourGroups = _armourGroups - ALiVE_PLACEMENT_GROUPBLACKLIST;
                        _groupCount = count _armourGroups;
                        _totalCount = _totalCount + _groupCount;

                        // create profiles

                        for "_i" from 0 to _groupCount -1 do {

                            _group = _armourGroups select _i;

                            _position = [_reinforcementPosition, (random(200)), random(360)] call BIS_fnc_relPos;

                            if(_paraDrop) then {
                                _position set [2,PARADROP_HEIGHT];
                            };

                            if!(surfaceIsWater _position) then {

                                _profiles = [_group, _position, random(360), false, _eventFaction, true] call ALIVE_fnc_createProfilesFromGroupConfig;

                                _profileIDs = [];
                                {
                                    _profileID = _x select 2 select 4;
                                    _profileIDs set [count _profileIDs, _profileID];
                                } forEach _profiles;

                                _armourProfiles set [count _armourProfiles, _profileIDs];

                            };
                        };

                        [_eventCargoProfiles, "armour", _armourProfiles] call ALIVE_fnc_hashSet;


                        // mechanised

                        private ["_mechanisedGroups","_mechanisedProfiles"];

                        _mechanisedGroups = [];
                        _mechanisedProfiles = [];

                        for "_i" from 0 to _eventForceMechanised -1 do {
                            _group = ["Mechanized",_eventFaction] call ALIVE_fnc_configGetRandomGroup;
                            if!(_group == "FALSE") then {
                                _mechanisedGroups set [count _mechanisedGroups, _group];
                            }
                        };

                        _mechanisedGroups = _mechanisedGroups - ALiVE_PLACEMENT_GROUPBLACKLIST;
                        _groupCount = count _mechanisedGroups;
                        _totalCount = _totalCount + _groupCount;

                        // create profiles

                        for "_i" from 0 to _groupCount -1 do {

                            _group = _mechanisedGroups select _i;

                            _position = [_reinforcementPosition, (random(200)), random(360)] call BIS_fnc_relPos;

                            if(_paraDrop) then {
                                _position set [2,PARADROP_HEIGHT];
                            };

                            if!(surfaceIsWater _position) then {

                                _profiles = [_group, _position, random(360), false, _eventFaction, true] call ALIVE_fnc_createProfilesFromGroupConfig;

                                _profileIDs = [];
                                {
                                    _profileID = _x select 2 select 4;
                                    _profileIDs set [count _profileIDs, _profileID];
                                } forEach _profiles;

                                _mechanisedProfiles set [count _mechanisedProfiles, _profileIDs];

                            };
                        };

                        [_eventCargoProfiles, "mechanised", _mechanisedProfiles] call ALIVE_fnc_hashSet;


                        // motorised

                        private ["_motorisedGroups","_motorisedProfiles"];

                        _motorisedGroups = [];
                        _motorisedProfiles = [];

                        for "_i" from 0 to _eventForceMotorised -1 do {
                            _group = ["Motorized",_eventFaction] call ALIVE_fnc_configGetRandomGroup;
                            if!(_group == "FALSE") then {
                                _motorisedGroups set [count _motorisedGroups, _group];
                            };
                        };

                        _motorisedGroups = _motorisedGroups - ALiVE_PLACEMENT_GROUPBLACKLIST;
                        _groupCount = count _motorisedGroups;
                        _totalCount = _totalCount + _groupCount;

                        // create profiles

                        for "_i" from 0 to _groupCount -1 do {

                            _group = _motorisedGroups select _i;

                            _position = [_reinforcementPosition, (random(200)), random(360)] call BIS_fnc_relPos;

                            if(_paraDrop) then {
                                _position set [2,PARADROP_HEIGHT];
                            };

                            if!(surfaceIsWater _position) then {

                                _profiles = [_group, _position, random(360), false, _eventFaction, true] call ALIVE_fnc_createProfilesFromGroupConfig;

                                _profileIDs = [];
                                {
                                    _profileID = _x select 2 select 4;
                                    _profileIDs set [count _profileIDs, _profileID];
                                } forEach _profiles;

                                _motorisedProfiles set [count _motorisedProfiles, _profileIDs];

                            };
                        };

                        [_eventCargoProfiles, "motorised", _motorisedProfiles] call ALIVE_fnc_hashSet;


                        // plane

                        private ["_planeProfiles","_planeClasses","_motorisedProfiles","_vehicleClass"];

                        _planeProfiles = [];

                        if(_eventType == "STANDARD" || _eventType == "HELI_INSERT") then {

                            _planeClasses = [0,_eventFaction,"Plane"] call ALiVE_fnc_findVehicleType;
                            _planeClasses = _planeClasses - ALiVE_PLACEMENT_VEHICLEBLACKLIST;

                            for "_i" from 0 to _eventForcePlane -1 do {

                                _position = [_remotePosition, (random(200)), random(360)] call BIS_fnc_relPos;
                                _position set [2,1000];

                                if(count _planeClasses > 0) then {

                                    _vehicleClass = _planeClasses call BIS_fnc_selectRandom;

                                    _profiles = [_vehicleClass,_side,_eventFaction,"CAPTAIN",_position,random(360),false,_eventFaction,true,true] call ALIVE_fnc_createProfilesCrewedVehicle;

                                    _profileIDs = [];
                                    {
                                        _profileID = _x select 2 select 4;
                                        _profileIDs set [count _profileIDs, _profileID];
                                    } forEach _profiles;

                                    _planeProfiles set [count _planeProfiles, _profileIDs];

                                    _profileWaypoint = [_reinforcementPosition, 100, "MOVE", "LIMITED", 300, [], "LINE"] call ALIVE_fnc_createProfileWaypoint;
                                    _profile = _profiles select 0;
                                    [_profile, "addWaypoint", _profileWaypoint] call ALIVE_fnc_profileEntity;
                                }
                            };

                            _groupCount = count _planeProfiles;
                            _totalCount = _totalCount + _groupCount;

                        };

                        [_eventCargoProfiles, "plane", _planeProfiles] call ALIVE_fnc_hashSet;


                        // heli

                        private ["_heliProfiles","_heliClasses","_motorisedProfiles","_vehicleClass"];

                        _heliProfiles = [];

                        if(_eventType == "STANDARD" || _eventType == "HELI_INSERT") then {

                            _heliClasses = [0,_eventFaction,"Helicopter"] call ALiVE_fnc_findVehicleType;
                            _heliClasses = _heliClasses - ALiVE_PLACEMENT_VEHICLEBLACKLIST;

                            for "_i" from 0 to _eventForceHeli -1 do {

                                _position = [_remotePosition, (random(200)), random(360)] call BIS_fnc_relPos;
                                _position set [2,1000];

                                if(count _heliClasses > 0) then {

                                    _vehicleClass = _heliClasses call BIS_fnc_selectRandom;

                                    _profiles = [_vehicleClass,_side,_eventFaction,"CAPTAIN",_position,random(360),false,_eventFaction,true,true] call ALIVE_fnc_createProfilesCrewedVehicle;

                                    _profileIDs = [];
                                    {
                                        _profileID = _x select 2 select 4;
                                        _profileIDs set [count _profileIDs, _profileID];
                                    } forEach _profiles;

                                    _heliProfiles set [count _heliProfiles, _profileIDs];

                                    _profileWaypoint = [_reinforcementPosition, 100, "MOVE", "LIMITED", 300, [], "LINE"] call ALIVE_fnc_createProfileWaypoint;
                                    _profile = _profiles select 0;
                                    [_profile, "addWaypoint", _profileWaypoint] call ALIVE_fnc_profileEntity;
                                }
                            };

                            _groupCount = count _heliProfiles;
                            _totalCount = _totalCount + _groupCount;

                        };

                        [_eventCargoProfiles, "heli", _heliProfiles] call ALIVE_fnc_hashSet;


                        // DEBUG -------------------------------------------------------------------------------------
                        if(_debug) then {
                            ["ALIVE ML - Profiles created: %1 ",_totalCount] call ALIVE_fnc_dump;
                            switch(_eventType) do {
                                case "STANDARD": {
                                    [_logic, "createMarker", [_reinforcementPosition,_eventFaction,"ML INSERTION"]] call MAINCLASS;
                                };
                                case "HELI_INSERT": {
                                    [_logic, "createMarker", [_reinforcementPosition,_eventFaction,"ML INSERTION"]] call MAINCLASS;
                                };
                                case "AIRDROP": {
                                    [_logic, "createMarker", [_eventPosition,_eventFaction,"ML AIRDROP"]] call MAINCLASS;
                                };
                            };
                        };
                        // DEBUG -------------------------------------------------------------------------------------


                        if(_totalCount > 0) then {

                            // remove the created group count
                            // from the force pool
                            _forcePool = _forcePool - _totalCount;
                            [_logic, "forcePool", _forcePool] call MAINCLASS;

                            switch(_eventType) do {
                                case "STANDARD": {

                                    // update the state of the event
                                    // next state is transport load
                                    [_event, "state", "transportLoad"] call ALIVE_fnc_hashSet;

                                    // dispatch event
                                    _logEvent = ['LOGISTICS_INSERTION', [_reinforcementPosition,_eventFaction,_side],"Logistics"] call ALIVE_fnc_event;
                                    [ALIVE_eventLog, "addEvent",_logEvent] call ALIVE_fnc_eventLog;

                                };
                                case "HELI_INSERT": {

                                    // update the state of the event
                                    // next state is transport load
                                    [_event, "state", "heliTransportStart"] call ALIVE_fnc_hashSet;

                                    // dispatch event
                                    _logEvent = ['LOGISTICS_INSERTION', [_reinforcementPosition,_eventFaction,_side],"Logistics"] call ALIVE_fnc_event;
                                    [ALIVE_eventLog, "addEvent",_logEvent] call ALIVE_fnc_eventLog;

                                };
                                case "AIRDROP": {

                                    // update the state of the event
                                    // next state is aridrop wait
                                    [_event, "state", "airdropWait"] call ALIVE_fnc_hashSet;

                                    // dispatch event
                                    _logEvent = ['LOGISTICS_DESTINATION', [_eventPosition,_eventFaction,_side],"Logistics"] call ALIVE_fnc_event;
                                    [ALIVE_eventLog, "addEvent",_logEvent] call ALIVE_fnc_eventLog;

                                };
                            };

                            [_event, "cargoProfiles", _eventCargoProfiles] call ALIVE_fnc_hashSet;
                            [_event, "transportProfiles", _eventTransportProfiles] call ALIVE_fnc_hashSet;
                            [_event, "transportVehiclesProfiles", _eventTransportVehiclesProfiles] call ALIVE_fnc_hashSet;

                            [_eventQueue, _eventID, _event] call ALIVE_fnc_hashSet;

                        }else{

                            // no profiles were created
                            // nothing to do so cancel..
                            [_logic, "removeEvent", _eventID] call MAINCLASS;
                        };
                    };
                }else{

                    // no insertion point available
                    // nothing to do so cancel..
                    [_logic, "removeEvent", _eventID] call MAINCLASS;

                };
            };

            // HELI INSERT ------------------------------------------------------------------------------------------------------------------------------

            case "heliTransportStart": {

                // assign waypoints to all
                // vehicle commanders

                private ["_transportProfiles","_infantryProfiles","_planeProfiles","_heliProfiles","_position","_profileWaypoint","_profile"];

                _transportProfiles = _eventTransportProfiles;
                _infantryProfiles = [_eventCargoProfiles, 'infantry'] call ALIVE_fnc_hashGet;
                _planeProfiles = [_eventCargoProfiles, 'plane'] call ALIVE_fnc_hashGet;
                _heliProfiles = [_eventCargoProfiles, 'heli'] call ALIVE_fnc_hashGet;

                {
                    _position = [_eventPosition, (random(DESTINATION_VARIANCE)), random(360)] call BIS_fnc_relPos;
                    _profileWaypoint = [_position, 100, "MOVE", "NORMAL", 300, [], "LINE"] call ALIVE_fnc_createProfileWaypoint;

                    _profile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
                    if!(isNil "_profile") then {
                        [_profile, "addWaypoint", _profileWaypoint] call ALIVE_fnc_profileEntity;
                    };

                } forEach _transportProfiles;

                {
                    _profileWaypoint = [_eventPosition, 100, "MOVE", "NORMAL", 300, [], "LINE"] call ALIVE_fnc_createProfileWaypoint;

                    _profile = [ALIVE_profileHandler, "getProfile", _x select 0] call ALIVE_fnc_profileHandler;
                    if!(isNil "_profile") then {
                        [_profile, "addWaypoint", _profileWaypoint] call ALIVE_fnc_profileEntity;
                    };

                } forEach _infantryProfiles;

                {
                    _position = [_eventPosition, (random(DESTINATION_VARIANCE)), random(360)] call BIS_fnc_relPos;
                    _profileWaypoint = [_position, 100, "MOVE", "NORMAL", 300, [], "LINE"] call ALIVE_fnc_createProfileWaypoint;

                    _profile = [ALIVE_profileHandler, "getProfile", _x select 0] call ALIVE_fnc_profileHandler;
                    if!(isNil "_profile") then {
                        [_profile, "addWaypoint", _profileWaypoint] call ALIVE_fnc_profileEntity;
                    };

                } forEach _planeProfiles;

                {
                    _position = [_eventPosition, (random(DESTINATION_VARIANCE)), random(360)] call BIS_fnc_relPos;
                    _profileWaypoint = [_position, 100, "MOVE", "NORMAL", 300, [], "LINE"] call ALIVE_fnc_createProfileWaypoint;

                    _profile = [ALIVE_profileHandler, "getProfile", _x select 0] call ALIVE_fnc_profileHandler;
                    if!(isNil "_profile") then {
                        [_profile, "addWaypoint", _profileWaypoint] call ALIVE_fnc_profileEntity;
                    };

                } forEach _heliProfiles;


                // DEBUG -------------------------------------------------------------------------------------
                if(_debug) then {
                    [_logic, "createMarker", [_eventPosition,_eventFaction,"ML DESTINATION"]] call MAINCLASS;
                };
                // DEBUG -------------------------------------------------------------------------------------


                // dispatch event
                _logEvent = ['LOGISTICS_DESTINATION', [_eventPosition,_eventFaction,_side],"Logistics"] call ALIVE_fnc_event;
                [ALIVE_eventLog, "addEvent",_logEvent] call ALIVE_fnc_eventLog;

                // respond to player request
                if(_playerRequested) then {
                    _logEvent = ['LOGCOM_RESPONSE', [_requestID,_playerID],"Logistics","REQUEST_ENROUTE"] call ALIVE_fnc_event;
                    [ALIVE_eventLog, "addEvent",_logEvent] call ALIVE_fnc_eventLog;
                };


                [_event, "state", "heliTransport"] call ALIVE_fnc_hashSet;
                [_eventQueue, _eventID, _event] call ALIVE_fnc_hashSet;

            };

            case "heliTransport": {

                // waypoint complete check stage

                private ["_waitTotalIterations","_waitIterations","_waitDifference","_transportProfiles","_infantryProfiles",
                "_planeProfiles","_heliProfiles","_waypointsCompleted","_waypointsNotCompleted","_profile","_position","_distance"];

                // mechanism for aborting this state
                // once set time limit has passed
                // if all units haven't reached objective
                _waitTotalIterations = 200;
                _waitIterations = 0;
                if(count _eventStateData > 0) then {
                    _waitIterations = _eventStateData select 0;
                };

                // check waypoints
                // if all waypoints are complete
                // trigger end of logistics control

                _transportProfiles = _eventTransportProfiles;
                _infantryProfiles = [_eventCargoProfiles, 'infantry'] call ALIVE_fnc_hashGet;
                _planeProfiles = [_eventCargoProfiles, 'plane'] call ALIVE_fnc_hashGet;
                _heliProfiles = [_eventCargoProfiles, 'heli'] call ALIVE_fnc_hashGet;

                _waypointsCompleted = 0;
                _waypointsNotCompleted = 0;

                {
                    _transportProfile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
                    if!(isNil "_transportProfile") then {

                        _position = _transportProfile select 2 select 2;
                        _distance = _position distance _eventPosition;

                        if(_distance > DESTINATION_RADIUS) then {
                            _waypointsNotCompleted = _waypointsNotCompleted + 1;
                        }else{
                            _waypointsCompleted = _waypointsCompleted + 1;
                        };

                    };

                } forEach _transportProfiles;

                if((_waypointsNotCompleted == 0) && (_waypointsCompleted == 0)) then {
                    {
                        _profile = [ALIVE_profileHandler, "getProfile", _x select 0] call ALIVE_fnc_profileHandler;
                        if!(isNil "_profile") then {

                            _position = _profile select 2 select 2;
                            _distance = _position distance _eventPosition;

                            if(_distance > DESTINATION_RADIUS) then {
                                _waypointsNotCompleted = _waypointsNotCompleted + 1;
                            }else{
                                _waypointsCompleted = _waypointsCompleted + 1;
                            };

                        };

                    } forEach _infantryProfiles;
                };

                // if some waypoints are completed
                // can assume most units are close to
                // destination, adjust timeout
                if(_waypointsCompleted > 0) then {
                    _waitDifference = _waitTotalIterations - _waitIterations;
                    if(_waitDifference > 50) then {
                        _waitIterations = _waitTotalIterations - 40;
                    };
                };

                {
                    _profile = [ALIVE_profileHandler, "getProfile", _x select 0] call ALIVE_fnc_profileHandler;
                    if!(isNil "_profile") then {

                        _position = _profile select 2 select 2;
                        _distance = _position distance _eventPosition;

                        if(_distance > DESTINATION_RADIUS) then {
                            _waypointsNotCompleted = _waypointsNotCompleted + 1;
                        }else{
                            _waypointsCompleted = _waypointsCompleted + 1;
                        };

                    };

                } forEach _planeProfiles;

                {
                    _profile = [ALIVE_profileHandler, "getProfile", _x select 0] call ALIVE_fnc_profileHandler;
                    if!(isNil "_profile") then {

                        _position = _profile select 2 select 2;
                        _distance = _position distance _eventPosition;

                        if(_distance > DESTINATION_RADIUS) then {
                            _waypointsNotCompleted = _waypointsNotCompleted + 1;
                        }else{
                            _waypointsCompleted = _waypointsCompleted + 1;
                        };

                    };

                } forEach _heliProfiles;


                // all waypoints completed

                if(_waypointsNotCompleted == 0) then {

                    [_event, "state", "heliTransportUnload"] call ALIVE_fnc_hashSet;
                    [_eventQueue, _eventID, _event] call ALIVE_fnc_hashSet;

                    // respond to player request
                    if(_playerRequested) then {
                        if(_waypointsCompleted > 0) then {
                            _logEvent = ['LOGCOM_RESPONSE', [_requestID,_playerID],"Logistics","REQUEST_ARRIVED"] call ALIVE_fnc_event;
                            [ALIVE_eventLog, "addEvent",_logEvent] call ALIVE_fnc_eventLog;
                        }else{
                            _logEvent = ['LOGCOM_RESPONSE', [_requestID,_playerID],"Logistics","REQUEST_LOST"] call ALIVE_fnc_event;
                            [ALIVE_eventLog, "addEvent",_logEvent] call ALIVE_fnc_eventLog;
                        };
                    };

                }else{

                    // not all waypoints have been completed
                    // to ensure control passes to OPCOM eventually
                    // limited number of iterations in this
                    // state are used.

                    _waitIterations = _waitIterations + 1;
                    _eventStateData set [0, _waitIterations];
                    [_event, "stateData", _eventStateData] call ALIVE_fnc_hashSet;

                    if(_waitIterations > _waitTotalIterations) then {

                        _eventStateData set [0, 0];
                        [_event, "stateData", _eventStateData] call ALIVE_fnc_hashSet;

                        //["TRANSPORT TRAVEL WAIT - ITERATIONS COMPLETE"] call ALIVE_fnc_dump;
                        [_event, "state", "heliTransportUnload"] call ALIVE_fnc_hashSet;
                        [_eventQueue, _eventID, _event] call ALIVE_fnc_hashSet;

                    };
                };

            };

            case "heliTransportUnload": {

                // unload transport vehicles

                private ["_transportProfile","_active","_group","_inCargo","_cargoProfileID","_cargoProfile","_profileCount","_countTransports"];

                _profileCount = 0;

                _countTransports = count _eventTransportVehiclesProfiles;

                if(_countTransports > 0) then {

                    // set transport profiles to careless
                    {
                        _transportProfile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
                        if!(isNil "_transportProfile") then {

                            _active = _transportProfile select 2 select 1;

                            if(_active) then {

                                _group = _transportProfile select 2 select 13;
                                _group setBehaviour "CARELESS";

                            };

                        };

                    } forEach _eventTransportProfiles;

                    // unload any transport vehicles
                    {
                        _transportProfile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
                        if!(isNil "_transportProfile") then {

                            _inCargo = _transportProfile select 2 select 9;

                            if(count _inCargo > 0) then {
                                {
                                    _cargoProfileID = _x;
                                    _cargoProfile = [ALIVE_profileHandler, "getProfile", _cargoProfileID] call ALIVE_fnc_profileHandler;

                                    if!(isNil "_cargoProfile") then {
                                        [_cargoProfile,_transportProfile] call ALIVE_fnc_removeProfileVehicleAssignment;
                                    };

                                } forEach _inCargo;
                            };

                        };

                    } forEach _eventTransportVehiclesProfiles;

                };

                private ["_countEmpty","_emptyProfiles","_inCommand","_commandProfileID","_position"];

                _countEmpty = 0;

                if(_playerRequested) then {

                    _emptyProfiles = [_playerRequestProfiles,"empty"] call ALIVE_fnc_hashGet;
                    _countEmpty = count _emptyProfiles;

                    // if empty vehicles requested
                    // land the vehicles, unload pilots

                    if(_countEmpty > 0) then {

                        // set empty profiles to careless
                        {
                            _emptyProfile = _x select 0;
                            _emptyProfile = [ALIVE_profileHandler, "getProfile", _emptyProfile] call ALIVE_fnc_profileHandler;
                            if!(isNil "_emptyProfile") then {

                                _active = _emptyProfile select 2 select 1;

                                if(_active) then {

                                    _group = _emptyProfile select 2 select 13;
                                    _group setBehaviour "CARELESS";

                                };

                            };

                        } forEach _emptyProfiles;

                        // land any empty vehicles
                        {
                            _emptyProfile = _x select 1;
                            _emptyProfile = [ALIVE_profileHandler, "getProfile", _emptyProfile] call ALIVE_fnc_profileHandler;
                            if!(isNil "_emptyProfile") then {

                                _inCommand = _emptyProfile select 2 select 8;

                                if(count _inCommand > 0) then {

                                    _commandProfileID = _inCommand select 0;
                                    _commandProfile = [ALIVE_profileHandler, "getProfile", _commandProfileID] call ALIVE_fnc_profileHandler;

                                    if!(isNil "_commandProfile") then {

                                        [_commandProfile,_emptyProfile] call ALIVE_fnc_removeProfileVehicleAssignment;

                                        _active = _commandProfile select 2 select 1;

                                        if!(_active) then {

                                            _position = _emptyProfile select 2 select 2;
                                            _position set [2,0];
                                            [_emptyProfile,"position",_position] call ALIVE_fnc_profileVehicle;
                                            [_emptyProfile,"hasSimulated",false] call ALIVE_fnc_profileVehicle;
                                            [_emptyProfile,"engineOn",false] call ALIVE_fnc_profileVehicle;
                                            [_emptyProfile,"despawnPosition",_position] call ALIVE_fnc_profileVehicle;

                                            [ALIVE_profileHandler, "unregisterProfile", _commandProfile] call ALIVE_fnc_profileHandler;

                                        };
                                    };

                                };

                            };

                        } forEach _emptyProfiles;;

                    };

                };

                _profileCount = _countTransports + _countEmpty;

                if(_profileCount == 0) then {

                    // no transport vehicles
                    // set state to event complete
                    [_event, "state", "eventComplete"] call ALIVE_fnc_hashSet;
                    [_eventQueue, _eventID, _event] call ALIVE_fnc_hashSet;

                 }else{

                    // wait for helis to unload
                    // set state to unload wait
                    [_event, "state", "heliTransportUnloadWait"] call ALIVE_fnc_hashSet;
                    [_eventQueue, _eventID, _event] call ALIVE_fnc_hashSet;

                 };

            };

            case "heliTransportUnloadWait": {

                // wait until all vehicles
                // have unloaded their cargo

                private ["_waitTotalIterations","_waitIterations","_infantryProfile","_active","_units",
                "_unloadedUnits","_loadedUnits","_waypointsCompleted","_waypointsNotCompleted","_profile","_position","_distance"];

                // mechanism for aborting this state
                // once set time limit has passed
                // if all units haven't reached objective
                _waitTotalIterations = 40;
                _waitIterations = 0;
                if(count _eventStateData > 0) then {
                    _waitIterations = _eventStateData select 0;
                };

                _infantryProfiles = [_eventCargoProfiles, 'infantry'] call ALIVE_fnc_hashGet;
                _unloadedUnits = [];
                _loadedUnits = [];

                {

                    _infantryProfile = [ALIVE_profileHandler, "getProfile", _x select 0] call ALIVE_fnc_profileHandler;
                    if!(isNil "_infantryProfile") then {

                        _active = _infantryProfile select 2 select 1;

                        // only need to worry about this is there are
                        // players nearby

                        if(_active) then {

                            _units = _infantryProfile select 2 select 21;

                            // catagorise units into loaded and not
                            // loaded arrays
                            {
                                if(alive _x) then {
                                    if(vehicle _x == _x) then {
                                        _unloadedUnits set [count _unloadedUnits, _x];
                                    }else{
                                        _loadedUnits set [count _loadedUnits, _x];
                                    };
                                };
                            } forEach _units;

                        }else{

                            // profiles are not active, can skip this wait
                            // continue on to travel

                            [_event, "state", "heliTransportComplete"] call ALIVE_fnc_hashSet;
                            [_eventQueue, _eventID, _event] call ALIVE_fnc_hashSet;

                        };

                    };

                } forEach _infantryProfiles;

                if(count _loadedUnits == 0) then {

                    // all unloaded
                    // continue on to travel

                    [_event, "state", "heliTransportComplete"] call ALIVE_fnc_hashSet;
                    [_eventQueue, _eventID, _event] call ALIVE_fnc_hashSet;

                };

                _waitIterations = _waitIterations + 1;
                _eventStateData set [0, _waitIterations];
                [_event, "stateData", _eventStateData] call ALIVE_fnc_hashSet;

                if(_waitIterations > _waitTotalIterations) then {

                    _eventStateData set [0, 0];
                    [_event, "stateData", _eventStateData] call ALIVE_fnc_hashSet;

                    [_event, "state", "heliTransportComplete"] call ALIVE_fnc_hashSet;
                    [_eventQueue, _eventID, _event] call ALIVE_fnc_hashSet;

                };

            };

            case "heliTransportComplete": {

                // unloading complete
                // if profiles are active move on
                // to return to insertion point
                // if not active destroy transport profiles

                private ["_transportProfile","_inCargo","_cargoProfileID","_cargoProfile","_active","_inCommand","_commandProfileID","_commandProfile","_anyActive"];

                if(count _eventTransportVehiclesProfiles > 0) then {

                    _anyActive = 0;

                    {
                        _transportProfile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
                        if!(isNil "_transportProfile") then {

                            _active = _transportProfile select 2 select 1;

                            if(_active) then {

                                _anyActive = _anyActive + 1;

                            }else{

                                // if not active dispose of transport profiles

                                _inCommand = _transportProfile select 2 select 8;

                                if(count _inCommand > 0) then {
                                    _commandProfileID = _inCommand select 0;
                                    _commandProfile = [ALIVE_profileHandler, "getProfile", _commandProfileID] call ALIVE_fnc_profileHandler;

                                    if!(isNil "_commandProfile") then {
                                        [ALIVE_profileHandler, "unregisterProfile", _commandProfile] call ALIVE_fnc_profileHandler;
                                    };

                                };

                                [ALIVE_profileHandler, "unregisterProfile", _transportProfile] call ALIVE_fnc_profileHandler;

                                [_logic, "setEventProfilesAvailable", _event] call MAINCLASS;

                                // set state to event complete
                                [_event, "state", "eventComplete"] call ALIVE_fnc_hashSet;
                                [_eventQueue, _eventID, _event] call ALIVE_fnc_hashSet;
                            };

                        };

                    } forEach _eventTransportVehiclesProfiles;

                    if(_anyActive > 0) then {

                        [_logic, "setEventProfilesAvailable", _event] call MAINCLASS;

                        // there are active transport vehicles
                        // send them back to insertion point
                        [_event, "state", "heliTransportReturn"] call ALIVE_fnc_hashSet;
                        [_eventQueue, _eventID, _event] call ALIVE_fnc_hashSet;
                    };

                }else{

                    // no transport vehicles
                    // set state to event complete
                    [_event, "state", "eventComplete"] call ALIVE_fnc_hashSet;
                    [_eventQueue, _eventID, _event] call ALIVE_fnc_hashSet;

                };

            };

            case "heliTransportReturn": {

                private ["_position","_profileWaypoint","_profile","_reinforcementPosition"];

                if(count _eventTransportProfiles > 0) then {

                    // send transport vehicles back to insertion point
                    {
                        _reinforcementPosition = [_reinforcementPrimaryObjective,"center"] call ALIVE_fnc_hashGet;
                        _position = [_reinforcementPosition, (random(300)), random(360)] call BIS_fnc_relPos;
                        _position = [_position] call ALIVE_fnc_getClosestRoad;
                        _profileWaypoint = [_position, 100, "MOVE", "LIMITED", 300, [], "LINE"] call ALIVE_fnc_createProfileWaypoint;

                        _profile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
                        if!(isNil "_profile") then {

                            [_profile, "addWaypoint", _profileWaypoint] call ALIVE_fnc_profileEntity;

                        };

                    } forEach _eventTransportProfiles;

                    // set state to wait for return of transports
                    [_event, "state", "heliTransportReturnWait"] call ALIVE_fnc_hashSet;
                    [_eventQueue, _eventID, _event] call ALIVE_fnc_hashSet;

                }else{

                    // no transport vehicles
                    // set state to event complete
                    [_event, "state", "eventComplete"] call ALIVE_fnc_hashSet;
                    [_eventQueue, _eventID, _event] call ALIVE_fnc_hashSet;

                };

            };

            case "heliTransportReturnWait": {

                private ["_anyActive","_transportProfile","_active","_inCommand","_commandProfileID","_commandProfile","_commandUnits"];

                if(count _eventTransportProfiles > 0) then {

                    _anyActive = 0;

                    // once transport vehicles are inactive
                    // dispose of the profiles
                    {
                        _transportProfile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
                        if!(isNil "_transportProfile") then {

                            _active = _transportProfile select 2 select 1;
                            _vehicle = _transportProfile select 2 select 10;

                            if([position _vehicle, 1500] call ALiVE_fnc_anyPlayersInRange == 0) then {

                                // if not active dispose of transport profiles

                                _inCommand = _transportProfile select 2 select 8;

                                if(count _inCommand > 0) then {
                                    _commandProfileID = _inCommand select 0;
                                    _commandProfile = [ALIVE_profileHandler, "getProfile", _commandProfileID] call ALIVE_fnc_profileHandler;

                                    if!(isNil "_commandProfile") then {
                                        [ALIVE_profileHandler, "unregisterProfile", _commandProfile] call ALIVE_fnc_profileHandler;
                                        _commandUnits = _commandProfile select 2 select 21;

                                        {
                                            deleteVehicle _x;
                                        } forEach _commandUnits;
                                    };

                                    deleteVehicle _vehicle;

                                };

                                [ALIVE_profileHandler, "unregisterProfile", _transportProfile] call ALIVE_fnc_profileHandler;
                            }else{
                                _anyActive = _anyActive + 1;
                            };

                        };

                    } forEach _eventTransportVehiclesProfiles;

                    if(_anyActive == 0) then {
                        // no transport vehicles
                        // set state to event complete
                        [_event, "state", "eventComplete"] call ALIVE_fnc_hashSet;
                        [_eventQueue, _eventID, _event] call ALIVE_fnc_hashSet;
                    };

                }else{

                    // no transport vehicles
                    // set state to event complete
                    [_event, "state", "eventComplete"] call ALIVE_fnc_hashSet;
                    [_eventQueue, _eventID, _event] call ALIVE_fnc_hashSet;

                };

            };

            // AIR DROP ------------------------------------------------------------------------------------------------------------------------------

            case "airdropWait": {

                private ["_waitIterations","_waitTotalIterations"];

                _waitTotalIterations = 15;
                _waitIterations = 0;
                if(count _eventStateData > 0) then {
                    _waitIterations = _eventStateData select 0;
                };

                _waitIterations = _waitIterations + 1;
                _eventStateData set [0, _waitIterations];
                [_event, "stateData", _eventStateData] call ALIVE_fnc_hashSet;

                if(_waitIterations > _waitTotalIterations) then {

                    _eventStateData set [0, 0];
                    [_event, "stateData", _eventStateData] call ALIVE_fnc_hashSet;

                    [_event, "state", "airdropComplete"] call ALIVE_fnc_hashSet;
                    [_eventQueue, _eventID, _event] call ALIVE_fnc_hashSet;

                };

            };

            case "airdropComplete": {

                [_logic, "setEventProfilesAvailable", _event] call MAINCLASS;

                [_logic, "removeEvent", _eventID] call MAINCLASS;

            };

            // CONVOY ---------------------------------------------------------------------------------------------------------------------------------

            case "transportLoad": {

                // for any infantry groups order
                // them to load onto the transport vehicles

                private ["_infantryProfiles","_processedProfiles","_infantryProfile","_transportProfileID","_transportProfile"];

                _infantryProfiles = [_eventCargoProfiles, 'infantry'] call ALIVE_fnc_hashGet;
                _processedProfiles = 0;

                if(count _eventTransportVehiclesProfiles > 0) then {

                    {
                        _infantryProfile = [ALIVE_profileHandler, "getProfile", _x select 0] call ALIVE_fnc_profileHandler;
                        if!(isNil "_infantryProfile") then {

                            _transportProfileID = _eventTransportVehiclesProfiles select _processedProfiles;
                            _transportProfile = [ALIVE_profileHandler, "getProfile", _transportProfileID] call ALIVE_fnc_profileHandler;
                            if!(isNil "_transportProfile") then {

                                [_infantryProfile,_transportProfile] call ALIVE_fnc_createProfileVehicleAssignment;

                                _processedProfiles = _processedProfiles + 1;
                            };
                        };

                    } forEach _infantryProfiles;

                };

                [_event, "state", "transportLoadWait"] call ALIVE_fnc_hashSet;
                [_eventQueue, _eventID, _event] call ALIVE_fnc_hashSet;

            };

            case "transportLoadWait": {

                private ["_infantryProfiles","_waitIterations","_waitTotalIterations","_loadedUnits","_notLoadedUnits",
                "_infantryProfile","_active","_units","_vehicle","_vehicleClass"];

                _infantryProfiles = [_eventCargoProfiles, 'infantry'] call ALIVE_fnc_hashGet;

                // mechanism for aborting this state
                // once set time limit has passed
                // if all units havent loaded up
                _waitTotalIterations = 35;
                _waitIterations = 0;
                if(count _eventStateData > 0) then {
                    _waitIterations = _eventStateData select 0;
                };

                // if there are transport vehicles available

                if(count _eventTransportVehiclesProfiles > 0) then {

                    _loadedUnits = [];
                    _notLoadedUnits = [];

                    {
                        _infantryProfile = [ALIVE_profileHandler, "getProfile", _x select 0] call ALIVE_fnc_profileHandler;
                        if!(isNil "_infantryProfile") then {
                            _active = _infantryProfile select 2 select 1;

                            // only need to worry about this is there are
                            // players nearby

                            if(_active) then {

                                _units = _infantryProfile select 2 select 21;

                                // catagorise units into loaded and not
                                // loaded arrays
                                {
                                    _vehicle = vehicle _x;
                                    _vehicleClass = typeOf _vehicle;
                                    if(_vehicleClass != "Steerable_Parachute_F") then {
                                        if(vehicle _x == _x) then {
                                            _notLoadedUnits set [count _notLoadedUnits, _x];
                                        }else{
                                            _loadedUnits set [count _loadedUnits, _x];
                                        };
                                    }else{
                                        _notLoadedUnits set [count _notLoadedUnits, _x];
                                    };

                                } forEach _units;

                            }else{

                                // profiles are not active, can skip this wait
                                // continue on to travel

                                [_event, "state", "transportStart"] call ALIVE_fnc_hashSet;
                                [_eventQueue, _eventID, _event] call ALIVE_fnc_hashSet;

                            };

                        };

                    } forEach _infantryProfiles;

                    // if there are units left to be loaded
                    // wait for x iterations for loading to occur
                    // once time is up delete all not loaded units

                    if(count _notLoadedUnits > 0) then {

                        _waitIterations = _waitIterations + 1;
                        _eventStateData set [0, _waitIterations];
                        [_event, "stateData", _eventStateData] call ALIVE_fnc_hashSet;

                        if(_waitIterations > _waitTotalIterations) then {

                            {
                                deleteVehicle _x;
                            } forEach _notLoadedUnits;

                            _eventStateData set [0, 0];
                            [_event, "stateData", _eventStateData] call ALIVE_fnc_hashSet;

                            [_event, "state", "transportStart"] call ALIVE_fnc_hashSet;
                            [_eventQueue, _eventID, _event] call ALIVE_fnc_hashSet;
                        };

                    }else{

                        // all units have loaded
                        // continue on to travel

                        [_event, "state", "transportStart"] call ALIVE_fnc_hashSet;
                        [_eventQueue, _eventID, _event] call ALIVE_fnc_hashSet;

                    };


                }else{

                    // no transport vehicles available
                    // continue on to travel

                    [_event, "state", "transportStart"] call ALIVE_fnc_hashSet;
                    [_eventQueue, _eventID, _event] call ALIVE_fnc_hashSet;
                };

            };

            case "transportStart": {

                // assign waypoints to all
                // vehicle commanders

                private ["_transportProfiles","_infantryProfiles","_armourProfiles","_mechanisedProfiles","_motorisedProfiles",
                "_planeProfiles","_heliProfiles","_profileWaypoint","_profile","_position","_countProfiles","_positionSeries"];

                _transportProfiles = _eventTransportProfiles;
                _infantryProfiles = [_eventCargoProfiles, 'infantry'] call ALIVE_fnc_hashGet;
                _armourProfiles = [_eventCargoProfiles, 'armour'] call ALIVE_fnc_hashGet;
                _mechanisedProfiles = [_eventCargoProfiles, 'mechanised'] call ALIVE_fnc_hashGet;
                _motorisedProfiles = [_eventCargoProfiles, 'motorised'] call ALIVE_fnc_hashGet;
                _planeProfiles = [_eventCargoProfiles, 'plane'] call ALIVE_fnc_hashGet;
                _heliProfiles = [_eventCargoProfiles, 'heli'] call ALIVE_fnc_hashGet;

                _countProfiles = (count(_transportProfiles)) + (count(_armourProfiles)) + (count(_mechanisedProfiles)) + (count(_motorisedProfiles));


                _position = [_eventPosition] call ALIVE_fnc_getClosestRoad;

                _positionSeries = [_position,300,_countProfiles,false] call ALIVE_fnc_getSeriesRoadPositions;

                if((count _positionSeries) == 0) then {
                    for "_i" from 0 to _countProfiles -1 do {
                        _position = [_eventPosition, (random(DESTINATION_VARIANCE)), random(360)] call BIS_fnc_relPos;
                        _positionSeries set [_i, _position];
                    };
                };

                _seriesIndex = 0;

                {

                    _position = _positionSeries select _seriesIndex;
                    _profileWaypoint = [_position, 1, "MOVE", "LIMITED", 2, [], "LINE"] call ALIVE_fnc_createProfileWaypoint;

                    _profile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
                    if!(isNil "_profile") then {
                        [_profile, "addWaypoint", _profileWaypoint] call ALIVE_fnc_profileEntity;
                    };

                    _seriesIndex = _seriesIndex + 1;

                } forEach _transportProfiles;

                {
                    _position = [_eventPosition, (random(DESTINATION_VARIANCE)), random(360)] call BIS_fnc_relPos;
                    _profileWaypoint = [_position, 1, "MOVE", "LIMITED", 2, [], "LINE"] call ALIVE_fnc_createProfileWaypoint;

                    _profile = [ALIVE_profileHandler, "getProfile", _x select 0] call ALIVE_fnc_profileHandler;
                    if!(isNil "_profile") then {
                        [_profile, "addWaypoint", _profileWaypoint] call ALIVE_fnc_profileEntity;
                    };

                } forEach _infantryProfiles;

                {
                    _position = _positionSeries select _seriesIndex;
                    _profileWaypoint = [_position, 1, "MOVE", "NORMAL", 2, [], "LINE"] call ALIVE_fnc_createProfileWaypoint;

                    _profile = [ALIVE_profileHandler, "getProfile", _x select 0] call ALIVE_fnc_profileHandler;
                    if!(isNil "_profile") then {
                        [_profile, "addWaypoint", _profileWaypoint] call ALIVE_fnc_profileEntity;
                    };

                    _seriesIndex = _seriesIndex + 1;

                } forEach _armourProfiles;

                {
                    _position = _positionSeries select _seriesIndex;
                    _profileWaypoint = [_position, 1, "MOVE", "LIMITED", 2, [], "LINE"] call ALIVE_fnc_createProfileWaypoint;

                    _profile = [ALIVE_profileHandler, "getProfile", _x select 0] call ALIVE_fnc_profileHandler;
                    if!(isNil "_profile") then {
                        [_profile, "addWaypoint", _profileWaypoint] call ALIVE_fnc_profileEntity;
                    };

                    _seriesIndex = _seriesIndex + 1;

                } forEach _mechanisedProfiles;

                {
                    _position = _positionSeries select _seriesIndex;
                    _profileWaypoint = [_position, 1, "MOVE", "LIMITED", 2, [], "LINE"] call ALIVE_fnc_createProfileWaypoint;

                    _profile = [ALIVE_profileHandler, "getProfile", _x select 0] call ALIVE_fnc_profileHandler;
                    if!(isNil "_profile") then {
                        [_profile, "addWaypoint", _profileWaypoint] call ALIVE_fnc_profileEntity;
                    };

                    _seriesIndex = _seriesIndex + 1;

                } forEach _motorisedProfiles;

                {
                    _position = [_eventPosition, (random(DESTINATION_VARIANCE)), random(360)] call BIS_fnc_relPos;
                    _profileWaypoint = [_position, 100, "MOVE", "LIMITED", 300, [], "LINE"] call ALIVE_fnc_createProfileWaypoint;

                    _profile = [ALIVE_profileHandler, "getProfile", _x select 0] call ALIVE_fnc_profileHandler;
                    if!(isNil "_profile") then {
                        [_profile, "addWaypoint", _profileWaypoint] call ALIVE_fnc_profileEntity;
                    };

                } forEach _planeProfiles;

                {
                    _position = [_eventPosition, (random(DESTINATION_VARIANCE)), random(360)] call BIS_fnc_relPos;
                    _profileWaypoint = [_position, 100, "MOVE", "LIMITED", 300, [], "LINE"] call ALIVE_fnc_createProfileWaypoint;

                    _profile = [ALIVE_profileHandler, "getProfile", _x select 0] call ALIVE_fnc_profileHandler;
                    if!(isNil "_profile") then {
                        [_profile, "addWaypoint", _profileWaypoint] call ALIVE_fnc_profileEntity;
                    };

                } forEach _heliProfiles;


                // DEBUG -------------------------------------------------------------------------------------
                if(_debug) then {
                    [_logic, "createMarker", [_eventPosition,_eventFaction,"ML DESTINATION"]] call MAINCLASS;
                };
                // DEBUG -------------------------------------------------------------------------------------


                // dispatch event
                _logEvent = ['LOGISTICS_DESTINATION', [_eventPosition,_eventFaction,_side],"Logistics"] call ALIVE_fnc_event;
                [ALIVE_eventLog, "addEvent",_logEvent] call ALIVE_fnc_eventLog;


                if(_playerRequested) then {
                    _logEvent = ['LOGCOM_RESPONSE', [_requestID,_playerID],"Logistics","REQUEST_ENROUTE"] call ALIVE_fnc_event;
                    [ALIVE_eventLog, "addEvent",_logEvent] call ALIVE_fnc_eventLog;
                };


                [_event, "state", "transportTravel"] call ALIVE_fnc_hashSet;
                [_eventQueue, _eventID, _event] call ALIVE_fnc_hashSet;
            };

            case "transportTravel": {

                // waypoint complete check stage

                private ["_waitTotalIterations","_waitIterations","_waitDifference","_transportProfiles","_infantryProfiles",
                "_armourProfiles","_mechanisedProfiles","_motorisedProfiles","_planeProfiles","_heliProfiles",
                "_waypointsCompleted","_waypointsNotCompleted","_profile","_position","_distance"];

                // mechanism for aborting this state
                // once set time limit has passed
                // if all units haven't reached objective
                _waitTotalIterations = 400;
                _waitIterations = 0;
                if(count _eventStateData > 0) then {
                    _waitIterations = _eventStateData select 0;
                };

                // check waypoints
                // if all waypoints are complete
                // trigger end of logistics control

                _transportProfiles = _eventTransportProfiles;
                _infantryProfiles = [_eventCargoProfiles, 'infantry'] call ALIVE_fnc_hashGet;
                _armourProfiles = [_eventCargoProfiles, 'armour'] call ALIVE_fnc_hashGet;
                _mechanisedProfiles = [_eventCargoProfiles, 'mechanised'] call ALIVE_fnc_hashGet;
                _motorisedProfiles = [_eventCargoProfiles, 'motorised'] call ALIVE_fnc_hashGet;
                _planeProfiles = [_eventCargoProfiles, 'plane'] call ALIVE_fnc_hashGet;
                _heliProfiles = [_eventCargoProfiles, 'heli'] call ALIVE_fnc_hashGet;

                _waypointsCompleted = 0;
                _waypointsNotCompleted = 0;

                {
                    _transportProfile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
                    if!(isNil "_transportProfile") then {

                        _position = _transportProfile select 2 select 2;
                        _distance = _position distance _eventPosition;

                        if(_distance > DESTINATION_RADIUS) then {
                            _waypointsNotCompleted = _waypointsNotCompleted + 1;
                        }else{
                            _waypointsCompleted = _waypointsCompleted + 1;
                        };

                    };
                } forEach _transportProfiles;

                if((_waypointsNotCompleted == 0) && (_waypointsCompleted == 0)) then {
                    {
                        _profile = [ALIVE_profileHandler, "getProfile", _x select 0] call ALIVE_fnc_profileHandler;
                        if!(isNil "_profile") then {

                            _position = _profile select 2 select 2;
                            _distance = _position distance _eventPosition;

                            if(_distance > DESTINATION_RADIUS) then {
                                _waypointsNotCompleted = _waypointsNotCompleted + 1;
                            }else{
                                _waypointsCompleted = _waypointsCompleted + 1;
                            };
                        };

                    } forEach _infantryProfiles;
                };

                // if some waypoints are completed
                // can assume most units are close to
                // destination, adjust timeout
                if(_waypointsCompleted > 0) then {
                    _waitDifference = _waitTotalIterations - _waitIterations;
                    if(_waitDifference > 50) then {
                        _waitIterations = _waitTotalIterations - 40;
                    };
                };

                {
                    _profile = [ALIVE_profileHandler, "getProfile", _x select 0] call ALIVE_fnc_profileHandler;
                    if!(isNil "_profile") then {

                        _position = _profile select 2 select 2;
                        _distance = _position distance _eventPosition;

                        if(_distance > DESTINATION_RADIUS) then {
                            _waypointsNotCompleted = _waypointsNotCompleted + 1;
                        }else{
                            _waypointsCompleted = _waypointsCompleted + 1;
                        };

                    };

                } forEach _armourProfiles;

                {
                    _profile = [ALIVE_profileHandler, "getProfile", _x select 0] call ALIVE_fnc_profileHandler;
                    if!(isNil "_profile") then {

                        _position = _profile select 2 select 2;
                        _distance = _position distance _eventPosition;

                        if(_distance > DESTINATION_RADIUS) then {
                            _waypointsNotCompleted = _waypointsNotCompleted + 1;
                        }else{
                            _waypointsCompleted = _waypointsCompleted + 1;
                        };

                    };

                } forEach _mechanisedProfiles;

                {
                    _profile = [ALIVE_profileHandler, "getProfile", _x select 0] call ALIVE_fnc_profileHandler;
                    if!(isNil "_profile") then {

                        _position = _profile select 2 select 2;
                        _distance = _position distance _eventPosition;

                        if(_distance > DESTINATION_RADIUS) then {
                            _waypointsNotCompleted = _waypointsNotCompleted + 1;
                        }else{
                            _waypointsCompleted = _waypointsCompleted + 1;
                        };

                    };

                } forEach _motorisedProfiles;

                {
                    _profile = [ALIVE_profileHandler, "getProfile", _x select 0] call ALIVE_fnc_profileHandler;
                    if!(isNil "_profile") then {

                        _position = _profile select 2 select 2;
                        _distance = _position distance _eventPosition;

                        if(_distance > DESTINATION_RADIUS) then {
                            _waypointsNotCompleted = _waypointsNotCompleted + 1;
                        }else{
                            _waypointsCompleted = _waypointsCompleted + 1;
                        };

                    };

                } forEach _planeProfiles;

                {
                    _profile = [ALIVE_profileHandler, "getProfile", _x select 0] call ALIVE_fnc_profileHandler;
                    if!(isNil "_profile") then {

                        _position = _profile select 2 select 2;
                        _distance = _position distance _eventPosition;

                        if(_distance > DESTINATION_RADIUS) then {
                            _waypointsNotCompleted = _waypointsNotCompleted + 1;
                        }else{
                            _waypointsCompleted = _waypointsCompleted + 1;
                        };

                    };

                } forEach _heliProfiles;


                // all waypoints completed

                if(_waypointsNotCompleted == 0) then {

                    [_event, "state", "transportComplete"] call ALIVE_fnc_hashSet;
                    [_eventQueue, _eventID, _event] call ALIVE_fnc_hashSet;

                    // respond to player request
                    if(_playerRequested) then {
                        if(_waypointsCompleted > 0) then {
                            _logEvent = ['LOGCOM_RESPONSE', [_requestID,_playerID],"Logistics","REQUEST_ARRIVED"] call ALIVE_fnc_event;
                            [ALIVE_eventLog, "addEvent",_logEvent] call ALIVE_fnc_eventLog;
                        }else{
                            _logEvent = ['LOGCOM_RESPONSE', [_requestID,_playerID],"Logistics","REQUEST_LOST"] call ALIVE_fnc_event;
                            [ALIVE_eventLog, "addEvent",_logEvent] call ALIVE_fnc_eventLog;
                        };
                    };

                }else{

                    // not all waypoints have been completed
                    // to ensure control passes to OPCOM eventually
                    // limited number of iterations in this
                    // state are used.

                    _waitIterations = _waitIterations + 1;
                    _eventStateData set [0, _waitIterations];
                    [_event, "stateData", _eventStateData] call ALIVE_fnc_hashSet;

                    if(_waitIterations > _waitTotalIterations) then {

                        _eventStateData set [0, 0];
                        [_event, "stateData", _eventStateData] call ALIVE_fnc_hashSet;

                        [_event, "state", "transportComplete"] call ALIVE_fnc_hashSet;
                        [_eventQueue, _eventID, _event] call ALIVE_fnc_hashSet;


                    };
                };

            };

            case "transportComplete": {

                // unload transport vehicles

                private ["_profileCount","_countTransports","_transportProfile","_inCargo","_cargoProfileID","_cargoProfile",
                "_active","_inCommand","_commandProfileID","_commandProfile","_anyActive"];

                _profileCount = 0;
                _anyActive = 0;

                _countTransports = count _eventTransportVehiclesProfiles;

                if(_countTransports > 0) then {

                    // unload any transport vehicles
                    {
                        _transportProfile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
                        if!(isNil "_transportProfile") then {

                            _inCargo = _transportProfile select 2 select 9;

                            if(count _inCargo > 0) then {
                                {
                                    _cargoProfileID = _x;
                                    _cargoProfile = [ALIVE_profileHandler, "getProfile", _cargoProfileID] call ALIVE_fnc_profileHandler;

                                    if!(isNil "_cargoProfile") then {
                                        [_cargoProfile,_transportProfile] call ALIVE_fnc_removeProfileVehicleAssignment;
                                    };

                                } forEach _inCargo;
                            };

                        };

                    } forEach _eventTransportVehiclesProfiles;

                    {
                        _transportProfile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
                        if!(isNil "_transportProfile") then {

                            _active = _transportProfile select 2 select 1;

                            if(_active) then {

                                _anyActive = _anyActive + 1;

                            }else{

                                // if not active dispose of transport profiles

                                _inCommand = _transportProfile select 2 select 8;

                                if(count _inCommand > 0) then {
                                    _commandProfileID = _inCommand select 0;
                                    _commandProfile = [ALIVE_profileHandler, "getProfile", _commandProfileID] call ALIVE_fnc_profileHandler;

                                    if!(isNil "_commandProfile") then {
                                        [ALIVE_profileHandler, "unregisterProfile", _commandProfile] call ALIVE_fnc_profileHandler;
                                    };

                                };

                                [ALIVE_profileHandler, "unregisterProfile", _transportProfile] call ALIVE_fnc_profileHandler;

                            };

                        };

                    } forEach _eventTransportVehiclesProfiles;

                };

                private ["_countEmpty","_emptyProfiles","_inCommand","_commandProfileID","_position"];

                _countEmpty = 0;

                if(_playerRequested) then {

                    _emptyProfiles = [_playerRequestProfiles,"empty"] call ALIVE_fnc_hashGet;
                    _countEmpty = count _emptyProfiles;

                    // if empty vehicles requested
                    // land the vehicles, unload pilots

                    if(_countEmpty > 0) then {

                        // unload any empty vehicles
                        {
                            _emptyProfile = _x select 1;
                            _emptyProfile = [ALIVE_profileHandler, "getProfile", _emptyProfile] call ALIVE_fnc_profileHandler;
                            if!(isNil "_emptyProfile") then {

                                _inCommand = _emptyProfile select 2 select 8;

                                if(count _inCommand > 0) then {

                                    _commandProfileID = _inCommand select 0;
                                    _commandProfile = [ALIVE_profileHandler, "getProfile", _commandProfileID] call ALIVE_fnc_profileHandler;

                                    if!(isNil "_commandProfile") then {

                                        [_commandProfile,_emptyProfile] call ALIVE_fnc_removeProfileVehicleAssignment;

                                        _active = _commandProfile select 2 select 1;

                                        if!(_active) then {

                                            _position = _emptyProfile select 2 select 2;
                                            _position set [2,0];
                                            [_emptyProfile,"position",_position] call ALIVE_fnc_profileVehicle;
                                            [_emptyProfile,"hasSimulated",false] call ALIVE_fnc_profileVehicle;
                                            [_emptyProfile,"engineOn",false] call ALIVE_fnc_profileVehicle;
                                            [_emptyProfile,"despawnPosition",_position] call ALIVE_fnc_profileVehicle;

                                            [ALIVE_profileHandler, "unregisterProfile", _commandProfile] call ALIVE_fnc_profileHandler;

                                        };
                                    };

                                };

                            };

                        } forEach _emptyProfiles;

                    };

                };

                _profileCount = _countTransports + _countEmpty;

                if(_profileCount == 0) then {

                    // no transport vehicles
                    // set state to event complete
                    [_event, "state", "eventComplete"] call ALIVE_fnc_hashSet;
                    [_eventQueue, _eventID, _event] call ALIVE_fnc_hashSet;

                }else{

                    if(_anyActive > 0) then {

                        [_logic, "setEventProfilesAvailable", _event] call MAINCLASS;

                        // there are active transport vehicles
                        // send them back to insertion point
                        [_event, "state", "transportReturn"] call ALIVE_fnc_hashSet;
                        [_eventQueue, _eventID, _event] call ALIVE_fnc_hashSet;

                    }else{

                        // no transport vehicles
                        // set state to event complete
                        [_event, "state", "eventComplete"] call ALIVE_fnc_hashSet;
                        [_eventQueue, _eventID, _event] call ALIVE_fnc_hashSet;

                    };
                };

            };

            case "transportReturn": {

                private ["_position","_profileWaypoint","_reinforcementPosition"];

                if(count _eventTransportProfiles > 0) then {

                    // send transport vehicles back to insertion point
                    {
                        _reinforcementPosition = [_reinforcementPrimaryObjective,"center"] call ALIVE_fnc_hashGet;
                        _position = [_reinforcementPosition, (random(300)), random(360)] call BIS_fnc_relPos;
                        _position = [_position] call ALIVE_fnc_getClosestRoad;
                        _profileWaypoint = [_position, 100, "MOVE", "LIMITED", 300, [], "LINE"] call ALIVE_fnc_createProfileWaypoint;

                        _transportProfile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
                        if!(isNil "_transportProfile") then {
                            [_transportProfile, "addWaypoint", _profileWaypoint] call ALIVE_fnc_profileEntity;
                        };


                    } forEach _eventTransportProfiles;

                    // set state to wait for return of transports
                    [_event, "state", "transportReturnWait"] call ALIVE_fnc_hashSet;
                    [_eventQueue, _eventID, _event] call ALIVE_fnc_hashSet;

                }else{

                    // no transport vehicles
                    // set state to event complete
                    [_event, "state", "eventComplete"] call ALIVE_fnc_hashSet;
                    [_eventQueue, _eventID, _event] call ALIVE_fnc_hashSet;

                };

            };

            case "transportReturnWait": {

                // unloading complete
                // if profiles are active move on
                // to return to insertion point
                // if not active destroy transport profiles

                private ["_anyActive","_transportProfile","_active","_inCommand","_commandProfileID","_commandProfile"];

                if(count _eventTransportProfiles > 0) then {

                    _anyActive = 0;

                    // once transport vehicles are inactive
                    // dispose of the profiles
                    {
                        _transportProfile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
                        if!(isNil "_transportProfile") then {

                            _active = _transportProfile select 2 select 1;

                            if(_active) then {

                                _anyActive = _anyActive + 1;

                            }else{

                                // if not active dispose of transport profiles

                                _inCommand = _transportProfile select 2 select 8;

                                if(count _inCommand > 0) then {
                                    _commandProfileID = _inCommand select 0;
                                    _commandProfile = [ALIVE_profileHandler, "getProfile", _commandProfileID] call ALIVE_fnc_profileHandler;

                                    if!(isNil "_commandProfile") then {
                                        [ALIVE_profileHandler, "unregisterProfile", _commandProfile] call ALIVE_fnc_profileHandler;
                                    };

                                };

                                [ALIVE_profileHandler, "unregisterProfile", _transportProfile] call ALIVE_fnc_profileHandler;
                            };

                        };

                    } forEach _eventTransportVehiclesProfiles;

                    if(_anyActive == 0) then {
                        // no transport vehicles
                        // set state to event complete
                        [_event, "state", "eventComplete"] call ALIVE_fnc_hashSet;
                        [_eventQueue, _eventID, _event] call ALIVE_fnc_hashSet;
                    };

                }else{

                    // no transport vehicles
                    // set state to event complete
                    [_event, "state", "eventComplete"] call ALIVE_fnc_hashSet;
                    [_eventQueue, _eventID, _event] call ALIVE_fnc_hashSet;

                };

            };

            case "eventComplete": {

                [_logic, "setEventProfilesAvailable", _event] call MAINCLASS;
                [_logic, "removeEvent", _eventID] call MAINCLASS;

            };

            // PLAYER REQUEST ---------------------------------------------------------------------------------------------------------------------------------

            // the units have been requested by a player
            // spawn the units at the insertion point
            case "playerRequested": {

                private ["_waitTime"];

                // according to the type of reinforcement
                // adjust wait time for creation of profiles

                switch(_reinforcementType) do {
                    case "AIR": {
                        _waitTime = WAIT_TIME_AIR;
                    };
                    case "HELI": {
                        _waitTime = WAIT_TIME_HELI;
                    };
                    case "MARINE": {
                        _waitTime = WAIT_TIME_MARINE;
                    };
                    case "DROP": {
                        _waitTime = WAIT_TIME_DROP;
                    };
                };


                // DEBUG -------------------------------------------------------------------------------------
                if(_debug) then {
                    ["ALIVE ML - Event state: %1 event timer: %2 wait time on event: %3 ",_eventState, (time - _eventTime), _waitTime] call ALIVE_fnc_dump;
                };
                // DEBUG -------------------------------------------------------------------------------------


                // if the reinforcement objective is
                // not available, cancel the event
                if(_reinforcementAvailable) then {

                    if((time - _eventTime) > _waitTime) then {

                        private ["_reinforcementPosition","_playersInRange","_paraDrop","_remotePosition","_totalCount"];

                        if(_eventType == "PR_STANDARD" || _eventType == "PR_HELI_INSERT") then {

                            _reinforcementPosition = [_reinforcementPrimaryObjective,"center"] call ALIVE_fnc_hashGet;

                        }else{
                            _reinforcementPosition = _eventPosition;
                        };

                        // players near check

                        _playersInRange = [_reinforcementPosition, 1500] call ALiVE_fnc_anyPlayersInRange;

                        // if players are in visible range
                        // para drop groups instead of
                        // spawning on the ground

                        _paraDrop = false;
                        if(_playersInRange > 0) then {
                            _paraDrop = true;

                            _remotePosition = [_reinforcementPosition, 2000] call ALIVE_fnc_getPositionDistancePlayers;
                        }else{
                            _remotePosition = _reinforcementPosition;
                        };

                        // wait time complete create profiles
                        // get groups according to requested force makeup

                        _totalCount = 0;


                        private ["_position","_profiles","_profileID","_profileIDs","_emptyVehicleProfiles","_itemCategory","_infantryProfiles","_armourProfiles",
                        "_mechanisedProfiles","_motorisedProfiles","_heliProfiles","_planeProfiles"];

                        _infantryProfiles = [];
                        _mechanisedProfiles = [];
                        _motorisedProfiles = [];
                        _armourProfiles = [];
                        _heliProfiles = [];
                        _planeProfiles = [];


                        // empty vehicles

                        _emptyVehicleProfiles = [];

                        {
                            _itemClass = _x select 0;

                            _position = [_reinforcementPosition, (random(200)), random(360)] call BIS_fnc_relPos;

                            if!(surfaceIsWater _position) then {

                                _itemCategory = _x select 1 select 1;

                                switch(_itemCategory) do {
                                    case "Car":{
                                        if(_paraDrop) then {
                                            _position set [2,PARADROP_HEIGHT];
                                        };
                                    };
                                    case "Armored":{
                                        if(_paraDrop) then {
                                            _position set [2,PARADROP_HEIGHT];
                                        };
                                    };
                                    case "Air":{
                                        _position = [_remotePosition, (random(200)), random(360)] call BIS_fnc_relPos;
                                        _position set [2,1000];
                                    };
                                };

                                if(_eventType == "PR_AIRDROP") then {
                                    _profiles = [_itemClass,_side,_eventFaction,_position] call ALIVE_fnc_createProfileVehicle;
                                    _profiles = [_profiles];
                                }else{
                                    _profiles = [_itemClass,_side,_eventFaction,"CAPTAIN",_position,random(360),false,_eventFaction,true,true] call ALIVE_fnc_createProfilesCrewedVehicle;
                                };

                                _profileIDs = [];
                                {
                                    _profileID = _x select 2 select 4;
                                    _profileIDs set [count _profileIDs, _profileID];
                                } forEach _profiles;

                                _emptyVehicleProfiles set [count _emptyVehicleProfiles, _profileIDs];

                                switch(_itemCategory) do {
                                    case "Car":{
                                        _motorisedProfiles set [count _motorisedProfiles, _profileIDs];
                                    };
                                    case "Armored":{
                                        _armourProfiles set [count _armourProfiles, _profileIDs];
                                    };
                                    case "Air":{
                                        _heliProfiles set [count _heliProfiles, _profileIDs];

                                        _profileWaypoint = [_reinforcementPosition, 100, "MOVE", "LIMITED", 300, [], "LINE"] call ALIVE_fnc_createProfileWaypoint;
                                        _profile = _profiles select 0;
                                        [_profile, "addWaypoint", _profileWaypoint] call ALIVE_fnc_profileEntity;
                                    };
                                };

                                _totalCount = _totalCount + 1;

                            };

                        } forEach _emptyVehicles;


                        // static individuals

                        private ["_staticIndividualProfiles","_unitClasses"];

                        _staticIndividualProfiles = [];

                        if(count _staticIndividuals > 0) then {

                            _staticIndividualProfiles = [];

                            _position = [_reinforcementPosition, (random(200)), random(360)] call BIS_fnc_relPos;

                            if(_paraDrop) then {
                                _position set [2,PARADROP_HEIGHT];
                            };

                            _unitClasses = [];
                            {
                                _unitClasses set [count _unitClasses,_x select 0];
                            } forEach _staticIndividuals;

                            _profile = [_unitClasses,_side,_eventFaction,_position,0,_side,true] call ALIVE_fnc_createProfileEntity;
                            _profileID = _profile select 2 select 4;
                            _staticIndividualProfiles set [count _staticIndividualProfiles, [_profileID]];
                            _infantryProfiles set [count _infantryProfiles, [_profileID]];

                            _totalCount = _totalCount + 1;

                        };


                        // join individuals

                        private ["_joinIndividualProfiles"];

                        _joinIndividualProfiles = [];

                        if(count _joinIndividuals > 0) then {

                            _joinIndividualProfiles = [];

                            _position = [_reinforcementPosition, (random(200)), random(360)] call BIS_fnc_relPos;

                            if(_paraDrop) then {
                                _position set [2,PARADROP_HEIGHT];
                            };

                            _unitClasses = [];
                            {
                                _unitClasses set [count _unitClasses,_x select 0];
                            } forEach _joinIndividuals;

                            _profile = [_unitClasses,_side,_eventFaction,_position,0,_side,true] call ALIVE_fnc_createProfileEntity;
                            _profileID = _profile select 2 select 4;
                            _joinIndividualProfiles set [count _joinIndividualProfiles, [_profileID]];
                            _infantryProfiles set [count _infantryProfiles, [_profileID]];

                            _totalCount = _totalCount + 1;

                        };

                        // reinforce individuals

                        private ["_reinforceIndividualProfiles"];

                        _reinforceIndividualProfiles = [];

                        if(count _reinforceIndividuals > 0) then {

                            _reinforceIndividualProfiles = [];

                            _position = [_reinforcementPosition, (random(200)), random(360)] call BIS_fnc_relPos;

                            if(_paraDrop) then {
                                _position set [2,PARADROP_HEIGHT];
                            };

                            _unitClasses = [];
                            {
                                _unitClasses set [count _unitClasses,_x select 0];
                            } forEach _reinforceIndividuals;

                            _profile = [_unitClasses,_side,_eventFaction,_position,0,_side,true] call ALIVE_fnc_createProfileEntity;
                            _profileID = _profile select 2 select 4;
                            _reinforceIndividualProfiles set [count _reinforceIndividualProfiles, [_profileID]];
                            _infantryProfiles set [count _infantryProfiles, [_profileID]];

                            _totalCount = _totalCount + 1;

                        };


                        // static groups

                        private ["_staticGroupProfiles","_group"];

                        _staticGroupProfiles = [];

                        {

                            _group = _x select 0;

                            _position = [_reinforcementPosition, (random(200)), random(360)] call BIS_fnc_relPos;

                            if!(surfaceIsWater _position) then {

                                _itemCategory = _x select 1 select 2;

                                switch(_itemCategory) do {
                                    case "Infantry":{
                                        if(_paraDrop) then {
                                            _position set [2,PARADROP_HEIGHT];
                                        };
                                    };
                                    case "SpecOps":{
                                        if(_paraDrop) then {
                                            _position set [2,PARADROP_HEIGHT];
                                        };
                                    };
                                    case "Armored":{
                                        if(_paraDrop) then {
                                            _position set [2,PARADROP_HEIGHT];
                                        };
                                    };
                                    case "Mechanized":{
                                        if(_paraDrop) then {
                                            _position set [2,PARADROP_HEIGHT];
                                        };
                                    };
                                    case "Motorized":{
                                        if(_paraDrop) then {
                                            _position set [2,PARADROP_HEIGHT];
                                        };
                                    };
                                    case "Motorized_MTP":{
                                        if(_paraDrop) then {
                                            _position set [2,PARADROP_HEIGHT];
                                        };
                                    };
                                    case "Air":{
                                        _position = [_remotePosition, (random(200)), random(360)] call BIS_fnc_relPos;
                                        _position set [2,1000];
                                    };
                                };

                                _profiles = [_group, _position, random(360), false, _eventFaction, true] call ALIVE_fnc_createProfilesFromGroupConfig;

                                _profileIDs = [];
                                {
                                    _profileID = _x select 2 select 4;
                                    _profileIDs set [count _profileIDs, _profileID];
                                } forEach _profiles;

                                _staticGroupProfiles set [count _staticGroupProfiles, _profileIDs];

                                switch(_itemCategory) do {
                                    case "Infantry":{
                                        _infantryProfiles set [count _infantryProfiles, _profileIDs];
                                    };
                                    case "SpecOps":{
                                        _infantryProfiles set [count _infantryProfiles, _profileIDs];
                                    };
                                    case "Armored":{
                                        _armourProfiles set [count _armourProfiles, _profileIDs];
                                    };
                                    case "Mechanized":{
                                         _mechanisedProfiles set [count _mechanisedProfiles, _profileIDs];
                                    };
                                    case "Motorized":{
                                         _motorisedProfiles set [count _motorisedProfiles, _profileIDs];
                                    };
                                    case "Motorized_MTP":{
                                         _motorisedProfiles set [count _motorisedProfiles, _profileIDs];
                                    };
                                    case "Air":{
                                        _heliProfiles set [count _heliProfiles, _profileIDs];

                                        _profileWaypoint = [_reinforcementPosition, 100, "MOVE", "LIMITED", 300, [], "LINE"] call ALIVE_fnc_createProfileWaypoint;
                                        _profile = _profiles select 0;
                                        [_profile, "addWaypoint", _profileWaypoint] call ALIVE_fnc_profileEntity;
                                    };
                                };

                                _totalCount = _totalCount + 1;

                            };

                        } forEach _staticGroups;


                        // join groups

                        private ["_joinGroupProfiles"];

                        _joinGroupProfiles = [];

                        {

                            _group = _x select 0;

                            _position = [_reinforcementPosition, (random(200)), random(360)] call BIS_fnc_relPos;

                            if!(surfaceIsWater _position) then {

                                _itemCategory = _x select 1 select 2;

                                switch(_itemCategory) do {
                                    case "Infantry":{
                                        if(_paraDrop) then {
                                            _position set [2,PARADROP_HEIGHT];
                                        };
                                    };
                                    case "SpecOps":{
                                        if(_paraDrop) then {
                                            _position set [2,PARADROP_HEIGHT];
                                        };
                                    };
                                    case "Armored":{
                                        if(_paraDrop) then {
                                            _position set [2,PARADROP_HEIGHT];
                                        };
                                    };
                                    case "Mechanized":{
                                        if(_paraDrop) then {
                                            _position set [2,PARADROP_HEIGHT];
                                        };
                                    };
                                    case "Motorized":{
                                        if(_paraDrop) then {
                                            _position set [2,PARADROP_HEIGHT];
                                        };
                                    };
                                    case "Motorized_MTP":{
                                        if(_paraDrop) then {
                                            _position set [2,PARADROP_HEIGHT];
                                        };
                                    };
                                    case "Air":{
                                        _position = [_remotePosition, (random(200)), random(360)] call BIS_fnc_relPos;
                                        _position set [2,1000];
                                    };
                                };

                                _profiles = [_group, _position, random(360), false, _eventFaction, true] call ALIVE_fnc_createProfilesFromGroupConfig;

                                _profileIDs = [];
                                {
                                    _profileID = _x select 2 select 4;
                                    _profileIDs set [count _profileIDs, _profileID];
                                } forEach _profiles;

                                _joinGroupProfiles set [count _joinGroupProfiles, _profileIDs];

                                switch(_itemCategory) do {
                                    case "Infantry":{
                                        _infantryProfiles set [count _infantryProfiles, _profileIDs];
                                    };
                                    case "SpecOps":{
                                        _infantryProfiles set [count _infantryProfiles, _profileIDs];
                                    };
                                    case "Armored":{
                                        _armourProfiles set [count _armourProfiles, _profileIDs];
                                    };
                                    case "Mechanized":{
                                         _mechanisedProfiles set [count _mechanisedProfiles, _profileIDs];
                                    };
                                    case "Motorized":{
                                         _motorisedProfiles set [count _motorisedProfiles, _profileIDs];
                                    };
                                    case "Motorized_MTP":{
                                         _motorisedProfiles set [count _motorisedProfiles, _profileIDs];
                                    };
                                    case "Air":{
                                        _heliProfiles set [count _heliProfiles, _profileIDs];

                                        _profileWaypoint = [_reinforcementPosition, 100, "MOVE", "LIMITED", 300, [], "LINE"] call ALIVE_fnc_createProfileWaypoint;
                                        _profile = _profiles select 0;
                                        [_profile, "addWaypoint", _profileWaypoint] call ALIVE_fnc_profileEntity;
                                    };
                                };

                                _totalCount = _totalCount + 1;

                            };

                        } forEach _joinGroups;


                        // reinforce groups

                        private ["_reinforceGroupProfiles"];

                        _reinforceGroupProfiles = [];

                        {

                            _group = _x select 0;

                            _position = [_reinforcementPosition, (random(200)), random(360)] call BIS_fnc_relPos;

                            if!(surfaceIsWater _position) then {

                                _itemCategory = _x select 1 select 2;

                                switch(_itemCategory) do {
                                    case "Infantry":{
                                        if(_paraDrop) then {
                                            _position set [2,PARADROP_HEIGHT];
                                        };
                                    };
                                    case "SpecOps":{
                                        if(_paraDrop) then {
                                            _position set [2,PARADROP_HEIGHT];
                                        };
                                    };
                                    case "Armored":{
                                        if(_paraDrop) then {
                                            _position set [2,PARADROP_HEIGHT];
                                        };
                                    };
                                    case "Mechanized":{
                                        if(_paraDrop) then {
                                            _position set [2,PARADROP_HEIGHT];
                                        };
                                    };
                                    case "Motorized":{
                                        if(_paraDrop) then {
                                            _position set [2,PARADROP_HEIGHT];
                                        };
                                    };
                                    case "Motorized_MTP":{
                                        if(_paraDrop) then {
                                            _position set [2,PARADROP_HEIGHT];
                                        };
                                    };
                                    case "Air":{
                                        _position = [_remotePosition, (random(200)), random(360)] call BIS_fnc_relPos;
                                        _position set [2,1000];
                                    };
                                };

                                _profiles = [_group, _position, random(360), false, _eventFaction, true] call ALIVE_fnc_createProfilesFromGroupConfig;

                                _profileIDs = [];
                                {
                                    _profileID = _x select 2 select 4;
                                    _profileIDs set [count _profileIDs, _profileID];
                                } forEach _profiles;

                                _reinforceGroupProfiles set [count _reinforceGroupProfiles, _profileIDs];

                                switch(_itemCategory) do {
                                    case "Infantry":{
                                        _infantryProfiles set [count _infantryProfiles, _profileIDs];
                                    };
                                    case "SpecOps":{
                                        _infantryProfiles set [count _infantryProfiles, _profileIDs];
                                    };
                                    case "Armored":{
                                        _armourProfiles set [count _armourProfiles, _profileIDs];
                                    };
                                    case "Mechanized":{
                                         _mechanisedProfiles set [count _mechanisedProfiles, _profileIDs];
                                    };
                                    case "Motorized":{
                                         _motorisedProfiles set [count _motorisedProfiles, _profileIDs];
                                    };
                                    case "Motorized_MTP":{
                                         _motorisedProfiles set [count _motorisedProfiles, _profileIDs];
                                    };
                                    case "Air":{
                                        _heliProfiles set [count _heliProfiles, _profileIDs];

                                        _profileWaypoint = [_reinforcementPosition, 100, "MOVE", "LIMITED", 300, [], "LINE"] call ALIVE_fnc_createProfileWaypoint;
                                        _profile = _profiles select 0;
                                        [_profile, "addWaypoint", _profileWaypoint] call ALIVE_fnc_profileEntity;
                                    };
                                };

                                _totalCount = _totalCount + 1;

                            };

                        } forEach _reinforceGroups;


                        // payload
                        // spawn vehicles to fit the requested
                        // payload items in
                        // TODO FIX!

                        private ["_transportGroups","_transportProfiles","_transportVehicleProfiles","_vehicleClass","_vehicle","_itemClass"];

                        if(_eventType == "PR_AIRDROP") then {

                            // create ground transport vehicles for the profiles

                            //_transportGroups = [ALIVE_factionDefaultTransport,_eventFaction,[]] call ALIVE_fnc_hashGet;
                            //_transportProfiles = [];
                            //_transportVehicleProfiles = [];

                            if(count _transportGroups == 0) then {
                                //_transportGroups = [ALIVE_sideDefaultTransport,_side] call ALIVE_fnc_hashGet;
                            };

                            if(count _transportGroups > 0) then {

                                //_vehicleClass = _transportGroups call BIS_fnc_selectRandom;
                                //_position = [0,0,50];
                                //_position = position player;
                                //_vehicle = createVehicle [_vehicleClass, _position, [], 0, "NONE"];
                                //_vehicle hideObjectGlobal true;
                                //_vehicle enableSimulationGlobal false;

                                /*
                                _items = [];

                                {
                                    _itemClass = _x;
                                    _item = createVehicle [_itemClass, _position, [], 0, "NONE"];

                                    //item hideObjectGlobal true;
                                    //item enableSimulationGlobal false;

                                    _items set [count _items,_item];

                                    ["ITEM: %1",_itemClass] call ALIVE_fnc_dump;

                                } forEach _payload;
                                */

                                /*
                                _state = _vehicle call ALIVE_fnc_getObjectState;

                                _state call ALIVE_fnc_inspectHash;

                                _cargo = [_state, "ALiVE_SYS_LOGISTICS_CARGO"] call ALIVE_fnc_hashGet;
                                _cargo set [0,_payload];

                                _state call ALIVE_fnc_inspectHash;

                                [_vehicle,_state] call ALIVE_fnc_setObjectState;
                                */

                                /*
                                [_vehicle,[_items]] call ALIVE_fnc_setObjectCargo;

                                _state = _vehicle call ALIVE_fnc_getObjectState;

                                _state call ALIVE_fnc_inspectHash;
                                */

                            };

                        };


                        private ["_transportGroups","_transportProfiles","_transportVehicleProfiles","_vehicleClass"];

                        if(_eventType == "PR_STANDARD") then {

                            // create ground transport vehicles for the profiles

                            _transportGroups = [ALIVE_factionDefaultTransport,_eventFaction,[]] call ALIVE_fnc_hashGet;
                            _transportProfiles = [];
                            _transportVehicleProfiles = [];

                            if(count _transportGroups == 0) then {
                                _transportGroups = [ALIVE_sideDefaultTransport,_side] call ALIVE_fnc_hashGet;
                            };

                            if(count _transportGroups > 0) then {
                                for "_i" from 0 to (count _infantryProfiles) -1 do {

                                    _position = [_reinforcementPosition, (random(200)), random(360)] call BIS_fnc_relPos;

                                    if(_paraDrop) then {
                                        _position set [2,PARADROP_HEIGHT];
                                    };

                                    if(count _transportGroups > 0) then {

                                        _vehicleClass = _transportGroups call BIS_fnc_selectRandom;

                                        _profiles = [_vehicleClass,_side,_eventFaction,"CAPTAIN",_position,random(360),false,_eventFaction,false,true] call ALIVE_fnc_createProfilesCrewedVehicle;

                                        _transportProfiles set [count _transportProfiles, _profiles select 0 select 2 select 4];
                                        _transportVehicleProfiles set [count _transportVehicleProfiles, _profiles select 1 select 2 select 4];

                                    }

                                };
                            };

                            _eventTransportProfiles = _transportProfiles;
                            _eventTransportVehiclesProfiles = _transportVehicleProfiles;

                        };

                        if(_eventType == "PR_HELI_INSERT") then {

                            private ["_infantryProfileID","_infantryProfile","_profileWaypoint","_profile"];

                            // create air transport vehicles for the profiles

                            _transportGroups = [ALIVE_factionDefaultAirTransport,_eventFaction,[]] call ALIVE_fnc_hashGet;
                            _transportProfiles = [];
                            _transportVehicleProfiles = [];

                            if(count _transportGroups == 0) then {
                                _transportGroups = [ALIVE_sideDefaultAirTransport,_side] call ALIVE_fnc_hashGet;
                            };

                            if(count _transportGroups > 0) then {

                                for "_i" from 0 to (count _infantryProfiles) -1 do {

                                    _position = [_remotePosition, (random(200)), random(360)] call BIS_fnc_relPos;

                                    if(_paraDrop) then {
                                        _position set [2,PARADROP_HEIGHT];
                                    };

                                    if(count _transportGroups > 0) then {

                                        _vehicleClass = _transportGroups call BIS_fnc_selectRandom;

                                        _profiles = [_vehicleClass,_side,_eventFaction,"CAPTAIN",_position,random(360),false,_eventFaction,true,true] call ALIVE_fnc_createProfilesCrewedVehicle;

                                        _transportProfiles set [count _transportProfiles, _profiles select 0 select 2 select 4];
                                        _transportVehicleProfiles set [count _transportVehicleProfiles, _profiles select 1 select 2 select 4];

                                        _infantryProfileID = _infantryProfiles select _i select 0;
                                        if!(isNil "_infantryProfileID") then {
                                            _infantryProfile = [ALIVE_profileHandler, "getProfile", _infantryProfileID] call ALIVE_fnc_profileHandler;
                                            if!(isNil "_infantryProfile") then {
                                                [_infantryProfile,_profiles select 1] call ALIVE_fnc_createProfileVehicleAssignment;
                                            };
                                        };

                                        _profileWaypoint = [_reinforcementPosition, 100, "MOVE", "LIMITED", 300, [], "LINE"] call ALIVE_fnc_createProfileWaypoint;
                                        _profile = _profiles select 0;
                                        [_profile, "addWaypoint", _profileWaypoint] call ALIVE_fnc_profileEntity;

                                    };

                                };

                            };

                            _eventTransportProfiles = _transportProfiles;
                            _eventTransportVehiclesProfiles = _transportVehicleProfiles;

                        };


                        [_playerRequestProfiles,"empty",_emptyVehicleProfiles] call ALIVE_fnc_hashSet;
                        [_playerRequestProfiles,"joinIndividuals",_joinIndividualProfiles] call ALIVE_fnc_hashSet;
                        [_playerRequestProfiles,"staticIndividuals",_staticIndividualProfiles] call ALIVE_fnc_hashSet;
                        [_playerRequestProfiles,"reinforceIndividuals",_reinforceIndividualProfiles] call ALIVE_fnc_hashSet;
                        [_playerRequestProfiles,"joinGroups",_joinGroupProfiles] call ALIVE_fnc_hashSet;
                        [_playerRequestProfiles,"staticGroups",_staticGroupProfiles] call ALIVE_fnc_hashSet;
                        [_playerRequestProfiles,"reinforceGroups",_reinforceGroupProfiles] call ALIVE_fnc_hashSet;
                        [_event, "playerRequestProfiles", _playerRequestProfiles] call ALIVE_fnc_hashSet;


                        [_eventCargoProfiles, "armour", _armourProfiles] call ALIVE_fnc_hashSet;
                        [_eventCargoProfiles, "infantry", _infantryProfiles] call ALIVE_fnc_hashSet;
                        [_eventCargoProfiles, "mechanised", _mechanisedProfiles] call ALIVE_fnc_hashSet;
                        [_eventCargoProfiles, "motorised", _motorisedProfiles] call ALIVE_fnc_hashSet;
                        [_eventCargoProfiles, "heli", _heliProfiles] call ALIVE_fnc_hashSet;
                        [_eventCargoProfiles, "plane", _planeProfiles] call ALIVE_fnc_hashSet;


                        // DEBUG -------------------------------------------------------------------------------------
                        if(_debug) then {
                            ["ALIVE ML - Profiles created: %1 ",_totalCount] call ALIVE_fnc_dump;
                            switch(_eventType) do {
                                case "PR_STANDARD": {
                                    [_logic, "createMarker", [_reinforcementPosition,_eventFaction,"PR INSERTION"]] call MAINCLASS;
                                };
                                case "PR_HELI_INSERT": {
                                    [_logic, "createMarker", [_reinforcementPosition,_eventFaction,"PR INSERTION"]] call MAINCLASS;
                                };
                                case "PR_AIRDROP": {
                                    [_logic, "createMarker", [_eventPosition,_eventFaction,"PR AIRDROP"]] call MAINCLASS;
                                };
                            };
                        };
                        // DEBUG -------------------------------------------------------------------------------------


                        if(_totalCount > 0) then {

                            // remove the created group count
                            // from the force pool
                            _forcePool = _forcePool - _totalCount;
                            [_logic, "forcePool", _forcePool] call MAINCLASS;

                            switch(_eventType) do {
                                case "PR_STANDARD": {

                                    // update the state of the event
                                    // next state is transport load
                                    [_event, "state", "transportLoad"] call ALIVE_fnc_hashSet;

                                    // dispatch event
                                    _logEvent = ['LOGISTICS_INSERTION', [_reinforcementPosition,_eventFaction,_side],"Logistics"] call ALIVE_fnc_event;
                                    [ALIVE_eventLog, "addEvent",_logEvent] call ALIVE_fnc_eventLog;

                                };
                                case "PR_HELI_INSERT": {

                                    // update the state of the event
                                    // next state is transport load
                                    [_event, "state", "heliTransportStart"] call ALIVE_fnc_hashSet;

                                    // dispatch event
                                    _logEvent = ['LOGISTICS_INSERTION', [_reinforcementPosition,_eventFaction,_side],"Logistics"] call ALIVE_fnc_event;
                                    [ALIVE_eventLog, "addEvent",_logEvent] call ALIVE_fnc_eventLog;

                                };
                                case "PR_AIRDROP": {

                                    // update the state of the event
                                    // next state is aridrop wait
                                    [_event, "state", "airdropWait"] call ALIVE_fnc_hashSet;

                                    // dispatch event
                                    _logEvent = ['LOGISTICS_DESTINATION', [_eventPosition,_eventFaction,_side],"Logistics"] call ALIVE_fnc_event;
                                    [ALIVE_eventLog, "addEvent",_logEvent] call ALIVE_fnc_eventLog;

                                };
                            };

                            [_event, "cargoProfiles", _eventCargoProfiles] call ALIVE_fnc_hashSet;
                            [_event, "transportProfiles", _eventTransportProfiles] call ALIVE_fnc_hashSet;
                            [_event, "transportVehiclesProfiles", _eventTransportVehiclesProfiles] call ALIVE_fnc_hashSet;

                            [_eventQueue, _eventID, _event] call ALIVE_fnc_hashSet;

                            // respond to player request
                            _logEvent = ['LOGCOM_RESPONSE', [_requestID,_playerID],"Logistics","REQUEST_INSERTION"] call ALIVE_fnc_event;
                            [ALIVE_eventLog, "addEvent",_logEvent] call ALIVE_fnc_eventLog;

                        }else{

                            // respond to player request
                            _logEvent = ['LOGCOM_RESPONSE', [_requestID,_playerID],"Logistics","DENIED_FORCE_CREATION"] call ALIVE_fnc_event;
                            [ALIVE_eventLog, "addEvent",_logEvent] call ALIVE_fnc_eventLog;

                            // no profiles were created
                            // nothing to do so cancel..
                            [_logic, "removeEvent", _eventID] call MAINCLASS;
                        };

                    };
                }else{

                    // no insertion point available
                    // nothing to do so cancel..
                    [_logic, "removeEvent", _eventID] call MAINCLASS;

                    // respond to player request
                    _logEvent = ['LOGCOM_RESPONSE', [_requestID,_playerID],"Logistics","DENIED_NOT_AVAILABLE"] call ALIVE_fnc_event;
                    [ALIVE_eventLog, "addEvent",_logEvent] call ALIVE_fnc_eventLog;

                };
            };
        };
    };

    case "setEventProfilesAvailable": {

        // logistics event complete
        // release profiles to OPCOM
        // control if AI requested
        // if player requested, it's more
        // complicated

        private ["_debug","_event","_eventData","_eventPosition","_eventCargoProfiles","_infantryProfiles","_armourProfiles",
        "_mechanisedProfiles","_motorisedProfiles","_planeProfiles","_heliProfiles","_profile"];

        _debug = [_logic, "debug"] call MAINCLASS;
        _event = _args;

        _eventData = [_event, "data"] call ALIVE_fnc_hashGet;
        _eventPosition = _eventData select 0;
        _eventCargoProfiles = [_event, "cargoProfiles"] call ALIVE_fnc_hashGet;

        _infantryProfiles = [_eventCargoProfiles, 'infantry'] call ALIVE_fnc_hashGet;
        _armourProfiles = [_eventCargoProfiles, 'armour'] call ALIVE_fnc_hashGet;
        _mechanisedProfiles = [_eventCargoProfiles, 'mechanised'] call ALIVE_fnc_hashGet;
        _motorisedProfiles = [_eventCargoProfiles, 'motorised'] call ALIVE_fnc_hashGet;
        _planeProfiles = [_eventCargoProfiles, 'plane'] call ALIVE_fnc_hashGet;
        _heliProfiles = [_eventCargoProfiles, 'heli'] call ALIVE_fnc_hashGet;

        if!(_playerRequested) then {

            // AI requested
            // set all cargo profiles as not busy

            {
                _profile = [ALIVE_profileHandler, "getProfile", _x select 0] call ALIVE_fnc_profileHandler;
                if!(isNil "_profile") then {
                    [_profile,"busy",false] call ALIVE_fnc_hashSet;
                };

            } forEach _infantryProfiles;

            {
                {
                    _profile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
                    if!(isNil "_profile") then {
                        [_profile,"busy",false] call ALIVE_fnc_hashSet;
                    };
                } forEach _x;

            } forEach _armourProfiles;

            {
                {
                    _profile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
                    if!(isNil "_profile") then {
                        [_profile,"busy",false] call ALIVE_fnc_hashSet;
                    };
                } forEach _x;

            } forEach _mechanisedProfiles;

            {
                {
                    _profile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
                    if!(isNil "_profile") then {
                        [_profile,"busy",false] call ALIVE_fnc_hashSet;
                    };
                } forEach _x;

            } forEach _motorisedProfiles;

            {
                {
                    _profile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
                    if!(isNil "_profile") then {
                        [_profile,"busy",false] call ALIVE_fnc_hashSet;
                    };
                } forEach _x;

            } forEach _planeProfiles;

            {
                {
                    _profile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
                    if!(isNil "_profile") then {
                        [_profile,"busy",false] call ALIVE_fnc_hashSet;
                    };
                } forEach _x;

            } forEach _heliProfiles;


        }else{

            // Player requested

            private ["_emptyProfiles","_joinIndividualProfiles","_staticIndividualProfiles","_reinforceIndividualProfiles",
            "_joinGroupProfiles","_staticGroupProfiles","_reinforceGroupProfiles","_player"];

            _emptyProfiles = [_playerRequestProfiles,"empty"] call ALIVE_fnc_hashGet;
            _joinIndividualProfiles = [_playerRequestProfiles,"joinIndividuals"] call ALIVE_fnc_hashGet;
            _staticIndividualProfiles = [_playerRequestProfiles,"staticIndividuals"] call ALIVE_fnc_hashGet;
            _reinforceIndividualProfiles = [_playerRequestProfiles,"reinforceIndividuals"] call ALIVE_fnc_hashGet;
            _joinGroupProfiles = [_playerRequestProfiles,"joinGroups"] call ALIVE_fnc_hashGet;
            _staticGroupProfiles = [_playerRequestProfiles,"staticGroups"] call ALIVE_fnc_hashGet;
            _reinforceGroupProfiles = [_playerRequestProfiles,"reinforceGroups"] call ALIVE_fnc_hashGet;

            // reinforce profiles get released
            // to OPCOM control

            {
                {
                    _profile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
                    if!(isNil "_profile") then {
                        [_profile,"busy",false] call ALIVE_fnc_hashSet;
                    };
                } forEach _x;

            } forEach _reinforceIndividualProfiles;

            {
                {
                    _profile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
                    if!(isNil "_profile") then {
                        [_profile,"busy",false] call ALIVE_fnc_hashSet;
                    };
                } forEach _x;

            } forEach _reinforceGroupProfiles;


            // find the player object

            if(isDedicated) then {
                _player = objNull;
                {
                    if (getPlayerUID _x == _playerID) exitWith {
                        _player = _x;
                    };
                } forEach playableUnits;
            }else{
                 _player = player;
            };

            // player found

            if (!(isNull _player)) then {

                private ["_active","_type","_units"];

                // join player profiles, if active
                // join the player group

                {
                    {
                        _profile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
                        if!(isNil "_profile") then {

                            _active = _profile select 2 select 1;
                            _type = _profile select 2 select 5;

                            if(_type == "entity") then {

                                if(_active) then {

                                    _units = _profile select 2 select 21;

                                    _units joinSilent (group player);

                                    [ALIVE_profileHandler, "unregisterProfile", _profile] call ALIVE_fnc_profileHandler;
                                }else{

                                    [_profile,"busy",false] call ALIVE_fnc_hashSet;

                                };

                            }else{

                                if!(_active) then {

                                    [_profile,"busy",false] call ALIVE_fnc_hashSet;

                                };

                            };

                        };
                    } forEach _x;

                } forEach _joinIndividualProfiles;

                {
                    {
                        _profile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
                        if!(isNil "_profile") then {

                            _active = _profile select 2 select 1;
                            _type = _profile select 2 select 5;

                            if(_type == "entity") then {

                                if(_active) then {

                                    _units = _profile select 2 select 21;

                                    _units joinSilent (group player);

                                    [ALIVE_profileHandler, "unregisterProfile", _profile] call ALIVE_fnc_profileHandler;
                                }else{

                                    [_profile,"busy",false] call ALIVE_fnc_hashSet;

                                };

                            }else{

                                if!(_active) then {

                                    [_profile,"busy",false] call ALIVE_fnc_hashSet;

                                };

                            };

                        };
                    } forEach _x;

                } forEach _joinGroupProfiles;

                // static defence profiles
                // if active set to garrison
                // nearby structures

                {
                    {
                        _profile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
                        if!(isNil "_profile") then {

                            _active = _profile select 2 select 1;
                            _type = _profile select 2 select 5;

                            if(_type == "entity") then {

                                if(_active) then {

                                    [_profile, "setActiveCommand", ["ALIVE_fnc_managedGarrison","managed",[_eventPosition,200]]] call ALIVE_fnc_profileEntity;

                                }else{

                                    [_profile,"busy",false] call ALIVE_fnc_hashSet;

                                };

                            }else{

                                if!(_active) then {

                                    [_profile,"busy",false] call ALIVE_fnc_hashSet;

                                };

                            };

                        };
                    } forEach _x;

                } forEach _staticIndividualProfiles;

                {
                    if(count _x < 2) then {

                        _profile = [ALIVE_profileHandler, "getProfile", (_x select 0)] call ALIVE_fnc_profileHandler;
                        if!(isNil "_profile") then {

                            _active = _profile select 2 select 1;
                            _type = _profile select 2 select 5;

                            if(_type == "entity") then {

                                if(_active) then {

                                    [_profile, "setActiveCommand", ["ALIVE_fnc_managedGarrison","managed",[_eventPosition,200]]] call ALIVE_fnc_profileEntity;

                                }else{

                                    [_profile,"busy",false] call ALIVE_fnc_hashSet;

                                };

                            }else{

                                if!(_active) then {

                                    [_profile,"busy",false] call ALIVE_fnc_hashSet;

                                };

                            };

                        };

                    };

                } forEach _staticGroupProfiles;


            }else{

                // player not found just set
                // the requested groups as
                // reinforcements

                {
                    {
                        _profile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
                        if!(isNil "_profile") then {
                            [_profile,"busy",false] call ALIVE_fnc_hashSet;
                        };
                    } forEach _x;

                } forEach _reinforceIndividualProfiles;

                {
                    {
                        _profile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
                        if!(isNil "_profile") then {
                            [_profile,"busy",false] call ALIVE_fnc_hashSet;
                        };
                    } forEach _x;

                } forEach _reinforceGroupProfiles;

                {
                    {
                        _profile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
                        if!(isNil "_profile") then {
                            [_profile,"busy",false] call ALIVE_fnc_hashSet;
                        };
                    } forEach _x;

                } forEach _staticIndividualProfiles;

                {
                    {
                        _profile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
                        if!(isNil "_profile") then {
                            [_profile,"busy",false] call ALIVE_fnc_hashSet;
                        };
                    } forEach _x;

                } forEach _staticGroupProfiles;

            };



            // respond to player request
            if(_playerRequested) then {
                _logEvent = ['LOGCOM_RESPONSE', [_requestID,_playerID],"Logistics","REQUEST_DELIVERED"] call ALIVE_fnc_event;
                [ALIVE_eventLog, "addEvent",_logEvent] call ALIVE_fnc_eventLog;
            };

        };
    };

    case "removeEvent": {
        private["_debug","_eventID","_eventQueue"];

        // remove the event from the queue

        _eventID = _args;
        _eventQueue = [_logic, "eventQueue"] call MAINCLASS;

        [_eventQueue,_eventID] call ALIVE_fnc_hashRem;

        [_logic, "eventQueue", _eventQueue] call MAINCLASS;

    };
};

TRACE_1("ML - output",_result);
_result;