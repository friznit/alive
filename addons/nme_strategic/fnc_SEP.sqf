#include <\x\alive\addons\nme_strategic\script_component.hpp>
SCRIPT(SEP);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_SEP
Description:
Initial placement of enemy based on clustered objectives within the AO.
In a persisted situation, the stance, etc would change during gameplay
and be persisted as well, restoring if the mission is restarted ie params
within editor module ignored.

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array - The selected parameters

Returns:
Any - The new instance or the result of the selected function and parameters

Attributes:
Nil - init - Intiate instance
Nil - destroy - Destroy instance
Boolean - debug - Debug enabled
Array - state - Save and restore module state
Array - faction - Faction associated with module

Parameters:
none

Description:
xxx

Examples:
[_logic, "faction", "OPF_F"] call ALiVE_fnc_SEP;

See Also:
- <ALIVE_fnc_SEPInit>

Author:
Wolffy
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClass
#define MAINCLASS ALIVE_fnc_SEP
#define MTEMPLATE "ALiVE_SEP_%1"
#define DEFAULT_STYLE QUOTE(SYM)
#define DEFAULT_SIZE QUOTE(COY)
#define DEFAULT_FACTION QUOTE(OPF_F)

private ["_logic","_operation","_args","_createMarkers","_deleteMarkers","_result"];

TRACE_1("SEP - input",_this);

_logic = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_operation = [_this, 1, "", [""]] call BIS_fnc_param;
_args = [_this, 2, objNull, [objNull,[],"",true,false]] call BIS_fnc_param;
_result = true;

_deleteMarkers = {
        private ["_logic"];
        _logic = _this;
        {
                deleteMarkerLocal _x;
        } forEach (_logic getVariable ["debugMarkers", []]);
};

_createMarkers = {
        private ["_logic","_markers","_m","_max","_nodes","_center"];
        _logic = _this;
        _markers = [];
        _nodes = _logic getVariable ["nodes", []];
        
        if(count _nodes > 0) then {
                // mark all nodes
                {
                        _m = format[MTEMPLATE, _x];
                        if(str getMarkerPos _m == "[0,0,0]") then {
                                _m = createMarkerLocal [_m, getPosATL _x];
                                _m setMarkerShapeLocal "Icon";
                                _m setMarkerSizeLocal [0.5,0.5];
                                _m setMarkerTypeLocal "mil_dot";
                                _markers set [count _markers, _m];
                        } else {
                                _m setMarkerPosLocal (getPosATL _x);
                        };
                        _m setMarkerColorLocal (_logic getVariable ["debugColor","ColorYellow"]);
                } forEach _nodes;
                
                _center = [_logic, "center"] call MAINCLASS;
                _m = createMarkerLocal [format[MTEMPLATE, _logic], _center];
                _m setMarkerShapeLocal "Icon";
                _m setMarkerSizeLocal [1, 1];
                _m setMarkerTypeLocal "mil_dot";
                _m setMarkerColorLocal (_logic getVariable ["debugColor","ColorYellow"]);
                _m setMarkerTextLocal format[MTEMPLATE, _logic];
                _markers set [count _markers, _m];
                
                _m = createMarkerLocal [(format[MTEMPLATE, _logic] + "_size"), _center];
                _max = [_logic, "size"] call ALiVE_fnc_cluster;
                _m setMarkerShapeLocal "Ellipse";
                _m setMarkerSizeLocal [_max, _max];
                _m setMarkerColorLocal (_logic getVariable ["debugColor","ColorYellow"]);
                _m setMarkerAlphaLocal 0.5;
                _markers set [count _markers, _m];
                
                _logic setVariable ["debugMarkers", _markers];
        };
};

_simpleOperation = {
	PARAMS_5(_logic,_operation,_args,_default,_choices);
	if(typeName _args != "STRING") then {
		_args = _logic getVariable [_operation, _default];
	};
	if(!(_args in _choices)) then {_args = _default;};
	_logic setVariable [_operation, _args];
	if (_logic getVariable ["debug", false]) then {
		diag_log PFORMAT_2(QUOTE(MAINCLASS), _operation,_args);
	};
	_result = _args;
};

switch(_operation) do {
        default {
                _result = [_logic, _operation, _args] call SUPERCLASS;
        };
        case "init": {
                /*
                MODEL - no visual just reference data
                - force size and composition
                - HQ and other forces locations
                - 
                */
                
                if (isServer) then {
                        // if server, initialise module game logic
                        _logic setVariable ["super", SUPERCLASS];
                        _logic setVariable ["class", MAINCLASS];
                        TRACE_1("After module init",_logic);
                };
                
                /*
                CONTROLLER  - coordination
                */
                
                /*
                VIEW - purely visual
                */
        };
        case "destroy": {
                [_logic, "debug", false] call MAINCLASS;
                if (isServer) then {
                        // if server
                        _logic setVariable ["super", nil];
                        _logic setVariable ["class", nil];
                        
                        [_logic, "destroy"] call SUPERCLASS;
                };
                
        };
        case "debug": {
                if(typeName _args != "BOOL") then {
                        _args = _logic getVariable ["debug", false];
                } else {
                        _logic setVariable ["debug", _args];
                };                
                ASSERT_TRUE(typeName _args == "BOOL",str _args);
                //_logic call _deleteMarkers;
                
                if(_args) then {
                        //_logic call _createMarkers;
                };
                _result = _args;
        };        
        case "state": {
                private["_state","_data","_nodes","_simple_operations"];
                _simple_operations = ["style", "size","faction"];
                
                if(typeName _args != "ARRAY") then {
                        _state = [] call CBA_fnc_hashCreate;
                        // Save state
                        {
                                [_state, _x, _logic getVariable _x] call CBA_fnc_hashSet;
                        } forEach _simple_operations;
                        
                        /*
                        // nodes
                        _data = [];
                        {
                                _data set [count _data, [
                                        _x call _findObjectID,
                                        position _x
                                ]];
                        } forEach (_logic getVariable ["nodes",[]]);
                        _result = [_state, "nodes", _data] call CBA_fnc_hashSet;
                        */
                        if (_logic getVariable ["debug", false]) then {
                                diag_log PFORMAT_2(QUOTE(MAINCLASS), _operation,_state);
                        };
                        _result = _state;
                } else {
                        ASSERT_TRUE([_args] call CBA_fnc_isHash,str _args);
                        
                        // Restore state
                        {
                                [_logic, _x, [_args, _x] call CBA_fnc_hashGet] call MAINCLASS;
                        } forEach _simple_operations;
                        
                        /*
                        // nodes
                        _data = [];
                        _nodes = [_args, "nodes"] call CBA_fnc_hashGet;
                        {
                                private["_node"];
                                _node = (_x select 1) nearestObject (_x select 0);
                                _data set [count _data, _node];
                        } forEach _nodes;
                        [_logic, "nodes", _data] call MAINCLASS;
                        */
                };		
        };        
        case "style": {
                // Symmetric or Asymmetric modelling - valid values are: SYM and ASYM
                _result = [_logic,_operation,_args,DEFAULT_STYLE,["ASYM","SYM"]] call _simpleOperation;
        };        
        case "size": {
                // Size of enemy force - valid values are: BN, COY and PL
                _result = [_logic,_operation,_args,DEFAULT_SIZE,["BN","PL","COY"]] call _simpleOperation;
        };        
        case "faction": {
                // Force faction
                _result = [_logic,_operation,_args,DEFAULT_FACTION,[] call BIS_fnc_getFactions] call _simpleOperation;
        };        
};
TRACE_1("SEP - output",_result);
_result;
