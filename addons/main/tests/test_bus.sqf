// ----------------------------------------------------------------------------

#include <\x\alive\addons\main\script_component.hpp>
SCRIPT(test_bus);

// ----------------------------------------------------------------------------

private ["_err","_logic","_amo"];

LOG("Testing ALiVE Service Bus");

// UNIT TESTS
ASSERT_DEFINED("ALIVE_fnc_BUS","ALIVE_fnc_BUS is not defined!");

#define STAT(msg) sleep 1; \
diag_log ["TEST("+str player+": "+msg]; \
titleText [msg,"PLAIN"]

#define STAT1(msg) CONT = false; \
waitUntil{CONT}; \
diag_log ["TEST("+str player+": "+msg]; \
titleText [msg,"PLAIN"]

private ["_expected","_returned","_result"];
STAT("Test No Params (Create/Check Eventhandler");
_expected = true;
_returned = [] call ALIVE_fnc_BUS;
_result = [typeName _expected, typeName _returned] call BIS_fnc_areEqual;
ASSERT_TRUE(_result,typeOf _expected + " != " + typeOf _returned);

ERROR_SERVER = nil;
ERROR_CLIENT = nil;
ERROR_CC = nil;

[] spawn {
	STAT("Test Transfer client to server");
	if !(isDedicated) then {
	
		    hint "Starting ALiVE Servicebus Test (expected duration: 20 secs)!";
		    private ["_idxv","_idtmp","_retV","_sumavg","_avgArr","_timeNow","_n"];
			_timeNow = time;
			_n = 1;
		
			BUS_pending = [];
			BUS_finished = [];
			BUS_archived = [];
		    BUS_ReturnedVals = [];
		    _avgArr = [];
		    _sumavg = 0;
		
			while {_n <= 100} do {
				_tmTmp = time;
		        _idtmp = ["server","Subject",[[_n],{diag_log format["server test %1",_this select 0];true;}]] call ALIVE_fnc_BUS;
				waituntil {_idxv = ([BUS_finished,_idtmp] call BIS_fnc_findNestedElement) select 0; !(isnil "_idxv")};
		        waituntil {_retV = nil;_retV = ((BUS_finished select _idxv) select 1) select 2; !(isnil "_retV");};
				_avgArr set [count _avgArr,(time - _tmTmp)];
		        BUS_ReturnedVals set [count BUS_ReturnedVals,_retV];
			    _n = _n + 1;
		    };
		    {_sumavg = _sumavg + _x} foreach _avgArr;
		    _sumavg = _sumavg / (count _avgArr);
		    
		    diag_log format["Test finished. time taken: %1 seconds (avg. transfer speed: %5! Operations total: %2! Operations failed: %3! Values returned: %4",
		    time - _timenow,
		    (count BUS_archived) + (count BUS_finished),
		    count BUS_pending,
		    count BUS_ReturnedVals,
		    _sumavg
		    ];
		    hint format["Test finished. time taken: %1 seconds (avg. transfer speed: %5! Operations total: %2! Operations failed: %3! Values returned: %4",
		    time - _timenow,
		    (count BUS_archived) + (count BUS_finished),
		    count BUS_pending,
		    count BUS_ReturnedVals,
		    _sumavg
		    ];
	        
	        if (count BUS_pending > 0) then {ERROR_CLIENT = true} else {ERROR_CLIENT = false};
	        Publicvariable "ERROR_CLIENT";
	};
	Waituntil {!isnil "ERROR_CLIENT"};
	
	STAT("Test Transfer server to client");
	if (isServer) then {
		    private ["_idxv","_idtmp","_retV","_sumavg","_avgArr","_timeNow","_n"];
			_timeNow = time;
			_n = 1;
		
			BUS_pending = [];
			BUS_finished = [];
			BUS_archived = [];
		    BUS_ReturnedVals = [];
		    _avgArr = [];
		    _sumavg = 0;
		
			while {_n <= 100} do {
				_tmTmp = time;
		        _idtmp = [playableunits select 0,"Subject",[[_n],{diag_log format["client test %1",_this select 0];true;}]] call ALIVE_fnc_BUS;
				waituntil {_idxv = ([BUS_finished,_idtmp] call BIS_fnc_findNestedElement) select 0; !(isnil "_idxv")};
		        waituntil {_retV = nil;_retV = ((BUS_finished select _idxv) select 1) select 2; !(isnil "_retV");};
				_avgArr set [count _avgArr,(time - _tmTmp)];
		        BUS_ReturnedVals set [count BUS_ReturnedVals,_retV];
			    _n = _n + 1;
		    };
		    {_sumavg = _sumavg + _x} foreach _avgArr;
		    _sumavg = _sumavg / (count _avgArr);
		    
		    diag_log format["Test finished. time taken: %1 seconds (avg. transfer speed: %5! Operations total: %2! Operations failed: %3! Values returned: %4",
		    time - _timenow,
		    (count BUS_archived) + (count BUS_finished),
		    count BUS_pending,
		    count BUS_ReturnedVals,
		    _sumavg
		    ];
		    hint format["Test finished. time taken: %1 seconds (avg. transfer speed: %5! Operations total: %2! Operations failed: %3! Values returned: %4",
		    time - _timenow,
		    (count BUS_archived) + (count BUS_finished),
		    count BUS_pending,
		    count BUS_ReturnedVals,
		    _sumavg
		    ];
	        if (count BUS_pending > 0) then {ERROR_SERVER = true} else {ERROR_SERVER = false};
	        Publicvariable "ERROR_SERVER";
	};
	Waituntil {!isnil "ERROR_SERVER"};
	
	STAT("Test Transfer client to client");
	if !(isDedicated) then {
	    if !(count playableunits > 1) exitwith {ERROR_CC = true; Publicvariable "ERROR_CC";};
		    private ["_idxv","_idtmp","_retV","_sumavg","_avgArr","_timeNow","_n"];
			_timeNow = time;
			_n = 1;
		
			BUS_pending = [];
			BUS_finished = [];
			BUS_archived = [];
		    BUS_ReturnedVals = [];
		    _avgArr = [];
		    _sumavg = 0;
		
			while {_n <= 100} do {
				_tmTmp = time;
		        _idtmp = [playableunits select 1,"Subject",[[_n],{diag_log format["server test %1",_this select 0];true;}]] call ALIVE_fnc_BUS;
				waituntil {_idxv = ([BUS_finished,_idtmp] call BIS_fnc_findNestedElement) select 0; !(isnil "_idxv")};
		        waituntil {_retV = nil;_retV = ((BUS_finished select _idxv) select 1) select 2; !(isnil "_retV");};
				_avgArr set [count _avgArr,(time - _tmTmp)];
		        BUS_ReturnedVals set [count BUS_ReturnedVals,_retV];
			    _n = _n + 1;
		    };
		    {_sumavg = _sumavg + _x} foreach _avgArr;
		    _sumavg = _sumavg / (count _avgArr);
		    
		    diag_log format["Test finished. time taken: %1 seconds (avg. transfer speed: %5! Operations total: %2! Operations failed: %3! Values returned: %4",
		    time - _timenow,
		    (count BUS_archived) + (count BUS_finished),
		    count BUS_pending,
		    count BUS_ReturnedVals,
		    _sumavg
		    ];
		    hint format["Test finished. time taken: %1 seconds (avg. transfer speed: %5! Operations total: %2! Operations failed: %3! Values returned: %4",
		    time - _timenow,
		    (count BUS_archived) + (count BUS_finished),
		    count BUS_pending,
		    count BUS_ReturnedVals,
		    _sumavg
		    ];
	        if (count BUS_pending > 0) then {ERROR_CC = true} else {ERROR_CC = false};
	        Publicvariable "ERROR_CC";
	};
	Waituntil {!isnil "ERROR_CC"};
	
	if (ERROR_SERVER || ERROR_CLIENT || ERROR_CC) then {
	    _message = format["Test Client2Server ok:  %1 Server2Client ok: %2 Client2Client ok: %3! See logs!",!ERROR_SERVER,!ERROR_CLIENT,!ERROR_CC];
		hint _message;
	    diag_log _message;
	} else {
	    _message = "All Tests OK";
		hint _message;
	    diag_log _message;
	};
    nil;
};
