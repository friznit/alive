private ["_display", "_casUnitLb", "_casArray", "_veh", "_callsign", "_callSignPlayer"];
_display = findDisplay 655555;
_casUnitLb = _display displayCtrl 655582;
_casArray = ALIVE_radioLogic getVariable format ["ALIVE_radioCasArray_%1", side player];
_veh = _casArray select (lbCurSel _casUnitLb) select 0;
_callsign = _casArray select (lbCurSel _casUnitLb) select 2;
_callSignPlayer = (format ["%1", group player]) call ALIVE_fnc_callsignFix;

//Task
_veh setVariable ["ALIVE_radioCasNewTask", ["RTB", [], 0, 0, ""], true];
[player, format ["%1, this is %2. Return to base. Over.", _callsign, _callSignPlayer], "side"] call ALIVE_fnc_messageBroadcast;

//Interface
[lbCurSel 1500] call ALIVE_fnc_radioRefreshUi;
