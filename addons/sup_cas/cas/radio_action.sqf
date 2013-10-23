//Action Variable

uinamespace setVariable ["ALIVE_radioCurrentAction", ALIVE_radioLogic];
diag_log format ["ALIVE_radioLogic LOAD: %1",ALIVE_radioLogic];
//Open Interface
createDialog "ALIVE_resourceRadio";

waitUntil {dialog};


_callsigns = ALIVE_radioLogic select 3;
lbadd[1500, _callsigns];







//_callsigns = ALIVE_radioLogic select 3;
///diag_log format ["LOGIC: %1",_callsigns];
//lbadd[1500, _callsigns];
