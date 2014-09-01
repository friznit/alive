#include <\x\alive\addons\fnc_analysis\script_component.hpp>
SCRIPT(battlefieldAnalysis);

/* ----------------------------------------------------------------------------
Function: MAINCLASS
Description:
Battlefield analysis

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array - The selected parameters

Returns:
Any - The new instance or the result of the selected function and parameters

Attributes:


Examples:
(begin example)
// create the battlefield analysis
_logic = [nil, "create"] call ALIVE_fnc_battlefieldAnalysis;

// init battlefield analysis
_result = [_logic, "init"] call ALIVE_fnc_battlefieldAnalysis;

(end)

See Also:

Author:
ARJay

Peer reviewed:
nil
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClassHash
#define MAINCLASS ALIVE_fnc_battlefieldAnalysis

private ["_logic","_operation","_args","_result"];

TRACE_1("battlefieldAnalysis - input",_this);

_logic = [_this, 0, objNull, [objNull,[]]] call BIS_fnc_param;
_operation = [_this, 1, "", [""]] call BIS_fnc_param;
_args = [_this, 2, objNull, [objNull,[],"",0,true,false]] call BIS_fnc_param;
//_result = true;

#define MTEMPLATE "ALiVE_BATTLEFIELDANALYSIS_%1"

switch(_operation) do {
    case "destroy": {
        [_logic, "debug", false] call MAINCLASS;
        if (isServer) then {
                [_logic, "destroy"] call SUPERCLASS;
        };
    };
    case "debug": {
        private["_tasks"];

        if(typeName _args != "BOOL") then {
                _args = [_logic,"debug"] call ALIVE_fnc_hashGet;
        } else {
                [_logic,"debug",_args] call ALIVE_fnc_hashSet;
        };
        ASSERT_TRUE(typeName _args == "BOOL",str _args);

        _result = _args;
    };
    case "init": {
        if (isServer) then {

            // if server, initialise module game logic
            [_logic,"super"] call ALIVE_fnc_hashRem;
            [_logic,"class",MAINCLASS] call ALIVE_fnc_hashSet;
            TRACE_1("After module init",_logic);

            // set defaults
            [_logic,"debug",false] call ALIVE_fnc_hashSet;
            [_logic,"activeSectors",[] call ALIVE_fnc_hashCreate] call ALIVE_fnc_hashSet;
            [_logic,"casualtySectors",[] call ALIVE_fnc_hashCreate] call ALIVE_fnc_hashSet;
            [_logic,"listenerID",""] call ALIVE_fnc_hashSet;

            [_logic,"listen"] call MAINCLASS;
        };
    };
    case "listen": {
        private["_listenerID"];

        _listenerID = [ALIVE_eventLog, "addListener",[_logic, [
            "LOGISTICS_INSERTION",
            "LOGISTICS_DESTINATION",
            "PROFILE_KILLED",
            "AGENT_KILLED",
            "OPCOM_RECON",
            "OPCOM_CAPTURE",
            "OPCOM_DEFEND",
            "OPCOM_RESERVE"
        ]]] call ALIVE_fnc_eventLog;

        [_logic,"listenerID",_listenerID] call ALIVE_fnc_hashSet;
    };
    case "handleEvent": {
        private["_event","_type","_eventData"];

        if(typeName _args == "ARRAY") then {

            _event = _args;

            _id = [_event, "id"] call ALIVE_fnc_hashGet;
            _type = [_event, "type"] call ALIVE_fnc_hashGet;
            _eventData = [_event, "data"] call ALIVE_fnc_hashGet;

            [_logic, _type, [_id,_eventData]] call MAINCLASS;

        };
    };
    case "LOGISTICS_INSERTION": {
        private["_eventID","_eventData"];

        _eventID = _args select 0;
        _eventData = _args select 1;

        ["LOGISTICS_INSERTION"] call ALIVE_fnc_dump;

        _eventData call ALIVE_fnc_inspectArray;

    };
    case "LOGISTICS_DESTINATION": {
        private["_eventID","_eventData"];

        _eventID = _args select 0;
        _eventData = _args select 1;

        ["LOGISTICS_DESTINATION"] call ALIVE_fnc_dump;

        _eventData call ALIVE_fnc_inspectArray;

    };
    case "PROFILE_KILLED": {
        private["_eventID","_eventData","_position","_side","_faction","_eventSector","_eventSectorID",
        "_sectorData","_casualties","_factionCasualties","_sideCasualties","_casualtySectors",
        "_factionCasualtyCount","_sideCasualtyCount"];

        _eventID = _args select 0;
        _eventData = _args select 1;

        _position = _eventData select 0;
        _side = _eventData select 2;
        _faction = _eventData select 1;

        _eventSector = [ALIVE_sectorGrid, "positionToSector", _position] call ALIVE_fnc_sectorGrid;
        _eventSectorID = [_eventSector,"id"] call ALIVE_fnc_hashGet;

        _sectorData = [_eventSector,"data"] call ALIVE_fnc_hashGet;

        if!("casualties" in (_sectorData select 1)) then {
            _casualties = [] call ALIVE_fnc_hashCreate;
            [_casualties,"side",[] call ALIVE_fnc_hashCreate] call ALIVE_fnc_hashSet;
            [_casualties,"faction",[] call ALIVE_fnc_hashCreate] call ALIVE_fnc_hashSet;
            [_sectorData,"casualties",_casualties] call ALIVE_fnc_hashSet;
        };

        _casualties = [_sectorData,"casualties"] call ALIVE_fnc_hashGet;
        _factionCasualties = [_casualties,"faction"] call ALIVE_fnc_hashGet;
        _sideCasualties = [_casualties,"side"] call ALIVE_fnc_hashGet;

        if!(_side in (_sideCasualties select 1)) then {
            [_sideCasualties,_side,0] call ALIVE_fnc_hashSet;
        };

        if!(_faction in (_factionCasualties select 1)) then {
            [_factionCasualties,_faction,0] call ALIVE_fnc_hashSet;
        };

        _factionCasualtyCount = [_factionCasualties,_faction] call ALIVE_fnc_hashGet;
        _factionCasualtyCount = _factionCasualtyCount + 1;
        [_factionCasualties,_faction,_factionCasualtyCount] call ALIVE_fnc_hashSet;

        _sideCasualtyCount = [_sideCasualties,_side] call ALIVE_fnc_hashGet;
        _sideCasualtyCount = _sideCasualtyCount + 1;
        [_sideCasualties,_side,_sideCasualtyCount] call ALIVE_fnc_hashSet;

        _casualtySectors = [_logic, "casualtySectors"] call ALIVE_fnc_hashGet;
        [_casualtySectors,_eventSectorID,_eventSector] call ALIVE_fnc_hashSet;

    };
    case "AGENT_KILLED": {
        private["_eventID","_eventData"];

        _eventID = _args select 0;
        _eventData = _args select 1;

        ["AGENT_KILLED"] call ALIVE_fnc_dump;

        _eventData call ALIVE_fnc_inspectArray;

    };
    case "OPCOM_RECON": {
        private["_eventID","_eventData","_side","_position","_type","_clusterID"];

        _eventID = _args select 0;
        _eventData = _args select 1;

        _side = _eventData select 0;
        _position = _eventData select 1 select 2 select 1;
        _type = _eventData select 1 select 2 select 3;
        _clusterID = _eventData select 1 select 2 select 6;

        [_logic,"storeClusterEventToSector",[_clusterID,[_operation,floor(time),_position,_side,_type]]] call MAINCLASS;

    };
    case "OPCOM_CAPTURE": {
        private["_eventID","_eventData","_side","_position","_type","_clusterID"];

        _eventID = _args select 0;
        _eventData = _args select 1;

        _side = _eventData select 0;
        _position = _eventData select 1 select 2 select 1;
        _type = _eventData select 1 select 2 select 3;
        _clusterID = _eventData select 1 select 2 select 6;

        [_logic,"storeClusterEventToSector",[_clusterID,[_operation,floor(time),_position,_side,_type]]] call MAINCLASS;

    };
    case "OPCOM_DEFEND": {
        private["_eventID","_eventData","_side","_position","_type","_clusterID"];

        _eventID = _args select 0;
        _eventData = _args select 1;

        _side = _eventData select 0;
        _position = _eventData select 1 select 2 select 1;
        _type = _eventData select 1 select 2 select 3;
        _clusterID = _eventData select 1 select 2 select 6;

        [_logic,"storeClusterEventToSector",[_clusterID,[_operation,floor(time),_position,_side,_type]]] call MAINCLASS;

    };
    case "OPCOM_RESERVE": {
        private["_eventID","_eventData","_side","_position","_type","_clusterID"];

        _eventID = _args select 0;
        _eventData = _args select 1;

        _side = _eventData select 0;
        _position = _eventData select 1 select 2 select 1;
        _type = _eventData select 1 select 2 select 3;
        _clusterID = _eventData select 1 select 2 select 6;

        [_logic,"storeClusterEventToSector",[_clusterID,[_operation,floor(time),_position,_side,_type]]] call MAINCLASS;

    };
    case "storeClusterEventToSector": {
        private["_clusterID","_eventData","_type","_position","_side","_clusterType","_eventSector","_eventSectorID",
        "_sectorData","_activeClusters","_activeCluster"];

        _clusterID = _args select 0;
        _eventData = _args select 1;

        _type = _eventData select 0;
        _position = _eventData select 2;
        _side = _eventData select 3;
        _clusterType = _eventData select 4;

        _eventSector = [ALIVE_sectorGrid, "positionToSector", _position] call ALIVE_fnc_sectorGrid;
        _eventSectorID = [_eventSector,"id"] call ALIVE_fnc_hashGet;

        _sectorData = [_eventSector,"data"] call ALIVE_fnc_hashGet;

        if!("activeClusters" in (_sectorData select 1)) then {
            [_sectorData,"activeClusters",[] call ALIVE_fnc_hashCreate] call ALIVE_fnc_hashSet;
        };

        _activeClusters = [_sectorData,"activeClusters"] call ALIVE_fnc_hashGet;

        if!(_clusterID in (_activeClusters select 1)) then {
            _activeCluster = [] call ALIVE_fnc_hashCreate;
            _activeCluster = [_activeCluster,"position",_position] call ALIVE_fnc_hashSet;
            _activeCluster = [_activeCluster,"type",_clusterType] call ALIVE_fnc_hashSet;
            _activeCluster = [_activeCluster,"owner",""] call ALIVE_fnc_hashSet;
            _activeCluster = [_activeCluster,"lastEvent",""] call ALIVE_fnc_hashSet;
            _activeCluster = [_activeCluster,"lastEventTime",time] call ALIVE_fnc_hashSet;
            [_activeClusters,_clusterID,_activeCluster] call ALIVE_fnc_hashSet;
        };

        _activeCluster = [_activeClusters,_clusterID] call ALIVE_fnc_hashGet;

        switch(_type) do {
            case "OPCOM_RECON": {
                _activeCluster = [_activeCluster,"lastEvent","recon"] call ALIVE_fnc_hashSet;
            };
            case "OPCOM_CAPTURE": {
                _activeCluster = [_activeCluster,"lastEvent","capture"] call ALIVE_fnc_hashSet;
            };
            case "OPCOM_DEFEND": {
                _activeCluster = [_activeCluster,"lastEvent","defend"] call ALIVE_fnc_hashSet;
            };
            case "OPCOM_RESERVE": {
                _activeCluster = [_activeCluster,"lastEvent","reserve"] call ALIVE_fnc_hashSet;
                _activeCluster = [_activeCluster,"owner",_side] call ALIVE_fnc_hashSet;
            };
        };

        [_activeClusters,_clusterID,_activeCluster] call ALIVE_fnc_hashSet;
        [_sectorData,"activeClusters",_activeClusters] call ALIVE_fnc_hashSet;
        [_eventSector,"data",_sectorData] call ALIVE_fnc_hashSet;

        _activeSectors = [_logic, "activeSectors"] call ALIVE_fnc_hashGet;
        [_activeSectors,_eventSectorID,_eventSector] call ALIVE_fnc_hashSet;

    };
    case "getActiveSectors": {
        _result = [_logic, "activeSectors"] call ALIVE_fnc_hashGet;
    };
    case "getCasualtySectors": {
        _result = [_logic, "casualtySectors"] call ALIVE_fnc_hashGet;
    };
    default {
        _result = [_logic, _operation, _args] call SUPERCLASS;
    };
};
TRACE_1("battlefieldAnalysis - output",_result);

if !(isnil "_result") then {_result} else {nil};
