//-- Check if markers are already being displayed
if (!isNil {player getVariable "STCObjectiveMarkers"}) exitWith {
	{deleteMarkerLocal _x} forEach (player getVariable "STCObjectiveMarkers");
	player setVariable ["STCObjectiveMarkers", nil];
};

//-- Get data from server
if (isNil "STCObjectives") then {
	[[[player],{
		params ["_player"];
		_returnTo = owner _player;

		//-- Exit if ALiVE is not running or they're are no opcoms
		if ((isNil "ALIVE_profileHandler") or {isNil "OPCOM_INSTANCES"}) exitWith {};

		//-- Get objectives of player faction OPCOM
		_objectiveData = [];
		{
			_opcom = _x;
			_opcomFactions = [_opcom,"factions",""] call ALiVE_fnc_HashGet;
			if (faction _player in _opcomFactions) then {
				{
					_objective = _x;
					_size = [_objective,"size",150] call CBA_fnc_HashGet;
					_position = [_objective,"center",[]] call CBA_fnc_HashGet;
					_orders = [_objective,"opcom_state","unassigned"] call ALiVE_fnc_HashGet;
					_objectiveData pushBack [_size,_position,_orders];
				} forEach ([_opcom,"objectives",[]] call ALiVE_fnc_HashGet);
			};
		} foreach OPCOM_INSTANCES;

		//-- Return data to client
		STCObjectives = _objectiveData;
		_returnTo publicVariableClient "STCObjectives";
		if (isDedicated) then {STCObjectives = nil};
	}],"BIS_fnc_spawn",false,true,false] call BIS_fnc_MP;
};

//-- Wait until data is retrieved
waitUntil {!isNil "STCObjectives"};

//-- create markers
_markers = [];
_randomNum = (count STCObjectives) * .5;
{
	//-- Extract data and create marker
	_data = _x;
	_data params ["_size","_position","_orders"];
	_marker = createMarkerLocal [(format ["%1", random _randomNum]), _position];
	_marker setMarkerType "Empty";
	_marker setMarkerShapeLocal "RECTANGLE";
	_marker setMarkerBrushLocal "BDiagonal";
	_marker setMarkerSizeLocal [_size, _size];
	_marker setMarkerAlphaLocal 0.8;


	//-- Orders
	switch (_orders) do {
		case "unassigned": {_marker setMarkerColorLocal "ColorWhite"};
		case "idle": {_marker setMarkerColorLocal "ColorYellow"};
		case "reserve": {_marker setMarkerColorLocal "ColorGreen"};
		case "defend": {_marker setMarkerColorLocal "ColorBlue"};
		case "attack": {_marker setMarkerColorLocal "ColorRed"};
		default {_marker setMarkerColorLocal "ColorWhite"};
	};
_markers pushBack _marker;
} forEach STCObjectives;

//--Attach markers to player (for toggle purposes >> see top of file)
player setVariable ["STCObjectiveMarkers", _markers];

//-- Keep variable defined for 20 seconds to avoid spamming server when toggling repeatedly (see above for implementation)
sleep 60;
STCObjectives = nil;