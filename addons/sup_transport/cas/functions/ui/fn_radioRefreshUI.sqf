disableSerialization;

private ["_display", "_supportLb", "_supportIndex"];
_display = findDisplay 655555;
_supportLb = _display displayCtrl 1500;
_supportIndex = _this select 0;

lbSetCurSel [1500, _supportIndex];
