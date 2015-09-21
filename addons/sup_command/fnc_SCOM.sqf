//#define DEBUG_MODE_FULL
#include <\x\alive\addons\sup_command\script_component.hpp>
SCRIPT(SCOM);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_SCOM
Description:
command and control

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array - The selected parameters

Returns:
Any - The new instance or the result of the selected function and parameters

Attributes:
Nil - init - Intiate instance
Nil - destroy - Destroy instance

Examples:
[_logic, "debug", true] call ALiVE_fnc_SCOM;

See Also:
- <ALIVE_fnc_SCOMInit>

Author:
SpyderBlack / ARJay

Peer Reviewed:
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClass
#define MAINCLASS ALIVE_fnc_SCOM
#define MTEMPLATE "ALiVE_SCOM_%1"
#define DEFAULT_DEBUG false
#define DEFAULT_STATE "INIT"
#define DEFAULT_SIDE "WEST"
#define DEFAULT_FACTION "BLU_F"
#define DEFAULT_MARKER []
#define DEFAULT_SELECTED_INDEX 0
#define DEFAULT_SELECTED_VALUE ""
#define DEFAULT_SCALAR 0
#define DEFAULT_COMMAND_STATE [] call ALIVE_fnc_hashCreate
#define DEFAULT_SCOM_LIMIT "SIDE"

// Display components
#define SCOMTablet_CTRL_MainDisplay 12001

// sub menu generic
#define SCOMTablet_CTRL_SubMenuBack 12006
#define SCOMTablet_CTRL_SubMenuAbort 12010
#define SCOMTablet_CTRL_Title 12007

// command interface elements
#define SCOMTablet_CTRL_BL1 12014
#define SCOMTablet_CTRL_BL2 12015
#define SCOMTablet_CTRL_BL3 12016
#define SCOMTablet_CTRL_BR1 12017
#define SCOMTablet_CTRL_BR2 12018
#define SCOMTablet_CTRL_BR3 12019
#define SCOMTablet_CTRL_MapRight 12021
#define SCOMTablet_CTRL_MainMap 12022
#define SCOMTablet_CTRL_IntelTypeTitle 12023
#define SCOMTablet_CTRL_IntelTypeList 12024
#define SCOMTablet_CTRL_IntelStatus 12025
#define SCOMTablet_CTRL_EditMap 12026
#define SCOMTablet_CTRL_EditList 12027
#define SCOMTablet_CTRL_WaypointList 12028
#define SCOMTablet_CTRL_WaypointTypeList 12029
#define SCOMTablet_CTRL_WaypointSpeedList 12030
#define SCOMTablet_CTRL_WaypointFormationList 12031
#define SCOMTablet_CTRL_WaypointBehavourList 12032

// Control Macros
#define SCOM_getControl(disp,ctrl) ((findDisplay ##disp) displayCtrl ##ctrl)
#define SCOM_getSelData(ctrl) (lbData[##ctrl,(lbCurSel ##ctrl)])


private ["_logic","_operation","_args","_result"];

TRACE_1("SCOM - input",_this);

_logic = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_operation = [_this, 1, "", [""]] call BIS_fnc_param;
_args = [_this, 2, objNull, [objNull,[],"",0,true,false]] call BIS_fnc_param;
_result = true;

switch(_operation) do {
	default {
		_result = [_logic, _operation, _args] call SUPERCLASS;
	};
	case "destroy": {
		if (isServer) then {
			// if server
			_logic setVariable ["super", nil];
			_logic setVariable ["class", nil];

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
    case "opsLimit": {
        _result = [_logic,_operation,_args,DEFAULT_SCOM_LIMIT,["SIDE","FACTION","ALL"]] call ALIVE_fnc_OOsimpleOperation;
    };
    case "intelLimit": {
        _result = [_logic,_operation,_args,DEFAULT_SCOM_LIMIT,["SIDE","FACTION","ALL"]] call ALIVE_fnc_OOsimpleOperation;
    };
	case "state": {
        _result = [_logic,_operation,_args,DEFAULT_STATE] call ALIVE_fnc_OOsimpleOperation;
    };
    case "side": {
        _result = [_logic,_operation,_args,DEFAULT_SIDE] call ALIVE_fnc_OOsimpleOperation;
    };
    case "faction": {
        _result = [_logic,_operation,_args,DEFAULT_FACTION] call ALIVE_fnc_OOsimpleOperation;
    };
    case "commandState": {
        _result = [_logic,_operation,_args,DEFAULT_COMMAND_STATE] call ALIVE_fnc_OOsimpleOperation;
    };
    case "marker": {
        _result = [_logic,_operation,_args,DEFAULT_MARKER] call ALIVE_fnc_OOsimpleOperation;
    };

	case "init": {

        //Only one init per instance is allowed
    	if !(isnil {_logic getVariable "initGlobal"}) exitwith {["ALiVE SUP Command - Only one init process per instance allowed! Exiting..."] call ALiVE_fnc_Dump};

    	//Start init
        _logic setVariable ["initGlobal", false];

	    private["_debug"];

        _logic setVariable ["super", SUPERCLASS];
        _logic setVariable ["class", MAINCLASS];
        _logic setVariable ["moduleType", "ALIVE_SCOM"];
        _logic setVariable ["startupComplete", false];

        _debug = [_logic, "debug"] call MAINCLASS;

        ALIVE_SUP_COMMAND = _logic;

        if (isServer) then {

            // create the command handler
            ALIVE_commandHandler = [nil, "create"] call ALIVE_fnc_commandHandler;
            [ALIVE_commandHandler, "init"] call ALIVE_fnc_commandHandler;
            [ALIVE_commandHandler, "debug", true] call ALIVE_fnc_commandHandler;

        };

        if (hasInterface) then {

            _logic setVariable ["startupComplete", true];

            // set the player side

            private ["_playerSide","_sideNumber","_sideText","_playerFaction"];

            waitUntil {
                sleep 1;
                ((str side player) != "UNKNOWN")
            };

            _playerSide = side player;
            _sideNumber = [_playerSide] call ALIVE_fnc_sideObjectToNumber;
            _sideText = [_sideNumber] call ALIVE_fnc_sideNumberToText;

            if(_sideText == "CIV") then {
                _playerFaction = faction player;
                _playerSide = _playerFaction call ALiVE_fnc_factionSide;
                _sideNumber = [_playerSide] call ALIVE_fnc_sideObjectToNumber;
                _sideText = [_sideNumber] call ALIVE_fnc_sideNumberToText;
            };

            [_logic,"side",_sideText] call MAINCLASS;


            // set the player faction

            _playerFaction = faction player;

            [_logic,"faction",_playerFaction] call MAINCLASS;

            // set the command state

            private ["_commandState","_opsGroupsBySide"];

            _commandState = [_logic,"commandState"] call MAINCLASS;

            [_commandState,"commandInterface",DEFAULT_SELECTED_VALUE] call ALIVE_fnc_hashSet;

            // intel state

            [_commandState,"intelTypeOptions",["Commander Objectives","Unit Marking"]] call ALIVE_fnc_hashSet;
            [_commandState,"intelTypeValues",["Objectives","Marking"]] call ALIVE_fnc_hashSet;
            [_commandState,"intelTypeSelectedIndex",DEFAULT_SELECTED_INDEX] call ALIVE_fnc_hashSet;
            [_commandState,"intelTypeSelectedValue",DEFAULT_SELECTED_VALUE] call ALIVE_fnc_hashSet;

            [_commandState,"intelOPCOMOptions",[]] call ALIVE_fnc_hashSet;
            [_commandState,"intelOPCOMValues",[]] call ALIVE_fnc_hashSet;
            [_commandState,"intelOPCOMSelectedIndex",DEFAULT_SELECTED_INDEX] call ALIVE_fnc_hashSet;
            [_commandState,"intelOPCOMSelectedValue",DEFAULT_SELECTED_VALUE] call ALIVE_fnc_hashSet;

            // ops state

            [_commandState,"opsOPCOMOptions",[]] call ALIVE_fnc_hashSet;
            [_commandState,"opsOPCOMValues",[]] call ALIVE_fnc_hashSet;
            [_commandState,"opsOPCOMSelectedIndex",DEFAULT_SELECTED_INDEX] call ALIVE_fnc_hashSet;
            [_commandState,"opsOPCOMSelectedValue",DEFAULT_SELECTED_VALUE] call ALIVE_fnc_hashSet;

            _opsGroupsBySide = [] call ALIVE_fnc_hashCreate;
            [_opsGroupsBySide, "EAST", []] call ALIVE_fnc_hashSet;
            [_opsGroupsBySide, "WEST", []] call ALIVE_fnc_hashSet;
            [_opsGroupsBySide, "GUER", []] call ALIVE_fnc_hashSet;
            [_commandState,"opsGroupsBySide",_opsGroupsBySide] call ALIVE_fnc_hashSet;

            [_commandState,"opsGroupsOptions",[]] call ALIVE_fnc_hashSet;
            [_commandState,"opsGroupsValues",[]] call ALIVE_fnc_hashSet;
            [_commandState,"opsGroupsSelectedIndex",DEFAULT_SELECTED_INDEX] call ALIVE_fnc_hashSet;
            [_commandState,"opsGroupsSelectedValue",DEFAULT_SELECTED_VALUE] call ALIVE_fnc_hashSet;

            [_commandState,"opsGroupSelectedProfile",[]] call ALIVE_fnc_hashSet;
            [_commandState,"opsGroupWaypoints",[]] call ALIVE_fnc_hashSet;
            [_commandState,"opsGroupPlannedWaypoints",[]] call ALIVE_fnc_hashSet;
            [_commandState,"opsGroupPreviousWaypoints",[]] call ALIVE_fnc_hashSet;
            [_commandState,"opsGroupArrowMarkers",[]] call ALIVE_fnc_hashSet;
            [_commandState,"opsGroupWaypointsPlanned",false] call ALIVE_fnc_hashSet;

            [_commandState,"opsGroupWaypointsSelectedOptions",[]] call ALIVE_fnc_hashSet;
            [_commandState,"opsGroupWaypointsSelectedValues",[]] call ALIVE_fnc_hashSet;
            [_commandState,"opsGroupWaypointsSelectedIndex",DEFAULT_SELECTED_INDEX] call ALIVE_fnc_hashSet;
            [_commandState,"opsGroupWaypointsSelectedValue",DEFAULT_SELECTED_VALUE] call ALIVE_fnc_hashSet;

            [_commandState,"opsWPTypeOptions",["Move","SAD","Cycle","Load","Land - Engines Off","Land - Low Hover","TR Unload"]] call ALIVE_fnc_hashSet;
            [_commandState,"opsWPTypeValues",["MOVE","SAD","CYCLE","LOAD","LAND_OFF","LAND_HOVER","TR UNLOAD"]] call ALIVE_fnc_hashSet;
            [_commandState,"opsWPTypeSelectedIndex",DEFAULT_SELECTED_INDEX] call ALIVE_fnc_hashSet;
            [_commandState,"opsWPTypeSelectedValue",DEFAULT_SELECTED_VALUE] call ALIVE_fnc_hashSet;

            [_commandState,"opsWPSpeedOptions",["Unchanged","Limited","Normal","Full"]] call ALIVE_fnc_hashSet;
            [_commandState,"opsWPSpeedValues",["UNCHANGED","LIMITED","NORMAL","FULL"]] call ALIVE_fnc_hashSet;
            [_commandState,"opsWPSpeedSelectedIndex",DEFAULT_SELECTED_INDEX] call ALIVE_fnc_hashSet;
            [_commandState,"opsWPSpeedSelectedValue",DEFAULT_SELECTED_VALUE] call ALIVE_fnc_hashSet;

            [_commandState,"opsWPFormationOptions",["File","Column","Staggered Column","Wedge","Echelon Left","Echelon Right","Vee","Line","Diamond"]] call ALIVE_fnc_hashSet;
            [_commandState,"opsWPFormationValues",["FILE","COLUMN","STAG COLUMN","WEDGE","ECH LEFT","ECH RIGHT","VEE","LINE","DIAMOND"]] call ALIVE_fnc_hashSet;
            [_commandState,"opsWPFormationSelectedIndex",DEFAULT_SELECTED_INDEX] call ALIVE_fnc_hashSet;
            [_commandState,"opsWPFormationSelectedValue",DEFAULT_SELECTED_VALUE] call ALIVE_fnc_hashSet;

            [_commandState,"opsWPBehaviourOptions",["Careless","Safe","Aware","Combat","Stealth"]] call ALIVE_fnc_hashSet;
            [_commandState,"opsWPBehaviourValues",["CARELESS","SAFE","AWARE","COMBAT","STEALTH"]] call ALIVE_fnc_hashSet;
            [_commandState,"opsWPBehaviourSelectedIndex",DEFAULT_SELECTED_INDEX] call ALIVE_fnc_hashSet;
            [_commandState,"opsWPBehaviourSelectedValue",DEFAULT_SELECTED_VALUE] call ALIVE_fnc_hashSet;

            //_commandState call ALIVE_fnc_inspectHash;

            [_logic,"commandState",_commandState] call MAINCLASS;

            // DEBUG -------------------------------------------------------------------------------------

            private ["_opsLimit","_intelLimit"];

            _opsLimit = [_logic,"opsLimit"] call MAINCLASS;
            _intelLimit = [_logic,"intelLimit"] call MAINCLASS;

            if(_debug) then {
                ["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
                ["ALIVE Command State"] call ALIVE_fnc_dump;
                ["ALIVE Command Side: %1, Faction: %2, OPS Limit: %3 Intel Limit: %4",_sideText,_playerFaction,_opsLimit,_intelLimit] call ALIVE_fnc_dump;
                _commandState call ALIVE_fnc_inspectHash;
            };

            // DEBUG -------------------------------------------------------------------------------------


        };

        [_logic, "start"] call MAINCLASS;

	};
	case "start": {

        // set module as startup complete
        _logic setVariable ["startupComplete", true];

        if(isServer) then {

            // start listening for events
            [_logic,"listen"] call MAINCLASS;

        };

	};
	case "listen": {
        private["_listenerID"];

        _listenerID = [ALIVE_eventLog, "addListener",[_logic, ["SCOM_UPDATED"]]] call ALIVE_fnc_eventLog;
        _logic setVariable ["listenerID", _listenerID];
    };
    case "handleEvent": {

        private["_event","_eventData"];

        if(typeName _args == "ARRAY") then {

            _event = _args;

            // a response event from command handler has been received.
            // if we are a dedicated server,
            // dispatch the event to the player who requested it
            if((isServer && isMultiplayer) || isDedicated) then {

                private ["_eventData","_playerID","_player"];

                _eventData = [_event, "data"] call ALIVE_fnc_hashGet;

                _playerID = _eventData select 0;

                _player = [_playerID] call ALIVE_fnc_getPlayerByUID;

                if !(isNull _player) then {
                    [_event,"ALIVE_fnc_SCOMTabletEventToClient",_player,false,false] spawn BIS_fnc_MP;
                };

            }else{

                // the player is the server

                [_logic, "handleServerResponse", _event] call MAINCLASS;

            };

        };
    };
    case "handleServerResponse": {

        // event handler for response from server command handler

        private["_event","_eventData","_type","_message"];

        if(typeName _args == "ARRAY") then {

            _event = _args;
            _type = [_event, "type"] call ALIVE_fnc_hashGet;
            _eventData = [_event, "data"] call ALIVE_fnc_hashGet;
            _message = [_event, "message"] call ALIVE_fnc_hashGet;

            _event call ALIVE_fnc_inspectHash;

            disableSerialization;

            switch(_message) do {
                case "OPCOM_SIDES_AVAILABLE": {

                    [_logic,"enableIntelOPCOMSelect",_eventData] call MAINCLASS;

                };
                case "OPCOM_OBJECTIVES": {

                    [_logic,"enableIntelOPCOMObjectives",_eventData] call MAINCLASS;

                };
                case "UNIT_MARKING": {

                    [_logic,"enableIntelUnitMarking",_eventData] call MAINCLASS;

                };
                case "OPS_SIDES_AVAILABLE": {

                    [_logic,"enableOpsOPCOMSelect",_eventData] call MAINCLASS;

                };
                case "OPS_GROUPS": {

                    [_logic,"enableOpsHighCommand",_eventData] call MAINCLASS;

                };
                case "OPS_PROFILE": {

                    [_logic,"enableOpsProfile",_eventData] call MAINCLASS;

                };
                case "OPS_RESET": {

                    [_logic,"enableOpsInterface",_eventData] call MAINCLASS;

                };
                case "OPS_PROFILE_WAYPOINTS": {

                    [_logic,"enableGroupWaypointEdit",_eventData] call MAINCLASS;

                };
                case "OPS_PROFILE_WAYPOINTS_CLEARED": {

                    [_logic,"enableGroupWaypointEdit",_eventData] call MAINCLASS;

                };
                case "OPS_PROFILE_WAYPOINTS_UPDATED": {

                    [_logic,"enableGroupWaypointEdit",_eventData] call MAINCLASS;

                };
            };
        };

    };
	case "tabletOnLoad": {

        // on load of the tablet
        // restore state

        if (hasInterface) then {

            [_logic] spawn {

                private ["_logic","_state"];

                _logic = _this select 0;

                disableSerialization;

                [_logic,"disableAll"] call MAINCLASS;

                sleep 0.5;

                _state = [_logic,"state"] call MAINCLASS;

                switch(_state) do {

                    case "INIT":{

                        // the interface is opened
                        // for the first time

                        private ["_commandState","_interfaceType"];

                        // get the current interface type

                        _commandState = [_logic,"commandState"] call MAINCLASS;

                        _interfaceType = [_commandState,"commandInterface"] call ALIVE_fnc_hashGet;

                        switch(_interfaceType) do {

                            case "INTEL":{
                                [_logic,"enableIntelInterface"] call MAINCLASS;
                            };
                            case "OPS":{
                                [_logic,"enableOpsInterface"] call MAINCLASS;
                            };
                        };

                    };

                };

                // Hide GPS
                showGPS false;

            };

        };

    };
    case "tabletOnUnLoad": {

        // The machine has an interface? Must be a MP client, SP client or a client that acts as host!
        if (hasInterface) then {

            private ["_commandState","_markers","_groupWaypoints","_arrowMarkers","_plannedWaypoints"];

            _commandState = [_logic,"commandState"] call MAINCLASS;

            // Show GPS
            showGPS true;

            // Clear markers
            _markers = [_logic,"marker"] call MAINCLASS;

            {
                deleteMarkerLocal _x;
            } foreach _markers;

            _groupWaypoints = [_commandState,"opsGroupWaypoints"] call ALIVE_fnc_hashGet;
            _arrowMarkers = [_commandState,"opsGroupArrowMarkers"] call ALIVE_fnc_hashGet;
            _plannedWaypoints = [_commandState,"opsGroupPlannedWaypoints"] call ALIVE_fnc_hashGet;

            {
                deleteMarkerLocal _x
            } forEach _groupWaypoints;

            {
                deleteMarkerLocal _x
            } forEach _arrowMarkers;

            {
                deleteMarkerLocal _x
            } forEach _plannedWaypoints;

        };

    };
	case "tabletOnAction": {

	    // The machine has an interface? Must be a MP client, SP client or a client that acts as host!
        if (hasInterface) then {

            if (isnil "_args") exitwith {};

            private ["_action"];

            _action = _args select 0;
            _args = _args select 1;

            switch(_action) do {

                case "OPEN_INTEL": {

                    private ["_commandState"];

                    // open the intel interface, set the interface type on the local module state

                    _commandState = [_logic,"commandState"] call MAINCLASS;

                    [_commandState,"commandInterface","INTEL"] call ALIVE_fnc_hashSet;

                    [_logic,"commandState",_commandState] call MAINCLASS;

                    createDialog "SCOMTablet";

                };

                case "OPEN_OPS": {

                    // open the ops interface, set the interface type on the local module state

                    _commandState = [_logic,"commandState"] call MAINCLASS;

                    [_commandState,"commandInterface","OPS"] call ALIVE_fnc_hashSet;

                    [_logic,"commandState",_commandState] call MAINCLASS;

                    createDialog "SCOMTablet";

                };

                // INTEL ------------------------------------------------------------------------------------------------------------------------------

                case "INTEL_TYPE_LIST_SELECT": {

                    private ["_commandState","_selectedList","_selectedIndex","_listOptions","_listValues","_selectedOption","_selectedValue","_playerID","_requestID",
                    "_intelLimit","_side","_faction","_event"];

                    // on click of the intel analysis type list

                    _commandState = [_logic,"commandState"] call MAINCLASS;

                    _selectedList = _args select 0 select 0;
                    _selectedIndex = _args select 0 select 1;

                    if(_selectedIndex >= 0) then {

                        // store the selected item in the state

                        _listOptions = [_commandState,"intelTypeOptions"] call ALIVE_fnc_hashGet;
                        _listValues = [_commandState,"intelTypeValues"] call ALIVE_fnc_hashGet;
                        _selectedOption = _listOptions select _selectedIndex;
                        _selectedValue = _listValues select _selectedIndex;

                        [_commandState,"intelTypeSelectedIndex",_selectedIndex] call ALIVE_fnc_hashSet;
                        [_commandState,"intelTypeSelectedValue",_selectedValue] call ALIVE_fnc_hashSet;

                        [_logic,"commandState",_commandState] call MAINCLASS;

                        _commandState call ALIVE_fnc_inspectHash;

                        // send the event to get further data from the command handler

                        _playerID = getPlayerUID player;
                        _requestID = format["%1_%2",_faction,floor(time)];

                        _intelLimit = [_logic,"intelLimit"] call MAINCLASS;
                        _side = [_logic,"side"] call MAINCLASS;
                        _faction = [_logic,"faction"] call MAINCLASS;

                        _event = ['INTEL_TYPE_SELECT', [_requestID,_playerID,_selectedValue,_intelLimit,_side,_faction], "SCOM"] call ALIVE_fnc_event;

                        if(isServer) then {
                            [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;
                        }else{
                            [[_event],"ALIVE_fnc_addEventToServer",false,false] spawn BIS_fnc_MP;
                        };

                        // show waiting until response comes back

                        [_logic, "enableIntelWaiting"] call MAINCLASS;

                    };
                };

                case "INTEL_OPCOM_LIST_SELECT": {

                    private ["_commandState","_selectedList","_selectedIndex","_listOptions","_listValues","_selectedOption","_selectedValue","_playerID","_requestID",
                    "_intelLimit","_side","_faction","_event"];

                    // on click of the intel opcom side list

                    _commandState = [_logic,"commandState"] call MAINCLASS;

                    _selectedList = _args select 0 select 0;
                    _selectedIndex = _args select 0 select 1;

                    if(_selectedIndex >= 0) then {

                        // store the selected item in the state

                        _listOptions = [_commandState,"intelOPCOMOptions"] call ALIVE_fnc_hashGet;
                        _listValues = [_commandState,"intelOPCOMValues"] call ALIVE_fnc_hashGet;
                        _selectedOption = _listOptions select _selectedIndex;
                        _selectedValue = _listValues select _selectedIndex;

                        [_commandState,"intelOPCOMSelectedIndex",_selectedIndex] call ALIVE_fnc_hashSet;
                        [_commandState,"intelOPCOMSelectedValue",_selectedValue] call ALIVE_fnc_hashSet;

                        [_logic,"commandState",_commandState] call MAINCLASS;

                        _commandState call ALIVE_fnc_inspectHash;

                        // send the event to get further data from the command handler

                        _faction = [_logic,"faction"] call MAINCLASS;

                        _playerID = getPlayerUID player;
                        _requestID = format["%1_%2",_faction,floor(time)];

                        _event = ['INTEL_OPCOM_SELECT', [_requestID,_playerID,_selectedValue], "SCOM"] call ALIVE_fnc_event;

                        if(isServer) then {
                            [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;
                        }else{
                            [[_event],"ALIVE_fnc_addEventToServer",false,false] spawn BIS_fnc_MP;
                        };

                        // show waiting until response comes back

                        [_logic, "enableIntelWaiting"] call MAINCLASS;

                    };
                };

                case "INTEL_RESET": {

                    [_logic,"enableIntelInterface"] call MAINCLASS;
                };


                // OPS ------------------------------------------------------------------------------------------------------------------------------


                case "OPS_OPCOM_LIST_SELECT": {

                    private ["_commandState","_selectedList","_selectedIndex","_listOptions","_listValues","_selectedOption","_selectedValue","_playerID","_requestID",
                    "_intelLimit","_side","_faction","_event"];

                    // on click of the ops opcom side list

                    _commandState = [_logic,"commandState"] call MAINCLASS;

                    _selectedList = _args select 0 select 0;
                    _selectedIndex = _args select 0 select 1;

                    if(_selectedIndex >= 0) then {

                        // store the selected item in the state

                        _listOptions = [_commandState,"opsOPCOMOptions"] call ALIVE_fnc_hashGet;
                        _listValues = [_commandState,"opsOPCOMValues"] call ALIVE_fnc_hashGet;
                        _selectedOption = _listOptions select _selectedIndex;
                        _selectedValue = _listValues select _selectedIndex;

                        [_commandState,"opsOPCOMSelectedIndex",_selectedIndex] call ALIVE_fnc_hashSet;
                        [_commandState,"opsOPCOMSelectedValue",_selectedValue] call ALIVE_fnc_hashSet;

                        [_logic,"commandState",_commandState] call MAINCLASS;

                        _commandState call ALIVE_fnc_inspectHash;

                        // send the event to get further data from the command handler

                        _faction = [_logic,"faction"] call MAINCLASS;

                        _playerID = getPlayerUID player;
                        _requestID = format["%1_%2",_faction,floor(time)];

                        _event = ['OPS_OPCOM_SELECT', [_requestID,_playerID,_selectedValue], "SCOM"] call ALIVE_fnc_event;

                        if(isServer) then {
                            [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;
                        }else{
                            [[_event],"ALIVE_fnc_addEventToServer",false,false] spawn BIS_fnc_MP;
                        };

                        // show waiting until response comes back

                        [_logic, "enableOpsWaiting"] call MAINCLASS;

                    };
                };

                case "OPS_GROUP_LIST_SELECT": {

                    private ["_commandState","_selectedList","_selectedIndex","_listOptions","_listValues","_selectedOption","_selectedValue","_map"];

                    // on click of the ops group list

                    _commandState = [_logic,"commandState"] call MAINCLASS;

                    _selectedList = _args select 0 select 0;
                    _selectedIndex = _args select 0 select 1;

                    if(_selectedIndex >= 0) then {

                        // store the selected item in the state

                        _listOptions = [_commandState,"opsGroupsOptions"] call ALIVE_fnc_hashGet;
                        _listValues = [_commandState,"opsGroupsValues"] call ALIVE_fnc_hashGet;
                        _selectedOption = _listOptions select _selectedIndex;
                        _selectedValue = _listValues select _selectedIndex;

                        [_commandState,"opsGroupsSelectedIndex",_selectedIndex] call ALIVE_fnc_hashSet;
                        [_commandState,"opsGroupsSelectedValue",_selectedValue] call ALIVE_fnc_hashSet;

                        [_logic,"commandState",_commandState] call MAINCLASS;

                        _commandState call ALIVE_fnc_inspectHash;

                        // move the map to the selected profile

                        _map = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_EditMap);

                        ctrlMapAnimClear _map;
                        _map ctrlMapAnimAdd [0.5, ctrlMapScale _map, _selectedValue select 1];
                        ctrlMapAnimCommit _map;

                        [_logic, "enableGroupSelected"] call MAINCLASS;

                    };
                };

                case "OP_EDIT_MAP_CLICK": {

                    // on right map click

                    private ["_button","_posX","_posY","_commandState","_map","_cursorPosition","_listOptions","_listValues","_position",
                    "_selectedIndex","_selectedOption","_selectedValue","_editList"];

                    _button = _args select 0 select 1;
                    _posX = _args select 0 select 2;
                    _posY = _args select 0 select 3;

                    if(_button == 0) then {

                        _commandState = [_logic,"commandState"] call MAINCLASS;

                        _map = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_EditMap);

                        // move the map

                        _cursorPosition = _map ctrlMapScreenToWorld [_posX, _posY];

                        ctrlMapAnimClear _map;
                        _map ctrlMapAnimAdd [0.5, ctrlMapScale _map, _cursorPosition];
                        ctrlMapAnimCommit _map;

                        // find a profile near where the map was clicked

                        _editList = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_EditList);

                        _listOptions = [_commandState,"opsGroupsOptions"] call ALIVE_fnc_hashGet;
                        _listValues = [_commandState,"opsGroupsValues"] call ALIVE_fnc_hashGet;

                        _selectedIndex = -1;

                        {
                            _position = _x select 1;
                            if(_cursorPosition distance2d _position < 30) then {
                                _selectedIndex = _forEachIndex;
                            };
                        } foreach _listValues;

                        // if profile found set the list to the selected profile

                        if(_selectedIndex > 0) then {

                            _editList lbSetCurSel _selectedIndex;

                            _selectedOption = _listOptions select _selectedIndex;
                            _selectedValue = _listValues select _selectedIndex;

                            [_commandState,"opsGroupsSelectedIndex",_selectedIndex] call ALIVE_fnc_hashSet;
                            [_commandState,"opsGroupsSelectedValue",_selectedValue] call ALIVE_fnc_hashSet;

                            [_logic,"commandState",_commandState] call MAINCLASS;

                            _commandState call ALIVE_fnc_inspectHash;

                        };

                    };

                };

                case "OPS_EDIT_WAYPOINTS": {

                    private ["_commandState","_selectedProfile","_profileID","_playerID","_requestID","_event","_faction","_buttonL1"];

                    // a group has been selected for waypoint editing

                    _commandState = [_logic,"commandState"] call MAINCLASS;

                    _selectedProfile = [_commandState,"opsGroupsSelectedValue"] call ALIVE_fnc_hashGet;

                    _profileID = _selectedProfile select 0;

                    _faction = [_logic,"faction"] call MAINCLASS;

                    _playerID = getPlayerUID player;
                    _requestID = format["%1_%2",_faction,floor(time)];

                    _buttonL1 = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_BL1);
                    _buttonL1 ctrlShow false;

                    // send the event to get further data from the command handler

                    _event = ['OPS_GET_PROFILE_WAYPOINTS', [_requestID,_playerID,_profileID], "SCOM"] call ALIVE_fnc_event;

                    if(isServer) then {
                        [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;
                    }else{
                        [[_event],"ALIVE_fnc_addEventToServer",false,false] spawn BIS_fnc_MP;
                    };

                    // show waiting until response comes back

                    [_logic, "enableOpsWaiting"] call MAINCLASS;

                };

                case "OP_EDIT_WAYPOINT_MAP_CLICK": {

                    // on click of edit map draw planned waypoint

                    private ["_commandState","_button","_posX","_posY","_map","_position","_groupWaypoints","_plannedWaypoints","_previousWaypoints",
                    "_arrowMarkers","_selectedProfile","_markerPos","_m","_waypointOptions","_waypoints","_newWaypointOption","_newWaypointValue",
                    "_waypointList"];

                    _button = _args select 0 select 1;
                    _posX = _args select 0 select 2;
                    _posY = _args select 0 select 3;

                    if(_button == 0) then {

                        _commandState = [_logic,"commandState"] call MAINCLASS;

                        _map = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_EditMap);

                        _position = _map ctrlMapScreenToWorld [_posX, _posY];

                        ctrlMapAnimClear _map;
                        _map ctrlMapAnimAdd [0.5, ctrlMapScale _map, _position];
                        ctrlMapAnimCommit _map;

                        _groupWaypoints = [_commandState,"opsGroupWaypoints"] call ALIVE_fnc_hashGet;
                        _plannedWaypoints = [_commandState,"opsGroupPlannedWaypoints"] call ALIVE_fnc_hashGet;
                        _previousWaypoints = [_commandState,"opsGroupPreviousWaypoints"] call ALIVE_fnc_hashGet;
                        _arrowMarkers = [_commandState,"opsGroupArrowMarkers"] call ALIVE_fnc_hashGet;
                        _selectedProfile = [_commandState,"opsGroupSelectedProfile"] call ALIVE_fnc_hashGet;

                        //-- Get info for line marker placement
                        if (count _groupWaypoints > 0) then {
                            if (count _plannedWaypoints == 0) then {
                                _markerPos = getMarkerPos (_groupWaypoints select (count _groupWaypoints - 1));
                            } else {
                                _markerPos = getMarkerPos ((_plannedWaypoints select (count _plannedWaypoints - 1))); //select 0);
                            };
                        } else {
                            if !(count _plannedWaypoints == 0) then {
                                _markerPos = getMarkerPos ((_plannedWaypoints select (count _plannedWaypoints - 1))); //select 0);
                            } else {
                                _markerPos = _selectedProfile select 2;
                            };
                        };

                        //-- Draw X marker
                        _m = createMarkerLocal [str _position, _position];
                        _m setMarkerSizeLocal [1.3,1.3];
                        _m setMarkerShapeLocal "ICON";
                        _m setMarkerTypeLocal "waypoint";
                        _m setMarkerColorLocal "ColorBlue";

                        _plannedWaypoints pushBack _m; //[_marker,STCWaypointType,STCWaypointSpeed,STCWaypointFormation,STCWaypointBehavior];

                        //-- Create line marker
                        _position params ["_1","_2"];
                        _position = [_1,_2,0];
                        _m = [str _markerPos, _markerPos, _position,20,"ColorGreen",.9] call ALIVE_fnc_createLineMarker;

                        _arrowMarkers pushBack _m;

                        // add to the waypoints array

                        _waypointOptions = [_commandState,"opsGroupWaypointsSelectedOptions"] call ALIVE_fnc_hashGet;
                        _waypoints = [_commandState,"opsGroupWaypointsSelectedValues"] call ALIVE_fnc_hashGet;

                        _newWaypointOption = format["Waypoint %1 [%2]",count(_waypoints),"MOVE"];
                        _newWaypointValue = [_position, 100] call ALIVE_fnc_createProfileWaypoint;

                        _newWaypointValue call ALIVE_fnc_inspectHash;

                        _waypointOptions pushBack _newWaypointOption;
                        _waypoints pushBack (_newWaypointValue select 2);

                        _waypointList = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_WaypointList);

                        _waypointList lbAdd _newWaypointOption;

                        // store updates in state

                        [_commandState,"opsGroupWaypointsSelectedOptions",_waypointOptions] call ALIVE_fnc_hashSet;
                        [_commandState,"opsGroupWaypointsSelectedValues",_waypoints] call ALIVE_fnc_hashSet;
                        [_commandState,"opsGroupPlannedWaypoints",_plannedWaypoints] call ALIVE_fnc_hashSet;
                        [_commandState,"opsGroupArrowMarkers",_arrowMarkers] call ALIVE_fnc_hashSet;
                        [_commandState,"opsGroupWaypointsPlanned",true] call ALIVE_fnc_hashSet;

                        _commandState call ALIVE_fnc_inspectHash;

                        [_logic,"commandState",_commandState] call MAINCLASS;

                        private["_backButton","_buttonR2","_buttonR3"];

                        _backButton = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_SubMenuBack);
                        _backButton ctrlShow false;

                        _buttonR2 = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_BR2);
                        _buttonR2 ctrlShow true;
                        _buttonR2 ctrlSetText "Clear Waypoint Changes";
                        _buttonR2 ctrlSetEventHandler ["MouseButtonClick", "['OPS_CANCEL_WAYPOINTS',[_this]] call ALIVE_fnc_SCOMTabletOnAction"];

                        _buttonR3 = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_BR3);
                        _buttonR3 ctrlShow true;
                        _buttonR3 ctrlSetText "Apply Waypoint Changes";
                        _buttonR3 ctrlSetEventHandler ["MouseButtonClick", "['OPS_APPLY_WAYPOINTS',[_this]] call ALIVE_fnc_SCOMTabletOnAction"];

                    };

                };

                case "OP_MAP_CLICK_NULL": {

                    // map click on reset
                    // do nothing

                };

                case "OPS_WAYPOINT_LIST_SELECT": {

                    private ["_commandState","_selectedList","_selectedIndex","_listOptions","_listValues","_selectedOption","_selectedValue","_map"];

                    // on click of the ops group list

                    _commandState = [_logic,"commandState"] call MAINCLASS;

                    _selectedList = _args select 0 select 0;
                    _selectedIndex = _args select 0 select 1;

                    if(_selectedIndex >= 0) then {

                        // store the selected item in the state

                        _listOptions = [_commandState,"opsGroupWaypointsSelectedOptions"] call ALIVE_fnc_hashGet;
                        _listValues = [_commandState,"opsGroupWaypointsSelectedValues"] call ALIVE_fnc_hashGet;
                        _selectedOption = _listOptions select _selectedIndex;
                        _selectedValue = _listValues select _selectedIndex;

                        [_commandState,"opsGroupWaypointsSelectedIndex",_selectedIndex] call ALIVE_fnc_hashSet;
                        [_commandState,"opsGroupWaypointsSelectedValue",_selectedValue] call ALIVE_fnc_hashSet;

                        [_logic,"commandState",_commandState] call MAINCLASS;

                        _commandState call ALIVE_fnc_inspectHash;

                        // move the map to the selected profile

                        _map = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_EditRight);

                        ctrlMapAnimClear _map;
                        _map ctrlMapAnimAdd [0.5, ctrlMapScale _map, _selectedValue select 0];
                        ctrlMapAnimCommit _map;

                        [_logic, "enableWaypointSelected"] call MAINCLASS;

                    };
                };

                case "OPS_WP_TYPE_LIST_SELECT": {

                    private ["_commandState","_selectedList","_selectedIndex","_listOptions","_listValues","_selectedOption","_selectedValue",
                    "_waypointSelectedIndex","_waypoints","_waypointSelected","_buttonR2","_buttonR3","_backButton"];

                    // on click of the ops group list

                    _commandState = [_logic,"commandState"] call MAINCLASS;

                    _selectedList = _args select 0 select 0;
                    _selectedIndex = _args select 0 select 1;

                    if(_selectedIndex >= 0) then {

                        // store the selected item in the state

                        _listOptions = [_commandState,"opsWPTypeOptions"] call ALIVE_fnc_hashGet;
                        _listValues = [_commandState,"opsWPTypeValues"] call ALIVE_fnc_hashGet;
                        _selectedOption = _listOptions select _selectedIndex;
                        _selectedValue = _listValues select _selectedIndex;

                        [_commandState,"opsWPTypeSelectedIndex",_selectedIndex] call ALIVE_fnc_hashSet;
                        [_commandState,"opsWPTypeSelectedValue",_selectedValue] call ALIVE_fnc_hashSet;

                        _commandState call ALIVE_fnc_inspectHash;

                        _waypointSelectedIndex = [_commandState,"opsGroupWaypointsSelectedIndex"] call ALIVE_fnc_hashGet;
                        _waypoints = [_commandState,"opsGroupWaypointsSelectedValues"] call ALIVE_fnc_hashGet;
                        _waypointSelected = _waypoints select _waypointSelectedIndex;

                        _waypointSelected set [2,_selectedValue];
                        _waypoints set [_waypointSelectedIndex,_waypointSelected];
                        [_commandState,"opsGroupWaypointsSelectedValues",_waypoints] call ALIVE_fnc_hashSet;

                        [_logic,"commandState",_commandState] call MAINCLASS;

                        _commandState call ALIVE_fnc_inspectHash;

                        _backButton = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_SubMenuBack);
                        _backButton ctrlShow false;

                        _buttonR2 = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_BR2);
                        _buttonR2 ctrlShow true;
                        _buttonR2 ctrlSetText "Clear Waypoint Changes";
                        _buttonR2 ctrlSetEventHandler ["MouseButtonClick", "['OPS_CANCEL_WAYPOINTS',[_this]] call ALIVE_fnc_SCOMTabletOnAction"];

                        _buttonR3 = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_BR3);
                        _buttonR3 ctrlShow true;
                        _buttonR3 ctrlSetText "Apply Waypoint Changes";
                        _buttonR3 ctrlSetEventHandler ["MouseButtonClick", "['OPS_APPLY_WAYPOINTS',[_this]] call ALIVE_fnc_SCOMTabletOnAction"];

                    };
                };

                case "OPS_WP_SPEED_LIST_SELECT": {

                    private ["_commandState","_selectedList","_selectedIndex","_listOptions","_listValues","_selectedOption","_selectedValue",
                    "_waypointSelectedIndex","_waypoints","_waypointSelected","_buttonR2","_buttonR3","_backButton"];

                    // on click of the ops group list

                    _commandState = [_logic,"commandState"] call MAINCLASS;

                    _selectedList = _args select 0 select 0;
                    _selectedIndex = _args select 0 select 1;

                    if(_selectedIndex >= 0) then {

                        // store the selected item in the state

                        _listOptions = [_commandState,"opsWPSpeedOptions"] call ALIVE_fnc_hashGet;
                        _listValues = [_commandState,"opsWPSpeedValues"] call ALIVE_fnc_hashGet;
                        _selectedOption = _listOptions select _selectedIndex;
                        _selectedValue = _listValues select _selectedIndex;

                        [_commandState,"opsWPSpeedSelectedIndex",_selectedIndex] call ALIVE_fnc_hashSet;
                        [_commandState,"opsWPSpeedSelectedValue",_selectedValue] call ALIVE_fnc_hashSet;

                        _commandState call ALIVE_fnc_inspectHash;

                        _waypointSelectedIndex = [_commandState,"opsGroupWaypointsSelectedIndex"] call ALIVE_fnc_hashGet;
                        _waypoints = [_commandState,"opsGroupWaypointsSelectedValues"] call ALIVE_fnc_hashGet;
                        _waypointSelected = _waypoints select _waypointSelectedIndex;

                        _waypointSelected set [3,_selectedValue];
                        _waypoints set [_waypointSelectedIndex,_waypointSelected];
                        [_commandState,"opsGroupWaypointsSelectedValues",_waypoints] call ALIVE_fnc_hashSet;

                        [_logic,"commandState",_commandState] call MAINCLASS;

                        _commandState call ALIVE_fnc_inspectHash;

                        _backButton = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_SubMenuBack);
                        _backButton ctrlShow false;

                        _buttonR2 = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_BR2);
                        _buttonR2 ctrlShow true;
                        _buttonR2 ctrlSetText "Clear Waypoint Changes";
                        _buttonR2 ctrlSetEventHandler ["MouseButtonClick", "['OPS_CANCEL_WAYPOINTS',[_this]] call ALIVE_fnc_SCOMTabletOnAction"];

                        _buttonR3 = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_BR3);
                        _buttonR3 ctrlShow true;
                        _buttonR3 ctrlSetText "Apply Waypoint Changes";
                        _buttonR3 ctrlSetEventHandler ["MouseButtonClick", "['OPS_APPLY_WAYPOINTS',[_this]] call ALIVE_fnc_SCOMTabletOnAction"];

                    };
                };

                case "OPS_WP_FORMATION_LIST_SELECT": {

                    private ["_commandState","_selectedList","_selectedIndex","_listOptions","_listValues","_selectedOption","_selectedValue",
                    "_waypointSelectedIndex","_waypoints","_waypointSelected","_buttonR2","_buttonR3","_backButton"];

                    // on click of the ops group list

                    _commandState = [_logic,"commandState"] call MAINCLASS;

                    _selectedList = _args select 0 select 0;
                    _selectedIndex = _args select 0 select 1;

                    if(_selectedIndex >= 0) then {

                        // store the selected item in the state

                        _listOptions = [_commandState,"opsWPFormationOptions"] call ALIVE_fnc_hashGet;
                        _listValues = [_commandState,"opsWPFormationValues"] call ALIVE_fnc_hashGet;
                        _selectedOption = _listOptions select _selectedIndex;
                        _selectedValue = _listValues select _selectedIndex;

                        [_commandState,"opsWPFormationSelectedIndex",_selectedIndex] call ALIVE_fnc_hashSet;
                        [_commandState,"opsWPFormationSelectedValue",_selectedValue] call ALIVE_fnc_hashSet;

                        _commandState call ALIVE_fnc_inspectHash;

                        _waypointSelectedIndex = [_commandState,"opsGroupWaypointsSelectedIndex"] call ALIVE_fnc_hashGet;
                        _waypoints = [_commandState,"opsGroupWaypointsSelectedValues"] call ALIVE_fnc_hashGet;
                        _waypointSelected = _waypoints select _waypointSelectedIndex;

                        _waypointSelected set [6,_selectedValue];
                        _waypoints set [_waypointSelectedIndex,_waypointSelected];
                        [_commandState,"opsGroupWaypointsSelectedValues",_waypoints] call ALIVE_fnc_hashSet;

                        [_logic,"commandState",_commandState] call MAINCLASS;

                        _commandState call ALIVE_fnc_inspectHash;

                        _backButton = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_SubMenuBack);
                        _backButton ctrlShow false;

                        _buttonR2 = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_BR2);
                        _buttonR2 ctrlShow true;
                        _buttonR2 ctrlSetText "Clear Waypoint Changes";
                        _buttonR2 ctrlSetEventHandler ["MouseButtonClick", "['OPS_CANCEL_WAYPOINTS',[_this]] call ALIVE_fnc_SCOMTabletOnAction"];

                        _buttonR3 = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_BR3);
                        _buttonR3 ctrlShow true;
                        _buttonR3 ctrlSetText "Apply Waypoint Changes";
                        _buttonR3 ctrlSetEventHandler ["MouseButtonClick", "['OPS_APPLY_WAYPOINTS',[_this]] call ALIVE_fnc_SCOMTabletOnAction"];

                    };
                };

                case "OPS_WP_BEHAVIOUR_LIST_SELECT": {

                    private ["_commandState","_selectedList","_selectedIndex","_listOptions","_listValues","_selectedOption","_selectedValue",
                    "_waypointSelectedIndex","_waypoints","_waypointSelected","_buttonR2","_buttonR3","_backButton"];

                    // on click of the ops group list

                    _commandState = [_logic,"commandState"] call MAINCLASS;

                    _selectedList = _args select 0 select 0;
                    _selectedIndex = _args select 0 select 1;

                    if(_selectedIndex >= 0) then {

                        // store the selected item in the state

                        _listOptions = [_commandState,"opsWPBehaviourOptions"] call ALIVE_fnc_hashGet;
                        _listValues = [_commandState,"opsWPBehaviourValues"] call ALIVE_fnc_hashGet;
                        _selectedOption = _listOptions select _selectedIndex;
                        _selectedValue = _listValues select _selectedIndex;

                        [_commandState,"opsWPBehaviourSelectedIndex",_selectedIndex] call ALIVE_fnc_hashSet;
                        [_commandState,"opsWPBehaviourSelectedValue",_selectedValue] call ALIVE_fnc_hashSet;

                        _commandState call ALIVE_fnc_inspectHash;

                        _waypointSelectedIndex = [_commandState,"opsGroupWaypointsSelectedIndex"] call ALIVE_fnc_hashGet;
                        _waypoints = [_commandState,"opsGroupWaypointsSelectedValues"] call ALIVE_fnc_hashGet;
                        _waypointSelected = _waypoints select _waypointSelectedIndex;

                        _waypointSelected set [8,_selectedValue];
                        _waypoints set [_waypointSelectedIndex,_waypointSelected];
                        [_commandState,"opsGroupWaypointsSelectedValues",_waypoints] call ALIVE_fnc_hashSet;

                        [_logic,"commandState",_commandState] call MAINCLASS;

                        _commandState call ALIVE_fnc_inspectHash;

                        _backButton = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_SubMenuBack);
                        _backButton ctrlShow false;

                        _buttonR2 = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_BR2);
                        _buttonR2 ctrlShow true;
                        _buttonR2 ctrlSetText "Clear Waypoint Changes";
                        _buttonR2 ctrlSetEventHandler ["MouseButtonClick", "['OPS_CANCEL_WAYPOINTS',[_this]] call ALIVE_fnc_SCOMTabletOnAction"];

                        _buttonR3 = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_BR3);
                        _buttonR3 ctrlShow true;
                        _buttonR3 ctrlSetText "Apply Waypoint Changes";
                        _buttonR3 ctrlSetEventHandler ["MouseButtonClick", "['OPS_APPLY_WAYPOINTS',[_this]] call ALIVE_fnc_SCOMTabletOnAction"];

                    };
                };

                case "OPS_CLEAR_WAYPOINTS": {

                    private ["_commandState","_selectedProfile","_profileID","_playerID","_requestID","_event","_faction"];

                    // a group has been selected for waypoint editing

                    _commandState = [_logic,"commandState"] call MAINCLASS;

                    _selectedProfile = [_commandState,"opsGroupsSelectedValue"] call ALIVE_fnc_hashGet;

                    _profileID = _selectedProfile select 0;

                    _faction = [_logic,"faction"] call MAINCLASS;

                    _playerID = getPlayerUID player;
                    _requestID = format["%1_%2",_faction,floor(time)];

                    // send the event to get further data from the command handler

                    _event = ['OPS_CLEAR_PROFILE_WAYPOINTS', [_requestID,_playerID,_profileID], "SCOM"] call ALIVE_fnc_event;

                    if(isServer) then {
                        [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;
                    }else{
                        [[_event],"ALIVE_fnc_addEventToServer",false,false] spawn BIS_fnc_MP;
                    };

                    // show waiting until response comes back

                    [_logic, "enableOpsWaiting"] call MAINCLASS;

                };

                case "OPS_CANCEL_WAYPOINTS": {

                    private ["_commandState","_plannedWaypoints","_arrowMarkers","_countPlanned","_countArrows","_diffCount","_newArrowMarkers",
                    "_selectedProfile","_profileID","_event","_requestID","_playerID"];

                    // cancel any planned waypoints

                    _commandState = [_logic,"commandState"] call MAINCLASS;

                    _plannedWaypoints = [_commandState,"opsGroupPlannedWaypoints"] call ALIVE_fnc_hashGet;
                    _arrowMarkers = [_commandState,"opsGroupArrowMarkers"] call ALIVE_fnc_hashGet;

                    _countPlanned = count(_plannedWaypoints);
                    _countArrows = count(_arrowMarkers);
                    _diffCount = _countArrows - _countPlanned;

                    {
                        deleteMarkerLocal _x;
                    } foreach _plannedWaypoints;

                    _newArrowMarkers = [];

                    {
                        if(_forEachIndex < _diffCount) then {
                            _newArrowMarkers pushBack _x;
                        }else{
                            deleteMarkerLocal _x;
                        }

                    } foreach _arrowMarkers;

                    for "_i" from _diffCount to _countArrows do {
                        deleteMarkerLocal (_arrowMarkers select _i);
                    };

                    // store updates in state

                    [_commandState,"opsGroupPlannedWaypoints",[]] call ALIVE_fnc_hashSet;
                    [_commandState,"opsGroupArrowMarkers",_newArrowMarkers] call ALIVE_fnc_hashSet;

                    [_logic,"commandState",_commandState] call MAINCLASS;

                    // send the event to get further data from the command handler\

                    _selectedProfile = [_commandState,"opsGroupsSelectedValue"] call ALIVE_fnc_hashGet;

                    _profileID = _selectedProfile select 0;

                    _faction = [_logic,"faction"] call MAINCLASS;

                    _playerID = getPlayerUID player;
                    _requestID = format["%1_%2",_faction,floor(time)];

                    _event = ['OPS_GET_PROFILE_WAYPOINTS', [_requestID,_playerID,_profileID], "SCOM"] call ALIVE_fnc_event;

                    if(isServer) then {
                        [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;
                    }else{
                        [[_event],"ALIVE_fnc_addEventToServer",false,false] spawn BIS_fnc_MP;
                    };

                    // show waiting until response comes back

                    [_logic, "enableOpsWaiting"] call MAINCLASS;

                };

                case "OPS_APPLY_WAYPOINTS": {

                    private ["_commandState","_selectedProfile","_waypoints",
                    "_profileID","_playerID","_requestID","_event","_faction","_buttonL2","_buttonR1","_backButton"];

                    // a group has been selected for waypoint editing

                    _commandState = [_logic,"commandState"] call MAINCLASS;

                    _selectedProfile = [_commandState,"opsGroupsSelectedValue"] call ALIVE_fnc_hashGet;
                    _waypoints = [_commandState,"opsGroupWaypointsSelectedValues"] call ALIVE_fnc_hashGet;

                    _profileID = _selectedProfile select 0;

                    _faction = [_logic,"faction"] call MAINCLASS;

                    _playerID = getPlayerUID player;
                    _requestID = format["%1_%2",_faction,floor(time)];

                    // send the event to get further data from the command handler

                    _event = ['OPS_APPLY_PROFILE_WAYPOINTS', [_requestID,_playerID,_profileID,_waypoints], "SCOM"] call ALIVE_fnc_event;

                    if(isServer) then {
                        [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;
                    }else{
                        [[_event],"ALIVE_fnc_addEventToServer",false,false] spawn BIS_fnc_MP;
                    };

                    // hide editing buttons

                    _backButton = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_SubMenuBack);
                    _backButton ctrlShow true;

                    _buttonR2 = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_BR2);
                    _buttonR2 ctrlShow false;

                    _buttonR1 = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_BR1);
                    _buttonR1 ctrlShow false;


                    // show waiting until response comes back

                    [_logic, "enableOpsWaiting"] call MAINCLASS;

                };

                case "OPS_RESET": {

                    [_logic,"enableOpsInterface"] call MAINCLASS;
                };


            };
        };
    };

    // INTEL ------------------------------------------------------------------------------------------------------------------------------

    case "enableIntelWaiting": {

        private ["_status","_intelTypeList"];

        // show waiting text and disable selection lists for intel

        _status = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_IntelStatus);
        _status ctrlShow true;

        _status ctrlSetText "Waiting...";

        _intelTypeList = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_IntelTypeList);
        _intelTypeList ctrlShow false;

    };

    case "enableIntelInterface": {

        private ["_title","_backButton","_abortButton","_mainMap","_mainList","_intelTypeTitle","_intelTypeList","_editList",
        "_editMap","_rightMap","_buttonL1","_buttonL2","_buttonL3","_buttonR1","_buttonR2","_buttonR3","_markers","_waypointList",
        "_waypointTypeList","_waypointSpeedList","_waypointFormationList"];

        // prepare the interface elements for the intel interface

        _title = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_Title);
        _title ctrlShow true;

        _title ctrlSetText "Intel";

        _abortButton = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_SubMenuAbort);
        _abortButton ctrlShow true;

        _mainMap = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_MainMap);
        _mainMap ctrlShow true;

        _intelTypeTitle = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_IntelTypeTitle);
        _intelTypeTitle ctrlShow true;

        _intelTypeList = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_IntelTypeList);
        _intelTypeList ctrlShow true;


        _editMap = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_EditMap);
        _editMap ctrlShow false;

        _mainList = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_MainList);
        _mainList ctrlShow false;

        _backButton = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_SubMenuBack);
        _backButton ctrlShow false;

        _editList = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_EditList);
        _editList ctrlShow false;

        _waypointList = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_WaypointList);
        _waypointList ctrlShow false;

        _waypointTypeList = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_WaypointTypeList);
        _waypointTypeList ctrlShow false;

        _waypointSpeedList = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_WaypointSpeedList);
        _waypointSpeedList ctrlShow false;

        _waypointFormationList = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_WaypointFormationList);
        _waypointFormationList ctrlShow false;

        _waypointBehaviourList = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_WaypointBehavourList);
        _waypointBehaviourList ctrlShow false;

        _rightMap = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_MapRight);
        _rightMap ctrlShow false;

        _buttonL1 = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_BL1);
        _buttonL1 ctrlShow false;

        _buttonL2 = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_BL2);
        _buttonL2 ctrlShow false;

        _buttonL3 = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_BL3);
        _buttonL3 ctrlShow false;

        _buttonR1 = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_BR1);
        _buttonR1 ctrlShow false;

        _buttonR2 = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_BR2);
        _buttonR2 ctrlShow false;

        _buttonR3 = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_BR3);
        _buttonR3 ctrlShow false;

        // clear markers

        _markers = [_logic,"marker"] call MAINCLASS;

        {
            deleteMarkerLocal _x;
        } foreach _markers;

        // call reset

        [_logic,"resetIntel"] call MAINCLASS;

    };

    case "resetIntel": {

        private ["_commandState","_status","_intelTypeTitle","_intelTypeList","_intelTypeListOptions"];

        // display the intel type selection list to begin with

        _commandState = [_logic,"commandState"] call MAINCLASS;

        // hide the loading status text

        _status = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_IntelStatus);
        _status ctrlShow false;

        _status ctrlSetText "";

        _intelTypeTitle = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_IntelTypeTitle);
        _intelTypeTitle ctrlShow true;

        _intelTypeTitle ctrlSetText "Intel Type";

        _intelTypeList = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_IntelTypeList);

        _intelTypeListOptions = [_commandState,"intelTypeOptions"] call ALIVE_fnc_hashGet;

        lbClear _intelTypeList;

        {
            _intelTypeList lbAdd format["%1", _x];
        } forEach _intelTypeListOptions;

        // set the event handler for the list selection event

        _intelTypeList ctrlSetEventHandler ["LBSelChanged", "['INTEL_TYPE_LIST_SELECT',[_this]] call ALIVE_fnc_SCOMTabletOnAction"];

    };

    case "enableIntelOPCOMSelect": {

        private["_back","_commandState","_status","_opcomData","_status","_intelTypeTitle","_intelTypeList","_intelTypeListOptions"];

        // once the user has selected the OPCOM state analysis
        // display the available OPCOM sides

        // display the reset button so the user can restart

        _back = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_SubMenuBack);
        _back ctrlShow true;

        _back ctrlSetEventHandler ["MouseButtonClick", "['INTEL_RESET',[_this]] call ALIVE_fnc_SCOMTabletOnAction"];

        if(typeName _args == "ARRAY") then {

            _commandState = [_logic,"commandState"] call MAINCLASS;

            // hide the loading status text

            _status = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_IntelStatus);
            _status ctrlShow false;

            _status ctrlSetText "";

            _opcomData = _args select 1;

            if(count(_opcomData) > 0) then {

                // display the opcom type selection list

                _opcomOptions = [];

                {
                    _sideDisplay = [_x] call ALIVE_fnc_sideTextToLong;
                    _opcomOptions pushBack format["%1 Commander",_sideDisplay];
                } foreach _opcomData;

                [_commandState,"intelOPCOMOptions",_opcomOptions] call ALIVE_fnc_hashSet;
                [_commandState,"intelOPCOMValues",_opcomData] call ALIVE_fnc_hashSet;

                [_logic,"commandState",_commandState] call MAINCLASS;

                _intelTypeTitle = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_IntelTypeTitle);
                _intelTypeTitle ctrlShow true;

                _intelTypeTitle ctrlSetText "Select Commander to display";

                _intelTypeList = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_IntelTypeList);
                _intelTypeList ctrlShow true;

                _intelTypeList lbSetCurSel -1;

                lbClear _intelTypeList;

                {
                    _intelTypeList lbAdd format["%1", _x];
                } forEach _opcomOptions;

                // set the event handler for the list selection event

                _intelTypeList ctrlSetEventHandler ["LBSelChanged", "['INTEL_OPCOM_LIST_SELECT',[_this]] call ALIVE_fnc_SCOMTabletOnAction"];

            }else{

                _status = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_IntelStatus);
                _status ctrlShow true;

                _status ctrlSetText "No OPCOM instances found";

            };

        };

    };

    case "enableIntelUnitMarking": {

        private["_back","_commandState","_profileData","_markers","_m","_intelTypeTitle","_status","_intelLimit","_side","_faction","_leaderSide","_leaderFaction","_display"];

        // perform unit marking display

        // display the reset button so the user can restart

        _back = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_SubMenuBack);
        _back ctrlShow true;

        _back ctrlSetEventHandler ["MouseButtonClick", "['INTEL_RESET',[_this]] call ALIVE_fnc_SCOMTabletOnAction"];

        if(typeName _args == "ARRAY") then {

            // hide the selection list title

            _intelTypeTitle = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_IntelTypeTitle);
            _intelTypeTitle ctrlShow false;

            // hide the loading status text

            _status = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_IntelStatus);
            _status ctrlShow false;

            _commandState = [_logic,"commandState"] call MAINCLASS;

            _intelLimit = [_logic,"intelLimit"] call MAINCLASS;
            _side = [_logic,"side"] call MAINCLASS;
            _faction = [_logic,"faction"] call MAINCLASS;

            _profileData = _args select 1;
            _markers = [];

            // display the markers for inactive profiles

            {

                _m = createMarkerLocal [format[MTEMPLATE, format["%1_inactive", _forEachIndex]], _x select 0];
                _m setMarkerTypeLocal "o_unknown";
                _m setMarkerShapeLocal "ICON";
                _m setMarkerSizeLocal [.8, .8];
                _m setMarkerBrushLocal "Solid";

                switch (_x select 1) do {
                    case "WEST": {
                        _m setMarkerTypeLocal "b_unknown";
                        _m setMarkerColorLocal "ColorBLUFOR";
                    };
                    case "EAST": {
                        _m setMarkerTypeLocal "o_unknown";
                        _m setMarkerColorLocal "ColorOPFOR";
                    };
                    case "GUER": {
                        _m setMarkerTypeLocal "n_unknown";
                        _m setMarkerColorLocal "ColorIndependent";
                    };
                };

                _markers = _markers + [_m];

            } foreach _profileData;

            // display the markers for spawned groups

            {
                _leaderSide = str(side (leader _x));
                _leaderFaction = faction (leader _x);
                _display = false;

                switch(_intelLimit) do {
                    case "SIDE": {
                        if(_side == _leaderSide) then {
                            _display = true;
                        };
                    };
                    case "FACTION": {
                        if(_faction == _leaderFaction) then {
                            _display = true;
                        };
                    };
                    case "ALL": {
                        _display = true;
                    };
                };

            	if (_display) then {

            		_m = createMarkerLocal [format[MTEMPLATE, format["%1_active", _forEachIndex]], position (leader _x)];
            		_m setMarkerSizeLocal [.7,.7];

            		switch (_leaderSide) do {
            			case "WEST": {
            				_m setMarkerTypeLocal "b_unknown";
            				_m setMarkerColorLocal "ColorBLUFOR";
            			};
            			case "EAST": {
            				_m setMarkerTypeLocal "o_unknown";
            				_m setMarkerColorLocal "ColorOPFOR";
            			};
            			case "GUER": {
            				_m setMarkerTypeLocal "x_unknown";
            				_m setMarkerColorLocal "ColorIndependent";
            			};
            		};
            	};

            	_markers = _markers + [_m];

            } forEach allGroups;

            // store the marker state for clearing later

            [_logic,"marker",_markers] call MAINCLASS;

        };

    };

    case "enableIntelOPCOMObjectives": {

        private["_commandState","_opcomData","_status","_intelTypeTitle","_intelTypeList","_intelTypeListOptions"];

        // preform OPCOM objective display

        if(typeName _args == "ARRAY") then {

            _commandState = [_logic,"commandState"] call MAINCLASS;

            _opcomData = _args select 1;

            if(count(_opcomData) > 0) then {

                // hide the selection list title

                _intelTypeTitle = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_IntelTypeTitle);
                _intelTypeTitle ctrlShow false;

                // hide the loading status text

                _status = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_IntelStatus);
                _status ctrlShow false;


                //_opcomData call ALIVE_fnc_inspectArray;

                _opcomSide = [_commandState,"intelOPCOMSelectedValue"] call ALIVE_fnc_hashGet;

                private ["_center","_size","_tacom_state","_opcom_state","_sections","_objectiveID","_alpha","_markers","_marker","_color","_dir","_position","_icon","_text","_m","_profileMarker","_opcomColor"];

                _color = "ColorYellow";
                _profileMarker = "b_unknown";

                _markers = [];

                // set the side color
                switch(_opcomSide) do {
                    case "EAST":{
                        _color = "ColorOPFOR";
                        _profileMarker = "o_unknown";
                    };
                    case "WEST":{
                        _color = "ColorBLUFOR";
                        _profileMarker = "b_unknown";
                    };
                    case "CIV":{
                        _color = "ColorYellow";
                        _profileMarker = "b_unknown";
                    };
                    case "GUER":{
                        _color = "ColorIndependent";
                        _profileMarker = "n_unknown";
                    };
                    default {
                        _color = "ColorYellow";
                    };
                };

                {
                    _size = _x select 0;
                    _center = _x select 1;
                    _tacom_state = _x select 2;
                    _opcom_state = _x select 3;
                    _sections = _x select 4;

                    _opcomColor = "ColorWhite";

                    //-- Orders
                    switch (_opcom_state) do {
                        case "unassigned": {
                            _opcomColor = "ColorWhite"
                        };
                        case "idle": {
                            _opcomColor = "ColorYellow"
                        };
                        case "reserve": {
                            _opcomColor = "ColorGreen"
                        };
                        case "defend": {
                            _opcomColor = "ColorBlue"
                        };
                        case "attack": {
                            _opcomColor = "ColorRed"
                        };
                        default {
                            _opcomColor = "ColorWhite"
                        };
                    };

                    _alpha = 1;

                    // create the objective area marker
                    _m = createMarkerLocal [format[MTEMPLATE, _forEachIndex], _center];
                    _m setMarkerShapeLocal "Ellipse";
                    _m setMarkerBrushLocal "FDiagonal";
                    _m setMarkerSizeLocal [_size, _size];
                    _m setMarkerColorLocal _opcomColor;
                    _m setMarkerAlphaLocal _alpha;

                    _markers = _markers + [_m];

                    _icon = "EMPTY";
                    _text = "";

                    _objectiveID = _forEachIndex;

                    // create the profile marker
                    {
                        _position = _x select 0;
                        _dir = _x select 1;

                        // create section marker
                        _m = createMarkerLocal [format[MTEMPLATE, format["%1%2_profile", _objectiveID, _forEachIndex]], _position];
                        _m setMarkerShapeLocal "ICON";
                        _m setMarkerSizeLocal [0.5,0.5];
                        _m setMarkerTypeLocal _profileMarker;
                        _m setMarkerColorLocal _color;
                        _m setMarkerAlphaLocal _alpha;

                        _markers = _markers + [_m];

                        if!(isNil "_tacom_state") then {
                            switch(_tacom_state) do {
                                case "recon":{

                                    // create direction marker
                                    _m = createMarkerLocal [format[MTEMPLATE, format["%1%2_dir", _objectiveID, _forEachIndex]], [_position, 100, _dir] call BIS_fnc_relPos];
                                    _m setMarkerShapeLocal "ICON";
                                    _m setMarkerSizeLocal [0.5,0.5];
                                    _m setMarkerTypeLocal "mil_arrow";
                                    _m setMarkerColorLocal _color;
                                    _m setMarkerAlphaLocal _alpha;
                                    _m setMarkerDirLocal _dir;

                                    _markers = _markers + [_m];

                                };
                                case "capture":{

                                    // create direction marker
                                    _m = createMarkerLocal [format[MTEMPLATE, format["%1%2_dir", _objectiveID, _forEachIndex]], [_position, 100, _dir] call BIS_fnc_relPos];
                                    _m setMarkerShapeLocal "ICON";
                                    _m setMarkerSizeLocal [0.5,0.5];
                                    _m setMarkerTypeLocal "mil_arrow2";
                                    _m setMarkerColorLocal _color;
                                    _m setMarkerAlphaLocal _alpha;
                                    _m setMarkerDirLocal _dir;

                                    _markers = _markers + [_m];

                                };
                            };
                        };

                    } forEach _sections;

                    if!(isNil "_tacom_state") then {
                        switch(_tacom_state) do {
                            case "reserve":{
                                _icon = "mil_marker";
                                _text = " occupied";
                            };
                            case "defend":{
                                _icon = "mil_marker";
                                _text = " occupied";
                            };
                            case "recon":{
                                _icon = "EMPTY";
                                _text = " sighting";
                            };
                            case "capture":{
                                _icon = "mil_warning";
                                _text = " captured";
                            };
                        };
                    };

                    // create type marker
                    _m = createMarkerLocal [format[MTEMPLATE, format["%1_type", _objectiveID]], _center];
                    _m setMarkerShapeLocal "ICON";
                    _m setMarkerSizeLocal [0.5, 0.5];
                    _m setMarkerTypeLocal _icon;
                    _m setMarkerColorLocal _color;
                    _m setMarkerAlphaLocal _alpha;
                    _m setMarkerTextLocal _text;

                    _markers = _markers + [_m];

                } forEach _opcomData;

                // store the marker state for clearing later

                [_logic,"marker",_markers] call MAINCLASS;


            }else{

                _status = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_IntelStatus);
                _status ctrlShow true;

                _status ctrlSetText "No OPCOM instances found";

            };
        };
    };


    // OPS ------------------------------------------------------------------------------------------------------------------------------


    case "enableOpsWaiting": {

        private ["_status"];

        // show waiting text and disable selection lists for ops

        _status = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_IntelStatus);
        _status ctrlShow true;

        _status ctrlSetText "Waiting...";

    };

    case "enableOpsInterface": {

        private ["_title","_backButton","_abortButton","_mainList","_editMap","_mainMap","_leftMap",
        "_intelTypeTitle","_intelTypeList","_buttonL1","_buttonL2","_buttonL3","_buttonR1","_buttonR2","_buttonR3",
        "_editList","_editMap","_waypointList","_waypointTypeList","_waypointSpeedList","_waypointFormationList","_waypointBehaviourList"];

        // prepare the interface elements for the ops interface

        _title = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_Title);
        _title ctrlShow true;

        _title ctrlSetText "Operations";

        _abortButton = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_SubMenuAbort);
        _abortButton ctrlShow true;

        _editList = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_EditList);
        _editList ctrlShow true;

        _editMap = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_EditMap);
        _editMap ctrlShow true;

        _editMap ctrlSetEventHandler ["MouseButtonDown", "['OP_MAP_CLICK_NULL',[_this]] call ALIVE_fnc_SCOMTabletOnAction"];


        _rightMap = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_MapRight);
        _rightMap ctrlShow false;

        _backButton = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_SubMenuBack);
        _backButton ctrlShow false;

        _mainList = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_MainList);
        _mainList ctrlShow false;

        _waypointList = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_WaypointList);
        _waypointList ctrlShow false;

        _waypointTypeList = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_WaypointTypeList);
        _waypointTypeList ctrlShow false;

        _waypointSpeedList = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_WaypointSpeedList);
        _waypointSpeedList ctrlShow false;

        _waypointFormationList = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_WaypointFormationList);
        _waypointFormationList ctrlShow false;

        _waypointBehaviourList = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_WaypointBehavourList);
        _waypointBehaviourList ctrlShow false;

        _mainMap = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_MainMap);
        _mainMap ctrlShow false;

        _intelTypeTitle = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_IntelTypeTitle);
        _intelTypeTitle ctrlShow false;

        _intelTypeList = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_IntelTypeList);
        _intelTypeList ctrlShow false;

        _buttonL1 = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_BL1);
        _buttonL1 ctrlShow false;

        _buttonL2 = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_BL2);
        _buttonL2 ctrlShow false;

        _buttonL3 = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_BL3);
        _buttonL3 ctrlShow false;

        _buttonR1 = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_BR1);
        _buttonR1 ctrlShow false;

        _buttonR2 = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_BR2);
        _buttonR2 ctrlShow false;

        _buttonR3 = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_BR3);
        _buttonR3 ctrlShow false;

        // clear markers

        _markers = [_logic,"marker"] call MAINCLASS;

        {
            deleteMarkerLocal _x;
        } foreach _markers;

        // call reset

        [_logic,"resetOps"] call MAINCLASS;

    };

    case "resetOps": {

        private ["_commandState","_playerID","_requestID","_opsLimit","_side","_faction","_event","_editList",
        "_groupWaypoints","_arrowMarkers","_plannedWaypoints"];

        // display the ops opcom side selection list to begin with

        _commandState = [_logic,"commandState"] call MAINCLASS;
        _opsLimit = [_logic,"opsLimit"] call MAINCLASS;
        _side = [_logic,"side"] call MAINCLASS;
        _faction = [_logic,"faction"] call MAINCLASS;

        _commandState call ALIVE_fnc_inspectHash;

        _playerID = getPlayerUID player;
        _requestID = format["%1_%2",_faction,floor(time)];

        // clear any markers

        _groupWaypoints = [_commandState,"opsGroupWaypoints"] call ALIVE_fnc_hashGet;
        _arrowMarkers = [_commandState,"opsGroupArrowMarkers"] call ALIVE_fnc_hashGet;
        _plannedWaypoints = [_commandState,"opsGroupPlannedWaypoints"] call ALIVE_fnc_hashGet;

        {
            deleteMarkerLocal _x
        } forEach _groupWaypoints;

        {
            deleteMarkerLocal _x
        } forEach _arrowMarkers;

        {
            deleteMarkerLocal _x
        } forEach _plannedWaypoints;

        // reset the waypoint data

        [_commandState,"opsGroupSelectedProfile",[]] call ALIVE_fnc_hashSet;
        [_commandState,"opsGroupWaypoints",[]] call ALIVE_fnc_hashSet;
        [_commandState,"opsGroupPlannedWaypoints",[]] call ALIVE_fnc_hashSet;
        [_commandState,"opsGroupPreviousWaypoints",[]] call ALIVE_fnc_hashSet;
        [_commandState,"opsGroupArrowMarkers",[]] call ALIVE_fnc_hashSet;
        [_commandState,"opsGroupWaypointsPlanned",false] call ALIVE_fnc_hashSet;

        [_logic,"commandState",_commandState] call MAINCLASS;

        // clear the group list

        _editList = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_EditList);

        lbClear _editList;

        _editList lbSetCurSel 0;

        // send the event to get further data from the command handler

        _event = ['OPS_DATA_PREPARE', [_requestID,_playerID,_opsLimit,_side,_faction], "SCOM"] call ALIVE_fnc_event;

        if(isServer) then {
            [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;
        }else{
            [[_event],"ALIVE_fnc_addEventToServer",false,false] spawn BIS_fnc_MP;
        };

        // show waiting until response comes back

        [_logic, "enableOpsWaiting"] call MAINCLASS;

    };

    case "enableOpsOPCOMSelect": {

        private["_back","_commandState","_status","_opcomData","_status","_opsTypeTitle","_opsTypeList","_opcomOptions","_sideDisplay"];

        // once the list of opcom instances has been loaded
        // display the available OPCOM sides

        // display the reset button so the user can restart

        _back = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_SubMenuBack);
        _back ctrlShow true;

        _back ctrlSetEventHandler ["MouseButtonClick", "['OPS_RESET',[_this]] call ALIVE_fnc_SCOMTabletOnAction"];

        if(typeName _args == "ARRAY") then {

            _commandState = [_logic,"commandState"] call MAINCLASS;

            // hide the loading status text

            _status = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_IntelStatus);
            _status ctrlShow false;

            _status ctrlSetText "";

            _opcomData = _args select 1;

            _opcomData call ALIVE_fnc_inspectArray;

            if(count(_opcomData) > 0) then {

                // display the opcom type selection list

                _opcomOptions = [];

                {
                    _sideDisplay = [_x] call ALIVE_fnc_sideTextToLong;
                    _opcomOptions pushBack format["%1 Commander",_sideDisplay];
                } foreach _opcomData;

                [_commandState,"opsOPCOMOptions",_opcomOptions] call ALIVE_fnc_hashSet;
                [_commandState,"opsOPCOMValues",_opcomData] call ALIVE_fnc_hashSet;

                [_logic,"commandState",_commandState] call MAINCLASS;

                _opsTypeTitle = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_IntelTypeTitle);
                _opsTypeTitle ctrlShow true;

                _opsTypeTitle ctrlSetText "Select Commander to use";

                _opsTypeList = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_IntelTypeList);
                _opsTypeList ctrlShow true;

                _opsTypeList lbSetCurSel -1;

                lbClear _opsTypeList;

                {
                    _opsTypeList lbAdd format["%1", _x];
                } forEach _opcomOptions;

                // set the event handler for the list selection event

                _opsTypeList ctrlSetEventHandler ["LBSelChanged", "['OPS_OPCOM_LIST_SELECT',[_this]] call ALIVE_fnc_SCOMTabletOnAction"];

            }else{

                _status = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_IntelStatus);
                _status ctrlShow true;

                _status ctrlSetText "No OPCOM instances found";

            };

        };

    };

    case "enableOpsHighCommand": {

        private ["_commandState","_status","_selectedSide","_groupData","_combinedData","_opsGroupsBySide","_editList","_options","_values",
        "_opsTypeTitle","_opsTypeList","_rightMap","_mainMap","_profileID","_position","_label","_typePrefix"];

        // populate group list and map markers

        if(typeName _args == "ARRAY") then {

            _commandState = [_logic,"commandState"] call MAINCLASS;

            _status = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_IntelStatus);
            _status ctrlShow false;

            _status ctrlSetText "";

            _selectedSide = _args select 1;
            _groupData = _args select 2;

            if(count(_groupData) > 0) then {

                // clear the ops type selection list and title

                _opsTypeTitle = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_IntelTypeTitle);
                _opsTypeTitle ctrlShow false;

                _opsTypeTitle ctrlSetText "";

                _opsTypeList = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_IntelTypeList);
                _opsTypeList ctrlShow false;

                _opsTypeList lbSetCurSel -1;

                lbClear _opsTypeList;

                // store a combined array of all profiles to state

                _combinedData = [];
                for "_i" from 0 to ((count _groupData) - 1) do {
                    _profileArray = _groupData select _i;

                    {
                        _combinedData pushBack _x;
                    } forEach _profileArray;
                };

                _opsGroupsBySide = [_commandState,"opsGroupsBySide"] call ALIVE_fnc_hashGet;
                [_opsGroupsBySide, _selectedSide, _combinedData] call ALIVE_fnc_hashSet;

                // set list items by category type

                _groupData params ["_infantry","_motorised","_mechanized","_armor","_air","_sea","_artillery","_AAA"];

                _editList = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_EditList);

                lbClear _editList;

                _editList lbSetCurSel 0;

                _infantry call ALIVE_fnc_inspectArray;

                _options = [];
                _values = [];

                _color = "ColorYellow";
                _typePrefix = "n";
                _alpha = 0.7;

                _markers = [];

                // set the side color
                switch(_selectedSide) do {
                    case "EAST":{
                        _color = "ColorOPFOR";
                        _typePrefix = "o";
                    };
                    case "WEST":{
                        _color = "ColorBLUFOR";
                        _typePrefix = "b";
                    };
                    case "CIV":{
                        _color = "ColorYellow";
                        _typePrefix = "n";
                    };
                    case "GUER":{
                        _color = "ColorIndependent";
                        _typePrefix = "n";
                    };
                    default {
                        _color = "ColorYellow";
                    };
                };

                {
                    _profileID = _x select 0;
                    _position = _x select 1;
                    _label = [_profileID, "_"] call CBA_fnc_split;
                    _label = _label select ((count _label) - 1);

                    _option = format ["Infantry Group %1", _label];
                    _options pushBack (_option);
                    _values pushBack (_x);

                    _editList lbAdd _option;

                    _profileMarker = format["%1_inf",_typePrefix];

                    _m = createMarkerLocal [format[MTEMPLATE, format["%1", _label]], _position];
                    _m setMarkerShapeLocal "ICON";
                    _m setMarkerSizeLocal [0.5,0.5];
                    _m setMarkerTypeLocal _profileMarker;
                    _m setMarkerColorLocal _color;
                    _m setMarkerAlphaLocal _alpha;
                    _m setMarkerText format["e%1",_label];

                    _markers = _markers + [_m];

                } forEach _infantry;

                {
                    _profileID = _x select 0;
                    _position = _x select 1;
                    _label = [_profileID, "_"] call CBA_fnc_split;
                    _label = _label select ((count _label) - 1);

                    _option = format ["Motorised Group %1", _label];
                    _options pushBack (_option);
                    _values pushBack (_x);

                    _editList lbAdd _option;

                    _profileMarker = format["%1_motor_inf",_typePrefix];

                    _m = createMarkerLocal [format[MTEMPLATE, format["%1", _label]], _position];
                    _m setMarkerShapeLocal "ICON";
                    _m setMarkerSizeLocal [0.5,0.5];
                    _m setMarkerTypeLocal _profileMarker;
                    _m setMarkerColorLocal _color;
                    _m setMarkerAlphaLocal _alpha;
                    _m setMarkerText format["e%1",_label];

                    _markers = _markers + [_m];

                } forEach _motorised;

                {
                    _profileID = _x select 0;
                    _position = _x select 1;
                    _label = [_profileID, "_"] call CBA_fnc_split;
                    _label = _label select ((count _label) - 1);

                    _option = format ["Mechanized Group %1", _label];
                    _options pushBack (_option);
                    _values pushBack (_x);

                    _editList lbAdd _option;

                    _profileMarker = format["%1_mech_inf",_typePrefix];

                    _m = createMarkerLocal [format[MTEMPLATE, format["%1", _label]], _position];
                    _m setMarkerShapeLocal "ICON";
                    _m setMarkerSizeLocal [0.5,0.5];
                    _m setMarkerTypeLocal _profileMarker;
                    _m setMarkerColorLocal _color;
                    _m setMarkerAlphaLocal _alpha;
                    _m setMarkerText format["e%1",_label];

                    _markers = _markers + [_m];

                } forEach _mechanized;

                {
                    _profileID = _x select 0;
                    _position = _x select 1;
                    _label = [_profileID, "_"] call CBA_fnc_split;
                    _label = _label select ((count _label) - 1);

                    _option = format ["Armor Group %1", _label];
                    _options pushBack (_option);
                    _values pushBack (_x);

                    _editList lbAdd _option;

                    _profileMarker = format["%1_armor",_typePrefix];

                    _m = createMarkerLocal [format[MTEMPLATE, format["%1", _label]], _position];
                    _m setMarkerShapeLocal "ICON";
                    _m setMarkerSizeLocal [0.5,0.5];
                    _m setMarkerTypeLocal _profileMarker;
                    _m setMarkerColorLocal _color;
                    _m setMarkerAlphaLocal _alpha;
                    _m setMarkerText format["e%1",_label];

                    _markers = _markers + [_m];

                } forEach _armor;

                {
                    _profileID = _x select 0;
                    _position = _x select 1;
                    _label = [_profileID, "_"] call CBA_fnc_split;
                    _label = _label select ((count _label) - 1);

                    _option = format ["Air Group %1", _label];
                    _options pushBack (_option);
                    _values pushBack (_x);

                    _editList lbAdd _option;

                    _profileMarker = format["%1_air",_typePrefix];

                    _m = createMarkerLocal [format[MTEMPLATE, format["%1", _label]], _position];
                    _m setMarkerShapeLocal "ICON";
                    _m setMarkerSizeLocal [0.5,0.5];
                    _m setMarkerTypeLocal _profileMarker;
                    _m setMarkerColorLocal _color;
                    _m setMarkerAlphaLocal _alpha;
                    _m setMarkerText format["e%1",_label];

                    _markers = _markers + [_m];

                } forEach _air;

                {
                    _profileID = _x select 0;
                    _position = _x select 1;
                    _label = [_profileID, "_"] call CBA_fnc_split;
                    _label = _label select ((count _label) - 1);

                    _option = format ["Naval Group %1", _label];
                    _options pushBack (_option);
                    _values pushBack (_x);

                    _editList lbAdd _option;

                    _profileMarker = format["%1_unknown",_typePrefix];

                    _m = createMarkerLocal [format[MTEMPLATE, format["%1", _label]], _position];
                    _m setMarkerShapeLocal "ICON";
                    _m setMarkerSizeLocal [0.5,0.5];
                    _m setMarkerTypeLocal _profileMarker;
                    _m setMarkerColorLocal _color;
                    _m setMarkerAlphaLocal _alpha;
                    _m setMarkerText format["e%1",_label];

                    _markers = _markers + [_m];

                } forEach _sea;

                {
                    _profileID = _x select 0;
                    _position = _x select 1;
                    _label = [_profileID, "_"] call CBA_fnc_split;
                    _label = _label select ((count _label) - 1);

                    _option = format ["Artillery Group %1", _label];
                    _options pushBack (_option);
                    _values pushBack (_x);

                    _editList lbAdd _option;

                    _profileMarker = format["%1_art",_typePrefix];

                    _m = createMarkerLocal [format[MTEMPLATE, format["%1", _label]], _position];
                    _m setMarkerShapeLocal "ICON";
                    _m setMarkerSizeLocal [0.5,0.5];
                    _m setMarkerTypeLocal _profileMarker;
                    _m setMarkerColorLocal _color;
                    _m setMarkerAlphaLocal _alpha;
                    _m setMarkerText format["e%1",_label];

                    _markers = _markers + [_m];

                } forEach _artillery;

                {
                    _profileID = _x select 0;
                    _position = _x select 1;
                    _label = [_profileID, "_"] call CBA_fnc_split;
                    _label = _label select ((count _label) - 1);

                    _option = format ["Anti-Air Group %1", _forEachIndex + 1];
                    _options pushBack (_option);
                    _values pushBack (_x);

                    _editList lbAdd _option;

                    _profileMarker = format["%1_mech_inf",_typePrefix];

                    _m = createMarkerLocal [format[MTEMPLATE, format["%1", _label]], _position];
                    _m setMarkerShapeLocal "ICON";
                    _m setMarkerSizeLocal [0.5,0.5];
                    _m setMarkerTypeLocal _profileMarker;
                    _m setMarkerColorLocal _color;
                    _m setMarkerAlphaLocal _alpha;
                    _m setMarkerText format["e%1",_label];

                    _markers = _markers + [_m];

                } forEach _AAA;


                // store the marker state for clearing later

                [_logic,"marker",_markers] call MAINCLASS;


                // set the event handler for the list selection event

                _editList ctrlSetEventHandler ["LBSelChanged", "['OPS_GROUP_LIST_SELECT',[_this]] call ALIVE_fnc_SCOMTabletOnAction"];

                // store the current values and options to state

                [_commandState,"opsGroupsOptions",_options] call ALIVE_fnc_hashSet;
                [_commandState,"opsGroupsValues",_values] call ALIVE_fnc_hashSet;

                // set the event handler for the map selection event

                _editMap = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_EditMap);

                _editMap ctrlSetEventHandler ["MouseButtonDown", "['OP_EDIT_MAP_CLICK',[_this]] call ALIVE_fnc_SCOMTabletOnAction"];

            }else{

                _status = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_IntelStatus);
                _status ctrlShow true;

                _status ctrlSetText "No OPCOM instances found";

            };

        };

    };

    case "enableGroupSelected": {

        private ["_commandState","_selectedProfile","_profileID","_playerID","_requestID","_event","_faction"];

        // a group has been selected

        _commandState = [_logic,"commandState"] call MAINCLASS;

        _selectedProfile = [_commandState,"opsGroupsSelectedValue"] call ALIVE_fnc_hashGet;

        _profileID = _selectedProfile select 0;

        _faction = [_logic,"faction"] call MAINCLASS;

        _playerID = getPlayerUID player;
        _requestID = format["%1_%2",_faction,floor(time)];

        // send the event to get further data from the command handler

        _event = ['OPS_GET_PROFILE', [_requestID,_playerID,_profileID], "SCOM"] call ALIVE_fnc_event;

        if(isServer) then {
            [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;
        }else{
            [[_event],"ALIVE_fnc_addEventToServer",false,false] spawn BIS_fnc_MP;
        };

        // show waiting until response comes back

        [_logic, "enableOpsWaiting"] call MAINCLASS;

    };

    case "enableOpsProfile": {

        private["_buttonR3","_commandState","_status","_profile","_waypoints","_previousWaypoints","_groupWaypoints","_arrowMarkers",
        "_position","_previousWaypointPos","_markerPos","_profilePosition"];

        // once the profile data has returned from the command handler
        // display the profiles waypoints

        if(typeName _args == "ARRAY") then {

            _commandState = [_logic,"commandState"] call MAINCLASS;

            // hide the loading status text

            _status = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_IntelStatus);
            _status ctrlShow false;

            _status ctrlSetText "";

            _profile = _args select 1;

            /*
            _profileData pushBack (_profile select 2 select 1); // active
            _profileData pushBack (_profile select 2 select 3); // side
            _profileData pushBack (_profile select 2 select 2); // position
            _profileData pushBack (_profile select 2 select 13); // group
            _profileData pushBack (_profile select 2 select 16); // waypoints
            */

            if(count(_profile) > 0) then {

                // plot the waypoints on the map

                _waypoints = _profile select 4;
                _profilePosition = _profile select 2;

                _groupWaypoints = [_commandState,"opsGroupWaypoints"] call ALIVE_fnc_hashGet;
                _previousWaypoints = [_commandState,"opsGroupPreviousWaypoints"] call ALIVE_fnc_hashGet;
                _arrowMarkers = [_commandState,"opsGroupArrowMarkers"] call ALIVE_fnc_hashGet;

                { deleteMarkerLocal _x } forEach _groupWaypoints;
                { deleteMarkerLocal _x } forEach _arrowMarkers;

                _previousWaypoints = [];
                _groupWaypoints = [];
                _arrowMarkers = [];

                {
                    _position = _x;

                    //-- Get arrow marker info
                    if (count _previousWaypoints > 0) then {
                        _previousWaypointPos = getMarkerPos (_previousWaypoints select (count _previousWaypoints - 1));
                        _markerPos = _previousWaypointPos;
                    } else {
                        _markerPos = _profilePosition;

                    };

                    //-- Create line marker
                    _m = [format ["%1",random 500], _markerPos, _position,20,"ColorBlue",.9] call ALIVE_fnc_createLineMarker;

                    _arrowMarkers pushBack _m;

                    //-- Draw X marker
                    _m = createMarkerLocal [format ["%1",random 500], _position];
                    _m setMarkerSizeLocal [1.3,1.3];
                    _m setMarkerShapeLocal "ICON";
                    _m setMarkerTypeLocal "waypoint";
                    _m setMarkerColorLocal "ColorBlue";

                    //-- Store marker
                    {
                        _x pushBack _m;
                    } forEach [_previousWaypoints,_groupWaypoints];

                } forEach _waypoints;

                [_commandState,"opsGroupSelectedProfile",_profile] call ALIVE_fnc_hashSet;
                [_commandState,"opsGroupWaypoints",_groupWaypoints] call ALIVE_fnc_hashSet;
                [_commandState,"opsGroupPreviousWaypoints",_previousWaypoints] call ALIVE_fnc_hashSet;
                [_commandState,"opsGroupArrowMarkers",_arrowMarkers] call ALIVE_fnc_hashSet;


                // enable interface elements for interacting with profile

                private["_buttonL1"];

                _buttonL1 = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_BL1);
                _buttonL1 ctrlShow true;
                _buttonL1 ctrlSetText "Edit Group Waypoints";
                _buttonL1 ctrlSetEventHandler ["MouseButtonClick", "['OPS_EDIT_WAYPOINTS',[_this]] call ALIVE_fnc_SCOMTabletOnAction"];

                [_logic,"commandState",_commandState] call MAINCLASS;


            }else{

                _status = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_IntelStatus);
                _status ctrlShow true;

                _status ctrlSetText "No group found";

            };

        };

    };

    case "enableGroupWaypointEdit": {

        private["_buttonR3","_commandState","_status","_profile","_waypoints","_previousWaypoints","_groupWaypoints","_arrowMarkers","_position",
        "_previousWaypointPos","_markerPos","_rightMap","_editMap","_profilePosition","_waypointsOptions","_waypointsValues","_option","_waypointList"];

        // once the profile data has returned from the command handler
        // display the profiles waypoints

        if(typeName _args == "ARRAY") then {

            _commandState = [_logic,"commandState"] call MAINCLASS;

            // hide the loading status text

            _status = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_IntelStatus);
            _status ctrlShow false;

            _status ctrlSetText "";

            _profile = _args select 1;

            /*
            _profileData pushBack (_profile select 2 select 1); // active
            _profileData pushBack (_profile select 2 select 3); // side
            _profileData pushBack (_profile select 2 select 2); // position
            _profileData pushBack (_profile select 2 select 13); // group
            _profileData pushBack (_profile select 2 select 16); // waypoints
            */

            if(count(_profile) > 0) then {

                _editList = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_EditList);
                _editList ctrlShow false;

                _waypointList = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_WaypointList);
                _waypointList ctrlShow true;

                lbClear _waypointList;

                _rightMap = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_MapRight);
                _rightMap ctrlShow false;

                _editMap = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_EditMap);
                _editMap ctrlShow true;

                _editMap ctrlSetEventHandler ["MouseButtonDown", "['OP_EDIT_WAYPOINT_MAP_CLICK',[_this]] call ALIVE_fnc_SCOMTabletOnAction"];

                _profilePosition = _profile select 2;

                ctrlMapAnimClear _editMap;
                _editMap ctrlMapAnimAdd [0.5, ctrlMapScale _editMap, _profilePosition];
                ctrlMapAnimCommit _editMap;

                // plot the waypoints on the map

                _waypoints = _profile select 4;

                _groupWaypoints = [_commandState,"opsGroupWaypoints"] call ALIVE_fnc_hashGet;
                _previousWaypoints = [_commandState,"opsGroupPreviousWaypoints"] call ALIVE_fnc_hashGet;
                _arrowMarkers = [_commandState,"opsGroupArrowMarkers"] call ALIVE_fnc_hashGet;

                { deleteMarkerLocal _x } forEach _groupWaypoints;
                { deleteMarkerLocal _x } forEach _arrowMarkers;

                _previousWaypoints = [];
                _groupWaypoints = [];
                _arrowMarkers = [];

                _waypointsOptions = [];
                _waypointsValues = [];

                {
                    ["WAYPOINT!!!!"] call ALIVE_fnc_dump;
                    _x call ALIVE_fnc_inspectArray;

                    _option = format["Waypoint %1 [%2]",_forEachIndex,_x select 2];

                    _waypointsOptions pushBack _option;
                    _waypointsValues pushBack _x;

                    _waypointList lbAdd _option;

                    _position = _x select 0;

                    //-- Get arrow marker info
                    if (count _previousWaypoints > 0) then {
                        _previousWaypointPos = getMarkerPos (_previousWaypoints select (count _previousWaypoints - 1));
                        _markerPos = _previousWaypointPos;
                    } else {
                        _markerPos = _profilePosition;

                    };

                    //-- Create line marker
                    _m = [format ["%1",random 500], _markerPos, _position,20,"ColorBlue",.9] call ALIVE_fnc_createLineMarker;

                    _arrowMarkers pushBack _m;

                    //-- Draw X marker
                    _m = createMarkerLocal [format ["%1",random 500], _position];
                    _m setMarkerSizeLocal [1.3,1.3];
                    _m setMarkerShapeLocal "ICON";
                    _m setMarkerTypeLocal "waypoint";
                    _m setMarkerColorLocal "ColorBlue";

                    //-- Store marker
                    {
                        _x pushBack _m;
                    } forEach [_previousWaypoints,_groupWaypoints];

                } forEach _waypoints;


                // set the event handler for the list selection event

                _waypointList ctrlSetEventHandler ["LBSelChanged", "['OPS_WAYPOINT_LIST_SELECT',[_this]] call ALIVE_fnc_SCOMTabletOnAction"];

                // store the current values and options to state

                [_commandState,"opsGroupWaypointsSelectedOptions",_waypointsOptions] call ALIVE_fnc_hashSet;
                [_commandState,"opsGroupWaypointsSelectedValues",_waypointsValues] call ALIVE_fnc_hashSet;

                [_commandState,"opsGroupSelectedProfile",_profile] call ALIVE_fnc_hashSet;
                [_commandState,"opsGroupWaypoints",_groupWaypoints] call ALIVE_fnc_hashSet;
                [_commandState,"opsGroupPreviousWaypoints",_previousWaypoints] call ALIVE_fnc_hashSet;
                [_commandState,"opsGroupArrowMarkers",_arrowMarkers] call ALIVE_fnc_hashSet;

                [_logic,"commandState",_commandState] call MAINCLASS;


                // enable interface elements for interacting with profile

                private["_buttonR1","_buttonR2","_buttonR3","_waypointTypeList","_waypointSpeedList","_waypointFormationList","_waypointBehaviourList"];

                _buttonR1 = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_BR1);
                _buttonR1 ctrlShow true;
                _buttonR1 ctrlSetText "Clear All Waypoints";
                _buttonR1 ctrlSetEventHandler ["MouseButtonClick", "['OPS_CLEAR_WAYPOINTS',[_this]] call ALIVE_fnc_SCOMTabletOnAction"];

                _backButton = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_SubMenuBack);
                _backButton ctrlShow true;

                // disable interface elements for interacting with profile

                _buttonR2 = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_BR2);
                _buttonR2 ctrlShow false;

                _buttonR3 = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_BR3);
                _buttonR3 ctrlShow false;

                _waypointTypeList = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_WaypointTypeList);
                _waypointTypeList ctrlShow false;

                lbClear _waypointTypeList;
                _waypointTypeList ctrlSetEventHandler ["LBSelChanged", ""];

                _waypointSpeedList = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_WaypointSpeedList);
                _waypointSpeedList ctrlShow false;

                lbClear _waypointSpeedList;
                _waypointSpeedList ctrlSetEventHandler ["LBSelChanged", ""];

                _waypointFormationList = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_WaypointFormationList);
                _waypointFormationList ctrlShow false;

                lbClear _waypointFormationList;
                _waypointFormationList ctrlSetEventHandler ["LBSelChanged", ""];

                _waypointBehaviourList = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_WaypointBehavourList);
                _waypointBehaviourList ctrlShow false;

                lbClear _waypointBehaviourList;
                _waypointBehaviourList ctrlSetEventHandler ["LBSelChanged", ""];


            }else{

                _status = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_IntelStatus);
                _status ctrlShow true;

                _status ctrlSetText "No group found";

            };

        };

    };

    case "enableWaypointSelected": {

        private ["_commandState","_selectedWaypoint","_profileID","_playerID","_requestID","_event","_faction","_opsWPTypeOptions","_opsWPSpeedOptions",
        "_opsWPFormationOptions","_opsWPBehaviourOptions","_waypointTypeList","_waypointSpeedList","_waypointFormationList","_waypointBehaviourList",
        "_selectedWaypointType","_selectedWaypointSpeed","_selectedWaypointFormation","_selectedWaypointBehaviour","_opsWPTypeValues",
        "_opsWPSpeedValues","_opsWPFormationValues","_opsWPBehaviourValues","_selectedWaypointTypeIndex","_selectedWaypointSpeedIndex",
        "_selectedWaypointFormationIndex","_selectedWaypointBehaviourIndex"];

        // a waypoint has been selected

        _commandState = [_logic,"commandState"] call MAINCLASS;

        _selectedWaypoint = [_commandState,"opsGroupWaypointsSelectedValue"] call ALIVE_fnc_hashGet;

        _selectedWaypointType = _selectedWaypoint select 2;
        _selectedWaypointSpeed = _selectedWaypoint select 3;
        _selectedWaypointFormation = _selectedWaypoint select 6;
        _selectedWaypointBehaviour = _selectedWaypoint select 8;

        _selectedWaypointTypeIndex = 0;
        _selectedWaypointSpeedIndex = 0;
        _selectedWaypointFormationIndex = 0;
        _selectedWaypointBehaviourIndex = 0;

        _opsWPTypeOptions = [_commandState,"opsWPTypeOptions"] call ALIVE_fnc_hashGet;
        _opsWPTypeValues = [_commandState,"opsWPTypeValues"] call ALIVE_fnc_hashGet;
        _opsWPSpeedOptions = [_commandState,"opsWPSpeedOptions"] call ALIVE_fnc_hashGet;
        _opsWPSpeedValues = [_commandState,"opsWPSpeedValues"] call ALIVE_fnc_hashGet;
        _opsWPFormationOptions = [_commandState,"opsWPFormationOptions"] call ALIVE_fnc_hashGet;
        _opsWPFormationValues = [_commandState,"opsWPFormationValues"] call ALIVE_fnc_hashGet;
        _opsWPBehaviourOptions = [_commandState,"opsWPBehaviourOptions"] call ALIVE_fnc_hashGet;
        _opsWPBehaviourValues = [_commandState,"opsWPBehaviourValues"] call ALIVE_fnc_hashGet;

        _waypointTypeList = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_WaypointTypeList);
        _waypointTypeList ctrlShow true;

        lbClear _waypointTypeList;

        {
            if(_selectedWaypointType == _x) then {
                _selectedWaypointTypeIndex = _forEachIndex;
            };
            _waypointTypeList lbAdd format["%1", _opsWPTypeOptions select _forEachIndex];
        } forEach _opsWPTypeValues;

        _waypointTypeList lbSetCurSel _selectedWaypointTypeIndex;

        // set the event handler for the list selection event

        _waypointTypeList ctrlSetEventHandler ["LBSelChanged", "['OPS_WP_TYPE_LIST_SELECT',[_this]] call ALIVE_fnc_SCOMTabletOnAction"];


        _waypointSpeedList = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_WaypointSpeedList);
        _waypointSpeedList ctrlShow true;

        lbClear _waypointSpeedList;

        {
            if(_selectedWaypointSpeed == _x) then {
                _selectedWaypointSpeedIndex = _forEachIndex;
            };
            _waypointSpeedList lbAdd format["%1", _opsWPSpeedOptions select _forEachIndex];
        } forEach _opsWPSpeedValues;

        _waypointSpeedList lbSetCurSel _selectedWaypointSpeedIndex;

        // set the event handler for the list selection event

        _waypointSpeedList ctrlSetEventHandler ["LBSelChanged", "['OPS_WP_SPEED_LIST_SELECT',[_this]] call ALIVE_fnc_SCOMTabletOnAction"];


        _waypointFormationList = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_WaypointFormationList);
        _waypointFormationList ctrlShow true;

        lbClear _waypointFormationList;

        {
            if(_selectedWaypointFormation == _x) then {
                _selectedWaypointFormationIndex = _forEachIndex;
            };
            _waypointFormationList lbAdd format["%1", _opsWPFormationOptions select _forEachIndex];
        } forEach _opsWPFormationValues;

        _waypointFormationList lbSetCurSel _selectedWaypointFormationIndex;

        // set the event handler for the list selection event

        _waypointFormationList ctrlSetEventHandler ["LBSelChanged", "['OPS_WP_FORMATION_LIST_SELECT',[_this]] call ALIVE_fnc_SCOMTabletOnAction"];


        _waypointBehaviourList = SCOM_getControl(SCOMTablet_CTRL_MainDisplay,SCOMTablet_CTRL_WaypointBehavourList);
        _waypointBehaviourList ctrlShow true;

        lbClear _waypointBehaviourList;

        {
            if(_selectedWaypointBehaviour == _x) then {
                _selectedWaypointBehaviourIndex = _forEachIndex;
            };
            _waypointBehaviourList lbAdd format["%1", _opsWPBehaviourOptions select _forEachIndex];
        } forEach _opsWPBehaviourValues;

        _waypointBehaviourList lbSetCurSel _selectedWaypointBehaviourIndex;

        // set the event handler for the list selection event

        _waypointBehaviourList ctrlSetEventHandler ["LBSelChanged", "['OPS_WP_BEHAVIOUR_LIST_SELECT',[_this]] call ALIVE_fnc_SCOMTabletOnAction"];

    };

};

TRACE_1("SCOM - output",_result);
_result;
