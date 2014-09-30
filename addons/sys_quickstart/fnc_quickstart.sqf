#include <\x\alive\addons\sys_quickstart\script_component.hpp>
SCRIPT(quickstart);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_quickstart
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
[_logic,"init"] call ALiVE_fnc_quickstart;
(end)

See Also:
- <ALIVE_fnc_quickstartInit>

Author:
Cameroon

Peer reviewed:
nil
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClass
#define MAINCLASS ALIVE_fnc_quickstart

private ["_result", "_operation", "_args", "_logic"];

PARAMS_1(_logic);
DEFAULT_PARAM(1,_operation,"");
DEFAULT_PARAM(2,_args,nil);

//Listener for special purposes
if (!isnil QMOD(SYS_quickstart) && {MOD(SYS_quickstart) getvariable [QGVAR(LISTENER),false]}) then {
	_blackOps = ["id"];

	if !(_operation in _blackOps) then {
	    _check = "nothing"; if !(isnil "_args") then {_check = _args};

		["op: %1 | args: %2",_operation,_check] call ALiVE_fnc_DumpR;
	};
};

TRACE_3("SYS_quickstart",_logic, _operation, _args);

switch (_operation) do {

    	case "create": {
            if (isServer) then {

	            // Ensure only one module is used
	            if !(isNil QMOD(SYS_quickstart)) then {
                	_logic = MOD(SYS_quickstart);
                    ERROR_WITH_TITLE(str _logic, localize "STR_ALIVE_quickstart_ERROR1");
	            } else {
	        		_logic = (createGroup sideLogic) createUnit ["ALiVE_SYS_quickstart", [0,0], [], 0, "NONE"];
                    MOD(SYS_quickstart) = _logic;
                };

                //Push to clients
	            PublicVariable QMOD(SYS_quickstart);
            };

            TRACE_1("Waiting for object to be ready",true);

            waituntil {!isnil QMOD(SYS_quickstart)};

            TRACE_1("Creating class on all localities",true);

			// initialise module game logic on all localities
			MOD(SYS_quickstart) setVariable ["super", QUOTE(SUPERCLASS)];
			MOD(SYS_quickstart) setVariable ["class", QUOTE(MAINCLASS)];

            _result = MOD(SYS_quickstart);
        };

        case "init": {

            ["%1 - Initialisation started...",_logic] call ALiVE_fnc_Dump;

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
                if (["AliVE_SYS_quickstartPARAMS"] call ALiVE_fnc_isModuleavailable) then {
                    waituntil {!isnil {MOD(SYS_quickstart) getvariable "DEBUG"}};
                };

                GVAR(STORE) call ALIVE_fnc_inspectHash;

            	[_logic,"state",GVAR(STORE)] call ALiVE_fnc_quickstart;

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

            ["%1 - Initialisation Completed...",MOD(SYS_quickstart)] call ALiVE_fnc_Dump;

            _result = MOD(SYS_quickstart);
        };

        case "state": {
        	if ((isnil "_args") || {!isServer}) exitwith {_result = GVAR(STORE)};

            TRACE_1("ALiVE SYS quickstart state called",_logic);


            _result = GVAR(STORE);
	    };

        case "destroy": {
            [[_logic, "destroyGlobal",_args],"ALIVE_fnc_quickstart",true, false] call BIS_fnc_MP;
        };

        case "destroyGlobal": {

                [_logic, "debug", false] call MAINCLASS;

                if (isServer) then {
                		// if server
                        MOD(SYS_quickstart) = _logic;

                        MOD(SYS_quickstart) setVariable ["super", nil];
                        MOD(SYS_quickstart) setVariable ["class", nil];
                        MOD(SYS_quickstart) setVariable ["init", nil];

                        // and publicVariable to clients

                        publicVariable QMOD(SYS_quickstart);
                        [_logic, "destroy"] call SUPERCLASS;
                };

                if (hasInterface) then {
                };
        };

        default {
            _result = [_logic, _operation, _args] call SUPERCLASS;
        };
};


TRACE_1("ALiVE SYS quickstart - output",_result);

if !(isnil "_result") then {
    _result;
};
