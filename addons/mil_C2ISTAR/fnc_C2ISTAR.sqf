//#define DEBUG_MODE_FULL
#include <\x\alive\addons\sup_player_resupply\script_component.hpp>
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

// tasking
#define C2Tablet_CTRL_TaskTitle 70007
#define C2Tablet_CTRL_TaskPlayerList 70011

// AAR
#define C2Tablet_CTRL_AARTitle 70008

// ISTAR
#define C2Tablet_CTRL_ISTARTitle 70009




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


	case "init": {

        _logic setVariable ["super", SUPERCLASS];
        _logic setVariable ["class", MAINCLASS];
        _logic setVariable ["moduleType", "ALIVE_C2ISTAR"];
        _logic setVariable ["startupComplete", false];

        ALIVE_MIL_C2ISTAR = _logic;

        [_logic, "start"] call MAINCLASS;


        if (hasInterface) then {

            _logic setVariable ["startupComplete", true];

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

            //private ["_taskingState","_playerListOptions","_playerListValues"];

            //_taskingState = [_logic,"taskingState"] call MAINCLASS;

            /*
            _playerListOptions = ["Player 1","Player 2","Player 3"];
            _playerListValues = ["p1","p2","p3"];

            [_taskingState,"playerListOptions",_playerListOptions] call ALIVE_fnc_hashSet;
            [_taskingState,"playerListValues",_playerListValues] call ALIVE_fnc_hashSet;
            [_taskingState,"playerListSelectedIndex",DEFAULT_SELECTED_INDEX] call ALIVE_fnc_hashSet;
            [_taskingState,"playerListSelectedValue",DEFAULT_SELECTED_VALUE] call ALIVE_fnc_hashSet;

            [_logic,"taskingState",_taskingState] call MAINCLASS;
            */


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

        _listenerID = [ALIVE_eventLog, "addListener",[_logic, ["LOGCOM_RESPONSE"]]] call ALIVE_fnc_eventLog;
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

                _playerID = _eventData select 1;

                _player = objNull;
                {
                    if (getPlayerUID _x == _playerID) exitWith {
                        _player = _x;
                    };
                } forEach playableUnits;

                if !(isNull _player) then {
                    [_event,"ALIVE_fnc_C2TabletEventToClient",_player,false,false] spawn BIS_fnc_MP;
                };

            }else{

                // the player is the server

                [_logic, "handleSERVERResponse", _event] call MAINCLASS;

            };

        };
    };
    case "handleSERVERResponse": {

        // event handler for LOGOM_RESPONSE
        // events

        private["_event","_eventData"];

        if(typeName _args == "ARRAY") then {

            _event = _args;
            _eventData = [_event, "data"] call ALIVE_fnc_hashGet;

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

                case "TASK_PLAYER_LIST_SELECT": {

                    private ["_taskingState","_playerList","_selectedIndex","_listOptions","_listValues","_selectedOption","_selectedValue"];

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


                };



            };

        };

    };
    case "disableAll": {

        [_logic,"disableMainMenu"] call MAINCLASS;
        [_logic,"disableTasking"] call MAINCLASS;
        [_logic,"disableAAR"] call MAINCLASS;
        [_logic,"disableISTAR"] call MAINCLASS;

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

        private ["_taskingState","_tasksTitle","_backButton","_abortButton"];

        _taskingState = [_logic,"taskingState"] call MAINCLASS;

        _taskingState call ALIVE_fnc_inspectHash;

        _tasksTitle = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskTitle);
        _tasksTitle ctrlShow true;

        _backButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuBack);
        _backButton ctrlShow true;
        _backButton ctrlSetEventHandler ["MouseButtonClick", "['BACK_BUTTON_CLICK',[_this]] call ALIVE_fnc_C2TabletOnAction"];

        _abortButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuAbort);
        _abortButton ctrlShow true;

        private ["_playerList","_playerListOptions"];

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

    };
    case "disableTasking": {

        private ["_tasksTitle","_backButton","_abortButton","_playerList"];

        _tasksTitle = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskTitle);
        _tasksTitle ctrlShow false;

        _backButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuBack);
        _backButton ctrlShow false;

        _abortButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuAbort);
        _abortButton ctrlShow false;

        _playerList = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_TaskPlayerList);
        _playerList ctrlShow false;

    };
    case "enableAAR": {

        private ["_aarTitle","_backButton","_abortButton"];

        _aarTitle = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_AARTitle);
        _aarTitle ctrlShow true;

        _backButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuBack);
        _backButton ctrlShow true;
        _backButton ctrlSetEventHandler ["MouseButtonClick", "['BACK_BUTTON_CLICK',[_this]] call ALIVE_fnc_C2TabletOnAction"];

        _abortButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuAbort);
        _abortButton ctrlShow true;

    };
    case "disableAAR": {

        private ["_aarTitle","_backButton","_abortButton"];

        _aarTitle = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_AARTitle);
        _aarTitle ctrlShow false;

        _backButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuBack);
        _backButton ctrlShow false;

        _abortButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuAbort);
        _abortButton ctrlShow false;

    };
    case "enableISTAR": {

        private ["_istarTitle","_backButton","_abortButton"];

        _istarTitle = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_ISTARTitle);
        _istarTitle ctrlShow true;

        _backButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuBack);
        _backButton ctrlShow true;
        _backButton ctrlSetEventHandler ["MouseButtonClick", "['BACK_BUTTON_CLICK',[_this]] call ALIVE_fnc_C2TabletOnAction"];

        _abortButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuAbort);
        _abortButton ctrlShow true;

    };
    case "disableISTAR": {

        private ["_istarTitle","_backButton","_abortButton"];

        _istarTitle = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_ISTARTitle);
        _istarTitle ctrlShow false;

        _backButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuBack);
        _backButton ctrlShow false;

        _abortButton = C2_getControl(C2Tablet_CTRL_MainDisplay,C2Tablet_CTRL_SubMenuAbort);
        _abortButton ctrlShow false;

    };
};

TRACE_1("C2 - output",_result);
_result;
