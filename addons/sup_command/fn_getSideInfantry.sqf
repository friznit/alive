params ["_side"];

//-- Get profile id's
_factions = _side call ALiVE_fnc_getSideFactions;
_profileIDs = [];
{
	{_profileIDs pushBack _x} forEach ([ALIVE_profileHandler, "getProfilesByFaction",_x] call ALIVE_fnc_profileHandler);
} foreach _factions;


_result = [];
//-- Find infantry
{
	_profile = [ALIVE_profileHandler, "getProfile",_x] call ALIVE_fnc_profileHandler;
	_type = [_profile,"type"] call ALIVE_fnc_hashGet;

	if (toLower (_type) == "entity") then {
		_assignments = ([_profile,"vehicleAssignments",["",[],[],nil]] call ALIVE_fnc_hashGet) select 1;

		if (((count _assignments) == 0) && {!([_profile,"isPlayer",false] call ALIVE_fnc_hashGet)}) then {
			_result pushBack _profile;
		};
	};
} forEach _profileIDs;
_result;