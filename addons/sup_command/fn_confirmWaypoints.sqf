//-- Exit if no planned waypoints exist
if (count STCPlannedWaypoints == 0) exitWith {hint "No new waypoints have been set"};

private ["_markerPos"];

//-- Get selected profile
_selectedProfile = lbData [7254, lbCurSel 7254];
_waypoints = [];
{
	_x params ["_marker","_2","_3","_4","_5"];
	_waypoints pushBack [getMarkerPos _marker,_2,_3,_4,_5];
} forEach STCPlannedWaypoints;

[[[player,_selectedProfile,_waypoints],{
	params ["_player","_profileID","_plannedWaypoints"];
	_returnTo = owner _player;

	//-- Get profile data
	_profile = [ALIVE_profileHandler, 'getProfile', _profileID] call ALIVE_fnc_profileHandler;
	_profilePos = [_profile, "position"] call CBA_fnc_HashGet;

	//-- Create waypoints
	{
		_wp = [_x select 0, 50, _x select 1, _x select 2,100,[0,0,0], _x select 3, "RED", _x select 4] call ALIVE_fnc_createProfileWaypoint;
		[_profile,"addWaypoint",_wp] call ALIVE_fnc_profileEntity;
	} forEach _plannedWaypoints;

	//-- Get waypoints
	_waypoints = (_profile select 2) select 16;
	_waypointPositions = [];
	{
		_waypointPositions pushBack ((_x select 2) select 0);
	} forEach _waypoints;

	//-- Return data to client
	STCConfirmWaypointsUnitData = [_profilePos,_waypointPositions];
	_returnTo publicVariableClient "STCConfirmWaypointsUnitData";
	//if (isDedicated) then {STCConfirmWaypointsUnitData = nil};
}],"BIS_fnc_spawn",false,true,false] call BIS_fnc_MP;

waitUntil {!isNil "STCConfirmWaypointsUnitData"};
STCConfirmWaypointsUnitData params ["_profilePos","_waypoints"];
STCConfirmWaypointsUnitData = nil;

//--Delete waypoint markers
if (!isNil "STCGroupWaypoints") then {{deleteMarkerLocal _x} forEach STCGroupWaypoints};STCGroupWaypoints = [];
if (!isNil "STCPlannedWaypoints") then {{deleteMarkerLocal (_x select 0)} forEach STCPlannedWaypoints};STCPlannedWaypoints = [];
if (!isNil "STCArrowMarkers") then {{deleteMarkerLocal _x} forEach STCArrowMarkers};STCArrowMarkers = [];

//-- Delay to visualize markers changing
sleep .15;

//-- Rebuild waypoint markers
_previousWaypoints = [];
{
	_position = _x;

	//-- Get arrow marker info
	if (count _previousWaypoints > 0) then {
		_markerPos = getMarkerPos (_previousWaypoints select (count _previousWaypoints - 1));
	} else {
		_markerPos = _profilePos;
	};

	//-- Create line marker
	_marker = [str _markerPos, _markerPos, _position,20,"ColorBlue",.9] call ALIVE_fnc_createLineMarker;
	STCArrowMarkers pushBack _marker;

	//-- Draw X marker
	_marker = createMarkerLocal [format ["%1",random 100], _position];
	_marker setMarkerSizeLocal [1.3,1.3];
	_marker setMarkerShapeLocal "ICON";
	_marker setMarkerTypeLocal "waypoint";
	_marker setMarkerColorLocal "ColorBlue";
	_previousWaypoints pushBack _marker;
	STCGroupWaypoints pushBack _marker;
} forEach _waypoints;