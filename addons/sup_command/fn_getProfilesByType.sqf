params ["_operation",["_arguments",[]]];
private ["_result"];

switch (_operation) do {

	case "client": {
		//-- Exit if data still exists
		if (!isNil "STCOpcomGroups") exitWith {_result = STCOpcomGroups};

		//-- Execute on server
		[[[player],{
			["server",_this] spawn ALiVE_fnc_getProfilesByType;
		}],"BIS_fnc_spawn",false,true,false] call BIS_fnc_MP;

		//-- Wait until info is retrieved from server
		waitUntil {!isNil "STCOpcomGroups"};

		//-- Keep info on client for 60s to avoid spamming server
		[] spawn {
			sleep 60;
			STCOpcomGroups = nil;
		};

		_result = STCOpcomGroups;
	};

	case "server": {
		_player = _arguments select 0;
		_playerSide = str ((faction _player) call ALiVE_fnc_factionSide);
		_returnTo = owner _player;

		//-- Get current profile id's
		_profileIDs = [ALIVE_profileHandler, "getProfilesBySide", _playerSide] call ALIVE_fnc_profileHandler;
		if ((count _profileIDs == 0) or (isNil "_profileIDs")) exitWith {[]};

		//-- Get units
		_groups = [];
		{
			_opcom = _x;
			if (_playerSide == ([_opcom, "side"] call ALiVE_fnc_HashGet)) then {
				{
					_data = [];
					_unitType = [_opcom,_x,[]] call ALiVE_fnc_HashGet;
					{
						if (_x in _profileIDs) then {
							_data pushBack _x;
						};
					} forEach _unitType;
					_groups pushBack _data;
				} forEach ["infantry","motorized","mechanized","armored","air","sea","artillery","AAA"];
			};
		} forEach OPCOM_instances;

		STCOpcomGroups = _groups;
		_returnTo publicVariableClient "STCOpcomGroups";

		sleep 1;
		//if (isDedicated) then {STCOpcomGroups = nil};
	};

};

if (isNil "_result") then {_result = []};
_result