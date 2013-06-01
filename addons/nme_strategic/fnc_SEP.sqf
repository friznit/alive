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

private ["_logic","_operation","_args","_createMarkers","_deleteMarkers","_result","_validateClusters"];

TRACE_1("SEP - input",_this);

_logic = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_operation = [_this, 1, "", [""]] call BIS_fnc_param;
_args = [_this, 2, objNull, [objNull,[],"",0,true,false]] call BIS_fnc_param;
_result = true;

_validateClusters = {
        private ["_logic","_clusters","_result","_marker"];
        PARAMS_2(_logic,_clusters);

        _result = [];
        _marker = _logic getVariable ["taor",""];
        if(_marker != "" &&
        {_marker call ALIVE_fnc_markerExists}) then {
                {
                        if(([_marker, position _x] call BIS_fnc_inTrigger)) then {
                                _result set [count _result, _x];
                        };
                } forEach _clusters;
        };
/*
        _clusters = +_result;

        _result = [];
        _marker = _logic getVariable ["blacklist",""];
        if(_marker != "" &&
        {_marker call ALIVE_fnc_markerExists}) then {
                {
                        if(!([_marker, position _x] call BIS_fnc_inTrigger)) then {
                                 _result set [count _result, _x];
                        };
                } forEach _clusters;
        };
*/        
        _result;
};

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
        // Determine Symmetric or Asymmetric modelling - valid values are: SYM and ASYM
        case "style": {
                _result = [_logic,_operation,_args,DEFAULT_STYLE,["ASYM","SYM"]] call ALIVE_fnc_OOsimpleOperation;
        };        
        // Determine size of enemy force - valid values are: BN, COY and PL
        case "size": {
                _result = [_logic,_operation,_args,DEFAULT_SIZE,["BN","PL","COY"]] call ALIVE_fnc_OOsimpleOperation;
        };
        // Determine force faction
        case "faction": {
                _result = [_logic,_operation,_args,DEFAULT_FACTION,[] call BIS_fnc_getFactions] call ALIVE_fnc_OOsimpleOperation;
        };
        // Main process
        case "execute": {
                private ["_obj_array","_clusters_hq","_clusters","_clusters_air","_clusters_heli","_clusters_veh"];

                // Find HQ locations
                _obj_array = [
                        "barrack",
                        "cargo_hq_",
                        "miloffices"
                ] call ALIVE_fnc_getObjectsByType;
                _clusters_hq = [_obj_array] call ALIVE_fnc_findClusters;
                _clusters_hq = [_logic, _clusters_hq] call _validateClusters;
                {
                        _x setVariable ["debugColor", "ColorRed"];
                } forEach _clusters_hq;
                
                switch([_logic, "size"] call MAINCLASS) do {
                        case "BN": {
                                // Find BN HQ location
                                // - Confirm HQ loc is not outside TAOR or inside Blacklist - otherwise redo
                                // - Place clutter objects
                                // - Place BN HQ at location
                                // - Consolidate HQ loc with objectives
                                // - Set HQ Objectives with the highest priority
                        };
                        case "COY": {
                                // Continue to find Coy HQ location
                                // - Confirm HQ loc is not outside TAOR or inside Blacklist - otherwise redo
                                // - Place clutter objects
                                // - Place Coy HQ at location
                                // - Consolidate HQ loc with objectives
                                // - Set HQ Objectives with the next highest priority
                                // Repeat as required
                        };
                };
                
                _clusters = +_clusters_hq;
/*                
                // Idenitfy objectives with hangers for military fixed wing air
                // - Optionally use hangers for military vehicle assets
                // - Calculate number of fixed wing air assets
                _obj_array = ["hangar"] call ALIVE_fnc_getObjectsByType;
                _clusters_air = [_obj_array] call ALIVE_fnc_findClusters;
                {
                        _x setVariable ["debugColor", "ColorOrange"];
                } forEach _clusters_air;
                
                // Idenitfy objectives with helipads for military rotary wing air
                // - Calculate number of rotary wing air assets
                _obj_array = ["helipadsquare"] call ALIVE_fnc_getObjectsByType;
                _clusters_heli = [_obj_array] call ALIVE_fnc_findClusters;
                {
                        _x setVariable ["debugColor", "ColorYellow"];
                } forEach _clusters_heli;                
                
                // Identify objectives with sheds for military vehicles assets
                // - Calculate number of military vehicles assets
                _obj_array = ["shed_big"] call ALIVE_fnc_getObjectsByType;
                _clusters_veh = [_obj_array] call ALIVE_fnc_findClusters;                
                {
                        _x setVariable ["debugColor", "ColorGreen"];
                } forEach _clusters_veh;
                
                _result = [_clusters, _clusters_air] call ALIVE_fnc_consolidateClusters;
                _clusters = (_result select 0) + (_result select 1);
                _result = [_clusters, _clusters_heli] call ALIVE_fnc_consolidateClusters;
                _clusters = (_result select 0) + (_result select 1);
                _result = [_clusters, _clusters_veh] call ALIVE_fnc_consolidateClusters;
                _clusters = (_result select 0) + (_result select 1);
*/                
                {
                        [_x, "debug", true] call ALIVE_fnc_cluster;
                } forEach _clusters;
                
                
                // If fixed wing assets available
                // - Create squadron (offensive or transport)
                // - Place near hangers
                // If rotary wing assets available
                // - Create squadron (offensive or transport)
                // - Place on helipads
                // If military vehicles available
                // - Create platoons (offensive or transport)
                // - Place near sheds
                
                // Collate objectives and their priorities
                // - Exclude objectives outside TAOR or inside Blacklist
                
                // Calculate remaining infantry for company
                // Randomly/appropriately choose remaining Platoons and their Squad make up
                // Place the entire PL somewhere and let them sort themselves out from there using OPCOM

        };
};
TRACE_1("SEP - output",_result);
_result;
