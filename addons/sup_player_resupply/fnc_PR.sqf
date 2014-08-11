//#define DEBUG_MODE_FULL
#include <\x\alive\addons\sup_player_resupply\script_component.hpp>
SCRIPT(PR);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_PR
Description:
Player Resupply

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
- <ALIVE_fnc_PRnit>

Author:
ARJay

Peer Reviewed:
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClass
#define MAINCLASS ALIVE_fnc_PR
#define MTEMPLATE "ALiVE_PR_%1"
#define DEFAULT_PR_ITEM "LaserDesignator"
#define DEFAULT_SELECTED_INDEX 0
#define DEFAULT_SELECTED_VALUE ""
#define DEFAULT_SELECTED_OPTIONS []
#define DEFAULT_SELECTED_VALUES []
#define DEFAULT_SELECTED_DEPTH 0
#define DEFAULT_SORTED_VEHICLES []
#define DEFAULT_SORTED_GROUPS []
#define DEFAULT_STATE "INIT"
#define DEFAULT_SIDE "WEST"
#define DEFAULT_FACTION "BLU_F"
#define DEFAULT_MARKER []
#define DEFAULT_DESTINATION_MARKER []
#define DEFAULT_DESTINATION []
#define DEFAULT_SCALAR 0
#define DEFAULT_COUNT_AIR []
#define DEFAULT_COUNT_INSERT []
#define DEFAULT_COUNT_CONVOY []
#define DEFAULT_PAYLOAD_READY false
#define DEFAULT_REQUEST_STATUS []

// Display components
#define PRTablet_CTRL_MainDisplay 60001
#define PRTablet_CTRL_Map 60002
#define PRTablet_CTRL_ButtonRequest 60003
#define PRTablet_CTRL_DeliveryList 60005
#define PRTablet_CTRL_SupplyList 60006
#define PRTablet_CTRL_ReinforceList 60007
#define PRTablet_CTRL_PayloadList 60008
#define PRTablet_CTRL_PayloadInfo 60009
#define PRTablet_CTRL_PayloadDelete 60010
#define PRTablet_CTRL_PayloadOptions 60011
#define PRTablet_CTRL_PayloadWeight 60012
#define PRTablet_CTRL_PayloadSize 60023
#define PRTablet_CTRL_PayloadGroups 60013
#define PRTablet_CTRL_PayloadVehicles 60014
#define PRTablet_CTRL_PayloadIndividuals 60015
#define PRTablet_CTRL_PayloadStatus 60016
#define PRTablet_CTRL_DeliveryTypeTitle 60017
#define PRTablet_CTRL_SupplyListTitle 60018
#define PRTablet_CTRL_ReinforceListTitle 60019
#define PRTablet_CTRL_PayloadListTitle 60020
#define PRTablet_CTRL_StatusTitle 60021
#define PRTablet_CTRL_StatusText 60022


// Control Macros
#define PR_getControl(disp,ctrl) ((findDisplay ##disp) displayCtrl ##ctrl)
#define PR_getSelData(ctrl) (lbData[##ctrl,(lbCurSel ##ctrl)])


private ["_logic","_operation","_args","_result"];

TRACE_1("PR - input",_this);

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

	case "pr_item": {
        _result = [_logic,_operation,_args,DEFAULT_PR_ITEM] call ALIVE_fnc_OOsimpleOperation;
    };

	case "countsAir": {
        _result = [_logic,_operation,_args,DEFAULT_COUNT_AIR] call ALIVE_fnc_OOsimpleOperation;
    };
    case "countsInsert": {
        _result = [_logic,_operation,_args,DEFAULT_COUNT_INSERT] call ALIVE_fnc_OOsimpleOperation;
    };
    case "countsConvoy": {
        _result = [_logic,_operation,_args,DEFAULT_COUNT_CONVOY] call ALIVE_fnc_OOsimpleOperation;
    };
    case "currentWeight": {
        _result = [_logic,_operation,_args,DEFAULT_SCALAR] call ALIVE_fnc_OOsimpleOperation;
    };
    case "currentGroups": {
        _result = [_logic,_operation,_args,DEFAULT_SCALAR] call ALIVE_fnc_OOsimpleOperation;
    };
    case "currentVehicles": {
        _result = [_logic,_operation,_args,DEFAULT_SCALAR] call ALIVE_fnc_OOsimpleOperation;
    };
    case "currentIndividuals": {
        _result = [_logic,_operation,_args,DEFAULT_SCALAR] call ALIVE_fnc_OOsimpleOperation;
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

    case "deliveryListOptions": {
        _result = [_logic,_operation,_args,DEFAULT_SELECTED_OPTIONS] call ALIVE_fnc_OOsimpleOperation;
    };
    case "deliveryListValues": {
        _result = [_logic,_operation,_args,DEFAULT_SELECTED_VALUES] call ALIVE_fnc_OOsimpleOperation;
    };
    case "selectedDeliveryListIndex": {
        _result = [_logic,_operation,_args,DEFAULT_SELECTED_INDEX] call ALIVE_fnc_OOsimpleOperation;
    };
    case "selectedDeliveryListValue": {
        _result = [_logic,_operation,_args,DEFAULT_SELECTED_VALUE] call ALIVE_fnc_OOsimpleOperation;
    };

    case "selectedSupplyListOptions": {
        _result = [_logic,_operation,_args,DEFAULT_SELECTED_OPTIONS] call ALIVE_fnc_OOsimpleOperation;
    };
    case "selectedSupplyListValues": {
        _result = [_logic,_operation,_args,DEFAULT_SELECTED_VALUES] call ALIVE_fnc_OOsimpleOperation;
    };
    case "selectedSupplyListDepth": {
        _result = [_logic,_operation,_args,DEFAULT_SELECTED_DEPTH] call ALIVE_fnc_OOsimpleOperation;
    };
    case "selectedSupplyListIndex": {
        _result = [_logic,_operation,_args,DEFAULT_SELECTED_INDEX] call ALIVE_fnc_OOsimpleOperation;
    };
    case "selectedSupplyListValue": {
        _result = [_logic,_operation,_args,DEFAULT_SELECTED_VALUE] call ALIVE_fnc_OOsimpleOperation;
    };
    case "selectedSupplyListParents": {
        _result = [_logic,_operation,_args,DEFAULT_SELECTED_VALUES] call ALIVE_fnc_OOsimpleOperation;
    };

    case "selectedReinforceListOptions": {
        _result = [_logic,_operation,_args,DEFAULT_SELECTED_OPTIONS] call ALIVE_fnc_OOsimpleOperation;
    };
    case "selectedReinforceListValues": {
        _result = [_logic,_operation,_args,DEFAULT_SELECTED_VALUES] call ALIVE_fnc_OOsimpleOperation;
    };
    case "selectedReinforceListDepth": {
        _result = [_logic,_operation,_args,DEFAULT_SELECTED_DEPTH] call ALIVE_fnc_OOsimpleOperation;
    };
    case "selectedReinforceListIndex": {
        _result = [_logic,_operation,_args,DEFAULT_SELECTED_INDEX] call ALIVE_fnc_OOsimpleOperation;
    };
    case "selectedReinforceListValue": {
        _result = [_logic,_operation,_args,DEFAULT_SELECTED_VALUE] call ALIVE_fnc_OOsimpleOperation;
    };
    case "selectedReinforceListParents": {
        _result = [_logic,_operation,_args,DEFAULT_SELECTED_VALUES] call ALIVE_fnc_OOsimpleOperation;
    };

    case "payloadListOptions": {
        _result = [_logic,_operation,_args,DEFAULT_SELECTED_OPTIONS] call ALIVE_fnc_OOsimpleOperation;
    };
    case "payloadListValues": {
        _result = [_logic,_operation,_args,DEFAULT_SELECTED_VALUES] call ALIVE_fnc_OOsimpleOperation;
    };
    case "payloadListIndex": {
        _result = [_logic,_operation,_args,DEFAULT_SELECTED_INDEX] call ALIVE_fnc_OOsimpleOperation;
    };
    case "payloadListValue": {
        _result = [_logic,_operation,_args,DEFAULT_SELECTED_VALUE] call ALIVE_fnc_OOsimpleOperation;
    };

    case "payloadComboOptions": {
        _result = [_logic,_operation,_args,DEFAULT_SELECTED_OPTIONS] call ALIVE_fnc_OOsimpleOperation;
    };
    case "payloadComboValues": {
        _result = [_logic,_operation,_args,DEFAULT_SELECTED_VALUES] call ALIVE_fnc_OOsimpleOperation;
    };
    case "payloadComboIndex": {
        _result = [_logic,_operation,_args,DEFAULT_SELECTED_INDEX] call ALIVE_fnc_OOsimpleOperation;
    };
    case "payloadComboValue": {
        _result = [_logic,_operation,_args,DEFAULT_SELECTED_VALUE] call ALIVE_fnc_OOsimpleOperation;
    };

    case "sortedVehicles": {
        _result = [_logic,_operation,_args,DEFAULT_SORTED_VEHICLES] call ALIVE_fnc_OOsimpleOperation;
    };
    case "sortedGroups": {
        _result = [_logic,_operation,_args,DEFAULT_SORTED_GROUPS] call ALIVE_fnc_OOsimpleOperation;
    };
    case "marker": {
        _result = [_logic,_operation,_args,DEFAULT_MARKER] call ALIVE_fnc_OOsimpleOperation;
    };
    case "destinationMarker": {
        _result = [_logic,_operation,_args,DEFAULT_DESTINATION_MARKER] call ALIVE_fnc_OOsimpleOperation;
    };
    case "destination": {
        _result = [_logic,_operation,_args,DEFAULT_DESTINATION] call ALIVE_fnc_OOsimpleOperation;
    };
    case "payloadReady": {
        _result = [_logic,_operation,_args,DEFAULT_PAYLOAD_READY] call ALIVE_fnc_OOsimpleOperation;
    };
    case "requestStatus": {
        _result = [_logic,_operation,_args,DEFAULT_REQUEST_STATUS] call ALIVE_fnc_OOsimpleOperation;
    };

	case "init": {

        _logic setVariable ["super", SUPERCLASS];
        _logic setVariable ["class", MAINCLASS];
        _logic setVariable ["moduleType", "ALIVE_PR"];
        _logic setVariable ["startupComplete", false];

        ALIVE_SUP_PLAYER_RESUPPLY = _logic;

        [_logic, "start"] call MAINCLASS;


		// The machine has an interface? Must be a MP client, SP client or a client that acts as host!
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


            // set the counts

             private ["_countAir","_countInsert","_countConvoy"];

            _countAir = [1000,3,3,8,100];
            _countInsert = [500,2,1,8,40];
            _countConvoy = [5000,5,5,8,200];

            [_logic,"countsAir",_countAir] call MAINCLASS;
            [_logic,"countsInsert",_countInsert] call MAINCLASS;
            [_logic,"countsConvoy",_countConvoy] call MAINCLASS;


            // set the delivery type list options

            private ["_deliveryListOptions","_deliveryListValues"];

            _deliveryListOptions = ["Air Drop","Heli Insertion","Convoy"];
            _deliveryListValues = ["PR_AIRDROP","PR_HELI_INSERT","PR_STANDARD"];

            [_logic,"deliveryListOptions",_deliveryListOptions] call MAINCLASS;

            // set the delivery list values
            [_logic,"deliveryListValues",_deliveryListValues] call MAINCLASS;



            // set the supply list options

            private ["_supplyListOptions","_supplyListValues","_selectedSupplyListOptions","_selectedSupplyListValues"];

            _supplyListOptions = ["Vehicles","Defence Stores","Combat Supplies"];
            _supplyListValues = ["Vehicles","Defence","Combat"];

            _selectedSupplyListOptions = [_logic,"selectedSupplyListOptions"] call MAINCLASS;
            _selectedSupplyListOptions set [count _selectedSupplyListOptions, _supplyListOptions];
            [_logic,"selectedSupplyListOptions",_selectedSupplyListOptions] call MAINCLASS;

            // set the supply list values
            _selectedSupplyListValues = [_logic,"selectedSupplyListValues"] call MAINCLASS;
            _selectedSupplyListValues set [count _selectedSupplyListValues, _supplyListOptions];
            [_logic,"selectedSupplyListValues",_selectedSupplyListValues] call MAINCLASS;



            // set the reinforcement list options

            private ["_reinforceListOptions","_selectedReinforceListOptions","_selectedReinforceListValues"];

            _reinforceListOptions = ["Individuals","Groups"];

            _selectedReinforceListOptions = [_logic,"selectedReinforceListOptions"] call MAINCLASS;
            _selectedReinforceListOptions set [count _selectedReinforceListOptions, _reinforceListOptions];
            [_logic,"selectedReinforceListOptions",_selectedReinforceListOptions] call MAINCLASS;

            // set the reinforcement list values
            _selectedReinforceListValues = [_logic,"selectedReinforceListValues"] call MAINCLASS;
            _selectedReinforceListValues set [count _selectedReinforceListValues, _reinforceListOptions];
            [_logic,"selectedReinforceListValues",_selectedReinforceListValues] call MAINCLASS;



            // set the payload combo options

            private ["_payloadComboOptions","_payloadComboValues"];

            _payloadComboOptions = ["Join Player Group","Static Defence","Reinforce"];
            _payloadComboValues = ["Join","Static","Reinforce"];

            [_logic,"payloadComboOptions",_payloadComboOptions] call MAINCLASS;

            // set the payload combo values
            [_logic,"payloadComboValues",_payloadComboValues] call MAINCLASS;


            private ["_file"];

            // load static data
            if(isNil "ALiVE_STATIC_DATA_LOADED") then {
                _file = "\x\alive\addons\main\static\staticData.sqf";
                call compile preprocessFileLineNumbers _file;
            };


            private ["_sortedGroups","_sortedVehicles"];

            // get sorted config data
            _sortedVehicles = [_sideText] call ALIVE_fnc_sortCFGVehiclesByClass;
            [_logic,"sortedVehicles",_sortedVehicles] call MAINCLASS;


            // get sorted group data
            _sortedGroups = [_sideText] call ALIVE_fnc_sortCFGGroupsBySide;
            [_logic,"sortedGroups",_sortedGroups] call MAINCLASS;


            // Initialise interaction key if undefined
            if (isNil "SELF_INTERACTION_KEY") then {SELF_INTERACTION_KEY = [221,[false,false,false]];};

            TRACE_2("Menu pre-req",SELF_INTERACTION_KEY,ALIVE_fnc_logisticsMenuDef);

            // Initialise main menu
            [
                    "player",
                    [SELF_INTERACTION_KEY],
                    -9500,
                    [
                            "call ALIVE_fnc_PRMenuDef",
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
                    [_event,"ALIVE_fnc_PRTabletEventToClient",_player,false,false] spawn BIS_fnc_MP;
                };

            }else{

                // the player is the server

                [_logic, "handleLOGCOMResponse", _event] call MAINCLASS;

            };

        };
    };
    case "handleLOGCOMResponse": {

        // event handler for LOGOM_RESPONSE
        // events

        private["_event","_eventData","_message","_requestID","_side","_sideObject","_selectedDeliveryValue",
        "_radioMessage","_radioBroadcast","_markers"];

        if(typeName _args == "ARRAY") then {

            _event = _args;
            _eventData = [_event, "data"] call ALIVE_fnc_hashGet;
            _message = [_event, "message"] call ALIVE_fnc_hashGet;

            _requestID = _eventData select 0;

            _side = [_logic,"side"] call MAINCLASS;
            _sideObject = [_side] call ALIVE_fnc_sideTextToObject;
            _selectedDeliveryValue = [_logic,"selectedDeliveryListValue"] call MAINCLASS;

            switch(_message) do {
                case "ACKNOWLEDGED":{

                    // LOGCOM has received and accepted the request

                    _radioMessage = "Request acknowledged, stand by";

                    _radioBroadcast = [player,_radioMessage,"side",_sideObject,false,true,false,true,"HQ"];

                    [_radioBroadcast,"ALIVE_fnc_radioBroadcast",true,true] spawn BIS_fnc_MP;

                    [_logic,"updateRequestStatus",_radioMessage] call MAINCLASS;


                };
                case "REQUEST_INSERTION":{

                    // LOGCOM has selected insertion point for request

                    switch(_selectedDeliveryValue) do {
                        case "PR_AIRDROP": {
                            _radioMessage = "Cargo lift in flight to requested destination";
                        };
                        case "PR_HELI_INSERT": {
                            _radioMessage = "Rotary wing units have been loaded with requested payload";
                        };
                        case "PR_STANDARD": {
                            _radioMessage = "Convoy units have been loaded with requested payload";
                        };
                    };

                    _radioBroadcast = [player,_radioMessage,"side",_sideObject,false,true,false,true,"HQ"];

                    [_radioBroadcast,"ALIVE_fnc_radioBroadcast",true,true] spawn BIS_fnc_MP;

                    [_logic,"updateRequestStatus",_radioMessage] call MAINCLASS;


                };
                case "REQUEST_ENROUTE":{

                    // LOGCOM request has arrived at destination point

                    switch(_selectedDeliveryValue) do {
                        case "PR_HELI_INSERT": {
                            _radioMessage = "Rotary wing units are on way to destination";
                        };
                        case "PR_STANDARD": {
                            _radioMessage = "Convoy units are on way to destination";
                        };
                    };

                    _radioBroadcast = [player,_radioMessage,"side",_sideObject,false,true,false,true,"HQ"];

                    [_radioBroadcast,"ALIVE_fnc_radioBroadcast",true,true] spawn BIS_fnc_MP;

                    [_logic,"updateRequestStatus",_radioMessage] call MAINCLASS;


                };
                case "REQUEST_ARRIVED":{

                    // LOGCOM request has arrived at destination point

                    switch(_selectedDeliveryValue) do {
                        case "PR_HELI_INSERT": {
                            _radioMessage = "Rotary wing units have arrived at the destination. Commencing unloading";
                        };
                        case "PR_STANDARD": {
                            _radioMessage = "Convoy units have arrived at the destination. Commencing unloading";
                        };
                    };

                    _radioBroadcast = [player,_radioMessage,"side",_sideObject,false,true,false,true,"HQ"];

                    [_radioBroadcast,"ALIVE_fnc_radioBroadcast",true,true] spawn BIS_fnc_MP;

                    [_logic,"updateRequestStatus",_radioMessage] call MAINCLASS;


                };
                case "REQUEST_DELIVERED":{

                    // LOGCOM has delivered the request

                    private ["_position","_isWaiting","_marker","_markers","_markerLabel"];

                    _position = _eventData select 2;
                    _isWaiting = _eventData select 3;
                    _markerLabel = "";

                    switch(_selectedDeliveryValue) do {
                        case "PR_AIRDROP": {
                            _radioMessage = "Airdrop request completed";
                            _markerLabel = "Airdrop destination";
                        };
                        case "PR_HELI_INSERT": {
                            _radioMessage = "Rotary wing insertion request completed";
                            _markerLabel = "Heli Insert destination";
                        };
                        case "PR_STANDARD": {
                            _radioMessage = "Convoy request completed";
                            _markerLabel = "Convoy destination";
                        };
                    };

                    if(_isWaiting) then {
                        _radioMessage = format["%1, Payload transport vehicle will wait for 2 minutes for unloading before RTB.",_radioMessage];
                    };

                    _radioBroadcast = [player,_radioMessage,"side",_sideObject,false,true,false,true,"HQ"];

                    [_radioBroadcast,"ALIVE_fnc_radioBroadcast",true,true] spawn BIS_fnc_MP;

                    [_logic,"updateRequestStatus",_radioMessage] call MAINCLASS;


                    // clear request markers

                    _markers = [_logic,"marker"] call MAINCLASS;

                    if(count _markers > 0) then {
                        deleteMarkerLocal (_markers select 0);
                    };

                    [_logic,"marker",[]] call MAINCLASS;

                    // display destination markers

                    if(count _position > 0) then {

                        _markers = [];

                        _marker = createMarkerLocal ["PR_DESTINATION_M1", _position];
                        _marker setMarkerShapeLocal "Icon";
                        _marker setMarkerSizeLocal [0.75, 0.75];
                        _marker setMarkerTypeLocal "mil_dot";
                        _marker setMarkerColorLocal "ColorYellow";
                        _marker setMarkerTextLocal _markerLabel;
                        _markers set [count _markers, _marker];

                        _marker = createMarkerLocal ["PR_DESTINATION_M2", _position];
                        _marker setMarkerShape "Ellipse";
                        _marker setMarkerSize [150, 150];
                        _marker setMarkerColor "ColorYellow";
                        _marker setMarkerAlpha 0.5;
                        _markers set [count _markers, _marker];

                        [_logic,"destinationMarker",_markers] call MAINCLASS;

                    };

                    // set the tablet state to reset

                    [_logic,"state","RESET"] call MAINCLASS;


                };
                case "REQUEST_LOST":{

                    // LOGCOM has lost the request enroute

                    switch(_selectedDeliveryValue) do {
                        case "PR_HELI_INSERT": {
                            _radioMessage = "Rotary wing units have been destroyed enroute to destination";
                        };
                        case "PR_STANDARD": {
                            _radioMessage = "Convoy units have been destroyed enroute to destination";
                        };
                    };

                    _radioBroadcast = [player,_radioMessage,"side",_sideObject,false,true,false,true,"HQ"];

                    [_radioBroadcast,"ALIVE_fnc_radioBroadcast",true,true] spawn BIS_fnc_MP;

                    [_logic,"updateRequestStatus",_radioMessage] call MAINCLASS;

                    // clear request markers

                    _markers = [_logic,"marker"] call MAINCLASS;

                    if(count _markers > 0) then {
                        deleteMarkerLocal (_markers select 0);
                    };

                    [_logic,"marker",[]] call MAINCLASS;

                    // set the tablet state to reset

                    [_logic,"state","RESET"] call MAINCLASS;


                };
                case "DENIED_FORCEPOOL":{

                    // LOGCOM has denied the request due to insufficient forces

                    _radioMessage = "Your request for support has been deined. Insufficient resources available";

                    _radioBroadcast = [player,_radioMessage,"side",_sideObject,false,true,false,true,"HQ"];

                    [_radioBroadcast,"ALIVE_fnc_radioBroadcast",true,true] spawn BIS_fnc_MP;

                    [_logic,"updateRequestStatus",_radioMessage] call MAINCLASS;

                    // clear request markers

                    _markers = [_logic,"marker"] call MAINCLASS;

                    if(count _markers > 0) then {
                        deleteMarkerLocal (_markers select 0);
                    };

                    [_logic,"marker",[]] call MAINCLASS;

                    // set the tablet state to reset

                    [_logic,"state","RESET"] call MAINCLASS;

                };
                case "DENIED_NOT_AVAILABLE":{

                    // LOGCOM has no insertion point to deliver from

                    _radioMessage = "Your request for support has been deined. No insertion point is available";

                    _radioBroadcast = [player,_radioMessage,"side",_sideObject,false,true,false,true,"HQ"];

                    [_radioBroadcast,"ALIVE_fnc_radioBroadcast",true,true] spawn BIS_fnc_MP;

                    [_logic,"updateRequestStatus",_radioMessage] call MAINCLASS;

                    // clear request markers

                    _markers = [_logic,"marker"] call MAINCLASS;

                    if(count _markers > 0) then {
                        deleteMarkerLocal (_markers select 0);
                    };

                    [_logic,"marker",[]] call MAINCLASS;

                    // set the tablet state to reset

                    [_logic,"state","RESET"] call MAINCLASS;

                };
                case "DENIED_FORCE_CREATION":{

                    // LOGCOM has denied the request because the force pool did not result in any profiles created

                    _radioMessage = "Your request for support has been deined. The forces requested are not available";

                    _radioBroadcast = [player,_radioMessage,"side",_sideObject,false,true,false,true,"HQ"];

                    [_radioBroadcast,"ALIVE_fnc_radioBroadcast",true,true] spawn BIS_fnc_MP;

                    [_logic,"updateRequestStatus",_radioMessage] call MAINCLASS;

                    // clear request markers

                    _markers = [_logic,"marker"] call MAINCLASS;

                    if(count _markers > 0) then {
                        deleteMarkerLocal (_markers select 0);
                    };

                    [_logic,"marker",[]] call MAINCLASS;

                    // set the tablet state to reset

                    [_logic,"state","RESET"] call MAINCLASS;

                };
            };

        };

    };
    case "updateRequestStatus": {

        // adds a status message to the
        // status array

        private ["_message","_date","_hour","_minutes","_minutesArray","_time","_requestStatus"];

        _message = _args;

        _date = date;
        _hour = _date select 3;
        _minutes = _date select 4;
        _minutesArray = toArray format["%1",_minutes];

        if(count _minutesArray == 1) then {
            _minutes = format["0%1",_minutes];
        };

        _time = format["%1:%2",_hour,_minutes];

        _message = format["[%1] %2",_time,_message];

        _requestStatus = [_logic,"requestStatus"] call MAINCLASS;

        _requestStatus set [count _requestStatus,_message];

        [_logic,"requestStatus",_requestStatus] call MAINCLASS;

        [_logic,"displayRequestStatus"] call MAINCLASS;

    };
    case "displayRequestStatus": {

        // updates the request status text

        disableSerialization;

        private ["_payloadStatusText","_requestText","_requestStatus"];

        _payloadStatusText = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_StatusText);
        _payloadStatusText ctrlShow true;

        _requestStatus = [_logic,"requestStatus"] call MAINCLASS;
        _requestText = "";

        {
            _requestText = format["%1\n%2",_requestText,_x];
        } forEach _requestStatus;

        _payloadStatusText ctrlSetText _requestText;

    };
	case "tabletOnLoad": {

        // on load of the tablet
        // restore state

        if (hasInterface) then {

            [_logic] spawn {

                private ["_logic","_state"];

                _logic = _this select 0;

                sleep 0.5;

                disableSerialization;

                _state = [_logic,"state"] call MAINCLASS;

                switch(_state) do {

                    case "INIT":{

                        // the interface is opened
                        // for the first time

                        // setup the delivery type list

                        private ["_deliveryList","_deliveryListOptions","_deliveryListValues","_selectedDeliveryListIndex"];

                        _deliveryList = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_DeliveryList);
                        _deliveryListOptions = [_logic,"deliveryListOptions"] call MAINCLASS;
                        _deliveryListValues = [_logic,"deliveryListValues"] call MAINCLASS;

                        lbClear _deliveryList;

                        {
                            _deliveryList lbAdd format["%1", _x];
                        } forEach _deliveryListOptions;

                        _deliveryList ctrlSetEventHandler ["LBSelChanged", "['DELIVERY_LIST_SELECT',[_this]] call ALIVE_fnc_PRTabletOnAction"];

                        // disable delete button

                        private ["_payloadDeleteButton"];

                        _payloadDeleteButton = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_PayloadDelete);
                        _payloadDeleteButton ctrlShow false;

                        // setup and disable payload selection combo

                        private ["_payloadOptionsCombo","_payloadComboOptions","_payloadComboValues","_selectedPayloadComboIndex"];

                        _payloadOptionsCombo = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_PayloadOptions);
                        _payloadOptionsCombo ctrlShow false;

                        _payloadComboOptions = [_logic,"payloadComboOptions"] call MAINCLASS;
                        _payloadComboValues = [_logic,"payloadComboValues"] call MAINCLASS;
                        _selectedPayloadComboIndex = [_logic,"payloadComboIndex"] call MAINCLASS;

                        lbClear _payloadOptionsCombo;

                        {
                            _payloadOptionsCombo lbAdd format["%1", _x];
                        } forEach _payloadComboOptions;

                        _payloadOptionsCombo ctrlSetEventHandler ["LBSelChanged", "['PAYLOAD_COMBO_SELECT',[_this]] call ALIVE_fnc_PRTabletOnAction"];

                        // disable request button

                        private ["_payloadRequestButton"];

                        _payloadRequestButton = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_ButtonRequest);
                        _payloadRequestButton ctrlShow false;

                        // disable the request status fields

                        private ["_payloadStatusTitle","_payloadStatusText"];

                        _payloadStatusTitle = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_StatusTitle);
                        _payloadStatusTitle ctrlShow false;

                        _payloadStatusText = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_StatusText);
                        _payloadStatusText ctrlShow false;

                    };

                    case "REQUEST":{

                        // a request is in progress
                        // but not yet sent
                        // restore the values of the request

                        private ["_map"];

                        // setup the map

                        _map = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_Map);

                        _map ctrlSetEventHandler ["MouseButtonDown", "['MAP_CLICK',[_this]] call ALIVE_fnc_PRTabletOnAction"];

                        // restore the delivery type list

                        private ["_deliveryList","_deliveryListOptions","_deliveryListValues","_selectedDeliveryListIndex"];

                        _deliveryList = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_DeliveryList);
                        _deliveryListOptions = [_logic,"deliveryListOptions"] call MAINCLASS;
                        _deliveryListValues = [_logic,"deliveryListValues"] call MAINCLASS;
                        _selectedDeliveryListIndex = [_logic,"selectedDeliveryListIndex"] call MAINCLASS;

                        lbClear _deliveryList;

                        {
                            _deliveryList lbAdd format["%1", _x];
                        } forEach _deliveryListOptions;

                        _deliveryList lbSetCurSel _selectedDeliveryListIndex;

                        _deliveryList ctrlSetEventHandler ["LBSelChanged", "['DELIVERY_LIST_SELECT',[_this]] call ALIVE_fnc_PRTabletOnAction"];

                        // restore the payload list

                        private ["_payloadListOptions","_payloadListValues","_payloadList"];

                        _payloadList = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_PayloadList);
                        _payloadListOptions = [_logic,"payloadListOptions"] call MAINCLASS;
                        _payloadListValues = [_logic,"payloadListValues"] call MAINCLASS;

                        lbClear _payloadList;

                        {
                            _payloadList lbAdd format["%1", _x];
                        } forEach _payloadListOptions;

                        _payloadList ctrlSetEventHandler ["LBSelChanged", "['PAYLOAD_LIST_SELECT',[_this]] call ALIVE_fnc_PRTabletOnAction"];

                        // setup the supply list

                        private ["_supplyList","_selectedSupplyListOptions","_selectedSupplyListValues","_selectedSupplyListDepth"];

                        _supplyList = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_SupplyList);

                        _selectedSupplyListOptions = [_logic,"selectedSupplyListOptions"] call MAINCLASS;
                        _selectedSupplyListValues = [_logic,"selectedSupplyListValues"] call MAINCLASS;
                        [_logic,"selectedSupplyListDepth",0] call MAINCLASS;

                        lbClear _supplyList;

                        {
                            _supplyList lbAdd format["%1", _x];
                        } forEach (_selectedSupplyListOptions select 0);

                        _supplyList ctrlSetEventHandler ["LBSelChanged", "['SUPPLY_LIST_SELECT',[_this]] call ALIVE_fnc_PRTabletOnAction"];

                        // setup the reinforce list

                        private ["_reinforceList","_selectedReinforceListOptions","_selectedReinforceListValues","_selectedReinforceListDepth"];

                        _reinforceList = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_ReinforceList);

                        _selectedReinforceListOptions = [_logic,"selectedReinforceListOptions"] call MAINCLASS;
                        _selectedReinforceListValues = [_logic,"selectedReinforceListValues"] call MAINCLASS;
                        [_logic,"selectedReinforceListDepth",0] call MAINCLASS;

                        lbClear _reinforceList;

                        {
                            _reinforceList lbAdd format["%1", _x];
                        } forEach (_selectedReinforceListOptions select 0);

                        _reinforceList ctrlSetEventHandler ["LBSelChanged", "['REINFORCE_LIST_SELECT',[_this]] call ALIVE_fnc_PRTabletOnAction"];

                        // disable delete button

                        private ["_payloadDeleteButton"];

                        _payloadDeleteButton = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_PayloadDelete);

                        _payloadDeleteButton ctrlShow false;

                        // setup and disable payload selection combo

                        private ["_payloadOptionsCombo","_payloadComboOptions","_payloadComboValues","_selectedPayloadComboIndex"];

                        _payloadOptionsCombo = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_PayloadOptions);

                        _payloadOptionsCombo ctrlShow false;

                        _payloadComboOptions = [_logic,"payloadComboOptions"] call MAINCLASS;
                        _payloadComboValues = [_logic,"payloadComboValues"] call MAINCLASS;
                        _selectedPayloadComboIndex = [_logic,"payloadComboIndex"] call MAINCLASS;

                        lbClear _payloadOptionsCombo;

                        {
                            _payloadOptionsCombo lbAdd format["%1", _x];
                        } forEach _payloadComboOptions;

                        _payloadOptionsCombo ctrlSetEventHandler ["LBSelChanged", "['PAYLOAD_COMBO_SELECT',[_this]] call ALIVE_fnc_PRTabletOnAction"];

                        // enable request button

                        private ["_payloadRequestButton"];

                        _payloadRequestButton = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_ButtonRequest);
                        _payloadRequestButton ctrlShow true;
                        _payloadRequestButton ctrlSetEventHandler ["MouseButtonClick", "['PAYLOAD_REQUEST_CLICK',[_this]] call ALIVE_fnc_PRTabletOnAction"];

                        // disable the request status fields

                        private ["_payloadStatusTitle","_payloadStatusText"];

                        _payloadStatusTitle = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_StatusTitle);
                        _payloadStatusTitle ctrlShow false;

                        _payloadStatusText = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_StatusText);
                        _payloadStatusText ctrlShow false;

                        // set paylist

                        [_logic,"payloadUpdated"] call MAINCLASS;

                    };

                    case "REQUEST_SENT":{

                        // request has been sent
                        // display the status interface

                        [_logic,"payloadRequested"] call MAINCLASS;

                    };
                    case "RESET":{

                        // the tablet has just made a request
                        // and the request has been completed
                        // reset the request interface objects

                        // reset map marker

                        private ["_markers","_destinationMarkers"];

                        _markers = [_logic,"marker"] call MAINCLASS;

                        if(count _markers > 0) then {
                            deleteMarkerLocal (_markers select 0);
                        };

                        [_logic,"marker",[]] call MAINCLASS;
                        [_logic,"destination",[]] call MAINCLASS;

                        _destinationMarkers = [_logic,"destinationMarker"] call MAINCLASS;

                        if(count _destinationMarkers > 0) then {
                            {
                                deleteMarkerLocal _x;
                            } forEach _destinationMarkers;

                        };

                        [_logic,"destinationMarker",[]] call MAINCLASS;

                        // restore the delivery type list

                        private ["_deliveryList","_deliveryListOptions","_deliveryListValues","_selectedDeliveryListIndex"];

                        _deliveryList = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_DeliveryList);
                        _deliveryListOptions = [_logic,"deliveryListOptions"] call MAINCLASS;
                        _deliveryListValues = [_logic,"deliveryListValues"] call MAINCLASS;
                        _selectedDeliveryListIndex = [_logic,"selectedDeliveryListIndex"] call MAINCLASS;

                        lbClear _deliveryList;

                        {
                            _deliveryList lbAdd format["%1", _x];
                        } forEach _deliveryListOptions;

                        _deliveryList lbSetCurSel _selectedDeliveryListIndex;

                        _deliveryList ctrlSetEventHandler ["LBSelChanged", "['DELIVERY_LIST_SELECT',[_this]] call ALIVE_fnc_PRTabletOnAction"];

                        // reset the payload list

                        private ["_payloadListOptions","_payloadListValues","_payloadList"];

                        [_logic,"payloadListOptions",[]] call MAINCLASS;
                        [_logic,"payloadListValues",[]] call MAINCLASS;

                        _payloadList = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_PayloadList);
                        _payloadListOptions = [_logic,"payloadListOptions"] call MAINCLASS;
                        _payloadListValues = [_logic,"payloadListValues"] call MAINCLASS;

                        lbClear _payloadList;

                        {
                            _payloadList lbAdd format["%1", _x];
                        } forEach _payloadListOptions;

                        _payloadList ctrlSetEventHandler ["LBSelChanged", "['PAYLOAD_LIST_SELECT',[_this]] call ALIVE_fnc_PRTabletOnAction"];

                        // setup the supply list

                        private ["_supplyList","_selectedSupplyListOptions","_selectedSupplyListValues","_selectedSupplyListDepth"];

                        _supplyList = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_SupplyList);

                        _selectedSupplyListOptions = [_logic,"selectedSupplyListOptions"] call MAINCLASS;
                        _selectedSupplyListValues = [_logic,"selectedSupplyListValues"] call MAINCLASS;
                        [_logic,"selectedSupplyListDepth",0] call MAINCLASS;

                        lbClear _supplyList;

                        {
                            _supplyList lbAdd format["%1", _x];
                        } forEach (_selectedSupplyListOptions select 0);

                        _supplyList ctrlSetEventHandler ["LBSelChanged", "['SUPPLY_LIST_SELECT',[_this]] call ALIVE_fnc_PRTabletOnAction"];

                        // setup the reinforce list

                        private ["_reinforceList","_selectedReinforceListOptions","_selectedReinforceListValues","_selectedReinforceListDepth"];

                        _reinforceList = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_ReinforceList);

                        _selectedReinforceListOptions = [_logic,"selectedReinforceListOptions"] call MAINCLASS;
                        _selectedReinforceListValues = [_logic,"selectedReinforceListValues"] call MAINCLASS;
                        [_logic,"selectedReinforceListDepth",0] call MAINCLASS;

                        lbClear _reinforceList;

                        {
                            _reinforceList lbAdd format["%1", _x];
                        } forEach (_selectedReinforceListOptions select 0);

                        _reinforceList ctrlSetEventHandler ["LBSelChanged", "['REINFORCE_LIST_SELECT',[_this]] call ALIVE_fnc_PRTabletOnAction"];

                        // disable delete button

                        private ["_payloadDeleteButton"];

                        _payloadDeleteButton = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_PayloadDelete);

                        _payloadDeleteButton ctrlShow false;

                        // setup and disable payload selection combo

                        private ["_payloadOptionsCombo","_payloadComboOptions","_payloadComboValues","_selectedPayloadComboIndex"];

                        _payloadOptionsCombo = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_PayloadOptions);

                        _payloadOptionsCombo ctrlShow false;

                        _payloadComboOptions = [_logic,"payloadComboOptions"] call MAINCLASS;
                        _payloadComboValues = [_logic,"payloadComboValues"] call MAINCLASS;
                        _selectedPayloadComboIndex = [_logic,"payloadComboIndex"] call MAINCLASS;

                        lbClear _payloadOptionsCombo;

                        {
                            _payloadOptionsCombo lbAdd format["%1", _x];
                        } forEach _payloadComboOptions;

                        _payloadOptionsCombo ctrlSetEventHandler ["LBSelChanged", "['PAYLOAD_COMBO_SELECT',[_this]] call ALIVE_fnc_PRTabletOnAction"];

                        // enable request button

                        private ["_payloadRequestButton"];

                        _payloadRequestButton = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_ButtonRequest);
                        _payloadRequestButton ctrlShow true;
                        _payloadRequestButton ctrlSetEventHandler ["MouseButtonClick", "['PAYLOAD_REQUEST_CLICK',[_this]] call ALIVE_fnc_PRTabletOnAction"];

                        // disable the request status fields

                        private ["_payloadStatusTitle","_payloadStatusText"];

                        [_logic,"requestStatus",[]] call MAINCLASS;

                        _payloadStatusTitle = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_StatusTitle);
                        _payloadStatusTitle ctrlShow false;

                        _payloadStatusText = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_StatusText);
                        _payloadStatusText ctrlShow false;

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

                    createDialog "PRTablet";

                };

                case "DELIVERY_LIST_SELECT": {

                    // user selects on of the delivery type options
                    // the selection will determine what options
                    // are available

                    private ["_deliveryList","_selectedIndex","_deliveryListOptions","_deliveryListValues","_selectedOption","_selectedValue"];

                    _deliveryList = _args select 0 select 0;
                    _selectedIndex = _args select 0 select 1;
                    _deliveryListOptions = [_logic,"deliveryListOptions"] call MAINCLASS;
                    _deliveryListValues = [_logic,"deliveryListValues"] call MAINCLASS;
                    _selectedOption = _deliveryListOptions select _selectedIndex;
                    _selectedValue = _deliveryListValues select _selectedIndex;

                    // set the state as request in progress
                    // store the selected values for later

                    [_logic,"state","REQUEST"] call MAINCLASS;
                    [_logic,"selectedDeliveryListIndex",_selectedIndex] call MAINCLASS;
                    [_logic,"selectedDeliveryListValue",_selectedValue] call MAINCLASS;

                    // set the counts

                    private ["_sizeText","_weightText","_groupText","_vehiclesText","_individualsText","_counts","_countWeight","_countSize","_countGroups","_countVehicles","_countIndividuals"];

                    _weightText = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_PayloadWeight);
                    _sizeText = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_PayloadSize);
                    _groupText = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_PayloadGroups);
                    _vehiclesText = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_PayloadVehicles);
                    _individualsText = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_PayloadIndividuals);

                    switch(_selectedValue) do {
                        case "PR_AIRDROP": {
                            _counts = [_logic,"countsAir"] call MAINCLASS;
                        };
                        case "PR_HELI_INSERT": {
                            _counts = [_logic,"countsInsert"] call MAINCLASS;
                        };
                        case "PR_STANDARD": {
                            _counts = [_logic,"countsConvoy"] call MAINCLASS;
                        };
                    };

                    _countWeight = _counts select 0;
                    _countGroups = _counts select 1;
                    _countVehicles = _counts select 2;
                    _countIndividuals = _counts select 3;
                    _countSize = _counts select 4;

                    _sizeText ctrlSetText format["%1 of %2 size",0,_countSize];
                    _weightText ctrlSetText format["%1 of %2 weight",0,_countWeight];
                    _groupText ctrlSetText format["%1 of %2 groups",0,_countGroups];
                    _vehiclesText ctrlSetText format["%1 of %2 vehicles",0,_countVehicles];
                    _individualsText ctrlSetText format["%1 of %2 individuals",0,_countIndividuals];


                    // reset the supply list

                    private ["_supplyList","_selectedSupplyListOptions","_selectedSupplyListValues","_selectedSupplyListDepth"];

                    _supplyList = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_SupplyList);

                    _selectedSupplyListOptions = [_logic,"selectedSupplyListOptions"] call MAINCLASS;
                    _selectedSupplyListValues = [_logic,"selectedSupplyListValues"] call MAINCLASS;
                    _selectedSupplyListDepth = [_logic,"selectedSupplyListDepth"] call MAINCLASS;

                    lbClear _supplyList;

                    {
                        _supplyList lbAdd format["%1", _x];
                    } forEach (_selectedSupplyListOptions select 0);

                    _supplyList ctrlSetEventHandler ["LBSelChanged", "['SUPPLY_LIST_SELECT',[_this]] call ALIVE_fnc_PRTabletOnAction"];

                    [_logic,"selectedSupplyListDepth",0] call MAINCLASS;

                    // reset the reinforce list

                    private ["_reinforceList","_selectedReinforceListOptions","_selectedReinforceListValues","_selectedReinforceListDepth"];

                    _reinforceList = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_ReinforceList);

                    _selectedReinforceListOptions = [_logic,"selectedReinforceListOptions"] call MAINCLASS;
                    _selectedReinforceListValues = [_logic,"selectedReinforceListValues"] call MAINCLASS;
                    _selectedReinforceListDepth = [_logic,"selectedReinforceListDepth"] call MAINCLASS;

                    lbClear _reinforceList;

                    {
                        _reinforceList lbAdd format["%1", _x];
                    } forEach (_selectedReinforceListOptions select 0);

                    _reinforceList ctrlSetEventHandler ["LBSelChanged", "['REINFORCE_LIST_SELECT',[_this]] call ALIVE_fnc_PRTabletOnAction"];

                    [_logic,"selectedReinforceListDepth",0] call MAINCLASS;

                    // reset the payload list

                    private ["_payloadListOptions","_payloadListValues","_payloadList"];

                    _payloadList = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_PayloadList);
                    _payloadListOptions = [_logic,"payloadListOptions"] call MAINCLASS;
                    _payloadListValues = [_logic,"payloadListValues"] call MAINCLASS;

                    _payloadListOptions = [];
                    _payloadListValues = [];

                    [_logic,"payloadListOptions",_payloadListOptions] call MAINCLASS;
                    [_logic,"payloadListValues",_payloadListValues] call MAINCLASS;

                    lbClear _payloadList;

                    _payloadList ctrlSetEventHandler ["LBSelChanged", "['PAYLOAD_LIST_SELECT',[_this]] call ALIVE_fnc_PRTabletOnAction"];

                    // reset the map

                    private ["_map","_markers"];

                    _map = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_Map);

                    _map ctrlSetEventHandler ["MouseButtonDown", "['MAP_CLICK',[_this]] call ALIVE_fnc_PRTabletOnAction"];

                    _markers = [_logic,"marker"] call MAINCLASS;

                    if(count _markers > 0) then {
                        deleteMarkerLocal (_markers select 0);
                    };

                    // enable send button

                    private ["_payloadRequestButton"];

                    _payloadRequestButton = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_ButtonRequest);
                    _payloadRequestButton ctrlShow true;
                    _payloadRequestButton ctrlSetEventHandler ["MouseButtonClick", "['PAYLOAD_REQUEST_CLICK',[_this]] call ALIVE_fnc_PRTabletOnAction"];


                };

                case "SUPPLY_LIST_SELECT": {

                    // supply list select
                    // the user selects an option from the list

                    private ["_supplyList","_selectedIndex","_selectedDeliveryValue","_selectedSupplyListOptions","_selectedSupplyListValues","_selectedSupplyListDepth",
                    "_selectedSupplyListParents","_selectedListOptions","_selectedListValues","_selectedOption","_selectedValue","_sortedVehicles",
                    "_updateList","_options","_values","_vehicleClasses","_displayName"];

                    _supplyList = _args select 0 select 0;
                    _selectedIndex = _args select 0 select 1;
                    _selectedDeliveryValue = [_logic,"selectedDeliveryListValue"] call MAINCLASS;
                    _selectedSupplyListOptions = [_logic,"selectedSupplyListOptions"] call MAINCLASS;
                    _selectedSupplyListValues = [_logic,"selectedSupplyListValues"] call MAINCLASS;
                    _selectedSupplyListDepth = [_logic,"selectedSupplyListDepth"] call MAINCLASS;
                    _selectedSupplyListParents = [_logic,"selectedSupplyListParents"] call MAINCLASS;
                    _selectedListOptions = _selectedSupplyListOptions select _selectedSupplyListDepth;
                    _selectedListValues = _selectedSupplyListValues select _selectedSupplyListDepth;
                    _selectedOption = _selectedListOptions select _selectedIndex;
                    _selectedValue = _selectedListValues select _selectedIndex;
                    _sortedVehicles = [_logic,"sortedVehicles"] call MAINCLASS;

                    _updateList = false;

                    _selectedSupplyListParents set [_selectedSupplyListDepth,_selectedValue];
                    [_logic,"selectedSupplyListParents",_selectedSupplyListParents] call MAINCLASS;

                    if(_selectedValue == "<< Back") then {

                        // go back a level

                        _selectedSupplyListDepth = _selectedSupplyListDepth - 1;

                        [_logic,"selectedSupplyListDepth",_selectedSupplyListDepth] call MAINCLASS;

                        _options = _selectedSupplyListOptions select _selectedSupplyListDepth;
                        _values = _selectedSupplyListValues select _selectedSupplyListDepth;

                        lbClear _supplyList;

                        {
                            _supplyList lbAdd format["%1", _x];
                        } forEach _options;

                    }else{

                        switch(_selectedSupplyListDepth) do {
                            case 0: {

                                // selected something from the top level
                                // get vehicle categories for the selected
                                // top level option

                                _updateList = true;

                                switch(_selectedValue) do {
                                    case "Vehicles": {

                                        switch(_selectedDeliveryValue) do {
                                            case "PR_AIRDROP": {
                                                _options = ["<< Back","Car","Ship"];
                                                _values = ["<< Back","Car","Ship"];
                                            };
                                            case "PR_HELI_INSERT": {
                                                _options = ["<< Back","Air"];
                                                _values = ["<< Back","Air"];
                                            };
                                            case "PR_STANDARD": {
                                                _options = ["<< Back","Car","Armored"];
                                                _values = ["<< Back","Car","Armored"];
                                            };
                                        };

                                        _selectedSupplyListOptions set [1,_options];
                                        _selectedSupplyListValues set [1,_values];
                                    };
                                    case "Defence Stores": {
                                        _options = ["<< Back","Static","Fortifications","Tents","Military"];
                                        _values = ["<< Back","Static","Fortifications","Tents","Structures_Military"];
                                        _selectedSupplyListOptions set [1,_options];
                                        _selectedSupplyListValues set [1,_values];
                                    };
                                    case "Combat Supplies": {
                                        _options = ["<< Back","Ammo"];
                                        _values = ["<< Back","Ammo"];
                                        _selectedSupplyListOptions set [1,_options];
                                        _selectedSupplyListValues set [1,_values];
                                    };
                                };

                            };
                            case 1: {

                                // selected something from the second level
                                // get vehicle classes for the selected category

                                _updateList = true;

                                _options = ["<< Back"];
                                _values = ["<< Back"];

                                _vehicleClasses = [_sortedVehicles,_selectedValue] call ALIVE_fnc_hashGet;
                                _vehicleClasses = _vehicleClasses - ALiVE_PLACEMENT_VEHICLEBLACKLIST;

                                {
                                    _displayName = getText(configFile >> "CfgVehicles" >> _x >> "displayname");

                                    _options set [count _options, _displayName];
                                    _values set [count _values, _x];

                                } forEach _vehicleClasses;

                                _selectedSupplyListOptions set [2,_options];
                                _selectedSupplyListValues set [2,_values];

                            };
                            case 2: {

                                private ["_payloadListOptions","_payloadListValues","_payloadList","_selectedParents"];

                                // selected something from the third level
                                // a vehicle has been selected..

                                _payloadListOptions = [_logic,"payloadListOptions"] call MAINCLASS;
                                _payloadListValues = [_logic,"payloadListValues"] call MAINCLASS;

                                _selectedParents = [];
                                {
                                    _selectedParents set [count _selectedParents, _x];
                                } forEach _selectedSupplyListParents;

                                _payloadListOptions set [count _payloadListOptions,_selectedOption];
                                _payloadListValues set [count _payloadListValues,[_selectedValue,_selectedParents]];

                                [_logic,"payloadListOptions",_payloadListOptions] call MAINCLASS;
                                [_logic,"payloadListValues",_payloadListValues] call MAINCLASS;

                                _payloadList = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_PayloadList);

                                _payloadList lbAdd format["%1", _selectedOption];

                                [_logic,"payloadUpdated"] call MAINCLASS;

                            };
                        };

                        if(_updateList) then {

                            // update the list options based
                            // on the last selection

                            _selectedSupplyListDepth = _selectedSupplyListDepth + 1;

                            [_logic,"selectedSupplyListDepth",_selectedSupplyListDepth] call MAINCLASS;
                            [_logic,"selectedSupplyListOptions",_selectedSupplyListOptions] call MAINCLASS;
                            [_logic,"selectedSupplyListValues",_selectedSupplyListValues] call MAINCLASS;

                            _options = _selectedSupplyListOptions select _selectedSupplyListDepth;
                            _values = _selectedSupplyListValues select _selectedSupplyListDepth;

                            lbClear _supplyList;

                            {
                                _supplyList lbAdd format["%1", _x];
                            } forEach _options;

                        };

                    };

                };

                case "REINFORCE_LIST_SELECT": {

                    // reinforce list select
                    // the user selects an option from the list

                    private ["_reinforceList","_selectedIndex","_selectedDeliveryValue","_selectedReinforceListOptions","_selectedReinforceListValues","_selectedReinforceListDepth",
                    "_selectedReinforceListParents","_selectedListOptions","_selectedListValues","_selectedOption","_selectedValue","_sortedVehicles","_sortedGroups",
                    "_updateList","_options","_values","_vehicleClasses","_displayName","_factions","_categories","_groups","_blacklistOptions"];

                    _reinforceList = _args select 0 select 0;
                    _selectedIndex = _args select 0 select 1;
                    _selectedDeliveryValue = [_logic,"selectedDeliveryListValue"] call MAINCLASS;
                    _selectedReinforceListOptions = [_logic,"selectedReinforceListOptions"] call MAINCLASS;
                    _selectedReinforceListValues = [_logic,"selectedReinforceListValues"] call MAINCLASS;
                    _selectedReinforceListDepth = [_logic,"selectedReinforceListDepth"] call MAINCLASS;
                    _selectedReinforceListParents = [_logic,"selectedReinforceListParents"] call MAINCLASS;
                    _selectedListOptions = _selectedReinforceListOptions select _selectedReinforceListDepth;
                    _selectedListValues = _selectedReinforceListValues select _selectedReinforceListDepth;
                    _selectedOption = _selectedListOptions select _selectedIndex;
                    _selectedValue = _selectedListValues select _selectedIndex;
                    _sortedVehicles = [_logic,"sortedVehicles"] call MAINCLASS;
                    _sortedGroups = [_logic,"sortedGroups"] call MAINCLASS;

                    _updateList = false;

                    _selectedReinforceListParents set [_selectedReinforceListDepth,_selectedValue];
                    [_logic,"selectedReinforceListParents",_selectedReinforceListParents] call MAINCLASS;

                    if(_selectedValue == "<< Back") then {

                        // go back a level

                        _selectedReinforceListDepth = _selectedReinforceListDepth - 1;

                        [_logic,"selectedReinforceListDepth",_selectedReinforceListDepth] call MAINCLASS;

                        _options = _selectedReinforceListOptions select _selectedReinforceListDepth;
                        _values = _selectedReinforceListValues select _selectedReinforceListDepth;

                        lbClear _reinforceList;

                        {
                            _reinforceList lbAdd format["%1", _x];
                        } forEach _options;

                    }else{

                        switch(_selectedReinforceListDepth) do {
                            case 0: {

                                // selected something from the top level
                                // get vehicle categories for the selected
                                // top level option

                                _updateList = true;

                                switch(_selectedValue) do {
                                    case "Individuals": {

                                        switch(_selectedDeliveryValue) do {
                                            case "PR_AIRDROP": {
                                                _options = ["<< Back","Men","MenDiver","MenRecon","MenSniper","MenSupport"];
                                                _values = ["<< Back","Men","MenDiver","MenRecon","MenSniper","MenSupport"];
                                            };
                                            case "PR_HELI_INSERT": {
                                                _options = ["<< Back","Men","MenDiver","MenRecon","MenSniper","MenSupport"];
                                                _values = ["<< Back","Men","MenDiver","MenRecon","MenSniper","MenSupport"];
                                            };
                                            case "PR_STANDARD": {
                                                _options = ["<< Back","Men","MenDiver","MenRecon","MenSniper","MenSupport"];
                                                _values = ["<< Back","Men","MenDiver","MenRecon","MenSniper","MenSupport"];
                                            };
                                        };

                                        _selectedReinforceListOptions set [1,_options];
                                        _selectedReinforceListValues set [1,_values];
                                    };
                                    case "Groups": {

                                        _options = ["<< Back"];
                                        _factions = _sortedGroups select 1;
                                        _options = _options + _factions;

                                        _selectedReinforceListOptions set [1,_options];
                                        _selectedReinforceListValues set [1,_options];

                                    };
                                };

                            };
                            case 1: {

                                _updateList = true;

                                if(_selectedReinforceListParents select 0 == "Groups") then {

                                    // selected a group faction
                                    // display categories

                                    _options = ["<< Back"];
                                    _categories = [_sortedGroups,_selectedValue] call ALIVE_fnc_hashGet;
                                    _categories = _categories select 1;
                                    _options = _options + _categories;

                                    switch(_selectedDeliveryValue) do {
                                        case "PR_AIRDROP": {
                                            _blacklistOptions = ["Armored","Support"];
                                        };
                                        case "PR_HELI_INSERT": {
                                            _blacklistOptions = ["Armored","Mechanized","Motorized","Motorized_MTP","SpecOps","Support"];
                                        };
                                        case "PR_STANDARD": {
                                            _blacklistOptions = ["Support"];
                                        };
                                    };

                                    _options = _options - _blacklistOptions;

                                    _selectedReinforceListOptions set [2,_options];
                                    _selectedReinforceListValues set [2,_options];

                                }else{

                                    // selected something from the second level
                                    // get vehicle classes for the selected category

                                    _options = ["<< Back"];
                                    _values = ["<< Back"];

                                    _vehicleClasses = [_sortedVehicles,_selectedValue] call ALIVE_fnc_hashGet;
                                    _vehicleClasses = _vehicleClasses - ALiVE_PLACEMENT_VEHICLEBLACKLIST;

                                    {
                                        _displayName = getText(configFile >> "CfgVehicles" >> _x >> "displayname");

                                        _options set [count _options, _displayName];
                                        _values set [count _values, _x];

                                    } forEach _vehicleClasses;

                                    _selectedReinforceListOptions set [2,_options];
                                    _selectedReinforceListValues set [2,_values];

                                };

                            };
                            case 2: {

                                if(_selectedReinforceListParents select 0 == "Groups") then {

                                    // selected a group category
                                    // display groups

                                    _updateList = true;

                                    _categories = [_sortedGroups,_selectedReinforceListParents select 1] call ALIVE_fnc_hashGet;
                                    _groups = [_categories,_selectedReinforceListParents select 2] call ALIVE_fnc_hashGet;

                                    _options = _groups select 2;
                                    _options = ["<< Back"] + _options;
                                    _values = _groups select 1;
                                    _values = ["<< Back"] + _values;

                                    _selectedReinforceListOptions set [3,_options];
                                    _selectedReinforceListValues set [3,_values];

                                }else{

                                    private ["_payloadListOptions","_payloadListValues","_payloadList","_selectedParents"];

                                    // selected something from the third level
                                    // a vehicle has been selected..

                                    _payloadListOptions = [_logic,"payloadListOptions"] call MAINCLASS;
                                    _payloadListValues = [_logic,"payloadListValues"] call MAINCLASS;

                                    _selectedParents = [];
                                    {
                                        _selectedParents set [count _selectedParents, _x];
                                    } forEach _selectedReinforceListParents;

                                    _payloadListOptions set [count _payloadListOptions,_selectedOption];
                                    _payloadListValues set [count _payloadListValues,[_selectedValue,_selectedParents,"Reinforce"]];

                                    [_logic,"payloadListOptions",_payloadListOptions] call MAINCLASS;
                                    [_logic,"payloadListValues",_payloadListValues] call MAINCLASS;

                                    _payloadList = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_PayloadList);

                                    _payloadList lbAdd format["%1", _selectedOption];

                                    [_logic,"payloadUpdated"] call MAINCLASS;

                                };

                            };
                            case 3: {

                                private ["_payloadListOptions","_payloadListValues","_payloadList","_selectedParents"];

                                // selected something from the third level
                                // a vehicle has been selected..

                                _payloadListOptions = [_logic,"payloadListOptions"] call MAINCLASS;
                                _payloadListValues = [_logic,"payloadListValues"] call MAINCLASS;

                                _selectedParents = [];
                                {
                                    _selectedParents set [count _selectedParents, _x];
                                } forEach _selectedReinforceListParents;

                                _payloadListOptions set [count _payloadListOptions,_selectedOption];
                                _payloadListValues set [count _payloadListValues,[_selectedValue,_selectedParents,"Reinforce"]];

                                [_logic,"payloadListOptions",_payloadListOptions] call MAINCLASS;
                                [_logic,"payloadListValues",_payloadListValues] call MAINCLASS;

                                _payloadList = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_PayloadList);

                                _payloadList lbAdd format["%1", _selectedOption];

                                [_logic,"payloadUpdated"] call MAINCLASS;

                            };
                        };

                        if(_updateList) then {

                            // update the list options based
                            // on the last selection

                            _selectedReinforceListDepth = _selectedReinforceListDepth + 1;

                            [_logic,"selectedReinforceListDepth",_selectedReinforceListDepth] call MAINCLASS;
                            [_logic,"selectedReinforceListOptions",_selectedReinforceListOptions] call MAINCLASS;
                            [_logic,"selectedReinforceListValues",_selectedReinforceListValues] call MAINCLASS;

                            _options = _selectedReinforceListOptions select _selectedReinforceListDepth;
                            _values = _selectedReinforceListValues select _selectedReinforceListDepth;

                            lbClear _reinforceList;

                            {
                                _reinforceList lbAdd format["%1", _x];
                            } forEach _options;

                        };

                    };

                };

                case "PAYLOAD_LIST_SELECT": {

                    // user selects one of the payload items

                    private ["_payloadList","_selectedIndex","_payloadListOptions","_payloadListValues","_selectedOption","_selectedValue"];

                    _payloadList = _args select 0 select 0;
                    _selectedIndex = _args select 0 select 1;
                    _payloadListOptions = [_logic,"payloadListOptions"] call MAINCLASS;
                    _payloadListValues = [_logic,"payloadListValues"] call MAINCLASS;

                    _selectedOption = _payloadListOptions select _selectedIndex;
                    _selectedValue = _payloadListValues select _selectedIndex;

                    [_logic,"payloadListIndex",_selectedIndex] call MAINCLASS;
                    [_logic,"payloadListValue",_selectedValue] call MAINCLASS;

                    // enable delete button

                    private ["_payloadDeleteButton"];

                    _payloadDeleteButton = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_PayloadDelete);
                    _payloadDeleteButton ctrlShow true;
                    _payloadDeleteButton ctrlSetEventHandler ["MouseButtonClick", "['PAYLOAD_DELETE_CLICK',[_this]] call ALIVE_fnc_PRTabletOnAction"];

                    // populate info text

                    private ["_payloadInfoText","_payloadInfo","_payloadOption","_payloadType","_payloadOptionsCombo","_payloadComboValues"];

                    _payloadOptionsCombo = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_PayloadOptions);
                    _payloadOptionsCombo ctrlShow false;

                    _payloadComboValues = [_logic,"payloadComboValues"] call MAINCLASS;

                    _payloadInfoText = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_PayloadInfo);
                    _payloadInfo = _selectedValue select 1;
                    _payloadOption = _selectedValue select 2;
                    _payloadType = _payloadInfo select 0;

                    switch(_payloadType) do {
                        case "Vehicles":{
                            _payloadInfoText ctrlSetText "Empty vehicle";
                        };
                        case "Defence Stores":{
                            _payloadInfoText ctrlSetText "Defence object";
                        };
                        case "Combat Supplies":{
                            _payloadInfoText ctrlSetText "Combat supply";
                        };
                        case "Individuals":{
                            _payloadInfoText ctrlSetText "Reinforcement individual";

                            // enable the options combo

                            _payloadOptionsCombo ctrlShow true;

                            _payloadOptionsCombo lbSetCurSel (_payloadComboValues find _payloadOption);

                        };
                        case "Groups":{
                            _payloadInfoText ctrlSetText "Reinforcement group";

                            // enable the options combo

                            _payloadOptionsCombo ctrlShow true;

                            _payloadOptionsCombo lbSetCurSel (_payloadComboValues find _payloadOption);


                        };
                    };

                };

                case "PAYLOAD_DELETE_CLICK": {

                    // delete selected option
                    // from the payload list

                    private ["_payloadDeleteButton","_payloadList","_selectedIndex","_payloadListOptions","_payloadListValues","_delete"];

                    _payloadDeleteButton = _args select 0 select 0;
                    _payloadList = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_PayloadList);
                    _selectedIndex = lbCurSel _payloadList;
                    _payloadListOptions = [_logic,"payloadListOptions"] call MAINCLASS;
                    _payloadListValues = [_logic,"payloadListValues"] call MAINCLASS;

                    _payloadListOptions set [_selectedIndex,"del"];
                    _payloadListValues set [_selectedIndex,"del"];

                    _delete = ["del"];

                    _payloadListOptions = _payloadListOptions - _delete;
                    _payloadListValues = _payloadListValues - _delete;

                    [_logic,"payloadListOptions",_payloadListOptions] call MAINCLASS;
                    [_logic,"payloadListValues",_payloadListValues] call MAINCLASS;

                    _payloadList lbDelete _selectedIndex;

                    _payloadDeleteButton ctrlShow false;

                    [_logic,"payloadUpdated"] call MAINCLASS;

                };

                case "PAYLOAD_COMBO_SELECT": {

                    // a group or individuals options
                    // have been set update the values
                    // of the item

                    private ["_payloadOptionsCombo","_selectedIndex","_payloadComboOptions","_payloadComboValues","_selectedOption","_selectedValue"];

                    _payloadOptionsCombo = _args select 0 select 0;
                    _selectedIndex = _args select 0 select 1;
                    _payloadComboOptions = [_logic,"payloadComboOptions"] call MAINCLASS;
                    _payloadComboValues = [_logic,"payloadComboValues"] call MAINCLASS;

                    _selectedOption = _payloadComboOptions select _selectedIndex;
                    _selectedValue = _payloadComboValues select _selectedIndex;

                    private ["_payloadList","_selectedPayloadIndex","_payloadListOptions","_payloadListValues","_selectedPayloadItem","_selectedPayloadValue"];

                    _payloadList = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_PayloadList);
                    _selectedPayloadIndex = lbCurSel _payloadList;
                    _payloadListOptions = [_logic,"payloadListOptions"] call MAINCLASS;
                    _payloadListValues = [_logic,"payloadListValues"] call MAINCLASS;

                    _selectedPayloadItem = _payloadListOptions select _selectedPayloadIndex;
                    _selectedPayloadValue = _payloadListValues select _selectedPayloadIndex;

                    _selectedPayloadValue set [2,_selectedValue];


                };

                case "MAP_CLICK": {

                    // on map click, clear existing
                    // markers, create a marker with
                    // details of the delivery type

                    private ["_posX","_posY","_map","_position","_markers","_marker","_markerLabel","_selectedDeliveryValue"];

                    _posX = _args select 0 select 2;
                    _posY = _args select 0 select 3;

                    _markers = [_logic,"marker"] call MAINCLASS;
                    _selectedDeliveryValue = [_logic,"selectedDeliveryListValue"] call MAINCLASS;

                    if(count _markers > 0) then {
                        deleteMarkerLocal (_markers select 0);
                    };

                    _map = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_Map);

                    _position = _map ctrlMapScreenToWorld [_posX, _posY];

                    ctrlMapAnimClear _map;
                    _map ctrlMapAnimAdd [0.5, ctrlMapScale _map, _position];
                    ctrlMapAnimCommit _map;

                    switch(_selectedDeliveryValue) do {
                        case "PR_AIRDROP": {
                            _markerLabel = "Air Drop";
                        };
                        case "PR_HELI_INSERT": {
                            _markerLabel = "Heli Insert";
                        };
                        case "PR_STANDARD": {
                            _markerLabel = "Convoy";
                        };
                    };

                    _marker = createMarkerLocal [format["%1%2",MTEMPLATE,"marker"],_position];
                    _marker setMarkerAlphaLocal 1;
                    _marker setMarkerTextLocal _markerLabel;
                    _marker setMarkerTypeLocal "hd_End";

                    [_logic,"marker",[_marker]] call MAINCLASS;
                    [_logic,"destination",_position] call MAINCLASS;

                };

                case "MAP_CLICK_NULL": {

                    // map click on status
                    // do nothing

                };

                case "PAYLOAD_REQUEST_CLICK": {

                    // payload requested
                    // if the payload and map marker
                    // are correct send the event
                    // if not output warning message

                    private ["_markers","_payloadReady","_status"];

                    _markers = [_logic,"marker"] call MAINCLASS;
                    _payloadReady = [_logic,"payloadReady"] call MAINCLASS;

                    _status = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_PayloadStatus);

                    if(count _markers > 0) then {

                        if(_payloadReady) then {

                            _status ctrlSetText "Sending payload request";
                            _status ctrlSetTextColor [0.384,0.439,0.341,1];

                            // prepare the payload

                            private ["_side","_faction","_destination","_deliveryType","_selectedDeliveryValue","_payloadListValues","_emptyVehicles",
                            "_payload","_staticIndividuals","_joinIndividuals","_reinforceIndividuals","_staticGroups","_joinGroups",
                            "_reinforceGroups","_payloadClass","_payloadInfo","_payloadType","_payloadOrders","_requestID","_forceMakeup",
                            "_event","_eventID","_playerID"];

                            _side = [_logic,"side"] call MAINCLASS;
                            _faction = [_logic,"faction"] call MAINCLASS;
                            _destination = [_logic,"destination"] call MAINCLASS;
                            _deliveryType = [_logic,"selectedDeliveryListValue"] call MAINCLASS;
                            _payloadListValues = [_logic,"payloadListValues"] call MAINCLASS;

                            _emptyVehicles = [];
                            _payload = [];
                            _staticIndividuals = [];
                            _joinIndividuals = [];
                            _reinforceIndividuals = [];
                            _staticGroups = [];
                            _joinGroups = [];
                            _reinforceGroups = [];

                            {
                                _payloadClass = _x select 0;
                                _payloadInfo = _x select 1;
                                _payloadType = _payloadInfo select 0;

                                switch(_payloadType) do {
                                    case "Vehicles":{
                                        _emptyVehicles set [count _emptyVehicles,[_payloadClass,_payloadInfo]];
                                    };
                                    case "Defence Stores":{
                                        _payload set [count _payload,_payloadClass];
                                    };
                                    case "Combat Supplies":{
                                        _payload set [count _payload,_payloadClass];
                                    };
                                    case "Individuals":{
                                        _payloadOrders = _x select 2;
                                        switch(_payloadOrders) do {
                                            case "Join":{
                                                _joinIndividuals set [count _joinIndividuals,[_payloadClass,_payloadInfo]];
                                            };
                                            case "Static":{
                                                _staticIndividuals set [count _staticIndividuals,[_payloadClass,_payloadInfo]];
                                            };
                                            case "Reinforce":{
                                                _reinforceIndividuals set [count _reinforceIndividuals,[_payloadClass,_payloadInfo]];
                                            };
                                        };
                                    };
                                    case "Groups":{
                                        _payloadOrders = _x select 2;
                                        switch(_payloadOrders) do {
                                            case "Join":{
                                                _joinGroups set [count _joinGroups,[_payloadClass,_payloadInfo]];
                                            };
                                            case "Static":{
                                                _staticGroups set [count _staticGroups,[_payloadClass,_payloadInfo]];
                                            };
                                            case "Reinforce":{
                                                _reinforceGroups set [count _reinforceGroups,[_payloadClass,_payloadInfo]];
                                            };
                                        };
                                    };
                                };

                            } forEach _payloadListValues;


                            _requestID = floor(time);

                            _forceMakeup = [_requestID,_payload,_emptyVehicles,_staticIndividuals,_joinIndividuals,_reinforceIndividuals,_staticGroups,_joinGroups,_reinforceGroups];

                            // send the event

                            _playerID = getPlayerUID player;

                            _event = ['LOGCOM_REQUEST', [_destination,_faction,_side,_forceMakeup,_deliveryType,_playerID],"PR"] call ALIVE_fnc_event;

                            if(isServer) then {
                                [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;
                            }else{
                                ["server","ALIVE_ADD_EVENT",[[_event],"ALIVE_fnc_addEventToServer"]] call ALiVE_fnc_BUS;
                            };

                            // display radio message

                            private ["_side","_sideObject","_callSignPlayer","_radioMessage","_radioBroadcast"];

                            _side = [_logic,"side"] call MAINCLASS;
                            _sideObject = [_side] call ALIVE_fnc_sideTextToObject;
                            _callSignPlayer = format ["%1", group player];
                            _radioMessage = "Requesting logistics support at the supplied location";

                            _radioBroadcast = [player,_radioMessage,"side",_sideObject,true,false,true,false,"HQ"];

                            [_radioBroadcast,"ALIVE_fnc_radioBroadcast",true,true] spawn BIS_fnc_MP;

                            // update the request status

                            [_logic,"updateRequestStatus","Requested"] call MAINCLASS;

                            // set the interface state

                            [_logic,"payloadRequested"] call MAINCLASS;

                        }else{
                            _status ctrlSetText "Payload refused adjust payload settings";
                            _status ctrlSetTextColor [0.729,0.216,0.235,1];
                        };

                    }else{
                        _status ctrlSetText "Select destination point on map";
                        _status ctrlSetTextColor [0.729,0.216,0.235,1];
                    };

                };

            };

        };

    };

    case "payloadUpdated": {

        // payload updated
        // calculate weights and
        // counts

        if (hasInterface) then {

            private ["_payloadListOptions","_payloadListValues","_selectedDeliveryValue","_currentWeight","_currentSize",
            "_currentGroups","_currentVehicles","_currentIndividuals","_payloadInfo","_payloadType","_payloadClass","_itemWeight","_itemSize"];

            _payloadListOptions = [_logic,"payloadListOptions"] call MAINCLASS;
            _payloadListValues = [_logic,"payloadListValues"] call MAINCLASS;
            _selectedDeliveryValue = [_logic,"selectedDeliveryListValue"] call MAINCLASS;

            _currentWeight = 0;
            _currentSize = 0;
            _currentGroups = 0;
            _currentVehicles = 0;
            _currentIndividuals = 0;

            {
                _payloadClass = _x select 0;
                _payloadInfo = _x select 1;
                _payloadType = _payloadInfo select 0;

                switch(_payloadType) do {
                    case "Vehicles":{
                        _currentVehicles = _currentVehicles + 1;
                    };
                    case "Defence Stores":{
                        // get object weight
                        _itemWeight = [_payloadClass] call ALIVE_fnc_getObjectWeight;
                        _currentWeight = _currentWeight + _itemWeight;

                        // get object size
                        _itemSize = [_payloadClass] call ALIVE_fnc_getObjectSize;
                        _currentSize = _currentSize + _itemSize;
                    };
                    case "Combat Supplies":{
                        // get object weight
                        _itemWeight = [_payloadClass] call ALIVE_fnc_getObjectWeight;
                        _currentWeight = _currentWeight + _itemWeight;

                        // get object size
                        _itemSize = [_payloadClass] call ALIVE_fnc_getObjectSize;
                        _currentSize = _currentSize + _itemSize;
                    };
                    case "Individuals":{
                        _currentIndividuals = _currentIndividuals + 1;
                    };
                    case "Groups":{
                        _currentGroups = _currentGroups + 1;
                    };
                };

            } forEach _payloadListValues;

            // set the counts

            private ["_weightText","_sizeText","_groupText","_vehiclesText","_individualsText","_counts","_countWeight","_countGroups",
            "_countVehicles","_countIndividuals","_countSize","_payloadReady"];

            _weightText = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_PayloadWeight);
            _sizeText = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_PayloadSize);
            _groupText = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_PayloadGroups);
            _vehiclesText = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_PayloadVehicles);
            _individualsText = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_PayloadIndividuals);

            switch(_selectedDeliveryValue) do {
                case "PR_AIRDROP": {
                    _counts = [_logic,"countsAir"] call MAINCLASS;
                };
                case "PR_HELI_INSERT": {
                    _counts = [_logic,"countsInsert"] call MAINCLASS;
                };
                case "PR_STANDARD": {
                    _counts = [_logic,"countsConvoy"] call MAINCLASS;
                };
            };

            _countWeight = _counts select 0;
            _countGroups = _counts select 1;
            _countVehicles = _counts select 2;
            _countIndividuals = _counts select 3;
            _countSize = _counts select 4;

            _weightText ctrlSetText format["%1 of %2 weight",_currentWeight,_countWeight];
            _sizeText ctrlSetText format["%1 of %2 size",_currentSize,_countSize];
            _groupText ctrlSetText format["%1 of %2 groups",_currentGroups,_countGroups];
            _vehiclesText ctrlSetText format["%1 of %2 vehicles",_currentVehicles,_countVehicles];
            _individualsText ctrlSetText format["%1 of %2 individuals",_currentIndividuals,_countIndividuals];

            _payloadReady = true;

            if(_currentWeight > _countWeight) then {
                _payloadReady = false;
                _weightText ctrlSetTextColor [0.729,0.216,0.235,1];
            }else{
                _weightText ctrlSetTextColor [0.384,0.439,0.341,1];
            };

            if(_currentSize > _countSize) then {
                _payloadReady = false;
                _sizeText ctrlSetTextColor [0.729,0.216,0.235,1];
            }else{
                _sizeText ctrlSetTextColor [0.384,0.439,0.341,1];
            };

            if(_currentGroups > _countGroups) then {
                _payloadReady = false;
                _groupText ctrlSetTextColor [0.729,0.216,0.235,1];
            }else{
                _groupText ctrlSetTextColor [0.384,0.439,0.341,1];
            };

            if(_currentVehicles > _countVehicles) then {
                _payloadReady = false;
                _vehiclesText ctrlSetTextColor [0.729,0.216,0.235,1];
            }else{
                _vehiclesText ctrlSetTextColor [0.384,0.439,0.341,1];
            };

            if(_currentIndividuals > _countIndividuals) then {
                _payloadReady = false;
                _individualsText ctrlSetTextColor [0.729,0.216,0.235,1];
            }else{
                _individualsText ctrlSetTextColor [0.384,0.439,0.341,1];
            };

            [_logic,"payloadReady",_payloadReady] call MAINCLASS;

        };

    };

    case "payloadRequested": {

        // payload requested
        // disable request inerface
        // display the status interface

        if (hasInterface) then {

            private ["_deliveryTitle","_deliveryList","_supplyTitle","_supplyList","_reinforceTitle","_reinforceList",
            "_payloadTitle","_payloadList","_payloadInfo","_payloadStatus","_payloadWeight","_payloadSize","_payloadGroups","_payloadVehicles",
            "_payloadIndividuals","_payloadDeleteButton","_payloadOptionsCombo","_payloadRequestButton"];

            _map = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_Map);

            _map ctrlSetEventHandler ["MouseButtonDown", "['MAP_CLICK_NULL',[_this]] call ALIVE_fnc_PRTabletOnAction"];


            _deliveryTitle = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_DeliveryTypeTitle);
            _deliveryTitle ctrlShow false;

            _deliveryList = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_DeliveryList);
            _deliveryList ctrlShow false;

            _supplyTitle = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_SupplyListTitle);
            _supplyTitle ctrlShow false;

            _supplyList = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_SupplyList);
            _supplyList ctrlShow false;

            _reinforceTitle = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_ReinforceListTitle);
            _reinforceTitle ctrlShow false;

            _reinforceList = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_ReinforceList);
            _reinforceList ctrlShow false;

            _payloadTitle = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_PayloadListTitle);
            _payloadTitle ctrlShow false;

            _payloadList = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_PayloadList);
            _payloadList ctrlShow false;

            _payloadInfo = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_PayloadInfo);
            _payloadInfo ctrlShow false;

            _payloadStatus = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_PayloadStatus);
            _payloadStatus ctrlShow false;

            _payloadWeight = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_PayloadWeight);
            _payloadWeight ctrlShow false;

            _payloadSize = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_PayloadSize);
            _payloadSize ctrlShow false;

            _payloadGroups = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_PayloadGroups);
            _payloadGroups ctrlShow false;

            _payloadVehicles = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_PayloadVehicles);
            _payloadVehicles ctrlShow false;

            _payloadIndividuals = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_PayloadIndividuals);
            _payloadIndividuals ctrlShow false;

            _payloadDeleteButton = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_PayloadDelete);
            _payloadDeleteButton ctrlShow false;

            _payloadOptionsCombo = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_PayloadOptions);
            _payloadOptionsCombo ctrlShow false;

            _payloadRequestButton = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_ButtonRequest);
            _payloadRequestButton ctrlShow false;


            // display request status text

            private ["_payloadStatusTitle","_payloadStatusText"];

            _payloadStatusTitle = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_StatusTitle);
            _payloadStatusTitle ctrlShow true;
            _payloadStatusTitle ctrlSetText "Request Status";

            _payloadStatusText = PR_getControl(PRTablet_CTRL_MainDisplay,PRTablet_CTRL_StatusText);
            _payloadStatusText ctrlShow true;

            [_logic,"displayRequestStatus"] call MAINCLASS;

            [_logic,"state","REQUEST_SENT"] call MAINCLASS;
        };

    };

};

TRACE_1("PR - output",_result);
_result;