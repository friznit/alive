private ["_marker"];


//-- Check if markers are already being displayed
if (!isNil {player getVariable "STCUnitMarkers"}) exitWith {
	{deleteMarkerLocal _x} forEach (player getVariable "STCUnitMarkers");
	player setVariable ["STCUnitMarkers", nil];
};

//-- Use the previously defined STCUnits (Stays defined for 20 seconds) to avoid spamming the server when toggling repeatedly
if (isNil "STCUnits") then {
	[[[player],{
		params ["_player"];
		_returnTo = owner _player;
		_playerSide = str ((faction _player) call ALiVE_fnc_factionSide);

		if (isNil "ALIVE_profileHandler") exitWith {};

		_profilesInactive = [ALIVE_profileHandler, "profilesInActiveBySide"] call ALIVE_fnc_hashGet;
		_entities = [_profilesInactive, _playerSide] call ALIVE_fnc_hashGet;
		_profiles = [];
		{
			_position = _x select 2 select 2;
			_side = _x select 2 select 3;
			_profiles pushback [_position,_side];
		} forEach (_entities select 2);

		STCUnits = _profiles;
		_returnTo publicVariableClient "STCUnits";
		if (isDedicated) then {STCUnits = nil};
	}],"BIS_fnc_spawn",false,true,false] call BIS_fnc_MP;
};

//-- Retrieve data from server
waitUntil {!isNil "STCUnits"};

//-- create markers on inactive profiles
_markers = [];
{
	_marker = createMarkerLocal [str (_x select 0), _x select 0];
	_marker setMarkerTypeLocal "o_unknown";
	_marker setMarkerShapeLocal "ICON";
	_marker setMarkerSizeLocal [.8, .8];
	_marker setMarkerBrushLocal "Solid";

	switch (_x select 1) do {
		case "WEST": {
			_marker setMarkerTypeLocal "b_unknown";
			_marker setMarkerColorLocal "ColorBLUFOR";
		};
		case "EAST": {
			_marker setMarkerTypeLocal "o_unknown";
			_marker setMarkerColorLocal "ColorOPFOR";
		};
		case "GUER": {
			_marker setMarkerTypeLocal "x_unknown";
			_marker setMarkerColorLocal "ColorIndependent";
		};
	};

	_markers pushback _marker;
} forEach STCUnits;

//-- Mark active units
_playerSide = (faction player) call ALiVE_fnc_factionSide;
{
	if ((side (leader _x)) == _playerSide) then {

		_marker = createMarkerLocal [str _x, position (leader _x)];
		_marker setMarkerSizeLocal [.7,.7];

		switch (toLower (str _playerSide)) do {
			case "west": {
				_marker setMarkerTypeLocal "b_unknown";
				_marker setMarkerColorLocal "ColorBLUFOR";
			};
			case "east": {
				_marker setMarkerTypeLocal "o_unknown";
				_marker setMarkerColorLocal "ColorOPFOR";
			};
			case "guer": {
				_marker setMarkerTypeLocal "x_unknown";
				_marker setMarkerColorLocal "ColorIndependent";
			};
		};
	};
	_markers pushback _marker;
} forEach allGroups;

player setVariable ["STCUnitMarkers", _markers];

//-- Keep variable defined for 20 seconds to avoid spamming server when toggling repeatedly (see above for implementation)
sleep 20;
STCUnits = nil;