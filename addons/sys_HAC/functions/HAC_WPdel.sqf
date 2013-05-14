	private ["_logic","_gp","_count"];

	_gp = _this select 0;
    _logic = _this select ((count _this)-1);

	if (isNil "_gp") exitWith {};
	if (isNull _gp) exitWith {};

	_count = (count (waypoints _gp)) - 1;

	if (_count < 0) exitWith {};

	[_gp, (currentWaypoint _gp)] setWaypointPosition [position (vehicle (leader _gp)), 0];

	while {(_count >= 0)} do
		{
		deleteWaypoint ((waypoints _gp) select _count);
		_count = (count (waypoints _gp)) - 1
		};