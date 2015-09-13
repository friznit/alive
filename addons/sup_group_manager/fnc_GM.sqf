//#define DEBUG_MODE_FULL
#include <\x\alive\addons\sup_group_manager\script_component.hpp>
SCRIPT(GM);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_GM
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
[_logic, "debug", true] call ALiVE_fnc_GM;

See Also:
- <ALIVE_fnc_GMInit>

Author:
ARJay

Peer Reviewed:
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClass
#define MAINCLASS ALIVE_fnc_GM
#define MTEMPLATE "ALiVE_GM_%1"
#define DEFAULT_DEBUG false
#define DEFAULT_STATE "INIT"
#define DEFAULT_SIDE "WEST"
#define DEFAULT_FACTION "BLU_F"
#define DEFAULT_SELECTED_INDEX 0
#define DEFAULT_SELECTED_VALUE ""
#define DEFAULT_SCALAR 0
#define DEFAULT_GROUP_STATE [] call ALIVE_fnc_hashCreate

// Display components
#define GMTablet_CTRL_MainDisplay 11001

// sub menu generic
#define GMTablet_CTRL_SubMenuBack 11006
#define GMTablet_CTRL_SubMenuAbort 11010
#define GMTablet_CTRL_Title 11007

// group management
#define GMTablet_CTRL_MainList 11011
#define GMTablet_CTRL_LeftList 11012
#define GMTablet_CTRL_RightList 11013
#define GMTablet_CTRL_BL1 11014
#define GMTablet_CTRL_BL2 11015
#define GMTablet_CTRL_BL3 11016
#define GMTablet_CTRL_BR1 11017
#define GMTablet_CTRL_BR2 11018
#define GMTablet_CTRL_BR3 11019

// Control Macros
#define GM_getControl(disp,ctrl) ((findDisplay ##disp) displayCtrl ##ctrl)
#define GM_getSelData(ctrl) (lbData[##ctrl,(lbCurSel ##ctrl)])


private ["_logic","_operation","_args","_result"];

TRACE_1("GM - input",_this);

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

	case "state": {
        _result = [_logic,_operation,_args,DEFAULT_STATE] call ALIVE_fnc_OOsimpleOperation;
    };
    case "side": {
        _result = [_logic,_operation,_args,DEFAULT_SIDE] call ALIVE_fnc_OOsimpleOperation;
    };
    case "faction": {
        _result = [_logic,_operation,_args,DEFAULT_FACTION] call ALIVE_fnc_OOsimpleOperation;
    };
    case "groupState": {
        _result = [_logic,_operation,_args,DEFAULT_GROUP_STATE] call ALIVE_fnc_OOsimpleOperation;
    };


	case "init": {

        //Only one init per instance is allowed
    	if !(isnil {_logic getVariable "initGlobal"}) exitwith {["ALiVE SUP GM - Only one init process per instance allowed! Exiting..."] call ALiVE_fnc_Dump};

    	//Start init
        _logic setVariable ["initGlobal", false];

	    private["_debug"];

        _logic setVariable ["super", SUPERCLASS];
        _logic setVariable ["class", MAINCLASS];
        _logic setVariable ["moduleType", "ALIVE_GM"];
        _logic setVariable ["startupComplete", false];

        _debug = [_logic, "debug"] call MAINCLASS;

        ALIVE_SUP_GROUP_MANAGER = _logic;

        if (isServer) then {

        };

        if (hasInterface) then {

            _logic setVariable ["startupComplete", true];

            // set the player side

            private ["_playerSide","_sideNumber","_sideText","_playerFaction","_groupState"];

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

            // set the group state

            private ["_groupState"];

            _groupState = [_logic,"groupState"] call MAINCLASS;

            [_groupState,"groupListOptions",[]] call ALIVE_fnc_hashSet;
            [_groupState,"groupListValues",[]] call ALIVE_fnc_hashSet;
            [_groupState,"groupListLeftSelectedIndex",DEFAULT_SELECTED_INDEX] call ALIVE_fnc_hashSet;
            [_groupState,"groupListLeftSelectedValue",DEFAULT_SELECTED_VALUE] call ALIVE_fnc_hashSet;
            [_groupState,"groupListLeftSelectedType",DEFAULT_SELECTED_VALUE] call ALIVE_fnc_hashSet;
            [_groupState,"groupListRightSelectedIndex",DEFAULT_SELECTED_INDEX] call ALIVE_fnc_hashSet;
            [_groupState,"groupListRightSelectedValue",DEFAULT_SELECTED_VALUE] call ALIVE_fnc_hashSet;
            [_groupState,"groupListRightSelectedType",DEFAULT_SELECTED_VALUE] call ALIVE_fnc_hashSet;

            _groupState call ALIVE_fnc_inspectHash;

            [_logic,"groupState",_groupState] call MAINCLASS;


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

        /*
        _listenerID = [ALIVE_eventLog, "addListener",[_logic, ["TASKS_UPDATED"]]] call ALIVE_fnc_eventLog;
        _logic setVariable ["listenerID", _listenerID];
        */
    };
    case "handleEvent": {

        private["_event","_eventData"];

        if(typeName _args == "ARRAY") then {

            _event = _args;

            // a response event from task handler has been received.
            // if the we are a dedicated server,
            // dispatch the event to the player who requested it
            if((isServer && isMultiplayer) || isDedicated) then {

                private ["_eventData","_playerID","_player"];

                _eventData = [_event, "data"] call ALIVE_fnc_hashGet;

                _playerID = _eventData select 0;

                _player = [_playerID] call ALIVE_fnc_getPlayerByUID;

                if !(isNull _player) then {
                    [_event,"ALIVE_fnc_GMTabletEventToClient",_player,false,false] spawn BIS_fnc_MP;
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

                        [_logic,"enableGroupManager"] call MAINCLASS;

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

            private ["_markers"];

            // Show GPS
            showGPS true;

            /*
            _markers = [_logic,"taskMarker"] call MAINCLASS;

            if(count _markers > 0) then {
                deleteMarkerLocal (_markers select 0);
            };
            */

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

                    createDialog "GMTablet";

                };

                case "GROUP_MANAGER_LEFT_LIST_SELECT": {

                    private ["_groupState","_list","_selectedIndex","_listOptions","_listValues","_selectedOption","_selectedValue"];

                    _groupState = [_logic,"groupState"] call MAINCLASS;

                    _list = _args select 0 select 0;
                    _selectedIndex = _args select 0 select 1;

                    _listOptions = [_groupState,"groupListOptions"] call ALIVE_fnc_hashGet;
                    _listValues = [_groupState,"groupListValues"] call ALIVE_fnc_hashGet;
                    _selectedOption = _listOptions select _selectedIndex;
                    _selectedValue = _listValues select _selectedIndex;

                    [_groupState,"groupListLeftSelectedIndex",_selectedIndex] call ALIVE_fnc_hashSet;
                    [_groupState,"groupListLeftSelectedValue",_selectedValue] call ALIVE_fnc_hashSet;

                    if(typeName _selectedValue == 'GROUP') then {
                        [_groupState,"groupListLeftSelectedType","GROUP"] call ALIVE_fnc_hashSet;
                    }else{
                        [_groupState,"groupListLeftSelectedType","UNIT"] call ALIVE_fnc_hashSet;
                    };

                    [_logic,"groupState",_groupState] call MAINCLASS;

                    _groupState call ALIVE_fnc_inspectHash;

                    [_logic,"handleGroupSelection"] call MAINCLASS;

                };

                case "GROUP_MANAGER_RIGHT_LIST_SELECT": {

                    private ["_groupState","_list","_selectedIndex","_listOptions","_listValues","_selectedOption","_selectedValue"];

                    _groupState = [_logic,"groupState"] call MAINCLASS;

                    _list = _args select 0 select 0;
                    _selectedIndex = _args select 0 select 1;

                    _listOptions = [_groupState,"groupListOptions"] call ALIVE_fnc_hashGet;
                    _listValues = [_groupState,"groupListValues"] call ALIVE_fnc_hashGet;
                    _selectedOption = _listOptions select _selectedIndex;
                    _selectedValue = _listValues select _selectedIndex;

                    [_groupState,"groupListRightSelectedIndex",_selectedIndex] call ALIVE_fnc_hashSet;
                    [_groupState,"groupListRightSelectedValue",_selectedValue] call ALIVE_fnc_hashSet;

                    if(typeName _selectedValue == 'GROUP') then {
                        [_groupState,"groupListRightSelectedType","GROUP"] call ALIVE_fnc_hashSet;
                    }else{
                        [_groupState,"groupListRightSelectedType","UNIT"] call ALIVE_fnc_hashSet;
                    };

                    [_logic,"groupState",_groupState] call MAINCLASS;

                    _groupState call ALIVE_fnc_inspectHash;

                    [_logic,"handleGroupSelection"] call MAINCLASS;

                };

            };

        };

    };

    case "handleGroupSelection": {

        private ["_groupState","_leftSelectedType","_rightSelectedType","_leftSelected","_rightSelected","_leftGroup","_rightGroup","_leaderLeftGroup","_leaderRightGroup",
        "_buttonL1","_buttonL2","_buttonL3","_buttonR1","_buttonR2","_buttonR3"];

        _groupState = [_logic,"groupState"] call MAINCLASS;

        _groupState call ALIVE_fnc_inspectHash;

        _leftSelectedType = [_groupState,"groupListLeftSelectedType"] call ALIVE_fnc_hashGet;
        _rightSelectedType = [_groupState,"groupListRightSelectedType"] call ALIVE_fnc_hashGet;

        _leftSelected = [_groupState,"groupListLeftSelectedValue"] call ALIVE_fnc_hashGet;
        _rightSelected = [_groupState,"groupListRightSelectedValue"] call ALIVE_fnc_hashGet;


        if(_leftSelectedType != '')then {

            if(_leftSelectedType == 'UNIT')then {
                _leftGroup = group _leftSelected;
                _leaderLeftGroup = leader _leftGroup;

                if(_leaderLeftGroup != _leftSelected) then {

                    _buttonL1 = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_BL1);
                    _buttonL1 ctrlShow true;
                    _buttonL1 ctrlSetText "Promote to Leader";
                    _buttonL1 ctrlSetEventHandler ["MouseButtonClick", "['LEADER_PROMOTE_LEFT',[_this]] call ALIVE_fnc_C2TabletOnAction"];

                }else{

                    _buttonL1 = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_BL1);
                    _buttonL1 ctrlShow false;

                };

                _buttonL2 = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_BL2);
                _buttonL2 ctrlShow true;
                _buttonL2 ctrlSetText "Leave Group";
                _buttonL2 ctrlSetEventHandler ["MouseButtonClick", "['LEAVE_GROUP_LEFT',[_this]] call ALIVE_fnc_C2TabletOnAction"];

            }else{
                _leftGroup = _leftSelected;
                _leaderLeftGroup = leader _leftGroup;

                _buttonL1 = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_BL1);
                _buttonL1 ctrlShow true;
                _buttonL1 ctrlSetText "Show Group Details";
                _buttonL1 ctrlSetEventHandler ["MouseButtonClick", "['SHOW_GROUP_LEFT',[_this]] call ALIVE_fnc_C2TabletOnAction"];

                _buttonL2 = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_BL2);
                _buttonL2 ctrlShow false;
            };

        };

        if(_rightSelectedType != '')then {

            if(_rightSelectedType == 'UNIT')then {
                _rightGroup = group _rightSelected;
                _leaderRightGroup = leader _rightGroup;

                if(_leaderRightGroup != _rightSelected) then {

                    _buttonR1 = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_BR1);
                    _buttonR1 ctrlShow true;
                    _buttonR1 ctrlSetText "Promote to Leader";
                    _buttonR1 ctrlSetEventHandler ["MouseButtonClick", "['LEADER_PROMOTE_LEFT',[_this]] call ALIVE_fnc_C2TabletOnAction"];

                }else{

                    _buttonR1 = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_BR1);
                    _buttonR1 ctrlShow false;

                };

                _buttonR2 = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_BR2);
                _buttonR2 ctrlShow true;
                _buttonR2 ctrlSetText "Leave Group";
                _buttonR2 ctrlSetEventHandler ["MouseButtonClick", "['LEAVE_GROUP_RIGHT',[_this]] call ALIVE_fnc_C2TabletOnAction"];

            }else{
                _rightGroup = _rightSelected;
                _leaderRightGroup = leader _rightGroup;

                _buttonR1 = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_BR1);
                _buttonR1 ctrlShow true;
                _buttonR1 ctrlSetText "Show Group Details";
                _buttonR1 ctrlSetEventHandler ["MouseButtonClick", "['SHOW_GROUP_RIGHT',[_this]] call ALIVE_fnc_C2TabletOnAction"];

                _buttonR2 = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_BR2);
                _buttonR2 ctrlShow false;
            };

        };

        if(_leftSelectedType == 'UNIT' && _rightSelectedType == 'GROUP')then {

            _buttonL3 = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_BL3);
            _buttonL3 ctrlShow true;
            _buttonL3 ctrlSetText "Join Group >";
            _buttonL3 ctrlSetEventHandler ["MouseButtonClick", "['JOIN_GROUP_LEFT',[_this]] call ALIVE_fnc_C2TabletOnAction"];

        }else{

            _buttonL3 = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_BL3);
            _buttonL3 ctrlShow false;

        };

        if(_rightSelectedType == 'UNIT' && _leftSelectedType == 'GROUP')then {

            _buttonR3 = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_BR3);
            _buttonR3 ctrlShow true;
            _buttonR3 ctrlSetText "Join Group <";
            _buttonR3 ctrlSetEventHandler ["MouseButtonClick", "['JOIN_GROUP_RIGHT',[_this]] call ALIVE_fnc_C2TabletOnAction"];

        }else{

            _buttonR3 = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_BR3);
            _buttonR3 ctrlShow false;

        };


        /*
        _buttonL2 = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_BL2);
        _buttonL2 ctrlShow true;

        _buttonL3 = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_BL3);
        _buttonL3 ctrlShow true;

        _buttonR1 = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_BR1);
        _buttonR1 ctrlShow true;

        _buttonR2 = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_BR2);
        _buttonR2 ctrlShow true;

        _buttonR3 = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_BR3);
        _buttonR3 ctrlShow true;
        */


    };

    case "loadInitialData": {

        private ["_side","_playerID","_event","_groupState","_dataSource","_rows","_values"];

        _side = [_logic,"side"] call MAINCLASS;
        _playerID = getPlayerUID player;

        ["GM LOAD INIT DATA FOR SIDE: %1 PLAYER: %2",_side,_playerID] call ALIVE_fnc_dump;

        /*
        _event = ['TASKS_UPDATE', ["",_playerID,_side], "GM"] call ALIVE_fnc_event;

        if(isServer) then {
            [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;
        }else{
            //["server","ALIVE_ADD_EVENT",[[_event],"ALIVE_fnc_addEventToServer"]] call ALiVE_fnc_BUS;
            [[_event],"ALIVE_fnc_addEventToServer",false,false] spawn BIS_fnc_MP;
        };
        */
    };

    case "disableAll": {

        [_logic,"disableGroupManager"] call MAINCLASS;

    };
    case "enableGroupManager": {

        private ["_title","_backButton","_abortButton","_mainList","_leftList","_rightList","_buttonL1","_buttonL2","_buttonL3","_buttonR1","_buttonR2","_buttonR3"];

        _title = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_Title);
        _title ctrlShow true;

        _title ctrlSetText "Group Manager";

        _abortButton = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_SubMenuAbort);
        _abortButton ctrlShow true;

        /*
        _mainList = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_MainList);
        _mainList ctrlShow true;
        */

        _leftList = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_LeftList);
        _leftList ctrlShow true;

        _rightList = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_RightList);
        _rightList ctrlShow true;

        _buttonL1 = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_BL1);
        _buttonL1 ctrlShow false;

        _buttonL2 = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_BL2);
        _buttonL2 ctrlShow false;

        _buttonL3 = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_BL3);
        _buttonL3 ctrlShow false;

        _buttonR1 = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_BR1);
        _buttonR1 ctrlShow false;

        _buttonR2 = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_BR2);
        _buttonR2 ctrlShow false;

        _buttonR3 = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_BR3);
        _buttonR3 ctrlShow false;

        [_logic,"resetGroupMananger"] call MAINCLASS;

    };
    case "resetGroupMananger": {

        private ["_side","_groupState","_leftList","_rightList","_dataSource","_rows","_values","_value","_row"];

        _side = [_logic,"side"] call MAINCLASS;
        _groupState = [_logic,"groupState"] call MAINCLASS;

        _leftList = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_LeftList);
        _rightList = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_RightList);

        _dataSource = [_side] call ALiVE_fnc_getGroupsDataSource;
        _rows = _dataSource select 0;
        _values = _dataSource select 1;

        _groupState call ALIVE_fnc_inspectHash;

        [_groupState,"groupListOptions",_rows] call ALIVE_fnc_hashSet;
        [_groupState,"groupListValues",_values] call ALIVE_fnc_hashSet;

        [_logic,"groupState",_groupState] call MAINCLASS;

        _groupState call ALIVE_fnc_inspectHash;

        /*
        [" name: %1", name _x] call ALIVE_fnc_dump;
        [" class name: %1", typeOf _x] call ALIVE_fnc_dump;
        [" is alive: %1", alive _x] call ALIVE_fnc_dump;
        [" is player: %1", isPlayer _x] call ALIVE_fnc_dump;
        [" is leader: %1", isFormationLeader _x] call ALIVE_fnc_dump;
        [" can stand: %1", canStand _x] call ALIVE_fnc_dump;
        [" can move: %1", canMove _x] call ALIVE_fnc_dump;
        [" can fire: %1", canFire _x] call ALIVE_fnc_dump;
        [" need reload: %1", needReload _x] call ALIVE_fnc_dump;
        [" side: %1", side _x] call ALIVE_fnc_dump;
        [" rank: %1", rank _x] call ALIVE_fnc_dump;
        [" group: %1", group _x] call ALIVE_fnc_dump;
        [" headgear: %1", headgear _x] call ALIVE_fnc_dump;
        [" goggles: %1", goggles _x] call ALIVE_fnc_dump;
        [" primary weapon: %1", primaryWeapon _x] call ALIVE_fnc_dump;
        [" primary weapon items: %1", primaryWeaponItems _x] call ALIVE_fnc_dump;
        [" secondary weapon: %1", secondaryWeapon _x] call ALIVE_fnc_dump;
        [" secondary weapon items: %1", secondaryWeaponItems _x] call ALIVE_fnc_dump;
        [" handgun: %1", handgunWeapon _x] call ALIVE_fnc_dump;
        [" handgun items: %1", handgunItems _x] call ALIVE_fnc_dump;
        [" assignedItems: %1", assignedItems _x] call ALIVE_fnc_dump;
        [" uniform: %1", uniform _x] call ALIVE_fnc_dump;
        [" uniformItems: %1", uniformItems _x] call ALIVE_fnc_dump;
        [" vest: %1", vest _x] call ALIVE_fnc_dump;
        [" vest items: %1", vestItems _x] call ALIVE_fnc_dump;
        [" backpack: %1", backpack _x] call ALIVE_fnc_dump;
        [" backpack items: %1", backpackItems _x] call ALIVE_fnc_dump;
        [" weapons: %1", weapons _x] call ALIVE_fnc_dump;
        [" magazines: %1", magazines _x] call ALIVE_fnc_dump;
        */

        {
            _value = _values select _forEachIndex;

            _row = _x select 0;

            _leftList lnbAddRow _row;

            _rightList lnbAddRow _row;

            if((_row select 3) == '----') then {
                _leftList lnbSetColor [[_forEachIndex,0], [0.384,0.439,0.341,1]];
                _leftList lnbSetColor [[_forEachIndex,1], [0.384,0.439,0.341,1]];
                _leftList lnbSetColor [[_forEachIndex,2], [0.384,0.439,0.341,1]];
                _leftList lnbSetColor [[_forEachIndex,3], [0.384,0.439,0.341,1]];

                _rightList lnbSetColor [[_forEachIndex,0], [0.384,0.439,0.341,1]];
                _rightList lnbSetColor [[_forEachIndex,1], [0.384,0.439,0.341,1]];
                _rightList lnbSetColor [[_forEachIndex,2], [0.384,0.439,0.341,1]];
                _rightList lnbSetColor [[_forEachIndex,3], [0.384,0.439,0.341,1]];
            };

        } foreach _rows;

        _leftList ctrlSetEventHandler ["LBSelChanged", "['GROUP_MANAGER_LEFT_LIST_SELECT',[_this]] call ALIVE_fnc_GMTabletOnAction"];
        _rightList ctrlSetEventHandler ["LBSelChanged", "['GROUP_MANAGER_RIGHT_LIST_SELECT',[_this]] call ALIVE_fnc_GMTabletOnAction"];

    };
    case "disableGroupManager": {

        private ["_title","_backButton","_abortButton","_leftList","_rightList","_joinGroupButton","_buttonL1","_buttonL2","_buttonL3","_buttonR1","_buttonR2","_buttonR3"];

        _title = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_Title);
        _title ctrlShow false;

        _backButton = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_SubMenuBack);
        _backButton ctrlShow false;

        _leftList = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_LeftList);
        _leftList ctrlShow false;

        _rightList = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_RightList);
        _rightList ctrlShow false;

        _buttonL1 = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_BL1);
        _buttonL1 ctrlShow false;

        _buttonL2 = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_BL2);
        _buttonL2 ctrlShow false;

        _buttonL3 = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_BL3);
        _buttonL3 ctrlShow false;

        _buttonR1 = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_BR1);
        _buttonR1 ctrlShow false;

        _buttonR2 = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_BR2);
        _buttonR2 ctrlShow false;

        _buttonR3 = GM_getControl(GMTablet_CTRL_MainDisplay,GMTablet_CTRL_BR3);
        _buttonR3 ctrlShow false;

    };
};

TRACE_1("GM - output",_result);
_result;
