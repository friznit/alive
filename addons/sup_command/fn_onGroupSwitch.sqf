params ["_operation",["_arguments",[]]];

switch (_operation) do {

	case "client": {
		private ["_markerPos"];

		_index = lbCurSel 7254;
		_profileID = lbData [7254, _index];

		//-- Delete previously showing waypoints
		if (!isNil "STCGroupWaypoints") then {{deleteMarkerLocal _x} forEach STCGroupWaypoints};
		if (!isNil "STCPlannedWaypoints") then {{deleteMarkerLocal (_x select 0)} forEach STCPlannedWaypoints};
		if (!isNil "STCArrowMarkers") then {{deleteMarkerLocal _x} forEach STCArrowMarkers};

		//-- Execute on server
		[[[player,_profileID],{
			["server",_this] spawn ALiVE_fnc_onGroupSwitch;
		}],"BIS_fnc_spawn",false,true,false] call BIS_fnc_MP;

		waitUntil {!isNil "STCUnitData"};
		STCUnitData params ["_pos","_waypoints"];
		STCUnitData = nil;

		//-- Move map
		ctrlMapAnimClear (findDisplay 725 displayCtrl 7252);
		(findDisplay 725 displayCtrl 7252) ctrlMapAnimAdd [.3, ctrlMapScale (findDisplay 725 displayCtrl 7252), _pos];
		ctrlMapAnimCommit (findDisplay 725 displayCtrl 7252);

		//-- Create markers for each waypoint
		STCGroupWaypoints = [];
		_previousWaypoints = [];
		{
			_position = _x;

			//-- Get arrow marker info
			if (count _previousWaypoints > 0) then {
				_previousWaypointPos = getMarkerPos (_previousWaypoints select (count _previousWaypoints - 1));
				_markerPos = _previousWaypointPos;
			} else {
				_markerPos = _pos;

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

			//-- Store marker
			{
				_x pushBack _marker;
			} forEach [_previousWaypoints,STCGroupWaypoints];
		} forEach _waypoints;

	};

	case "server": {
		_arguments params ["_player","_profileID"];
		_returnTo = owner _player;

		//-- Get profile
		_profile = [ALIVE_profileHandler, "getProfile", _profileID] call ALIVE_fnc_profileHandler;
		if (isNil "_profile") exitWith {};

		//-- Get info
		_profilePosition = [_profile, "position", []] call CBA_fnc_HashGet;
		_waypoints = (_profile select 2) select 16;
		_waypointPositions = [];
		{
			_waypointPositions pushBack ((_x select 2) select 0);
		} forEach _waypoints;

		//-- Return data
		STCUnitData = [_profilePosition,_waypointPositions];
		_returnTo publicVariableClient "STCUnitData";
		//if (isDedicated) then {STCUnitData = nil};
	};

}