private 
[
	"_display", "_casUnitLb", "_casTaskLb", "_casFlyHeightSlider", "_casRadiusSlider", "_casArray", "_veh", 
	"_grp", "_callsign", "_callSignPlayer", "_task", "_marker", "_isPlane", "_pos", "_radius", "_flyInHeight", 
	"_Coord"
];
_display = findDisplay 655555;
_casUnitLb = _display displayCtrl 655582;
_casTaskLb = _display displayCtrl 655587;
_casFlyHeightSlider = _display displayCtrl 655590;
_casRadiusSlider = _display displayCtrl 655592;
_casArray = ALIVE_radioLogic getVariable format ["ALIVE_radioCasArray_%1", side player];
_veh = _casArray select (lbCurSel _casUnitLb) select 0;
_grp = _casArray select (lbCurSel _casUnitLb) select 1;
_callsign = _casArray select (lbCurSel _casUnitLb) select 2;
_callSignPlayer = (format ["%1", group player]) call ALIVE_fnc_callsignFix;
_task = _casTaskLb lbText (lbCurSel _casTaskLb);
_marker = ALIVE_radioLogic getVariable "ALIVE_supportMarker";
_isPlane = !(_veh isKindOf "Helicopter");
_pos = getMarkerPos _marker;
_pos set [2, 0];
_radius = sliderPosition _casRadiusSlider;
_flyInHeight = switch (sliderPosition _casFlyHeightSlider) do
{
	case 1 : { if (_isPlane) then { 150 } else { 50 } };
	case 2 : { if (_isPlane) then { 250 } else { 100 } };
	case 3 : { if (_isPlane) then { 500 } else { 150 } };
};
_coord = _pos call BIS_fnc_posToGrid;

//New Task
_veh setVariable ["ALIVE_radioCasNewTask", [_task, _pos, _radius, _flyInHeight], true];
[player, format ["%1, this is %2. We need imediate CAS at position. Over.", _callsign, _callSignPlayer, _coord select 0, _coord select 1], "side"] call ALIVE_fnc_messageBroadcast;

//Interface
[lbCurSel 1500] call ALIVE_fnc_radioRefreshUi;
