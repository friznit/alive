	private ["_logic","_units","_id"];

	_units = _this select 0;
    _logic = _this select ((count _this)-1);

		{
		_id = _x addAction ["Time: x2", "\x\alive\addons\sys_HAC\TimeM\TimeFaster.sqf", "", -50, false, true, "", "true"];
		_id = _x addAction ["Time: x0.5", "\x\alive\addons\sys_HAC\TimeM\TimeSlower.sqf", "", -60, false, true, "", "true"];
		_id = _x addAction ["Order pause enabled", "\x\alive\addons\sys_HAC\TimeM\EnOP.sqf", "", -70, false, true, "", "not HAC_HQ_GPauseActive"];
		_id = _x addAction ["Order pause disabled", "\x\alive\addons\sys_HAC\TimeM\DisOP.sqf", "", -80, false, true, "", "HAC_HQ_GPauseActive"];
		}
	foreach _units;

	true;