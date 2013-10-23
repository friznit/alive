_test = ALIVE_radioLogic;
diag_log format ["LOGIC: %1",_test];

_callsigns = ALIVE_radioLogic select 3;
diag_log format ["LOGIC: %1",_callsigns];
lbadd[1500, _callsigns];
private ["_display","_map","_abort","_casList","_casStatus","_unit","_target"];
_display = this select 0;
_map = _display displayCtrl 655560;
_abort = _display displayCtrl 1701;
_casList = _display displayCtrl 1500;
_casStatus =  _display displayCtrl 1004;
_unit = player;
_target = _display displayCtrl 2100;

lbadd[1500, _callsigns];