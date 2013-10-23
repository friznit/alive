private ["_casConfirmButton", "_casArray", "_veh"];
_casConfirmButton = _display displayCtrl 1700;
_casUnitLb = _display displayCtrl 655582;
_casTaskLb = _display displayCtrl 655587;
_casArray = ALIVE_radioLogic getVariable format ["ALIVE_radioCasArray_%1", side player];
_veh = _casArray select (lbCurSel _casUnitLb) select 0;

if
(
	!isNil { uinamespace getVariable "ALIVE_casMarkerCreated" }
	&&
	_veh getVariable "ALIVE_radioCasUnitStatus" != "KILLED"
	&&
	lbCurSel _casUnitLb != -1
	&&
	lbCurSel _casTaskLb != -1
)
then
{
	_casConfirmButton ctrlEnable true;
}
else
{
	_casConfirmButton ctrlEnable false;
};
