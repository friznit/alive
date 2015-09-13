//-- Exit if no profile is selected
if (lbCurSel 7254 == -1) exitWith {hint "No group is selected"};

//-- Get selected profile
_selectedProfile = lbData [7254, lbCurSel 7254];

//-- Delete planned waypoints if any exist, if not, then delete any real waypoints
if (count STCPlannedWaypoints > 0) then {

	[[[player,_selectedProfile],{
		params ["_player","_profileID"];
		_returnTo = owner _player;
		_profile = [ALIVE_profileHandler, 'getProfile', _profileID] call ALIVE_fnc_profileHandler;
		STCClearWaypointsWaypointCount = count ((_profile select 2) select 16);
		_returnTo publicVariableClient "STCClearWaypointsWaypointCount";
		if (isDedicated) then {STCClearWaypointsWaypointCount = nil};
	}],"BIS_fnc_spawn",false,true,false] call BIS_fnc_MP;
	{deleteMarkerLocal (_x select 0)} forEach STCPlannedWaypoints;STCPlannedWaypoints = [];

	//-- Wait until data is retrieved from the server
	waitUntil {!isNil "STCClearWaypointsWaypointCount"};
	_waypointCount = STCClearWaypointsWaypointCount;
	STCClearWaypointsWaypointCount = nil;

	for "_i" from _waypointCount to (count STCArrowMarkers) do {
		deleteMarkerLocal (STCArrowMarkers select _i);
	};
} else {

	//-- Clear waypoints
	[[[_selectedProfile],{
		_profile = [ALIVE_profileHandler, 'getProfile', (_this select 0)] call ALIVE_fnc_profileHandler;
		[_profile, 'clearWaypoints'] call ALIVE_fnc_profileEntity;
	}],"BIS_fnc_spawn",false,true,false] call BIS_fnc_MP;

	//-- Delete any showing waypoints markers for that group
	if (!isNil "STCGroupWaypoints") then {{deleteMarkerLocal _x} forEach STCGroupWaypoints;STCGroupWaypoints = []};
	if (!isNil "STCPlannedWaypoints") then {{deleteMarkerLocal (_x select 0)} forEach STCPlannedWaypoints;STCPlannedWaypoints = []};
	if (!isNil "STCArrowMarkers") then {{deleteMarkerLocal _x} forEach STCArrowMarkers;STCArrowMarkers = []};

};
