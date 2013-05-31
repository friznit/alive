#include <\x\alive\addons\fnc_analysis\script_component.hpp>
SCRIPT(sectorPlot);

/* ----------------------------------------------------------------------------
Function: MAINCLASS
Description:
Creates visual representations of sector data

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array - The selected parameters

Returns:
Any - The new instance or the result of the selected function and parameters

Attributes:
Array - plot - Array of sector and key to plot data

Examples:
(begin example)
// create a sector plot
_logic = [nil, "create"] call ALIVE_fnc_sectorPlot;

// plot a sector
_result = [_logic, "plot", [_sector, "key"]] call ALIVE_fnc_sectorPlot;
(end)

See Also:

Author:
ARJay

Peer reviewed:
nil
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClass
#define MAINCLASS ALIVE_fnc_sectorPlot

private ["_logic","_operation","_args","_result"];

TRACE_1("sectorPlot - input",_this);

_logic = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_operation = [_this, 1, "", [""]] call BIS_fnc_param;
_args = [_this, 2, objNull, [objNull,[],"",true,false]] call BIS_fnc_param;
_result = true;

#define MTEMPLATE "ALiVE_SECTORPLOT_%1"

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
								
                if (isServer) then {
				
						// clear plot
						[_logic, "clear"] call MAINCLASS;						
						
                        // if server
                        _logic setVariable ["super", nil];
                        _logic setVariable ["class", nil];
											                      
                        [_logic, "destroy"] call SUPERCLASS;					
                };
                
        };
		case "plot": {
				private["_sector","_key","_centerPosition","_id","_bounds","_dimensions","_sectorData","_markers","_plotData"];
				
				_sector = _args select 0;
				_key = _args select 1;
				
				_centerPosition = [_sector, "center"] call ALIVE_fnc_sector;
				_id = [_sector, "id"] call ALIVE_fnc_sector;
				_bounds = [_sector, "bounds"] call ALIVE_fnc_sector;
				_dimensions = [_sector, "dimensions"] call ALIVE_fnc_sector;
				_sectorData = [_sector, "data"] call ALIVE_fnc_sector;
				_markers = [];
				
				switch(_key) do {
						case "units": {
							private["_eastUnits","_westUnits","_civUnits","_guerUnits","_eastCount","_westUnits","_civUnits","_guerUnits","_alpha", "_m"];
							_plotData = [_sectorData, _key] call CBA_fnc_hashGet;
							
							_eastUnits = [_plotData, "EAST"] call CBA_fnc_hashGet;
							_westUnits = [_plotData, "WEST"] call CBA_fnc_hashGet;
							_civUnits = [_plotData, "CIV"] call CBA_fnc_hashGet;
							_guerUnits = [_plotData, "GUER"] call CBA_fnc_hashGet;
							
							_eastCount = count _eastUnits;
							_westCount = count _westUnits;
							_civCount = count _civUnits;
							_guerCount = count _guerUnits;
							
							if(_eastCount > 0) then {
								if(_eastCount > 0) then { _alpha = 0.2; };
								if(_eastCount > 10) then { _alpha = 0.3; };
								if(_eastCount > 20) then { _alpha = 0.4; };
								if(_eastCount > 30) then { _alpha = 0.5; };							
								
								_m = createMarkerLocal [format[MTEMPLATE, format["e%1",_id]], _centerPosition];
								_m setMarkerShapeLocal "RECTANGLE";
								_m setMarkerSizeLocal _dimensions;
								_m setMarkerTypeLocal "Solid";		
								_m setMarkerAlphaLocal _alpha;
								_m setMarkerColorLocal "ColorRed";	
											
								_markers set [count _markers, _m];
							};
							
							if(_westCount > 0) then {
								if(_westCount > 0) then { _alpha = 0.2; };
								if(_westCount > 10) then { _alpha = 0.3; };
								if(_westCount > 20) then { _alpha = 0.4; };
								if(_westCount > 30) then { _alpha = 0.5; };
							
								_m = createMarkerLocal [format[MTEMPLATE, format["w%1",_id]], _centerPosition];
								_m setMarkerShapeLocal "RECTANGLE";
								_m setMarkerSizeLocal _dimensions;
								_m setMarkerTypeLocal "Solid";		
								_m setMarkerAlphaLocal 0.5;
								_m setMarkerColorLocal "ColorBlue";	
											
								_markers set [count _markers, _m];
							};
							
							if(_civCount > 0) then {
								if(_civCount > 0) then { _alpha = 0.2; };
								if(_civCount > 10) then { _alpha = 0.3; };
								if(_civCount > 20) then { _alpha = 0.4; };
								if(_civCount > 30) then { _alpha = 0.5; };
							
								_m = createMarkerLocal [format[MTEMPLATE, format["c%1",_id]], _centerPosition];
								_m setMarkerShapeLocal "RECTANGLE";
								_m setMarkerSizeLocal _dimensions;
								_m setMarkerTypeLocal "Solid";		
								_m setMarkerAlphaLocal 0.5;
								_m setMarkerColorLocal "ColorGreen";	
											
								_markers set [count _markers, _m];
							};
							
							if(_guerCount > 0) then {
								if(_guerCount > 0) then { _alpha = 0.2; };
								if(_guerCount > 10) then { _alpha = 0.3; };
								if(_guerCount > 20) then { _alpha = 0.4; };
								if(_guerCount > 30) then { _alpha = 0.5; };
								
								_m = createMarkerLocal [format[MTEMPLATE, format["g%1",_id]], _centerPosition];
								_m setMarkerShapeLocal "RECTANGLE";
								_m setMarkerSizeLocal _dimensions;
								_m setMarkerTypeLocal "Solid";		
								_m setMarkerAlphaLocal 0.5;
								_m setMarkerColorLocal "ColorYellow";	
											
								_markers set [count _markers, _m];
							};
						};
						case "terrain": {
							private["_m"];
							_plotData = [_sectorData, _key] call CBA_fnc_hashGet;
							
							switch (_plotData) do {
								case "LAND": {
									_m = createMarkerLocal [format[MTEMPLATE, format["t%1",_id]], _centerPosition];
									_m setMarkerShapeLocal "RECTANGLE";
									_m setMarkerSizeLocal _dimensions;
									_m setMarkerTypeLocal "Solid";		
									_m setMarkerAlphaLocal 0.5;
									_m setMarkerColorLocal "ColorBrown";	
												
									_markers set [count _markers, _m];
								};
								case "SHORE": {
									_m = createMarkerLocal [format[MTEMPLATE, format["t%1",_id]], _centerPosition];
									_m setMarkerShapeLocal "RECTANGLE";
									_m setMarkerSizeLocal _dimensions;
									_m setMarkerTypeLocal "Solid";		
									_m setMarkerAlphaLocal 0.5;
									_m setMarkerColorLocal "ColorKhaki";	
												
									_markers set [count _markers, _m];
								};
								case "SEA": {
									_m = createMarkerLocal [format[MTEMPLATE, format["t%1",_id]], _centerPosition];
									_m setMarkerShapeLocal "RECTANGLE";
									_m setMarkerSizeLocal _dimensions;
									_m setMarkerTypeLocal "Solid";		
									_m setMarkerAlphaLocal 0.5;
									_m setMarkerColorLocal "ColorBlue";	
												
									_markers set [count _markers, _m];
								};
							};
						};
						case "elevation": {
							private["_m","_colour","_alpha","_value"];							
							_plotData = [_sectorData, _key] call CBA_fnc_hashGet;
							
							_alpha = 0;
							
							_colour = "ColorRed";
							_value = _plotData;
							
							if(_value < 0) then {
								_colour = "ColorBlue";
								_value = _plotData - (_plotData * 2);
							}else {
								_value = _plotData;
							};
							
							if(_value > 0) then { _alpha = 0.1; };
							if(_value > 20) then { _alpha = 0.2; };
							if(_value > 40) then { _alpha = 0.3; };
							if(_value > 60) then { _alpha = 0.4; };
							if(_value > 80) then { _alpha = 0.5; };
							if(_value > 100) then { _alpha = 0.6; };
							if(_value > 120) then { _alpha = 0.7; };
							if(_value > 140) then { _alpha = 0.8; };
							
							_m = createMarkerLocal [format[MTEMPLATE, format["e%1",_id]], _centerPosition];
							_m setMarkerShapeLocal "RECTANGLE";
							_m setMarkerSizeLocal _dimensions;
							_m setMarkerTypeLocal "Solid";		
							_m setMarkerAlphaLocal _alpha;
							_m setMarkerColorLocal _colour;	
										
							_markers set [count _markers, _m];
						};
				};	

				_logic setVariable ["markers", _markers];				
        };
		case "clear": {
				private["_markers"];
				
				_markers = _logic getVariable ["markers", []];
				
				{
					deleteMarkerLocal _x;
				} forEach _markers;				
		};
        default {
                _result = [_logic, _operation, _args] call SUPERCLASS;
        };
};
TRACE_1("sectorPlot - output",_result);
_result;