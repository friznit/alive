private ["_markerPos"];

_position = (_this select 0) ctrlMapScreenToWorld [(_this select 2),(_this select 3)];

switch (STCHighCommandMode) do {

	case "GroupSelect": {

		//-- Get data from server
		[[[player,_position],{
			params ["_player","_position"];
			private ["_pos","_id"];
			_returnTo = owner _player;
			_profiles = [_position, 250] call ALIVE_fnc_getNearProfiles;
			if (count _profiles == 0) exitWith {};
			_profiles = [_profiles,[_position],{_Input0 distance2D ([_x, "position", []] call CBA_fnc_HashGet)},"ASCEND"] call BIS_fnc_sortBy;

			_count = 0;
			{
				if (_count == 1) exitWith {};
				if (([_x, "side"] call CBA_fnc_HashGet) == str ((faction _player) call ALiVE_fnc_factionSide)) then {
					_count = 1;
					_pos = [_x, "position"] call CBA_fnc_HashGet;
					_id = [_x,"profileID"] call ALIVE_fnc_hashGet;
				};
			} forEach _profiles;

			STCSelectedUnitPosition = [_pos,_id];
			_returnTo publicVariableClient "STCSelectedUnitPosition";
			if (isDedicated) then {STCSelectedUnitPosition = nil};
		}],"BIS_fnc_spawn",false,true,false] call BIS_fnc_MP;

		//-- Wait till data is retrieved from server
		waitUntil {!isNil "STCSelectedUnitPosition"};

		STCSelectedUnitPosition params ["_position","_profileID"];
		STCSelectedUnitPosition = nil;

		ctrlMapAnimClear (findDisplay 725 displayCtrl 7252);
		(findDisplay 725 displayCtrl 7252) ctrlMapAnimAdd [.3, ctrlMapScale (findDisplay 725 displayCtrl 7252), _position];
		ctrlMapAnimCommit (findDisplay 725 displayCtrl 7252);
		_index = (player getVariable "STCGroups") find _profileID;
		lbSetCurSel [7254, _index];

	};

		case "WaypointSelect": {
			if !(lbCurSel 7254 == -1) then {

				//-- Get selected profile
				_selectedProfile = lbData [7254, lbCurSel 7254];

				//-- Get currently selected profile position from server
				[[[player,_selectedProfile],{
					params ["_player","_profileID"];
					_returnTo = owner _player;
					_profile = [ALIVE_profileHandler, "getProfile", _profileID] call ALIVE_fnc_profileHandler;
					_profilePos = [_profile, "position"] call CBA_fnc_HashGet;
					STCWaypointUnitPosition = _profilePos;
					_returnTo publicVariableClient "STCWaypointUnitPosition";
					//if (isDedicated) then {STCWaypointUnitPosition = nil};
				}],"BIS_fnc_spawn",false,true,false] call BIS_fnc_MP;

				waitUntil {!isNil "STCWaypointUnitPosition"};
				_profilePos = STCWaypointUnitPosition;
				STCWaypointUnitPosition = nil;

				//-- Get info for line marker placement
				if (count STCGroupWaypoints > 0) then {
					if (count STCPlannedWaypoints == 0) then {
						_markerPos = getMarkerPos (STCGroupWaypoints select (count STCGroupWaypoints - 1));
					} else {
						_markerPos = getMarkerPos ((STCPlannedWaypoints select (count STCPlannedWaypoints - 1)) select 0);
					};
				} else {
					if !(count STCPlannedWaypoints == 0) then {
						_markerPos = getMarkerPos ((STCPlannedWaypoints select (count STCPlannedWaypoints - 1)) select 0);
					} else {
						_markerPos = _profilePos;
					};
				};

				//-- Draw X marker
				_marker = createMarkerLocal [str _position, _position];
				_marker setMarkerSizeLocal [1.3,1.3];
				_marker setMarkerShapeLocal "ICON";
				_marker setMarkerTypeLocal "waypoint";
				_marker setMarkerColorLocal "ColorBlue";
				STCPlannedWaypoints pushBack [_marker,STCWaypointType,STCWaypointSpeed,STCWaypointFormation,STCWaypointBehavior];

				//-- Create line marker
				_position params ["_1","_2"];
				_position = [_1,_2,0];	//-- Will error if you don't convert to 3D
				_marker = [str _markerPos, _markerPos, _position,20,"ColorBlue",.9] call ALIVE_fnc_createLineMarker;
				STCArrowMarkers pushBack _marker;

			} else {
				hint "No group is currently selected";
			};

		};

};