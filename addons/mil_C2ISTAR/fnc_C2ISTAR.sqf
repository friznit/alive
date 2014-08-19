//#define DEBUG_MODE_FULL
#include <\x\alive\addons\mil_C2ISTAR\script_component.hpp>
SCRIPT(C2ISTAR);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_C2ISTAR
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
[_logic, "debug", true] call ALiVE_fnc_PR;

See Also:
- <ALIVE_fnc_C2ISTARInit>

Author:
ARJay

Peer Reviewed:
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClass
#define MAINCLASS ALIVE_fnc_C2ISTAR
#define MTEMPLATE "ALiVE_C2_%1"
#define DEFAULT_C2_ITEM "LaserDesignator"
#define DEFAULT_STATE "INIT"
#define DEFAULT_SIDE "WEST"
#define DEFAULT_FACTION "BLU_F"
#define DEFAULT_SELECTED_INDEX 0
#define DEFAULT_SELECTED_VALUE ""
#define DEFAULT_SCALAR 0
#define DEFAULT_TASKING_STATE [] call ALIVE_fnc_hashCreate
#define DEFAULT_TASKING_MARKER []
#define DEFAULT_TASKING_DESTINATION []

// Display components
#define C2Tablet_CTRL_MainDisplay 70001

// main menu
#define C2Tablet_CTRL_MainMenuTasks 70002
#define C2Tablet_CTRL_MainMenuAAR 70003
#define C2Tablet_CTRL_MainMenuISTAR 70004
#define C2Tablet_CTRL_MainMenuAbort 70005

// sub menu generic
#define C2Tablet_CTRL_SubMenuBack 70006
#define C2Tablet_CTRL_SubMenuAbort 70010
#define C2Tablet_CTRL_Title 70007

// tasking
#define C2Tablet_CTRL_TaskPlayerList 70011
#define C2Tablet_CTRL_TaskSelectedPlayerTitle 70012
#define C2Tablet_CTRL_TaskSelectedPlayerList 70013
#define C2Tablet_CTRL_TaskSelectGroupButton 70014
#define C2Tablet_CTRL_TaskSelectedPlayerListDeleteButton 70015
#define C2Tablet_CTRL_TaskSelectedPlayersAddTaskButton 70016
#define C2Tablet_CTRL_TaskSelectedPlayersClearButton 70029
#define C2Tablet_CTRL_TaskAddTitleEditTitle 70018
#define C2Tablet_CTRL_TaskAddTitleEdit 70019
#define C2Tablet_CTRL_TaskAddDescriptionEditTitle 70020
#define C2Tablet_CTRL_TaskAddDescriptionEdit 70021
#define C2Tablet_CTRL_TaskAddStateEditTitle 70030
#define C2Tablet_CTRL_TaskAddStateEdit 70031
#define C2Tablet_CTRL_TaskAddMap 70022
#define C2Tablet_CTRL_TaskAddCreateButton 70023
#define C2Tablet_CTRL_TaskCurrentList 70025
#define C2Tablet_CTRL_TaskCurrentListEditButton 70026
#define C2Tablet_CTRL_TaskCurrentListDeleteButton 70027
#define C2Tablet_CTRL_TaskEditUpdateButton 70028
#define C2Tablet_CTRL_TaskEditManagePlayersButton 70032
#define C2Tablet_CTRL_TaskAddApplyTitle 70033
#define C2Tablet_CTRL_TaskAddApplyEdit 70034
#define C2Tablet_CTRL_TaskAddCurrentTitle 70035
#define C2Tablet_CTRL_TaskAddCurrentEdit 70036

// AAR

// ISTAR




// Control Macros
#define C2_getControl(disp,ctrl) ((findDisplay ##disp) displayCtrl ##ctrl)
#define C2_getSelData(ctrl) (lbData[##ctrl,(lbCurSel ##ctrl)])


private ["_logic","_operation","_args","_result"];

TRACE_1("C2ISTAR - input",_this);

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

	case "c2_item": {
        _result = [_logic,_operation,_args,DEFAULT_C2_ITEM] call ALIVE_fnc_OOsimpleOperation;
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

    case "taskingState": {
        _result = [_logic,_operation,_args,DEFAULT_TASKING_STATE] call ALIVE_fnc_OOsimpleOperation;
    };

    case "taskMarker": {
        _result = [_logic,_operation,_args,DEFAULT_TASKING_MARKER] call ALIVE_fnc_OOsimpleOperation;
    };
    case "taskDestination": {
        _result = [_logic,_operation,_args,DEFAULT_TASKING_DESTINATION] call ALIVE_fnc_OOsimpleOperation;
    };


	case "init": {

        _logic setVariable ["super", SUPERCLASS];
        _logic setVariable ["class", MAINCLASS];
        _logic setVariable ["moduleType", "ALIVE_C2ISTAR"];
        _logic setVariable ["startupComplete", false];

        ALIVE_MIL_C2ISTAR = _logic;

        [_logic, "start"] call MAINCLASS;

        if (isServer) then {

            /*
            if!(isNil "ALIVE_eventLog") then {
                // create event log
                ALIVE_eventLog = [nil, "create"] call ALIVE_fnc_eventLog;
                [ALIVE_eventLog, "init"] call ALIVE_fnc_eventLog;
                [ALIVE_eventLog, "debug", false] call ALIVE_fnc_eventLog;
            };
            */

            // create the task handler
            ALIVE_taskHandler = [nil, "create"] call ALIVE_fnc_taskHandler;
            [ALIVE_taskHandler, "init"] call ALIVE_fnc_taskHandler;

        };


        if (hasInterface) then {

            _logic setVariable ["startupComplete", true];

            // create the client task handler
            ALIVE_taskHandlerClient = [nil, "create"] call ALIVE_fnc_taskHandlerClient;
            [ALIVE_taskHandlerClient, "init"] call ALIVE_fnc_taskHandlerClient;

            // set the player side

            private ["_playerSide","_sideNumber","_sideText"];

            _playerSide = side player;
            _sideNumber = [_playerSide] call ALIVE_fnc_sideObjectToNumber;
            _sideText = [_sideNumber] call ALIVE_fnc_sideNumberToText;

            [_logic,"side",_sideText] call MAINCLASS;


            // set the player faction

            private ["_playerFaction"];

            _playerFaction = faction player;

            [_logic,"faction",_playerFaction] call MAINCLASS;


            // set the tasking state

            private ["_taskingState","_playerListOptions","_playerListValues"];

            _taskingState = [_logic,"taskingState"] call MAINCLASS;

            [_taskingState,"playerListOptions",[]] call ALIVE_fnc_hashSet;
            [_taskingState,"playerListValues",[]] call ALIVE_fnc_hashSet;
            [_taskingState,"playerListSelectedIndex",DEFAULT_SELECTED_INDEX] call ALIVE_fnc_hashSet;
            [_taskingState,"playerListSelectedValue",DEFAULT_SELECTED_VALUE] call ALIVE_fnc_hashSet;

            [_taskingState,"selectedPlayerListOptions",[]] call ALIVE_fnc_hashSet;
            [_taskingState,"selectedPlayerListValues",[]] call ALIVE_fnc_hashSet;
            [_taskingState,"selectedPlayerListSelectedIndex",DEFAULT_SELECTED_INDEX] call ALIVE_fnc_hashSet;
            [_taskingState,"selectedPlayerListSelectedValue",DEFAULT_SELECTED_VALUE] call ALIVE_fnc_hashSet;

            [_taskingState,"currentTaskListOptions",[]] call ALIVE_fnc_hashSet;
            [_taskingState,"currentTaskListValues",[]] call ALIVE_fnc_hashSet;
            [_taskingState,"currentTaskListSelectedIndex",DEFAULT_SELECTED_INDEX] call ALIVE_fnc_hashSet;
            [_taskingState,"currentTaskListSelectedValue",DEFAULT_SELECTED_VALUE] call ALIVE_fnc_hashSet;

            [_taskingState,"currentTaskStateOptions",["Created","Assigned","Succeeded","Failed","Canceled"]] call ALIVE_fnc_hashSet;
            [_taskingState,"currentTaskStateValues",["Created","Assigned","Succeeded","Failed","Canceled"]] call ALIVE_fnc_hashSet;
            [_taskingState,"currentTaskStateSelectedIndex",DEFAULT_SELECTED_INDEX] call ALIVE_fnc_hashSet;
            [_taskingState,"currentTaskStateSelectedValue",DEFAULT_SELECTED_VALUE] call ALIVE_fnc_hashSet;

            [_taskingState,"currentTaskApplyOptions",["Apply to all current and future groups members","Apply only to these individuals"]] call ALIVE_fnc_hashSet;
            [_taskingState,"currentTaskApplyValues",["Group","Individual"]] call ALIVE_fnc_hashSet;
            [_taskingState,"currentTaskApplySelectedIndex",DEFAULT_SELECTED_INDEX] call ALIVE_fnc_hashSet;
            [_taskingState,"currentTaskApplySelectedValue",DEFAULT_SELECTED_VALUE] call ALIVE_fnc_hashSet;

            [_taskingState,"currentTaskCurrentOptions",["Yes","No"]] call ALIVE_fnc_hashSet;
            [_taskingState,"currentTaskCurrentValues",["Y","N"]] call ALIVE_fnc_hashSet;
            [_taskingState,"currentTaskCurrentSelectedIndex",DEFAULT_SELECTED_INDEX] call ALIVE_fnc_hashSet;
            [_taskingState,"currentTaskCurrentSelectedValue",DEFAULT_SELECTED_VALUE] call ALIVE_fnc_hashSet;

            [_taskingState,"currentTaskPlayerListOptions",[]] call ALIVE_fnc_hashSet;
            [_taskingState,"currentTaskPlayerListValues",[]] call ALIVE_fnc_hashSet;
            [_taskingState,"currentTaskPlayerListSelectedIndex",DEFAULT_SELECTED_INDEX] call ALIVE_fnc_hashSet;
            [_taskingState,"currentTaskPlayerListSelectedValue",DEFAULT_SELECTED_VALUE] call ALIVE_fnc_hashSet;

            [_taskingState,"currentTaskSelectedPlayerListOptions",[]] call ALIVE_fnc_hashSet;
            [_taskingState,"currentTaskSelectedPlayerListValues",[]] call ALIVE_fnc_hashSet;
            [_taskingState,"currentTaskSelectedPlayerListSelectedIndex",DEFAULT_SELECTED_INDEX] call ALIVE_fnc_hashSet;
            [_taskingState,"currentTaskSelectedPlayerListSelectedValue",DEFAULT_SELECTED_VALUE] call ALIVE_fnc_hashSet;

            [_logic,"taskingState",_taskingState] call MAINCLASS;


            // Initialise interaction key if undefined
            if (isNil "SELF_INTERACTION_KEY") then {SELF_INTERACTION_KEY = [221,[false,false,false]];};

            TRACE_2("Menu pre-req",SELF_INTERACTION_KEY,ALIVE_fnc_logisticsMenuDef);

            // Initialise main menu
            [
                    "player",
                    [SELF_INTERACTION_KEY],
                    -9500,
                    [
                            "call ALIVE_fnc_C2MenuDef",
                            "main"
                    ]
            ] call ALiVE_fnc_flexiMenu_Add;
        };
	};
	case "start": {

        // set module as startup complete
        _logic setVariable ["startupComplete", true];

        if(isServer) then {

            // start listening for logcom events
            [_logic,"listen"] call MAINCLASS;

        };

	};
	case "listen": {
        private["_listenerID"];

        _listenerID = [ALIVE_eventLog, "addListener",[_logic, ["TASKS_UPDATED"]]] call ALIVE_fnc_eventLog;
        _logic setVariable ["listenerID", _listenerID];
    };
    case "handleEvent": {

        private["_event","_eventData"];

        if(typeName _args == "ARRAY") then {

            _event = _args;

            // a response event from LOGCOM has been received.
            // if the we are a dedicated server,
            // dispatch the event to the player who requested it
            if(isDedicated) then {

                private ["_eventData","_playerID","_player"];

                _eventData = [_event, "data"] call ALIVE_fnc_hashGet;

                _playerID = _eventData select 0;

                _player = [_playerID] call ALIVE_fnc_getPlayerByUID;

                if !(isNull _player) then {
                    [_event,"ALIVE_fnc_C2TabletEventToClient",_player,false,false] spawn BIS_fnc_MP;
                };

            }else{

                // the player is the server

                [_logic, "handleServerResponse", _event] call MAINCLASS;

            };

        };
    };
    case "handleServerResponse": {

        // event handler for response from server
        // events

        private["_event","_eventData","_type"];

        if(typeName _args == "ARRAY") then {

            _event = _args;
            _type = [_event, "type"] call ALIVE_fnc_hashGet;
            _eventData = [_event, "data"] call ALIVE_fnc_hashGet;

            switch(_type) do {
                case "TASKS_UPDATED": {

                    private["_taskState"];

                    _taskState = _eventData select 1;

                    [_logic,"updateCurrentTaskList",_taskState] call MAINCLASS;

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

                        [_logic,"enableMainMenu"] call MAINCLASS;

                        [_logic,"loadInitialData"] call MAINCLASS;

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

            // Show GPS
            showGPS true;

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

                case "OPEN": {

                    createDialog "C2Tablet";

                };

                case "MAIN_MENU_TASKING_CLICK": {

                    [_logic,"disableMainMenu"] call MAINCLASS;
                    [_logic,"enableTasking"] call MAINCLASS;

                };

                case "MAIN_MENU_AAR_CLICK": {

                    [_logic,"disableMainMenu"] call MAINCLASS;
                    [_logic,"enableAAR"] call MAINCLASS;

                };

                case "MAIN_MENU_ISTAR_CLICK": {

                    [_logic,"disableMainMenu"] call MAINCLASS;
                    [_logic,"enableISTAR"] call MAINCLASS;

                };

                case "BACK_BUTTON_CLICK": {

                    [_logic,"disableAll"] call MAINCLASS;
                    [_logic,"enableMainMenu"] call MAINCLASS;

                };

                case "TASK_ADD_BUTTON_CLICK": {

                    [_logic,"disableTasking"] call MAINCLASS;
                    [_logic,"enableAddTask"] call MAINCLASS;

                };

                case "TASK_ADD_BACK_BUTTON_CLICK": {

                    [_logic,"disableAddTask"] call MAINCLASS;
                    [_logic,"enableTasking"] call MAINCLASS;
                };

                case "TASK_ADD_STATE_LIST_SELECT": {

                    private ["_taskingState","_stateList","_selectedIndex","_listOptions","_listValues","_selectedOption","_selectedValue"];

                    _taskingState = [_logic,"taskingState"] call MAINCLASS;

                    _stateList = _args select 0 select 0;
                    _selectedIndex = _args select 0 select 1;
                    _listOptions = [_taskingState,"currentTaskStateOptions"] call ALIVE_fnc_hashGet;
                    _listValues = [_taskingState,"currentTaskStateValues"] call ALIVE_fnc_hashGet;
                    _selectedOption = _listOptions select _selectedIndex;
                    _selectedValue = _listValues select _selectedIndex;

                    [_taskingState,"currentTaskStateSelectedIndex",_selectedIndex] call ALIVE_fnc_hashSet;
                    [_taskingState,"currentTaskStateSelectedValue",_selectedValue] call ALIVE_fnc_hashSet;

                    [_logic,"taskingState",_taskingState] call MAINCLASS;

                    _taskingState call ALIVE_fnc_inspectHash;
                };

                case "TASK_ADD_APPLY_LIST_SELECT": {

                    private ["_taskingState","_stateList","_selectedIndex","_listOptions","_listValues","_selectedOption","_selectedValue"];

                    _taskingState = [_logic,"taskingState"] call MAINCLASS;

                    _stateList = _args select 0 select 0;
                    _selectedIndex = _args select 0 select 1;
                    _listOptions = [_taskingState,"currentTaskApplyOptions"] call ALIVE_fnc_hashGet;
                    _listValues = [_taskingState,"currentTaskApplyValues"] call ALIVE_fnc_hashGet;
                    _selectedOption = _listOptions select _selectedIndex;
                    _selectedValue = _listValues select _selectedIndex;

                    [_taskingState,"currentTaskApplySelectedIndex",_selectedIndex] call ALIVE_fnc_hashSet;
                    [_taskingState,"currentTaskApplySelectedValue",_selectedValue] call ALIVE_fnc_hashSet;

                    [_logic,"taskingState",_taskingState] call MAINCLASS;

                    _taskingState call ALIVE_fnc_inspectHash;
                };

                case "TASK_ADD_CURRENT_LIST_SELECT": {

                    private ["_taskingState","_currentList","_selectedIndex","_listOptions","_listValues","_selectedOption","_selectedValue"];

                    _taskingState = [_logic,"taskingState"] call MAINCLASS;

                    _currentList = _args select 0 select 0;
                    _selectedIndex = _args select 0 select 1;
                    _listOptions = [_taskingState,"currentTaskCurrentOptions"] call ALIVE_fnc_hashGet;
                    _listValues = [_taskingState,"currentTaskCurrentValues"] call ALIVE_fnc_hashGet;
                    _selectedOption = _listOptions select _selectedIndex;
                    _selectedValue = _listValues select _selectedIndex;

                    [_taskingState,"currentTaskCurrentSelectedIndex",_selectedIndex] call ALIVE_fnc_hashSet;
                    [_taskingState,"currentTaskCurrentSelectedValue",_selectedValue] call ALIVE_fnc_hashSet;

                    [_logic,"taskingState",_taskingState] call MAINCLASS;

                    _taskingState call ALIVE_fnc_inspectHash;
                };

                case "TASK_ADD_CREATE_BUTTON_CLICK": {

                    private ["_taskingState","_titleEdit","_descriptionEdit","_title","_description","_marker","_destination",
                    "_side","_faction","_selectedPlayers","_selectedPlayersValues","_selectedPlayersOptions","_event","_requestID","_playerID","_state","_apply","_current"];

                    _taskingState = [_logic,"taskingState"] call MAINCLASS;

                    _titleEdit = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddTitleEdit);
                    _descriptionEdit = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddDescriptionEdit);

                    _title = ctrlText _titleEdit;
                    _description = ctrlText _descriptionEdit;

                    _side = [_logic,"side"] call MAINCLASS;
                    _faction = [_logic,"faction"] call MAINCLASS;
                    _marker = [_logic,"taskMarker"] call MAINCLASS;
                    _destination = [_logic,"taskDestination"] call MAINCLASS;

                    _state = [_taskingState,"currentTaskStateSelectedValue"] call ALIVE_fnc_hashGet;
                    _apply = [_taskingState,"currentTaskApplySelectedValue"] call ALIVE_fnc_hashGet;
                    _current = [_taskingState,"currentTaskCurrentSelectedValue"] call ALIVE_fnc_hashGet;

                    _playerID = getPlayerUID player;
                    _requestID = format["%1_%2",_faction,floor(time)];

                    _selectedPlayers = [];
                    _selectedPlayersValues = [_taskingState,"selectedPlayerListValues"] call ALIVE_fnc_hashGet;
                    _selectedPlayersOptions = [_taskingState,"selectedPlayerListOptions"] call ALIVE_fnc_hashGet;

                    _newSelectedPlayerValues = [];
                    _newSelectedPlayerOptions = [];

                    _newSelectedPlayerValues = _newSelectedPlayerValues + _selectedPlayersValues;
                    _newSelectedPlayerOptions = _newSelectedPlayerOptions + _selectedPlayersOptions;

                    _selectedPlayers set [0, _newSelectedPlayerValues];
                    _selectedPlayers set [1, _newSelectedPlayerOptions];

                    _event = ['TASK_CREATE', [_requestID,_playerID,_side,_destination,_faction,_title,_description,_selectedPlayers,_state,_apply,_current], "C2ISTAR"] call ALIVE_fnc_event;

                    if(isServer) then {
                        [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;
                    }else{
                        ["server","ALIVE_ADD_EVENT",[[_event],"ALIVE_fnc_addEventToServer"]] call ALiVE_fnc_BUS;
                    };

                    [_logic,"disableAddTask"] call MAINCLASS;
                    [_logic,"enableTasking"] call MAINCLASS;
                };

                case "TASK_ADD_MAP_CLICK": {

                    private ["_posX","_posY","_map","_position","_markers","_marker","_markerLabel","_selectedDeliveryValue"];

                    _posX = _args select 0 select 2;
                    _posY = _args select 0 select 3;

                    _markers = [_logic,"taskMarker"] call MAINCLASS;

                    if(count _markers > 0) then {
                        deleteMarkerLocal (_markers select 0);
                    };

                    _map = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddMap);

                    _position = _map ctrlMapScreenToWorld [_posX, _posY];

                    ctrlMapAnimClear _map;
                    _map ctrlMapAnimAdd [0.5, ctrlMapScale _map, _position];
                    ctrlMapAnimCommit _map;

                    _marker = createMarkerLocal [format["%1%2",MTEMPLATE,"marker"],_position];
                    _marker setMarkerAlphaLocal 1;
                    _marker setMarkerTextLocal "Destination";
                    _marker setMarkerTypeLocal "hd_Objective";

                    [_logic,"taskMarker",[_marker]] call MAINCLASS;
                    [_logic,"taskDestination",_position] call MAINCLASS;

                };

                case "TASK_ADD_MANAGE_PLAYERS_BUTTON_CLICK": {

                    [_logic,"disableAddTask"] call MAINCLASS;
                    [_logic,"enableAddTaskManagePlayers"] call MAINCLASS;

                };

                case "TASK_ADD_MANAGE_PLAYERS_BACK_BUTTON_CLICK": {

                    [_logic,"disableAddTaskManagePlayers"] call MAINCLASS;
                    [_logic,"enableAddTask"] call MAINCLASS;

                };

                case "TASK_PLAYER_LIST_SELECT": {

                    private ["_taskingState","_playerList","_selectedIndex","_listOptions","_listValues","_selectedOption","_selectedValue","_selectedPlayersAddTaskButton","_selectedPlayersClearButton"];

                    _taskingState = [_logic,"taskingState"] call MAINCLASS;

                    _playerList = _args select 0 select 0;
                    _selectedIndex = _args select 0 select 1;
                    _listOptions = [_taskingState,"playerListOptions"] call ALIVE_fnc_hashGet;
                    _listValues = [_taskingState,"playerListValues"] call ALIVE_fnc_hashGet;
                    _selectedOption = _listOptions select _selectedIndex;
                    _selectedValue = _listValues select _selectedIndex;

                    [_taskingState,"playerListSelectedIndex",_selectedIndex] call ALIVE_fnc_hashSet;
                    [_taskingState,"playerListSelectedValue",_selectedValue] call ALIVE_fnc_hashSet;

                    [_logic,"taskingState",_taskingState] call MAINCLASS;

                    _taskingState call ALIVE_fnc_inspectHash;

                    _selectedPlayersClearButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskSelectedPlayersClearButton);
                    _selectedPlayersClearButton ctrlShow true;

                    _selectedPlayersClearButton ctrlSetEventHandler ["MouseButtonClick", "['TASK_SELECTED_PLAYER_LIST_CLEAR_BUTTON_CLICK',[_this]] call ALIVE_fnc_C2TabletOnAction"];

                    private ["_selectedPlayerListOptions","_selectedPlayerListValues","_selectedPlayerList"];

                    _selectedPlayerListOptions = [_taskingState,"selectedPlayerListOptions"] call ALIVE_fnc_hashGet;
                    _selectedPlayerListValues = [_taskingState,"selectedPlayerListValues"] call ALIVE_fnc_hashGet;

                    if!(_selectedOption in _selectedPlayerListOptions) then {

                        _selectedPlayerListOptions set [count _selectedPlayerListOptions,_selectedOption];
                        _selectedPlayerListValues set [count _selectedPlayerListValues,_selectedValue];

                        [_taskingState,"selectedPlayerListOptions",_selectedPlayerListOptions] call ALIVE_fnc_hashSet;
                        [_taskingState,"selectedPlayerListValues",_selectedPlayerListValues] call ALIVE_fnc_hashSet;

                        _selectedPlayerList = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskSelectedPlayerList);

                        _selectedPlayerList lbAdd format["%1", _selectedOption];

                        private ["_selectGroupButton"];

                        _selectGroupButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskSelectGroupButton);
                        _selectGroupButton ctrlShow true;

                        _selectGroupButton ctrlSetEventHandler ["MouseButtonClick", "['TASK_SELECT_GROUP_BUTTON_CLICK',[_this]] call ALIVE_fnc_C2TabletOnAction"];
                    };

                };

                case "TASK_SELECT_GROUP_BUTTON_CLICK": {

                    private ["_taskingState","_selectedIndex","_listValues","_selectedPlayerUID","_playersInGroup"];

                    _taskingState = [_logic,"taskingState"] call MAINCLASS;

                    _selectedIndex = [_taskingState,"playerListSelectedIndex"] call ALIVE_fnc_hashGet;
                    _listValues = [_taskingState,"playerListValues"] call ALIVE_fnc_hashGet;

                    _selectedPlayerUID = _listValues select _selectedIndex;

                    _playersInGroup = [_selectedPlayerUID] call ALiVE_fnc_getPlayersInGroupDataSource;

                    if(count (_playersInGroup select 0) > 0) then {

                        private ["_selectedPlayerListOptions","_selectedPlayerListValues","_selectedPlayerList"];

                        _selectedPlayerListOptions = [_taskingState,"selectedPlayerListOptions"] call ALIVE_fnc_hashGet;
                        _selectedPlayerListValues = [_taskingState,"selectedPlayerListValues"] call ALIVE_fnc_hashGet;

                        _selectedPlayerList = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskSelectedPlayerList);

                        {
                            if!((_x select 0) in _selectedPlayerListOptions) then {
                                _selectedPlayerListOptions set [count _selectedPlayerListOptions,_x select 0];
                                _selectedPlayerListValues set [count _selectedPlayerListValues,_x select 1];

                                _selectedPlayerList lbAdd format["%1", _x select 0];
                            };
                        } foreach _playersInGroup;

                        [_taskingState,"selectedPlayerListOptions",_selectedPlayerListOptions] call ALIVE_fnc_hashSet;
                        [_taskingState,"selectedPlayerListValues",_selectedPlayerListValues] call ALIVE_fnc_hashSet;
                    };

                };

                case "TASK_SELECTED_PLAYER_LIST_SELECT": {

                    private ["_taskingState","_selectedPlayerList","_selectedIndex","_listOptions","_listValues","_selectedOption","_selectedValue"];

                    _taskingState = [_logic,"taskingState"] call MAINCLASS;

                    _selectedPlayerList = _args select 0 select 0;
                    _selectedIndex = _args select 0 select 1;
                    _listOptions = [_taskingState,"selectedPlayerListOptions"] call ALIVE_fnc_hashGet;
                    _listValues = [_taskingState,"selectedPlayerListValues"] call ALIVE_fnc_hashGet;
                    _selectedOption = _listOptions select _selectedIndex;
                    _selectedValue = _listValues select _selectedIndex;

                    [_taskingState,"selectedPlayerListSelectedIndex",_selectedIndex] call ALIVE_fnc_hashSet;
                    [_taskingState,"selectedPlayerListSelectedValue",_selectedValue] call ALIVE_fnc_hashSet;

                    [_logic,"taskingState",_taskingState] call MAINCLASS;

                    _taskingState call ALIVE_fnc_inspectHash;

                    private ["_selectedPlayerListDeleteButton","_selectedPlayersClearButton"];

                    _selectedPlayerListDeleteButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskSelectedPlayerListDeleteButton);
                    _selectedPlayerListDeleteButton ctrlShow true;

                    _selectedPlayerListDeleteButton ctrlSetEventHandler ["MouseButtonClick", "['TASK_SELECTED_PLAYER_LIST_DELETE_BUTTON_CLICK',[_this]] call ALIVE_fnc_C2TabletOnAction"];

                };

                case "TASK_SELECTED_PLAYER_LIST_DELETE_BUTTON_CLICK": {

                    private ["_taskingState","_deleteButton","_selectedPlayerList","_selectedIndex","_listOptions","_listValues","_delete","_selectedPlayersAddTaskButton","_selectedPlayersClearButton"];

                     _taskingState = [_logic,"taskingState"] call MAINCLASS;

                    _deleteButton = _args select 0 select 0;
                    _selectedPlayerList = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskSelectedPlayerList);
                    _selectedIndex = lbCurSel _selectedPlayerList;
                    _listOptions = [_taskingState,"selectedPlayerListOptions"] call ALIVE_fnc_hashGet;
                    _listValues = [_taskingState,"selectedPlayerListValues"] call ALIVE_fnc_hashGet;

                    _listOptions set [_selectedIndex,"del"];
                    _listValues set [_selectedIndex,"del"];

                    _delete = ["del"];

                    _listOptions = _listOptions - _delete;
                    _listValues = _listValues - _delete;

                    [_taskingState,"selectedPlayerListOptions",_listOptions] call ALIVE_fnc_hashSet;
                    [_taskingState,"selectedPlayerListValues",_listValues] call ALIVE_fnc_hashSet;

                    [_logic,"taskingState",_taskingState] call MAINCLASS;

                    _selectedPlayerList lbDelete _selectedIndex;

                    _deleteButton ctrlShow false;

                    if(count _listOptions == 0) then {

                        _selectedPlayersAddTaskButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskSelectedPlayersAddTaskButton);
                        _selectedPlayersAddTaskButton ctrlShow false;

                        _selectedPlayersClearButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskSelectedPlayersClearButton);
                        _selectedPlayersClearButton ctrlShow false;

                    };

                };

                case "TASK_SELECTED_PLAYER_LIST_CLEAR_BUTTON_CLICK": {

                    private ["_taskingState","_selectedPlayerList","_selectedPlayersAddTaskButton","_selectedPlayersClearButton"];

                    _taskingState = [_logic,"taskingState"] call MAINCLASS;

                    _selectedPlayerList = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskSelectedPlayerList);

                    [_taskingState,"selectedPlayerListOptions",[]] call ALIVE_fnc_hashSet;
                    [_taskingState,"selectedPlayerListValues",[]] call ALIVE_fnc_hashSet;

                    [_logic,"taskingState",_taskingState] call MAINCLASS;

                    lbClear _selectedPlayerList;

                    _selectedPlayersAddTaskButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskSelectedPlayersAddTaskButton);
                    _selectedPlayersAddTaskButton ctrlShow false;

                    _selectedPlayersClearButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskSelectedPlayersClearButton);
                    _selectedPlayersClearButton ctrlShow false;
                };

                case "TASK_CURRENT_TASK_LIST_SELECT": {

                    private ["_taskingState","_currentTaskList","_selectedIndex","_listOptions","_listValues","_selectedOption","_selectedValue"];

                    _taskingState = [_logic,"taskingState"] call MAINCLASS;

                    _currentTaskList = _args select 0 select 0;
                    _selectedIndex = _args select 0 select 1;
                    _listOptions = [_taskingState,"currentTaskListOptions"] call ALIVE_fnc_hashGet;
                    _listValues = [_taskingState,"currentTaskListValues"] call ALIVE_fnc_hashGet;
                    _selectedOption = _listOptions select _selectedIndex;
                    _selectedValue = _listValues select _selectedIndex;

                    [_taskingState,"currentTaskListSelectedIndex",_selectedIndex] call ALIVE_fnc_hashSet;
                    [_taskingState,"currentTaskListSelectedValue",_selectedValue] call ALIVE_fnc_hashSet;

                    [_logic,"taskingState",_taskingState] call MAINCLASS;

                    _taskingState call ALIVE_fnc_inspectHash;

                    private ["_taskCurrentEditButton","_taskCurrentDeleteButton"];

                    _taskCurrentEditButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskCurrentListEditButton);
                    _taskCurrentEditButton ctrlShow true;
                    _taskCurrentEditButton ctrlSetEventHandler ["MouseButtonClick", "['TASK_CURRENT_EDIT_BUTTON_CLICK',[_this]] call ALIVE_fnc_C2TabletOnAction"];

                    _taskCurrentDeleteButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskCurrentListDeleteButton);
                    _taskCurrentDeleteButton ctrlShow true;
                    _taskCurrentDeleteButton ctrlSetEventHandler ["MouseButtonClick", "['TASK_CURRENT_DELETE_BUTTON_CLICK',[_this]] call ALIVE_fnc_C2TabletOnAction"];

                };

                case "TASK_CURRENT_EDIT_BUTTON_CLICK": {

                    [_logic,"disableTasking"] call MAINCLASS;
                    [_logic,"enableEditTask"] call MAINCLASS;

                };

                case "TASK_CURRENT_DELETE_BUTTON_CLICK": {

                    private ["_taskingState","_currentTask","_taskID","_side","_playerID","_event"];

                    _taskingState = [_logic,"taskingState"] call MAINCLASS;

                    _currentTask = [_taskingState,"currentTaskListSelectedValue"] call ALIVE_fnc_hashGet;

                    _side = [_logic,"side"] call MAINCLASS;
                    _playerID = getPlayerUID player;
                    _taskID = _currentTask select 0;

                    _event = ['TASK_DELETE', [_taskID,_playerID,_side], "C2ISTAR"] call ALIVE_fnc_event;

                    if(isServer) then {
                        [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;
                    }else{
                        ["server","ALIVE_ADD_EVENT",[[_event],"ALIVE_fnc_addEventToServer"]] call ALiVE_fnc_BUS;
                    };

                    private ["_taskCurrentEditButton","_taskCurrentDeleteButton"];

                    _taskCurrentEditButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskCurrentListEditButton);
                    _taskCurrentEditButton ctrlShow false;

                    _taskCurrentDeleteButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskCurrentListDeleteButton);
                    _taskCurrentDeleteButton ctrlShow false;

                };

                case "TASK_EDIT_BACK_BUTTON_CLICK": {
                    [_logic,"disableEditTask"] call MAINCLASS;
                    [_logic,"enableTasking"] call MAINCLASS;
                };

                case "TASK_EDIT_BUTTON_CLICK": {

                    private ["_taskingState","_currentTask","_titleEdit","_descriptionEdit","_title","_description",
                    "_side","_faction","_marker","_destination","_selectedPlayers","_event","_taskID","_playerID","_state",
                    "_selectedPlayerListOptions","_selectedPlayerListValues","_apply","_current","_newSelectedPlayerListOptions","_newSelectedPlayerListValues"];

                    _taskingState = [_logic,"taskingState"] call MAINCLASS;

                    _currentTask = [_taskingState,"currentTaskListSelectedValue"] call ALIVE_fnc_hashGet;

                    _titleEdit = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddTitleEdit);
                    _descriptionEdit = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddDescriptionEdit);

                    _title = ctrlText _titleEdit;
                    _description = ctrlText _descriptionEdit;

                    _side = [_logic,"side"] call MAINCLASS;
                    _faction = [_logic,"faction"] call MAINCLASS;
                    _marker = [_logic,"taskMarker"] call MAINCLASS;
                    _destination = [_logic,"taskDestination"] call MAINCLASS;

                    _state = [_taskingState,"currentTaskStateSelectedValue"] call ALIVE_fnc_hashGet;
                    _apply = [_taskingState,"currentTaskApplySelectedValue"] call ALIVE_fnc_hashGet;
                    _current = [_taskingState,"currentTaskCurrentSelectedValue"] call ALIVE_fnc_hashGet;

                    _playerID = getPlayerUID player;
                    _taskID = _currentTask select 0;
                    _selectedPlayerListOptions = _currentTask select 7 select 1;
                    _selectedPlayerListValues = _currentTask select 7 select 0;

                    _newSelectedPlayerListOptions = [];
                    _newSelectedPlayerListOptions = _newSelectedPlayerListOptions + _selectedPlayerListOptions;

                    _newSelectedPlayerListValues = [];
                    _newSelectedPlayerListValues = _newSelectedPlayerListValues + _selectedPlayerListValues;

                    _selectedPlayers = [];
                    _selectedPlayers set [0, _newSelectedPlayerListValues];
                    _selectedPlayers set [1, _newSelectedPlayerListOptions];

                    _event = ['TASK_UPDATE', [_taskID,_playerID,_side,_destination,_faction,_title,_description,_selectedPlayers,_state,_apply,_current], "C2ISTAR"] call ALIVE_fnc_event;

                    if(isServer) then {
                        [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;
                    }else{
                        ["server","ALIVE_ADD_EVENT",[[_event],"ALIVE_fnc_addEventToServer"]] call ALiVE_fnc_BUS;
                    };

                    [_logic,"disableEditTask"] call MAINCLASS;
                    [_logic,"enableTasking"] call MAINCLASS;
                };

                case "TASK_EDIT_MANAGE_PLAYERS_BUTTON_CLICK": {

                    [_logic,"disableEditTask"] call MAINCLASS;
                    [_logic,"enableEditTaskManagePlayers"] call MAINCLASS;

                };

                case "TASK_EDIT_MANAGE_PLAYERS_BACK_BUTTON_CLICK": {

                    [_logic,"disableEditTaskManagePlayers"] call MAINCLASS;
                    [_logic,"enableEditTask"] call MAINCLASS;

                };

                case "TASK_EDIT_MANAGE_PLAYER_LIST_SELECT": {

                    private ["_taskingState","_playerList","_selectedIndex","_listOptions","_listValues","_selectedOption","_selectedValue","_selectedPlayersAddTaskButton","_selectedPlayersClearButton"];

                    _taskingState = [_logic,"taskingState"] call MAINCLASS;

                    _playerList = _args select 0 select 0;
                    _selectedIndex = _args select 0 select 1;
                    _listOptions = [_taskingState,"currentTaskPlayerListOptions"] call ALIVE_fnc_hashGet;
                    _listValues = [_taskingState,"currentTaskPlayerListValues"] call ALIVE_fnc_hashGet;
                    _selectedOption = _listOptions select _selectedIndex;
                    _selectedValue = _listValues select _selectedIndex;

                    [_taskingState,"currentTaskPlayerListSelectedIndex",_selectedIndex] call ALIVE_fnc_hashSet;
                    [_taskingState,"currentTaskPlayerListSelectedValue",_selectedValue] call ALIVE_fnc_hashSet;

                    [_logic,"taskingState",_taskingState] call MAINCLASS;

                    _taskingState call ALIVE_fnc_inspectHash;

                    private ["_selectedPlayerListOptions","_selectedPlayerListValues","_selectedPlayerList"];

                    _selectedPlayerListOptions = [_taskingState,"currentTaskSelectedPlayerListOptions"] call ALIVE_fnc_hashGet;
                    _selectedPlayerListValues = [_taskingState,"currentTaskSelectedPlayerListValues"] call ALIVE_fnc_hashGet;

                    if!(_selectedOption in _selectedPlayerListOptions) then {

                        _selectedPlayerListOptions set [count _selectedPlayerListOptions,_selectedOption];
                        _selectedPlayerListValues set [count _selectedPlayerListValues,_selectedValue];

                        [_taskingState,"currentTaskSelectedPlayerListOptions",_selectedPlayerListOptions] call ALIVE_fnc_hashSet;
                        [_taskingState,"currentTaskSelectedPlayerListValues",_selectedPlayerListValues] call ALIVE_fnc_hashSet;

                        _selectedPlayerList = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskSelectedPlayerList);

                        _selectedPlayerList lbAdd format["%1", _selectedOption];

                        private ["_selectGroupButton"];

                        _selectGroupButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskSelectGroupButton);
                        _selectGroupButton ctrlShow true;

                        _selectGroupButton ctrlSetEventHandler ["MouseButtonClick", "['TASK_EDIT_MANAGER_SELECT_GROUP_BUTTON_CLICK',[_this]] call ALIVE_fnc_C2TabletOnAction"];
                    };
                };

                case "TASK_EDIT_MANAGER_SELECT_GROUP_BUTTON_CLICK": {

                    private ["_taskingState","_selectedIndex","_listValues","_selectedPlayerUID","_playersInGroup"];

                    _taskingState = [_logic,"taskingState"] call MAINCLASS;

                    _selectedIndex = [_taskingState,"currentTaskPlayerListSelectedIndex"] call ALIVE_fnc_hashGet;
                    _listValues = [_taskingState,"currentTaskPlayerListValues"] call ALIVE_fnc_hashGet;

                    _selectedPlayerUID = _listValues select _selectedIndex;

                    _playersInGroup = [_selectedPlayerUID] call ALiVE_fnc_getPlayersInGroupDataSource;

                    if(count (_playersInGroup select 0) > 0) then {

                        private ["_selectedPlayerListOptions","_selectedPlayerListValues","_selectedPlayerList"];

                        _selectedPlayerListOptions = [_taskingState,"currentTaskSelectedPlayerListOptions"] call ALIVE_fnc_hashGet;
                        _selectedPlayerListValues = [_taskingState,"currentTaskSelectedPlayerListValues"] call ALIVE_fnc_hashGet;

                        _selectedPlayerList = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskSelectedPlayerList);

                        {
                            if!((_x select 0) in _selectedPlayerListOptions) then {
                                _selectedPlayerListOptions set [count _selectedPlayerListOptions,_x select 0];
                                _selectedPlayerListValues set [count _selectedPlayerListValues,_x select 1];

                                _selectedPlayerList lbAdd format["%1", _x select 0];
                            };
                        } foreach _playersInGroup;

                        [_taskingState,"currentTaskSelectedPlayerListOptions",_selectedPlayerListOptions] call ALIVE_fnc_hashSet;
                        [_taskingState,"currentTaskSelectedPlayerListValues",_selectedPlayerListValues] call ALIVE_fnc_hashSet;
                    };

                };

                case "TASK_EDIT_MANAGE_SELECTED_PLAYER_LIST_SELECT": {

                    private ["_taskingState","_selectedPlayerList","_selectedIndex","_listOptions","_listValues","_selectedOption","_selectedValue"];

                    _taskingState = [_logic,"taskingState"] call MAINCLASS;

                    _selectedPlayerList = _args select 0 select 0;
                    _selectedIndex = _args select 0 select 1;
                    _listOptions = [_taskingState,"currentTaskSelectedPlayerListOptions"] call ALIVE_fnc_hashGet;
                    _listValues = [_taskingState,"currentTaskSelectedPlayerListValues"] call ALIVE_fnc_hashGet;
                    _selectedOption = _listOptions select _selectedIndex;
                    _selectedValue = _listValues select _selectedIndex;

                    [_taskingState,"currentTaskSelectedPlayerListSelectedIndex",_selectedIndex] call ALIVE_fnc_hashSet;
                    [_taskingState,"currentTaskSelectedPlayerListSelectedValue",_selectedValue] call ALIVE_fnc_hashSet;

                    [_logic,"taskingState",_taskingState] call MAINCLASS;

                    _taskingState call ALIVE_fnc_inspectHash;

                    private ["_selectedPlayerListDeleteButton","_selectedPlayersClearButton"];

                    _selectedPlayerListDeleteButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskSelectedPlayerListDeleteButton);
                    _selectedPlayerListDeleteButton ctrlShow true;

                    _selectedPlayerListDeleteButton ctrlSetEventHandler ["MouseButtonClick", "['TASK_EDIT_MANAGE_PLAYERS_SELECTED_PLAYER_LIST_DELETE_BUTTON_CLICK',[_this]] call ALIVE_fnc_C2TabletOnAction"];
                };

                case "TASK_EDIT_MANAGE_PLAYERS_SELECTED_PLAYER_LIST_DELETE_BUTTON_CLICK": {

                    private ["_taskingState","_currentTask","_currentTaskPlayers","_currentTaskPlayersOptions","_currentTaskPlayersValues","_deleteButton",
                    "_selectedPlayerList","_selectedIndex","_listOptions","_listValues","_delete","_selectedPlayersAddTaskButton","_selectedPlayersClearButton"];

                    _taskingState = [_logic,"taskingState"] call MAINCLASS;

                    _currentTask = [_taskingState,"currentTaskListSelectedValue"] call ALIVE_fnc_hashGet;
                    _currentTaskPlayers = _currentTask select 7;
                    _currentTaskPlayersOptions = _currentTaskPlayers select 1;
                    _currentTaskPlayersValues = _currentTaskPlayers select 0;

                    _deleteButton = _args select 0 select 0;
                    _selectedPlayerList = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskSelectedPlayerList);
                    _selectedIndex = lbCurSel _selectedPlayerList;
                    _listOptions = [_taskingState,"currentTaskSelectedPlayerListOptions"] call ALIVE_fnc_hashGet;
                    _listValues = [_taskingState,"currentTaskSelectedPlayerListValues"] call ALIVE_fnc_hashGet;

                    _listOptions set [_selectedIndex,"del"];
                    _listValues set [_selectedIndex,"del"];

                    _delete = ["del"];

                    _listOptions = _listOptions - _delete;
                    _listValues = _listValues - _delete;

                    [_taskingState,"currentTaskSelectedPlayerListOptions",_listOptions] call ALIVE_fnc_hashSet;
                    [_taskingState,"currentTaskSelectedPlayerListValues",_listValues] call ALIVE_fnc_hashSet;

                    _currentTaskPlayersValues = _currentTaskPlayersValues - _delete;
                    _currentTaskPlayersOptions = _currentTaskPlayersOptions - _delete;

                    _currentTaskPlayers set [0,_currentTaskPlayersValues];
                    _currentTaskPlayers set [1,_currentTaskPlayersOptions];

                    _currentTask set [7,_currentTaskPlayers];

                    [_taskingState,"currentTaskListSelectedValue",_currentTask] call ALIVE_fnc_hashSet;

                    [_logic,"taskingState",_taskingState] call MAINCLASS;

                    _selectedPlayerList lbDelete _selectedIndex;

                    _deleteButton ctrlShow false;
                };

            };

        };

    };
    case "loadInitialData": {

        private ["_side","_playerID","_event"];

        _side = [_logic,"side"] call MAINCLASS;

        _playerID = getPlayerUID player;

        _event = ['TASKS_UPDATE', ["",_playerID,_side], "C2ISTAR"] call ALIVE_fnc_event;

        if(isServer) then {
            [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;
        }else{
            ["server","ALIVE_ADD_EVENT",[[_event],"ALIVE_fnc_addEventToServer"]] call ALiVE_fnc_BUS;
        };
    };
    case "updateCurrentTaskList": {

        private["_taskState","_taskingState","_task","_newTask","_newPlayers","_newPlayerIDs","_newPlayerNames","_players",
        "_playerIDs","_playerNames","_title","_listOptions","_listValues","_taskCurrentList"];

        disableSerialization;

        _taskState = _args;

        _taskingState = [_logic,"taskingState"] call MAINCLASS;

        _listOptions = [];
        _listValues = [];

        {
            _task = _x;
            _newTask = [];

            _newTask set [0,_task select 0];
            _newTask set [1,_task select 1];
            _newTask set [2,_task select 2];
            _newTask set [3,_task select 3];
            _newTask set [4,_task select 4];
            _newTask set [5,_task select 5];
            _newTask set [6,_task select 6];

            _newPlayers = [];
            _newPlayerIDs = [];
            _newPlayerNames = [];

            _players = _task select 7;
            _playerIDs = _players select 0;
            _playerNames = _players select 1;

            {
                _newPlayerIDs set [count _newPlayerIDs, _x];
            } forEach _playerIDs;

            {
                _newPlayerNames set [count _newPlayerNames, _x];
            } forEach _playerNames;

            _newPlayers set [0,_newPlayerIDs];
            _newPlayers set [1,_newPlayerNames];

            _newTask set [7,_newPlayers];
            _newTask set [8,_task select 8];
            _newTask set [9,_task select 9];
            _newTask set [10,_task select 10];

            _title = _newTask select 5;

            _listOptions set [count _listOptions, _title];
            _listValues set [count _listValues, _newTask];

        } foreach _taskState;

        [_taskingState,"currentTaskListOptions",_listOptions] call ALIVE_fnc_hashSet;
        [_taskingState,"currentTaskListValues",_listValues] call ALIVE_fnc_hashSet;

        _taskCurrentList = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskCurrentList);

        lbClear _taskCurrentList;

        {
            _taskCurrentList lbAdd format["%1", _x];
        } forEach _listOptions;

        _taskCurrentList ctrlSetEventHandler ["LBSelChanged", "['TASK_CURRENT_TASK_LIST_SELECT',[_this]] call ALIVE_fnc_C2TabletOnAction"];

    };
    case "disableAll": {

        [_logic,"disableMainMenu"] call MAINCLASS;
        [_logic,"disableTasking"] call MAINCLASS;
        [_logic,"disableAAR"] call MAINCLASS;
        [_logic,"disableISTAR"] call MAINCLASS;
        [_logic,"disableAddTask"] call MAINCLASS;
        [_logic,"disableEditTask"] call MAINCLASS;
        [_logic,"disableAddTaskManagePlayers"] call MAINCLASS;
        [_logic,"disableEditTaskManagePlayers"] call MAINCLASS;

    };
    case "enableMainMenu": {

        private ["_tasksButton","_aarButton","_istarButton","_abortButton"];

        _tasksButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_MainMenuTasks);
        _tasksButton ctrlShow true;
        _tasksButton ctrlSetEventHandler ["MouseButtonClick", "['MAIN_MENU_TASKING_CLICK',[_this]] call ALIVE_fnc_C2TabletOnAction"];

        _aarButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_MainMenuAAR);
        _aarButton ctrlShow true;
        _aarButton ctrlSetEventHandler ["MouseButtonClick", "['MAIN_MENU_AAR_CLICK',[_this]] call ALIVE_fnc_C2TabletOnAction"];

        _istarButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_MainMenuISTAR);
        _istarButton ctrlShow true;
        _istarButton ctrlSetEventHandler ["MouseButtonClick", "['MAIN_MENU_ISTAR_CLICK',[_this]] call ALIVE_fnc_C2TabletOnAction"];

        _abortButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_MainMenuAbort);
        _abortButton ctrlShow true;

    };
    case "disableMainMenu": {

        private ["_tasksButton","_aarButton","_istarButton","_abortButton"];

        _tasksButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_MainMenuTasks);
        _tasksButton ctrlShow false;

        _aarButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_MainMenuAAR);
        _aarButton ctrlShow false;

        _istarButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_MainMenuISTAR);
        _istarButton ctrlShow false;

        _abortButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_MainMenuAbort);
        _abortButton ctrlShow false;

    };
    case "enableTasking": {

        private ["_taskingState","_title","_backButton","_abortButton","_addTaskButton"];

        _taskingState = [_logic,"taskingState"] call MAINCLASS;

        _taskingState call ALIVE_fnc_inspectHash;

        _title = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_Title);
        _title ctrlShow true;

        _title ctrlSetText "Current Tasks";

        _backButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuBack);
        _backButton ctrlShow true;
        _backButton ctrlSetEventHandler ["MouseButtonClick", "['BACK_BUTTON_CLICK',[_this]] call ALIVE_fnc_C2TabletOnAction"];

        _abortButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuAbort);
        _abortButton ctrlShow true;

        _addTaskButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskSelectedPlayersAddTaskButton);
        _addTaskButton ctrlShow true;

        _addTaskButton ctrlSetEventHandler ["MouseButtonClick", "['TASK_ADD_BUTTON_CLICK',[_this]] call ALIVE_fnc_C2TabletOnAction"];

        private ["_taskCurrentList","_currentTaskListOptions"];

        _taskCurrentList = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskCurrentList);
        _taskCurrentList ctrlShow true;

        private ["_taskCurrentEditButton","_taskCurrentDeleteButton"];

        _taskCurrentEditButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskCurrentListEditButton);
        _taskCurrentEditButton ctrlShow false;

        _taskCurrentDeleteButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskCurrentListDeleteButton);
        _taskCurrentDeleteButton ctrlShow false;

    };
    case "disableTasking": {

        private ["_title","_backButton","_abortButton","_playerList","_addTaskButton"];

        _title = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_Title);
        _title ctrlShow false;

        _backButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuBack);
        _backButton ctrlShow false;

        _abortButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuAbort);
        _abortButton ctrlShow false;

        _addTaskButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskSelectedPlayersAddTaskButton);
        _addTaskButton ctrlShow false;

        private ["_taskCurrentList"];

        _taskCurrentList = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskCurrentList);
        _taskCurrentList ctrlShow false;

        private ["_taskCurrentEditButton","_taskCurrentDeleteButton"];

        _taskCurrentEditButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskCurrentListEditButton);
        _taskCurrentEditButton ctrlShow false;

        _taskCurrentDeleteButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskCurrentListDeleteButton);
        _taskCurrentDeleteButton ctrlShow false;

    };
    case "enableAddTask": {

        private ["_taskingState"];

        _taskingState = [_logic,"taskingState"] call MAINCLASS;

        _taskingState call ALIVE_fnc_inspectHash;

        private ["_title","_backButton","_abortButton"];

        _title = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_Title);
        _title ctrlShow true;

        _title ctrlSetText "Add Task";

        _backButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuBack);
        _backButton ctrlShow true;
        _backButton ctrlSetEventHandler ["MouseButtonClick", "['TASK_ADD_BACK_BUTTON_CLICK',[_this]] call ALIVE_fnc_C2TabletOnAction"];

        _abortButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuAbort);
        _abortButton ctrlShow true;

        private ["_editTitle","_titleEdit","_editDescription","_descriptionEdit","_map","_createButton","_stateTitle",
        "_stateList","_stateListOptions","_managePlayersButton","_applyTitle","_applyList","_applyListOptions"];

        _editTitle = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddTitleEditTitle);
        _editTitle ctrlShow true;

        _titleEdit = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddTitleEdit);
        _titleEdit ctrlShow true;

        _editDescription = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddDescriptionEditTitle);
        _editDescription ctrlShow true;

        _descriptionEdit = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddDescriptionEdit);
        _descriptionEdit ctrlShow true;

        _stateTitle = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddStateEditTitle);
        _stateTitle ctrlShow true;

        _stateList = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddStateEdit);
        _stateList ctrlShow true;

        _stateListOptions = [_taskingState,"currentTaskStateOptions"] call ALIVE_fnc_hashGet;

        lbClear _stateList;

        {
            _stateList lbAdd format["%1", _x];
        } forEach _stateListOptions;

        _stateList ctrlSetEventHandler ["LBSelChanged", "['TASK_ADD_STATE_LIST_SELECT',[_this]] call ALIVE_fnc_C2TabletOnAction"];

        _applyTitle = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddApplyTitle);
        _applyTitle ctrlShow true;

        _applyList = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddApplyEdit);
        _applyList ctrlShow true;

        _applyListOptions = [_taskingState,"currentTaskApplyOptions"] call ALIVE_fnc_hashGet;

        lbClear _applyList;

        {
            _applyList lbAdd format["%1", _x];
        } forEach _applyListOptions;

        _applyList ctrlSetEventHandler ["LBSelChanged", "['TASK_ADD_APPLY_LIST_SELECT',[_this]] call ALIVE_fnc_C2TabletOnAction"];

        private ["_currentTitle","_currentList","_currentIndex","_currentListOptions"];

        _currentTitle = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddCurrentTitle);
        _currentTitle ctrlShow true;

        _currentList = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddCurrentEdit);
        _currentList ctrlShow true;

        _currentListOptions = [_taskingState,"currentTaskCurrentOptions"] call ALIVE_fnc_hashGet;

        lbClear _currentList;

        {
            _currentList lbAdd format["%1", _x];
        } forEach _currentListOptions;

        _currentList ctrlSetEventHandler ["LBSelChanged", "['TASK_ADD_CURRENT_LIST_SELECT',[_this]] call ALIVE_fnc_C2TabletOnAction"];

        _map = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddMap);
        _map ctrlShow true;
        _map ctrlSetEventHandler ["MouseButtonDown", "['TASK_ADD_MAP_CLICK',[_this]] call ALIVE_fnc_C2TabletOnAction"];

        _managePlayersButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskEditManagePlayersButton);
        _managePlayersButton ctrlShow true;
        _managePlayersButton ctrlSetEventHandler ["MouseButtonClick", "['TASK_ADD_MANAGE_PLAYERS_BUTTON_CLICK',[_this]] call ALIVE_fnc_C2TabletOnAction"];

        _createButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddCreateButton);
        _createButton ctrlShow true;
        _createButton ctrlSetEventHandler ["MouseButtonClick", "['TASK_ADD_CREATE_BUTTON_CLICK',[_this]] call ALIVE_fnc_C2TabletOnAction"];

    };
    case "disableAddTask": {

        private ["_taskingState"];

        _taskingState = [_logic,"taskingState"] call MAINCLASS;

        _taskingState call ALIVE_fnc_inspectHash;

        private ["_title","_backButton","_abortButton"];

        _title = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_Title);
        _title ctrlShow false;

        _backButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuBack);
        _backButton ctrlShow false;

        _abortButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuAbort);
        _abortButton ctrlShow false;

        private ["_editTitle","_titleEdit","_editDescription","_descriptionEdit","_map","_createButton","_stateTitle","_stateList","_managePlayersButton","_applyTitle","_applyList","_currentTitle","_currentList"];

        _editTitle = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddTitleEditTitle);
        _editTitle ctrlShow false;

        _titleEdit = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddTitleEdit);
        _titleEdit ctrlShow false;

        _editDescription = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddDescriptionEditTitle);
        _editDescription ctrlShow false;

        _descriptionEdit = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddDescriptionEdit);
        _descriptionEdit ctrlShow false;

        _stateTitle = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddStateEditTitle);
        _stateTitle ctrlShow false;

        _stateList = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddStateEdit);
        _stateList ctrlShow false;

        _applyTitle = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddApplyTitle);
        _applyTitle ctrlShow false;

        _applyList = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddApplyEdit);
        _applyList ctrlShow false;

        _currentTitle = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddCurrentTitle);
        _currentTitle ctrlShow false;

        _currentList = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddCurrentEdit);
        _currentList ctrlShow false;

        _map = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddMap);
        _map ctrlShow false;

        _managePlayersButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskEditManagePlayersButton);
        _managePlayersButton ctrlShow false;

        _createButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddCreateButton);
        _createButton ctrlShow false;

    };
    case "enableAddTaskManagePlayers": {

        private ["_taskingState"];

        _taskingState = [_logic,"taskingState"] call MAINCLASS;

        _taskingState call ALIVE_fnc_inspectHash;

        private ["_title","_backButton","_abortButton"];

        _title = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_Title);
        _title ctrlShow true;

        _title ctrlSetText "Assign players to this task";

        _backButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuBack);
        _backButton ctrlShow true;
        _backButton ctrlSetEventHandler ["MouseButtonClick", "['TASK_ADD_MANAGE_PLAYERS_BACK_BUTTON_CLICK',[_this]] call ALIVE_fnc_C2TabletOnAction"];

        _abortButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuAbort);
        _abortButton ctrlShow true;

        private ["_playerList","_playerListOptions","_playerDataSource"];

        _playerList = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskPlayerList);
        _playerList ctrlShow true;

        _playerDataSource = call ALiVE_fnc_getPlayersDataSource;
        [_taskingState,"playerListOptions",_playerDataSource select 0] call ALIVE_fnc_hashSet;
        [_taskingState,"playerListValues",_playerDataSource select 1] call ALIVE_fnc_hashSet;

        [_logic,"taskingState",_taskingState] call MAINCLASS;

        _playerListOptions = [_taskingState,"playerListOptions"] call ALIVE_fnc_hashGet;

        lbClear _playerList;

        {
            _playerList lbAdd format["%1", _x];
        } forEach _playerListOptions;

        _playerList ctrlSetEventHandler ["LBSelChanged", "['TASK_PLAYER_LIST_SELECT',[_this]] call ALIVE_fnc_C2TabletOnAction"];

        private ["_selectedPlayerTitle","_selectedPlayerList","_selectedPlayerListOptions"];

        _selectedPlayerTitle = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskSelectedPlayerTitle);
        _selectedPlayerTitle ctrlShow true;

        _selectedPlayerList = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskSelectedPlayerList);
        _selectedPlayerList ctrlShow true;

        _selectedPlayerListOptions = [_taskingState,"selectedPlayerListOptions"] call ALIVE_fnc_hashGet;

        lbClear _selectedPlayerList;

        {
            _selectedPlayerList lbAdd format["%1", _x];
        } forEach _selectedPlayerListOptions;

        _selectedPlayerList ctrlSetEventHandler ["LBSelChanged", "['TASK_SELECTED_PLAYER_LIST_SELECT',[_this]] call ALIVE_fnc_C2TabletOnAction"];

        private ["_selectedPlayersAddTaskButton","_selectedPlayersClearButton"];

        if(count _selectedPlayerListOptions > 0) then {

            _selectedPlayersClearButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskSelectedPlayersClearButton);
            _selectedPlayersClearButton ctrlShow true;

            _selectedPlayersClearButton ctrlSetEventHandler ["MouseButtonClick", "['TASK_SELECTED_PLAYER_LIST_CLEAR_BUTTON_CLICK',[_this]] call ALIVE_fnc_C2TabletOnAction"];

        };
    };
    case "disableAddTaskManagePlayers": {

        private ["_title","_backButton","_abortButton"];

        _title = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_Title);
        _title ctrlShow false;

        _backButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuBack);
        _backButton ctrlShow false;

        _abortButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuAbort);
        _abortButton ctrlShow false;

        private ["_playerList"];

        _playerList = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskPlayerList);
        _playerList ctrlShow false;

        private ["_selectedPlayerTitle","_selectedPlayerList"];

        _selectedPlayerTitle = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskSelectedPlayerTitle);
        _selectedPlayerTitle ctrlShow false;

        _selectedPlayerList = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskSelectedPlayerList);
        _selectedPlayerList ctrlShow false;

        private ["_selectGroupButton","_selectedPlayerListDeleteButton","_selectedPlayersAddTaskButton","_selectedPlayersClearButton"];

        _selectGroupButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskSelectGroupButton);
        _selectGroupButton ctrlShow false;

        _selectedPlayerListDeleteButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskSelectedPlayerListDeleteButton);
        _selectedPlayerListDeleteButton ctrlShow false;

        _selectedPlayersAddTaskButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskSelectedPlayersAddTaskButton);
        _selectedPlayersAddTaskButton ctrlShow false;

        _selectedPlayersClearButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskSelectedPlayersClearButton);
        _selectedPlayersClearButton ctrlShow false;

    };
    case "enableEditTask": {

        private ["_taskingState","_currentTask"];

        _taskingState = [_logic,"taskingState"] call MAINCLASS;

        _currentTask = [_taskingState,"currentTaskListSelectedValue"] call ALIVE_fnc_hashGet;

        _taskingState call ALIVE_fnc_inspectHash;

        private ["_title","_backButton","_abortButton"];

        _title = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_Title);
        _title ctrlShow true;

        _title ctrlSetText "Edit Task";

        _backButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuBack);
        _backButton ctrlShow true;
        _backButton ctrlSetEventHandler ["MouseButtonClick", "['TASK_EDIT_BACK_BUTTON_CLICK',[_this]] call ALIVE_fnc_C2TabletOnAction"];

        _abortButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuAbort);
        _abortButton ctrlShow true;

        private ["_editTitle","_titleEdit","_editDescription","_descriptionEdit","_map","_createButton","_editButton"];

        _editTitle = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddTitleEditTitle);
        _editTitle ctrlShow true;

        _titleEdit = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddTitleEdit);
        _titleEdit ctrlShow true;

        _titleEdit ctrlSetText (_currentTask select 5);

        _editDescription = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddDescriptionEditTitle);
        _editDescription ctrlShow true;

        _descriptionEdit = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddDescriptionEdit);
        _descriptionEdit ctrlShow true;

        _descriptionEdit ctrlSetText (_currentTask select 6);

        private ["_stateTitle","_stateList","_stateListOptions","_stateIndex"];

        _stateTitle = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddStateEditTitle);
        _stateTitle ctrlShow true;

        _stateList = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddStateEdit);
        _stateList ctrlShow true;

        _stateListOptions = [_taskingState,"currentTaskStateOptions"] call ALIVE_fnc_hashGet;

        lbClear _stateList;

        {
            _stateList lbAdd format["%1", _x];
        } forEach _stateListOptions;

        _stateIndex = _stateListOptions find (_currentTask select 8);
        _stateList lbSetCurSel _stateIndex;

        _stateList ctrlSetEventHandler ["LBSelChanged", "['TASK_ADD_STATE_LIST_SELECT',[_this]] call ALIVE_fnc_C2TabletOnAction"];

        private ["_applyTitle","_applyList","_applyIndex","_applyListOptions","_applyListValues"];

        _applyTitle = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddApplyTitle);
        _applyTitle ctrlShow true;

        _applyList = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddApplyEdit);
        _applyList ctrlShow true;

        _applyListOptions = [_taskingState,"currentTaskApplyOptions"] call ALIVE_fnc_hashGet;
        _applyListValues = [_taskingState,"currentTaskApplyValues"] call ALIVE_fnc_hashGet;

        lbClear _applyList;

        {
            _applyList lbAdd format["%1", _x];
        } forEach _applyListOptions;

        _applyIndex = _applyListValues find (_currentTask select 9);
        _applyList lbSetCurSel _applyIndex;

        _applyList ctrlSetEventHandler ["LBSelChanged", "['TASK_ADD_APPLY_LIST_SELECT',[_this]] call ALIVE_fnc_C2TabletOnAction"];

        private ["_currentTitle","_currentList","_currentIndex","_currentListOptions","_currentListValues"];

        _currentTitle = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddCurrentTitle);
        _currentTitle ctrlShow true;

        _currentList = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddCurrentEdit);
        _currentList ctrlShow true;

        _currentListOptions = [_taskingState,"currentTaskCurrentOptions"] call ALIVE_fnc_hashGet;
        _currentListValues = [_taskingState,"currentTaskCurrentValues"] call ALIVE_fnc_hashGet;

        lbClear _currentList;

        {
            _currentList lbAdd format["%1", _x];
        } forEach _currentListOptions;

        _currentIndex = _currentListValues find (_currentTask select 10);
        _currentList lbSetCurSel _currentIndex;

        _currentList ctrlSetEventHandler ["LBSelChanged", "['TASK_ADD_CURRENT_LIST_SELECT',[_this]] call ALIVE_fnc_C2TabletOnAction"];

        _map = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddMap);
        _map ctrlShow true;
        _map ctrlSetEventHandler ["MouseButtonDown", "['TASK_ADD_MAP_CLICK',[_this]] call ALIVE_fnc_C2TabletOnAction"];

        _managePlayersButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskEditManagePlayersButton);
        _managePlayersButton ctrlShow true;
        _managePlayersButton ctrlSetEventHandler ["MouseButtonClick", "['TASK_EDIT_MANAGE_PLAYERS_BUTTON_CLICK',[_this]] call ALIVE_fnc_C2TabletOnAction"];

        _editButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskEditUpdateButton);
        _editButton ctrlShow true;
        _editButton ctrlSetEventHandler ["MouseButtonClick", "['TASK_EDIT_BUTTON_CLICK',[_this]] call ALIVE_fnc_C2TabletOnAction"];

        private ["_posX","_posY","_markers","_position","_marker"];

        _position = _currentTask select 3;

        if(count _position > 0) then {

            _markers = [_logic,"taskMarker"] call MAINCLASS;

            if(count _markers > 0) then {
                deleteMarkerLocal (_markers select 0);
            };

            ctrlMapAnimClear _map;
            _map ctrlMapAnimAdd [0.5, ctrlMapScale _map, _position];
            ctrlMapAnimCommit _map;

            _marker = createMarkerLocal [format["%1%2",MTEMPLATE,"marker"],_position];
            _marker setMarkerAlphaLocal 1;
            _marker setMarkerTextLocal "Destination";
            _marker setMarkerTypeLocal "hd_Objective";

            [_logic,"taskMarker",[_marker]] call MAINCLASS;
            [_logic,"taskDestination",_position] call MAINCLASS;

        };

    };
    case "disableEditTask": {

        private ["_taskingState"];

        _taskingState = [_logic,"taskingState"] call MAINCLASS;

        _taskingState call ALIVE_fnc_inspectHash;

        private ["_title","_backButton","_abortButton"];

        _title = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_Title);
        _title ctrlShow false;

        _backButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuBack);
        _backButton ctrlShow false;

        _abortButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuAbort);
        _abortButton ctrlShow false;

        private ["_editTitle","_titleEdit","_editDescription","_descriptionEdit","_map","_editButton","_stateTitle","_stateList","_managePlayersButton","_applyTitle","_applyList","_currentTitle","_currentList"];

        _editTitle = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddTitleEditTitle);
        _editTitle ctrlShow false;

        _titleEdit = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddTitleEdit);
        _titleEdit ctrlShow false;

        _editDescription = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddDescriptionEditTitle);
        _editDescription ctrlShow false;

        _descriptionEdit = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddDescriptionEdit);
        _descriptionEdit ctrlShow false;

        _stateTitle = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddStateEditTitle);
        _stateTitle ctrlShow false;

        _stateList = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddStateEdit);
        _stateList ctrlShow false;

        _applyTitle = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddApplyTitle);
        _applyTitle ctrlShow false;

        _applyList = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddApplyEdit);
        _applyList ctrlShow false;

        _currentTitle = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddCurrentTitle);
        _currentTitle ctrlShow false;

        _currentList = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddCurrentEdit);
        _currentList ctrlShow false;

        _map = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskAddMap);
        _map ctrlShow false;

        _managePlayersButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskEditManagePlayersButton);
        _managePlayersButton ctrlShow false;

        _editButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskEditUpdateButton);
        _editButton ctrlShow false;

    };
    case "enableEditTaskManagePlayers": {

        private ["_taskingState","_currentTask"];

        _taskingState = [_logic,"taskingState"] call MAINCLASS;

        _currentTask = [_taskingState,"currentTaskListSelectedValue"] call ALIVE_fnc_hashGet;

        _taskingState call ALIVE_fnc_inspectHash;

        private ["_title","_backButton","_abortButton"];

        _title = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_Title);
        _title ctrlShow true;

        _title ctrlSetText "Update assigned players for this task";

        _backButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuBack);
        _backButton ctrlShow true;
        _backButton ctrlSetEventHandler ["MouseButtonClick", "['TASK_EDIT_MANAGE_PLAYERS_BACK_BUTTON_CLICK',[_this]] call ALIVE_fnc_C2TabletOnAction"];

        _abortButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuAbort);
        _abortButton ctrlShow true;

        private ["_playerList","_playerListOptions","_playerDataSource"];

        _playerList = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskPlayerList);
        _playerList ctrlShow true;

        _playerDataSource = call ALiVE_fnc_getPlayersDataSource;
        [_taskingState,"currentTaskPlayerListOptions",_playerDataSource select 0] call ALIVE_fnc_hashSet;
        [_taskingState,"currentTaskPlayerListValues",_playerDataSource select 1] call ALIVE_fnc_hashSet;

        [_logic,"taskingState",_taskingState] call MAINCLASS;

        _playerListOptions = [_taskingState,"currentTaskPlayerListOptions"] call ALIVE_fnc_hashGet;

        lbClear _playerList;

        {
            _playerList lbAdd format["%1", _x];
        } forEach _playerListOptions;

        _playerList ctrlSetEventHandler ["LBSelChanged", "['TASK_EDIT_MANAGE_PLAYER_LIST_SELECT',[_this]] call ALIVE_fnc_C2TabletOnAction"];

        private ["_selectedPlayerTitle","_selectedPlayerList","_selectedPlayerListOptions","_selectedPlayerListValues"];

        _selectedPlayerTitle = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskSelectedPlayerTitle);
        _selectedPlayerTitle ctrlShow true;

        _selectedPlayerList = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskSelectedPlayerList);
        _selectedPlayerList ctrlShow true;

        _selectedPlayerListOptions = _currentTask select 7 select 1;
        _selectedPlayerListValues = _currentTask select 7 select 0;

        [_taskingState,"currentTaskSelectedPlayerListOptions",_selectedPlayerListOptions] call ALIVE_fnc_hashSet;
        [_taskingState,"currentTaskSelectedPlayerListValues",_selectedPlayerListValues] call ALIVE_fnc_hashSet;

        lbClear _selectedPlayerList;

        {
            _selectedPlayerList lbAdd format["%1", _x];
        } forEach _selectedPlayerListOptions;

        _selectedPlayerList ctrlSetEventHandler ["LBSelChanged", "['TASK_EDIT_MANAGE_SELECTED_PLAYER_LIST_SELECT',[_this]] call ALIVE_fnc_C2TabletOnAction"];

        [_taskingState,"selectedPlayerListOptions",[]] call ALIVE_fnc_hashSet;
        [_taskingState,"selectedPlayerListValues",[]] call ALIVE_fnc_hashSet;
        [_taskingState,"selectedPlayerListSelectedIndex",DEFAULT_SELECTED_INDEX] call ALIVE_fnc_hashSet;
        [_taskingState,"selectedPlayerListSelectedValue",DEFAULT_SELECTED_VALUE] call ALIVE_fnc_hashSet;

    };
    case "disableEditTaskManagePlayers": {

        private ["_title","_backButton","_abortButton","_playerList"];

        _title = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_Title);
        _title ctrlShow false;

        _backButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuBack);
        _backButton ctrlShow false;

        _abortButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuAbort);
        _abortButton ctrlShow false;

        _playerList = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskPlayerList);
        _playerList ctrlShow false;

        private ["_selectedPlayerTitle","_selectedPlayerList"];

        _selectedPlayerTitle = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskSelectedPlayerTitle);
        _selectedPlayerTitle ctrlShow false;

        _selectedPlayerList = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskSelectedPlayerList);
        _selectedPlayerList ctrlShow false;

        private ["_selectGroupButton","_selectedPlayerListDeleteButton","_selectedPlayersAddTaskButton","_selectedPlayersClearButton"];

        _selectGroupButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskSelectGroupButton);
        _selectGroupButton ctrlShow false;

        _selectedPlayerListDeleteButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskSelectedPlayerListDeleteButton);
        _selectedPlayerListDeleteButton ctrlShow false;

        _selectedPlayersAddTaskButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskSelectedPlayersAddTaskButton);
        _selectedPlayersAddTaskButton ctrlShow false;

        _selectedPlayersClearButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskSelectedPlayersClearButton);
        _selectedPlayersClearButton ctrlShow false;

    };
    case "enableAAR": {

        private ["_title","_backButton","_abortButton"];

        _title = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_Title);
        _title ctrlShow true;

        _backButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuBack);
        _backButton ctrlShow true;
        _backButton ctrlSetEventHandler ["MouseButtonClick", "['BACK_BUTTON_CLICK',[_this]] call ALIVE_fnc_C2TabletOnAction"];

        _abortButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuAbort);
        _abortButton ctrlShow true;

    };
    case "disableAAR": {

        private ["_title","_backButton","_abortButton"];

        _title = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_Title);
        _title ctrlShow false;

        _backButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuBack);
        _backButton ctrlShow false;

        _abortButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuAbort);
        _abortButton ctrlShow false;

    };
    case "enableISTAR": {

        private ["_title","_backButton","_abortButton"];

        _title = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_Title);
        _title ctrlShow true;

        _backButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuBack);
        _backButton ctrlShow true;
        _backButton ctrlSetEventHandler ["MouseButtonClick", "['BACK_BUTTON_CLICK',[_this]] call ALIVE_fnc_C2TabletOnAction"];

        _abortButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuAbort);
        _abortButton ctrlShow true;

    };
    case "disableISTAR": {

        private ["_title","_backButton","_abortButton"];

        _title = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_Title);
        _title ctrlShow false;

        _backButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuBack);
        _backButton ctrlShow false;

        _abortButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuAbort);
        _abortButton ctrlShow false;

    };
};

TRACE_1("C2 - output",_result);
_result;
