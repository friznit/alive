#include <\x\alive\addons\mil_insurgency\script_component.hpp>
SCRIPT(insurgency);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_insurgency
Description:
Creates the server side object to store settings

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array,String,Number,Boolean - The selected parameters

Returns:
Array, String, Number, Any - The expected return value

Examples:
(begin example)
// Create instance by placing editor module
[_logic,"init"] call ALiVE_fnc_insurgency;
(end)

See Also:
- <ALIVE_fnc_insurgencyInit>

Author:
Cameroon

Peer reviewed:
nil
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClass
#define MAINCLASS ALIVE_fnc_insurgency

private ["_result", "_operation", "_args", "_logic"];

PARAMS_1(_logic);
DEFAULT_PARAM(1,_operation,"");
DEFAULT_PARAM(2,_args,nil);

//Listener for special purposes
if (!isnil QMOD(mil_insurgency) && {MOD(mil_insurgency) getvariable [QGVAR(LISTENER),false]}) then {
	_blackOps = ["id"];

	if !(_operation in _blackOps) then {
	    _check = "nothing"; if !(isnil "_args") then {_check = _args};

		["op: %1 | args: %2",_operation,_check] call ALiVE_fnc_DumpR;
	};
};

TRACE_3("mil_insurgency",_logic, _operation, _args);

switch (_operation) do {

    	case "create": {
            if (isServer) then {

	            // Ensure only one module is used
	            if !(isNil QMOD(mil_insurgency)) then {
                	_logic = MOD(mil_insurgency);
                    ERROR_WITH_TITLE(str _logic, localize "STR_ALIVE_insurgency_ERROR1");
	            } else {
	        		_logic = (createGroup sideLogic) createUnit ["ALiVE_mil_insurgency", [0,0], [], 0, "NONE"];
                    MOD(mil_insurgency) = _logic;
                };

                //Push to clients
	            PublicVariable QMOD(mil_insurgency);
            };

            TRACE_1("Waiting for object to be ready",true);

            waituntil {!isnil QMOD(mil_insurgency)};

            TRACE_1("Creating class on all localities",true);

			// initialise module game logic on all localities
			MOD(mil_insurgency) setVariable ["super", QUOTE(SUPERCLASS)];
			MOD(mil_insurgency) setVariable ["class", QUOTE(MAINCLASS)];

            _result = MOD(mil_insurgency);
        };

        case "init": {

            //["%1 - Initialisation started...",_logic] call ALiVE_fnc_Dump;

            /*
            MODEL - no visual just reference data
            - module object datastorage parameters
            - Establish data handler on server
            - Establish data model on server and client
            */

            TRACE_1("Creating data store",true);

	        // Create logistics data storage in memory on all localities
	        GVAR(STORE) = [] call ALIVE_fnc_hashCreate;

            // Define module basics on server
			if (isServer) then {
                _errorMessage = "Please include either the Requires ALiVE module or the Profiles module! %1 %2";
                _error1 = ""; _error2 = ""; //defaults
                if(
                    !(["ALiVE_require"] call ALiVE_fnc_isModuleavailable)
                    && !(["ALiVE_sys_profile"] call ALiVE_fnc_isModuleAvailable)
                    ) exitwith {
                    [_errorMessage,_error1,_error2] call ALIVE_fnc_dumpR;
                };

				// Wait for disable log module  to set module parameters
                if (["AliVE_mil_insurgencyPARAMS"] call ALiVE_fnc_isModuleavailable) then {
                    waituntil {!isnil {MOD(mil_insurgency) getvariable "DEBUG"}};
                };

                GVAR(STORE) call ALIVE_fnc_inspectHash;

            	[_logic,"state",GVAR(STORE)] call ALiVE_fnc_insurgency;

                _logic setVariable ["init", true, true];
			};

            /*
            CONTROLLER  - coordination
            */

            // Wait until server init is finished
            waituntil {_logic getvariable ["init",false]};

            TRACE_1("Spawning Server processes",isServer);

            if (isServer) then {
                // Start any server-side processes that are needed
            };

			TRACE_1("Spawning clientside processes",hasInterface);

            if (hasInterface) then {
                // Start any client-side processes that are needed
            };


            TRACE_1("After module init",_logic);

            // Indicate Init is finished on server
            if (isServer) then {
                _logic setVariable ["startupComplete", true, true];
            };

            //["%1 - Initialisation Completed...",MOD(mil_insurgency)] call ALiVE_fnc_Dump;

            _result = MOD(mil_insurgency);
        };

        case "state": {
        	if ((isnil "_args") || {!isServer}) exitwith {_result = GVAR(STORE)};

            TRACE_1("ALiVE SYS insurgency state called",_logic);


            _result = GVAR(STORE);
	    };

        case "destroy": {
            [[_logic, "destroyGlobal",_args],"ALIVE_fnc_insurgency",true, false] call BIS_fnc_MP;
        };

        case "destroyGlobal": {

                [_logic, "debug", false] call MAINCLASS;

                if (isServer) then {
                		// if server
                        MOD(mil_insurgency) = _logic;

                        MOD(mil_insurgency) setVariable ["super", nil];
                        MOD(mil_insurgency) setVariable ["class", nil];
                        MOD(mil_insurgency) setVariable ["init", nil];

                        // and publicVariable to clients

                        publicVariable QMOD(mil_insurgency);
                        [_logic, "destroy"] call SUPERCLASS;
                };

                if (hasInterface) then {
                };
        };

        default {
            _result = [_logic, _operation, _args] call SUPERCLASS;
        };
};


TRACE_1("ALiVE SYS insurgency - output",_result);

if !(isnil "_result") then {
    _result;
};
