#include <\x\alive\addons\mil_convoy\script_component.hpp>
SCRIPT(convoy);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_convoy
Description:
XXXXXXXXXX

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array - The selected parameters

Returns:
Any - The new instance or the result of the selected function and parameters

Attributes:
Boolean - debug - Debug enabled
Boolean - enabled - Enabled or disable module

Parameters:
none

Description:
Transport Module! Detailed description to follow

Examples:
[_logic, "factions", ["OPF_F"] call ALiVE_fnc_Transport;
[_logic, "houses", _nonStrategicHouses] call ALiVE_fnc_Transport;
[_logic, "spawnDistance", 500] call ALiVE_fnc_Transport;
[_logic, "active", true] call ALiVE_fnc_Transport;

See Also:
- <ALIVE_fnc_TransportInit>

Author:
Gunny

---------------------------------------------------------------------------- */

#define SUPERCLASS nil

private ["_logic","_operation","_args"];

PARAMS_1(_logic);
DEFAULT_PARAM(1,_operation,"");
DEFAULT_PARAM(2,_args,nil);


switch(_operation) do {              
		default {
                private["_err"];
                _err = format["%1 does not support %2 operation", _logic, _operation];
                ERROR_WITH_TITLE(str _logic,_err);
        };
		/*MODEL - no visual just reference data
		- server side object only
		- enabled/disabled
		*/
		// Ensure only one module is used
case "init": {  

		if (isServer) then {
			MOD(convoy) = _logic;
			publicVariable QMOD(convoy);

 			 //Initialise module game logic on all localities (clientside spawn)
                _logic setVariable ["super", SUPERCLASS];
                _logic setVariable ["class", ALIVE_fnc_CONVOY];
                _logic setVariable ["init", true, true]; 

              _CONVOY_intensity = _logic getvariable["conv_intensity_setting",1];
            CONVOY_intensity = parsenumber _CONVOY_intensity;
		diag_log format["Convoy Instensity: %1", CONVOY_intensity];

                 CONVOY_safearea = _logic getvariable ["conv_safearea_setting",2000];
				if (typename (CONVOY_safearea) == "STRING") then {CONVOY_safearea = call compile CONVOY_safearea};
                _logic setVariable ["convoy_safearea", CONVOY_safearea];
		diag_log format["Safe Area: %1", CONVOY_safearea];

                factionsConvoy = _logic getvariable ["CONV_FACTIONS","OPF_F"];
                //factionsConvoy = [_logic,"convoyfactions",factionsConvoy];
diag_log format["FActions: %1", factionsConvoy];

                CONVOY_GLOBALDEBUG = _logic getvariable ["conv_debug_setting",false];
                if (typename (CONVOY_GLOBALDEBUG) == "STRING") then {CONVOY_GLOBALDEBUG = call compile CONVOY_GLOBALDEBUG};
diag_log format["DEBUG: %1", CONVOY_GLOBALDEBUG];            
} else {
		
};


		 


		 if(!isDedicated && !isHC) then 
		 	{
		 call ALIVE_fnc_startConvoy;
		  };


};


     	case "destroy": {
		if (isServer) then {
			// if server
			_logic setVariable ["super", nil];
			_logic setVariable ["class", nil];
			_logic setVariable ["init", nil];
			// and publicVariable to clients
			MOD(convoy) = _logic;
			publicVariable QMOD(convoy);
		};
	};
       
};
