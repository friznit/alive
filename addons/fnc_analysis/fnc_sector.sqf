#include <\x\alive\addons\fnc_analysis\script_component.hpp>
SCRIPT(sector);

/* ----------------------------------------------------------------------------
Function: MAINCLASS
Description:
Creates the server side object to create a sector

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array - The selected parameters

Returns:
Any - The new instance or the result of the selected function and parameters

Attributes:
Boolean - debug - Debug enable, disable or refresh
Boolean - state - Store or restore state of analysis
Array - dimensions - Array of width, height dimensions for sector creation
Array - position - Array of width, height dimensions for sector creation
center - Returns the center point of the sector
bounds - Returns Array of corner postions BL, TL, TR, BR
Array - within - Returns if the passed position is within the sector
String - id - Id of sector
Array - data - Array of key values for storage in the sectors data hash

Examples:
(begin example)
// create a sector
_logic = [nil, "create"] call ALIVE_fnc_sector;

// set sector dimension
_result = [_logic, "dimensions", _dimension_array] call ALIVE_fnc_sector;

// set sector position
_result = [_logic, "position", _position_array] call ALIVE_fnc_sector;

// set sector id
_result = [_logic, "id", "Sector Id"] call ALIVE_fnc_sector;

// get sector center
_result = [_logic, "center"] call ALIVE_fnc_sector;

// get sector bounds
_result = [_logic, "bounds"] call ALIVE_fnc_sector;

// get position within sector
_result = [_logic, "within", getPos player] call ALIVE_fnc_sector;

// set arbitrary data on the sectors data hash
_result = [_logic, "data", ["key" ["values"]]] call ALIVE_fnc_sector;

(end)

See Also:

Author:
ARJay

Peer reviewed:
nil
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClass
#define MAINCLASS ALIVE_fnc_sector

private ["_logic","_operation","_args","_result"];

TRACE_1("sector - input",_this);

_logic = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_operation = [_this, 1, "", [""]] call BIS_fnc_param;
_args = [_this, 2, objNull, [objNull,[],"",true,false]] call BIS_fnc_param;
_result = true;

#define MTEMPLATE "ALiVE_SECTOR_%1"

_deleteMarkers = {
		private ["_logic"];
        _logic = _this;
        {
                deleteMarkerLocal _x;
        } forEach (_logic getVariable ["debugMarkers", []]);
};

_createMarkers = {
        private ["_logic","_markers","_m","_position","_dimensions"];
        _logic = _this;
        _markers = [];
        _position = _logic getVariable ["position", []];
		_dimensions = _logic getVariable ["dimensions", []];
		_id = _logic getVariable ["id", ""];
		
        if((count _position > 0) && (count _dimensions > 0)) then {                                
                
				_m = createMarkerLocal [format[MTEMPLATE, _logic], _position];
				_m setMarkerShapeLocal "RECTANGLE";
                _m setMarkerSizeLocal _dimensions;
                _m setMarkerTypeLocal "Solid";				
                _m setMarkerColorLocal (_logic getVariable ["debugColor","ColorGreen"]);	
							
                _markers set [count _markers, _m];				
				
				_m = createMarkerLocal [format[MTEMPLATE, _id], _position];
				_m setMarkerShapeLocal "ICON";
				_m setMarkerSizeLocal [1, 1];
				_m setMarkerTypeLocal "mil_dot";
				_m setMarkerColorLocal (_logic getVariable ["debugColor","ColorGreen"]);
                _m setMarkerTextLocal _id;	
				
				_markers set [count _markers, _m];
				
                _logic setVariable ["debugMarkers", _markers];
        };
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
				private["_state","_dimensions","_position","_id"];
                
                if(typeName _args != "ARRAY") then {
                        _state = [] call CBA_fnc_hashCreate;
                        // Save state

                        // dimensions                   
                        _result = [_state, "dimensions", _logic getVariable ["dimensions",[]]] call CBA_fnc_hashSet;
						
						// position                        
                        _result = [_state, "position", _logic getVariable ["position",[]]] call CBA_fnc_hashSet;
						
						// id
                        _result = [_state, "id", _logic getVariable ["id",""]] call CBA_fnc_hashSet;
						
                } else {
						ASSERT_TRUE(typeName _args == "ARRAY",str typeName _args);

                        // Restore state

                        // dimensions
                        _dimensions = [_args, "dimensions"] call CBA_fnc_hashGet;
                        [_logic, "dimensions", _dimensions] call MAINCLASS;
						
						// position
                        _position = [_args, "position"] call CBA_fnc_hashGet;
                        [_logic, "position", _position] call MAINCLASS;
						
						// id
                        _id = [_args, "id"] call CBA_fnc_hashGet;
                        [_logic, "id", _id] call MAINCLASS;
                };		
        };
		case "dimensions": {
				if(typeName _args == "ARRAY") then {
                        _logic setVariable ["dimensions", _args];                        
                };
                _result = _logic getVariable ["dimensions", []];
        };
		case "position": {
				if(typeName _args == "ARRAY") then {
                        _logic setVariable ["position", _args];              
                };
                _result = _logic getVariable ["position", []];
        };
		case "id": {
				if(typeName _args == "STRING") then {
                        _logic setVariable ["id", _args];              
                };
                _result = _logic getVariable ["id", ""];
        };
		case "data": {
				if(typeName _args == "ARRAY") then {
					_key = _args select 0;
					_value = _args select 1;		
					_data = _logic getVariable ["data", [] call CBA_fnc_hashCreate];
					_result = [_data, _key, _value] call CBA_fnc_hashSet;
					_logic setVariable ["data", _result];
				};					
				_result = _logic getVariable ["data", [] call CBA_fnc_hashCreate];
        };
		case "center": {
				_result = _logic getVariable ["position", []];
        };
		case "bounds": {
				private["_position","_dimensions","_positionX","_positionY","_sectorWidth","_sectorHeight","_positionBL","_positionTL","_positionTR","_positionBR"];
				_position = _logic getVariable ["position", []];
				_dimensions = _logic getVariable ["dimensions", []];
				
				_positionX = _position select 0;
				_positionY = _position select 1;
				_sectorWidth = _dimensions select 0;
				_sectorHeight = _dimensions select 1;
				
				_positionBL = [(_positionX - _sectorWidth), (_positionY - _sectorHeight)];
				_positionTL = [(_positionX - _sectorWidth), (_positionY + _sectorHeight)];
				_positionTR = [(_positionX + _sectorWidth), (_positionY + _sectorHeight)];
				_positionBR = [(_positionX + _sectorWidth), (_positionY - _sectorHeight)];
				
				_result = [_positionBL, _positionTL, _positionTR, _positionBR]
        };
		case "within": {
				private["_position","_bounds","_positionBL","_positionBLX","_positionBLY","_positionTR","_positionTRX","_positionTRY"];
				ASSERT_TRUE(typeName _args == "ARRAY",str typeName _args);
				
				_position = _args;
				_positionX = _position select 0;
				_positionY = _position select 1;
				
				_bounds = [_logic, "bounds"] call MAINCLASS;
				
				_positionBL = _bounds select 0;
				_positionBLX = _positionBL select 0;
				_positionBLY = _positionBL select 1;
				_positionTR = _bounds select 2;
				_positionTRX = _positionTR select 0;
				_positionTRY = _positionTR select 1;
				
				_result = false;
				
				if(
					(_positionX > _positionBLX) &&
					(_positionY > _positionBLY) &&
					(_positionX < _positionTRX) &&
					(_positionY < _positionTRY)
				) then {
					_result = true;
				};
        };
        default {
                _result = [_logic, _operation, _args] call SUPERCLASS;
        };
};
TRACE_1("sector - output",_result);
_result;