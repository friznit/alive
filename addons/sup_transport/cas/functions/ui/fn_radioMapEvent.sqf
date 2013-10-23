private ["_display", "_lb", "_map", "_button", "_pos", "_marker"];
_display = findDisplay 655555;
_lb = _display displayCtrl 655565;
_map = _this select 0;
_button = _this select 1; if (_button == 1) exitWith {};
_pos = _map ctrlMapScreenToWorld [_this select 2, _this select 3];
_marker = ALIVE_radioLogic getVariable "ALIVE_supportMarker";

ctrlMapAnimClear _map;
_map ctrlMapAnimAdd [0.5, ctrlMapScale _map, _pos];
ctrlMapAnimCommit _map;

_marker setMarkerPosLocal _pos;
_marker setMarkerAlphaLocal 1;


		_marker setMarkerTextLocal "CAS";
		_marker setMarkerTypeLocal "Destroy";
		
		uinamespace setVariable ["ALIVE_casMarkerCreated", _marker];
		[] call ALIVE_fnc_casConfirmButtonEnable;
	