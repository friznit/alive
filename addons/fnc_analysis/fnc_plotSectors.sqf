#include <\x\alive\addons\fnc_analysis\script_component.hpp>
SCRIPT(plotSectors);

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
Array - plot - Array of sectors and key to plot data

Examples:
(begin example)
// create a sector plot
_logic = [nil, "create"] call ALIVE_fnc_plotSectors;

// plot sectors
_result = [_logic, "plot", [_sectors, "key"]] call ALIVE_fnc_plotSectors;
(end)

See Also:

Author:
ARJay

Peer reviewed:
nil
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClassHash
#define MAINCLASS ALIVE_fnc_plotSectors

private ["_logic","_operation","_args","_result"];

TRACE_1("plotSectors - input",_this);

_logic = [_this, 0, objNull, [[]]] call BIS_fnc_param;
_operation = [_this, 1, "", [""]] call BIS_fnc_param;
_args = [_this, 2, objNull, [objNull,[],"",0,true,false]] call BIS_fnc_param;
_result = true;

#define MTEMPLATE "ALiVE_PLOTSECTORS_%1"

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
                        [_logic,"super",SUPERCLASS] call ALIVE_fnc_hashSet;
						[_logic,"class",MAINCLASS] call ALIVE_fnc_hashSet;
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
				
						// clear plots
						[_logic, "clear"] call MAINCLASS;
												
                        // if server
                        //[_logic,"super",nil] call ALIVE_fnc_hashSet;
						//[_logic,"class",nil] call ALIVE_fnc_hashSet;		
                        
                        [_logic, "destroy"] call SUPERCLASS;					
                };
                
        };
		case "plot": {
				private["_sector","_key","_plots","_plot"];
				
				_sectors = _args select 0;
				_key = _args select 1;
				
				_plots = [];
				
				{
					_sector = _x;
					_plot = [nil, "create"] call ALIVE_fnc_sectorPlot;
					[_plot, "plot", [_sector, _key]] call ALIVE_fnc_sectorPlot;
					_plots set [count _plots, _plot];
				} forEach _sectors;

				[_logic,"plots",_plots] call ALIVE_fnc_hashSet;
        };
		case "clear": {
				private["_plots"];
				
				_plots = [_logic,"plots"] call ALIVE_fnc_hashGet;
				
				{
					_result = [_x, "destroy", false] call ALIVE_fnc_sectorPlot;
				} forEach _plots;				
		};
        default {
                _result = [_logic, _operation, _args] call SUPERCLASS;
        };
};
TRACE_1("plotSectors - output",_result);
_result;