	private ["_logic","_wp","_trg","_otherWP","_gp","_isRest","_pos","_alive","_cwp","_timer"];

	_wp = _this select 0;
	_trg = group (_this select 1);
    _logic = _this select ((count _this)-1);

	if (isNull _trg) exitWith {};

	_pos = waypointPosition _wp;

	_otherWP = _trg getVariable ["HAC_Attacks",[]];

	_wp synchronizeWaypoint _otherWP;
	_trg setVariable ["HAC_Attacks",_otherWP + [_wp]];

	_otherWP = _trg getVariable ["HAC_Attacks",[]];

	_gp = _wp select 0;

	_timer = 0;
	_alive = true;

	waitUntil 
		{
		sleep 5;
		_isRest = _gp getVariable [("Resting" + (str _gp)),false];
		if (fleeing (leader _gp)) then {_isRest = true};
		_timer = _timer + 1;
		_cwp = [_gp,currentWaypoint _gp];
		if (isNull _trg) then {_alive = false};
		if ((((waypointPosition _cwp) distance _pos) > 1) and (((waypointPosition _cwp) distance (vehicle (leader _gp))) > 20)) then {_isRest = true};
		((_isRest) or (_timer > 360) or not (_alive))
		};

	_wp synchronizeWaypoint [];