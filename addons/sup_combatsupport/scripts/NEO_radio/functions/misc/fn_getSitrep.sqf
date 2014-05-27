private ["_display","_lb","_index","_asset","_callsign"];

disableSerialization;
_display = findDisplay 655555;
_tasklb = _display displayctrl 655565;
_task = _tasklb lbText (lbCurSel _tasklb);
diag_log format["_task: %1", _task];


switch (toUpper _task) do
{
	case "TRANSPORT" : {
		private ["_transportUnitLb","_transportArray"];

		_transportUnitLb = _display displayCtrl 655568;
		_transportArray = NEO_radioLogic getVariable format ["NEO_radioTrasportArray_%1", playerSide];

        if ((lbCurSel _transportUnitLb) < 0) exitwith {};

        _asset = _transportArray select (lbCurSel _transportUnitLb) select 0; if (!isNil { NEO_radioLogic getVariable "NEO_radioTalkWithPilot" }) then { _asset = vehicle player };
		_unit = _transportArray select (lbCurSel _transportUnitLb) select 0;
		_grp = _transportArray select (lbCurSel _transportUnitLb) select 1; if (!isNil { NEO_radioLogic getVariable "NEO_radioTalkWithPilot" }) then { _grp = group (driver _unit) };
		_callsign = _transportArray select (lbCurSel _transportUnitLb) select 2; if (!isNil { NEO_radioLogic getVariable "NEO_radioTalkWithPilot" }) then { _callsign = (format ["%1", _grp]) call NEO_fnc_callsignFix };
	};
	case "CAS" : {
		private ["_casUnitLb","_casArray"];

		_casUnitLb = _display displayCtrl 655582;
		_casArray = NEO_radioLogic getVariable format ["NEO_radioCasArray_%1", playerSide];

        if ((lbCurSel _casUnitLb) < 0) exitwith {};

        _asset = _casArray select (lbCurSel _casUnitLb) select 0;
		_grp = _casArray select (lbCurSel _casUnitLb) select 1;
		_callsign = _casArray select (lbCurSel _casUnitLb) select 2;
	};
	case "ARTY" : {
		private ["_artyUnitLb","_artyArray"];

		_artyUnitLb = _display displayCtrl 655594;
		_artyArray = NEO_radioLogic getVariable format ["NEO_radioartyArray_%1", playerSide];

        if ((lbCurSel _artyUnitLb) < 0) exitwith {};

        _asset = _artyArray select (lbCurSel _artyUnitLb) select 0;
		_grp = _artyArray select (lbCurSel _artyUnitLb) select 1;
		_callsign = _artyArray select (lbCurSel _artyUnitLb) select 2;
	};
};

if (isnil "_asset") exitwith {};

private ["_callSignPlayer","_pos","_assetpos","_ammo"];

_callSignPlayer = (format ["%1", group player]) call NEO_fnc_callsignFix;
_pos = getpos _asset;
_assetpos = mapGridPosition _pos;

private ["_damage","_fuel","_text"];

_damage= getDammage _asset;
_fuel  = fuel _asset;
_text = format ["%1 this is %2, send SITREP. Over.",_callsign, _callSignPlayer];

[[player, _text, "side"],"NEO_fnc_messageBroadcast",true,true] spawn BIS_fnc_MP;

private ["_damageamcas","_fuelamcas","_amcas"];

_damageamcas ="";
    if (_damage <= 0.3) then {_damageamcas = "Green"};
    if (_damage > 0.3 &&  _damage < 0.6) then {_damageamcas = "Amber"};
    if (_damage >= 0.6) then {_damageamcas = "Red"};

_fuelamcas ="";
    if (_fuel <= 0.3) then {_fuelamcas = "Red"};
    if (_fuel > 0.3 &&  _damage < 0.6) then {_fuelamcas = "Amber"};
    if (_fuel >= 0.6) then {_fuelamcas = "Green"};

_amcas = format ["%1 this is %2, Current location %3, AMCAS %4, Fuel State %5", _callSignPlayer,_callsign,_assetpos,_damageamcas,_fuelamcas] ;

sleep 6;

[[player,_amcas,"side"],"NEO_fnc_messageBroadcast",true,true] spawn BIS_fnc_MP;