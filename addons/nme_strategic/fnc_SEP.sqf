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
Array - factions - Factions associated with module

Parameters:
none

Description:
xxx

Examples:
[_logic, "factions", ["OPF_F"] call ALiVE_fnc_SEP;

See Also:
- <ALIVE_fnc_SEPInit>

Author:
Wolffy
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClass
#define MAINCLASS ALIVE_fnc_SEP
#define MTEMPLATE "ALiVE_SEP_%1"

private ["_logic","_operation","_args","_createMarkers","_deleteMarkers","_result","_findObjectID"];

TRACE_1("SEP - input",_this);

_logic = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_operation = [_this, 1, "", [""]] call BIS_fnc_param;
_args = [_this, 2, objNull, [objNull,[],true,false]] call BIS_fnc_param;
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
                _logic call _deleteMarkers;
                
                if(_args) then {
                        _logic call _createMarkers;
                };
                _result = _args;
        };        
        case "state": {
                private["_state","_data","_nodes"];
                
                if(typeName _args != "ARRAY") then {
                        _state = [] call CBA_fnc_hashCreate;
                        // Save state
                        
                        // nodes
                        _data = [];
                        {
                                _data set [count _data, [
                                        _x call _findObjectID,
                                        position _x
                                ]];
                        } forEach (_logic getVariable ["nodes",[]]);
                        
                        _result = [_state, "nodes", _data] call CBA_fnc_hashSet;
                } else {
                        ASSERT_TRUE([_args] call CBA_fnc_isHash,str _args);
                        
                        // Restore state
                        
                        // nodes
                        _data = [];
                        _nodes = [_args, "nodes"] call CBA_fnc_hashGet;
                        {
                                private["_node"];
                                _node = (_x select 1) nearestObject (_x select 0);
                                _data set [count _data, _node];
                        } forEach _nodes;
                        [_logic, "nodes", _data] call MAINCLASS;
                };		
        };        
        case "factions": {
                if(isNil "_args") then {
                        // if no new faction list was provided return current setting
                        _args = _logic getVariable ["factions", []];
                } else {
                        // if a new faction list was provided set factions settings
                        ASSERT_TRUE(typeName _args == "ARRAY",str typeName _args);
                        _logic setVariable ["factions", _args, true];
                };
                _args;
        };        
};
TRACE_1("SEP - output",_result);
_result;
