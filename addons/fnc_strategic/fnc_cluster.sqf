#include <\x\alive\addons\fnc_strategic\script_component.hpp>
SCRIPT(cluster);

/* ----------------------------------------------------------------------------
Function: MAINCLASS
Description:
Creates the server side object to cluster information

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array - The selected parameters

Returns:
Any - The new instance or the result of the selected function and parameters

Attributes:
Boolean - debug - Debug enable, disable or refresh
Boolean - state - Store or restore state of cluster
Array - nodes - Array of object nodes within cluster
Object - addNode - Add object to node array of cluster
Object - delNode - Delete object from node array of cluster
Array - center - (Read only) - Recalculate, set and return centre position of cluster
Number - size - (Read only) - Maximum distance of an object from the centre

Examples:
(begin example)
// 
(end)

See Also:
- <ALIVE_fnc_findClusters>
- <ALIVE_fnc_consolidateClusters>

Author:
Wolffy.au

Peer reviewed:
nil
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClass
#define MAINCLASS ALIVE_fnc_cluster

private ["_logic","_operation","_args","_createMarkers","_deleteMarkers","_nodes","_center","_result","_findObjectID"];

TRACE_1("cluster - input",_this);

_logic = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_operation = [_this, 1, "", [""]] call BIS_fnc_param;
_args = [_this, 2, objNull, [objNull,[],"",true,false]] call BIS_fnc_param;
_result = true;

#define MTEMPLATE "ALiVE_CLUSTER_%1"

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
                _max = [_logic, "size"] call MAINCLASS;
                _m setMarkerShapeLocal "Ellipse";
                _m setMarkerSizeLocal [_max, _max];
                _m setMarkerColorLocal (_logic getVariable ["debugColor","ColorYellow"]);
                _m setMarkerAlphaLocal 0.5;
                _markers set [count _markers, _m];
                
                _logic setVariable ["debugMarkers", _markers];
        };
};

_findObjectID = {
        // 388c2080# 88544: helipadsquare_f.p3d
        private ["_tmp","_result"];
        PARAMS_1(_tmp);
        _result = [str _tmp, "# "] call CBA_fnc_split;
	if(count _result > 1) then {
	        _result = [_result select 1, ": "] call CBA_fnc_split;
        	_result = parseNumber (_result select 0);
	} else {
		_result = typeOf _tmp;
	};
	_result;
};

switch(_operation) do {
        case "init": {                
                /*
                MODEL - no visual just reference data
                - nodes
                - center
                - size
                */
                
                if (isServer) then {
                        // if server, initialise module game logic
                        _logic setVariable ["super", SUPERCLASS];
                        _logic setVariable ["class", MAINCLASS];
                        TRACE_1("After module init",_logic);
                };
                
                
                /*
                VIEW - purely visual
                */
                
                /*
                CONTROLLER  - coordination
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
        case "center": {
                // Read Only - return centre of clustered nodes
                _result = [_logic getVariable ["nodes",[]]] call ALIVE_fnc_findClusterCenter;
		if(count _result > 0) then {_logic setPos _result;};
        };
        
        case "size": {
                // Read Only - return distance from centre to furthest node
                private ["_max"];
                _nodes = _logic getVariable ["nodes",[]];
                _result = 0;
                _center = [_logic, "center"] call MAINCLASS;
		if(count _center > 0) then {
	       	        {
        	       	        if(_x distance _center > _result) then {_result = _x distance _center;};
                	} forEach _nodes;
		};
        };        
        case "nodes": {
                if(typeName _args == "ARRAY") then {
                        _logic setVariable ["nodes", _args];                        
                };
                
                if (_logic getVariable ["debug", false]) then {
                        [_logic, "debug"] call MAINCLASS;
                };
                _result = _logic getVariable ["nodes", []];
        };
        case "addNode": {
                if(typeName _args == "OBJECT") then {
                        [_logic,"nodes",[_args],true,true] call BIS_fnc_variableSpaceAdd;
                        
                        if (_logic getVariable ["debug", false]) then {
                                [_logic, "debug"] call MAINCLASS;
                        };
                };
                _result = _logic getVariable ["nodes", []];
        };
        case "delNode": {
                if(typeName _args == "OBJECT") then {
                        [_logic,"nodes",[_args],true] call BIS_fnc_variableSpaceRemove;
                        
                        if (_logic getVariable ["debug", false]) then {
                                [_logic, "debug"] call MAINCLASS;
                        };
                };
                _result = _logic getVariable ["nodes", []];
        };        
        default {
                _result = [_logic, _operation, _args] call SUPERCLASS;
        };
};
TRACE_1("cluster - output",_result);
_result;