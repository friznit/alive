private ["_display", "_map", "_transportUnitLb", "_transportTaskLb", "_transportConfirmButton", "_slider", "_transportFlyHeightSlider"];
_display = findDisplay 655555;
_map = _display displayCtrl 655560;
_transportUnitLb = _display displayCtrl 655568;
_transportTaskLb = _display displayCtrl 655569;
_transportConfirmButton = _display displayCtrl 655574;
_slider = _display displayCtrl 655578;
_transportFlyHeightSlider = _display displayCtrl 655580;

private ["_transportArray", "_unit", "_grp", "_callsign", "_callSignPlayer", "_task", "_marker", "_pos"];
_transportArray = NEO_radioLogic getVariable format ["NEO_radioTrasportArray_%1", side player];
_unit = _transportArray select (lbCurSel _transportUnitLb) select 0; if (!isNil { NEO_radioLogic getVariable "NEO_radioTalkWithPilot" }) then { _unit = vehicle player };
_grp = _transportArray select (lbCurSel _transportUnitLb) select 1; if (!isNil { NEO_radioLogic getVariable "NEO_radioTalkWithPilot" }) then { _grp = group (driver _unit) };
_callsign = _transportArray select (lbCurSel _transportUnitLb) select 2; if (!isNil { NEO_radioLogic getVariable "NEO_radioTalkWithPilot" }) then { _callsign = (format ["%1", _grp]) call NEO_fnc_callsignFix };
_callSignPlayer = (format ["%1", group player]) call NEO_fnc_callsignFix;
_task = _transportTaskLb lbText (lbCurSel _transportTaskLb);
_marker = NEO_radioLogic getVariable "NEO_supportMarker";
_pos = getMarkerPos _marker;
_pos set [2, 0];

//New Task Assigned
private ["_arguments"];
_arguments = [_task, _pos];

if (toUpper _task == "CIRCLE") then
{
	_arguments set [count _arguments, sliderPosition _slider];
};

//Player dialog
private ["_posTask", "_text"];
_posTask = _pos call BIS_fnc_posToGrid;
_text = switch (toUpper _task) do
{
	case "PICKUP" : { format ["%1 this is %2, requesting pickup at position. Over.", _callsign, _callSignPlayer, _posTask select 0, _posTask select 1] };
	case "LAND" : { format ["%1 this is %2, land at position. Over.", _callsign, _callSignPlayer, _posTask select 0, _posTask select 1] };
	case "LAND (ENG OFF)" : { format ["%1 this is %2, land at position. Over.", _callsign, _callSignPlayer, _posTask select 0, _posTask select 1] };
	case "MOVE" : { format ["%1 this is %2, move to position and wait for orders. Over.", _callsign, _callSignPlayer, _posTask select 0, _posTask select 1] };
	case "CIRCLE" : { format ["%1 this is %2, move to position and provide overwatch. Over.", _callsign, _callSignPlayer, _posTask select 0, _posTask select 1] };
	case "RTB" : { format ["%1 this is %2, return to base. Over.", _callsign, _callSignPlayer] };
};

//New Task
_unit setVariable ["NEO_radioTransportNewTask", _arguments, true];
[player, _text, "side"] call NEO_fnc_messageBroadcast;

//Interface
[lbCurSel 655565] call NEO_fnc_radioRefreshUi;
