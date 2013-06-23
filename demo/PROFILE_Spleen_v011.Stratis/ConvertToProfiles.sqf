    ALIVE_profileHandler = [nil, "create"] call ALIVE_fnc_profileHandler;
	[ALIVE_profileHandler, "init"] call ALIVE_fnc_profileHandler;
    
    {
        private ["_leader","_grp","_units","_profileID","_inVehicle","_unitClasses","_positions","_ranks","_damages","_cWP"];
        _leader = _x;
	    _grp = group _x;
	    _units = units _grp;
	    _profileID = str(_grp);
        _inVehicle = !(vehicle _leader == _leader);
	    
	    _unitClasses = [];
	    _positions = [];
	    _ranks = [];
	    _damages = [];
	        
	    {
	        _unitClasses set [count _unitClasses, typeof _x];
	        _positions set [count _positions, getposATL _x];
	        _ranks set [count _ranks, rank _x];
	        _damages set [count _damages, damage _x];
	    } foreach (_units);
	    
	    _profileEntity = [nil, "create"] call ALIVE_fnc_profileEntity;
		[_profileEntity, "init"] call ALIVE_fnc_profileEntity;
		[_profileEntity, "profileID", _profileID] call ALIVE_fnc_profileEntity;
		[_profileEntity, "unitClasses", _unitClasses] call ALIVE_fnc_profileEntity;
	    [_profileEntity, "position", getposATL _leader] call ALIVE_fnc_profileEntity;
		[_profileEntity, "positions", _positions] call ALIVE_fnc_profileEntity;
		[_profileEntity, "damages", _damages] call ALIVE_fnc_profileEntity;
		[_profileEntity, "ranks", _ranks] call ALIVE_fnc_profileEntity;
		[_profileEntity, "side", str(side _leader)] call ALIVE_fnc_profileEntity;
		[ALIVE_profileHandler, "registerProfile", _profileEntity] call ALIVE_fnc_profileHandler;
		   
		   {
		   _profileWaypoint = [_x ] call ALIVE_fnc_waypointToProfileWaypoint;
		   [_profileEntity, "addWaypoint", _profileWaypoint] call ALIVE_fnc_profileEntity;
		  } forEach (waypoints _grp);
        
        if (_inVehicle) then {
            _vehicle = (vehicle _leader);
            _vehicleClass = typeof _vehicle;
            _profileVehID = _vehicleClass + str(_grp);
            
            _profileVehicle = [nil, "create"] call ALIVE_fnc_profileVehicle;
			[_profileVehicle, "init"] call ALIVE_fnc_profileVehicle;
			[_profileVehicle, "profileID", _profileVehID] call ALIVE_fnc_profileVehicle;
			[_profileVehicle, "vehicleClass", _vehicleClass] call ALIVE_fnc_profileVehicle;
			[_profileVehicle, "position", getposATL _vehicle] call ALIVE_fnc_profileVehicle;
			[_profileVehicle, "direction", getdir _vehicle] call ALIVE_fnc_profileVehicle;
			[_profileVehicle, "damage", damage _vehicle] call ALIVE_fnc_profileVehicle;
			[_profileVehicle, "fuel", fuel _vehicle] call ALIVE_fnc_profileVehicle;
			[_profileVehicle, "side", str(side _vehicle)] call ALIVE_fnc_profileVehicle;
            [ALIVE_profileHandler, "registerProfile", _profileVehicle] call ALIVE_fnc_profileHandler;
            [_profileEntity,_profileVehicle] call ALIVE_fnc_createProfileVehicleAssignment;
        };
    } foreach HAC_Leaders;
    
    _profiles = [ALIVE_profileHandler, "getProfiles"] call ALIVE_fnc_profileHandler;
    player sidechat format["Count Profiles %1",count (_profiles select 2)];
    
    {
        _unitsGRP = units (group _x);
        {deletevehicle vehicle _x; deletevehicle _x} foreach _unitsGRP;
    } foreach HAC_Leaders;
    
    [] spawn {[] call ALIVE_fnc_simulateProfileMovement};
    [] spawn {
        //player sidechat format["Starting Loop",time];
        
        waituntil {
            sleep 3;
            _profiles = [ALIVE_profileHandler, "getProfilesByType", "entity"] call ALIVE_fnc_profileHandler;
            sleep 0.1;
            
            {
                private ["_profile", "_pos","_active"];
                _profile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
                _active = [_profile, "active"] call ALIVE_fnc_hashGet;
                _pos = [_profile,"position"] call ALIVE_fnc_hashGet;
                
                if ([_pos, 1000] call ALiVE_fnc_anyPlayersInRange > 0) then {
                    //player sidechat format["Spawning Profile %1",time];
                    [_profile, "spawn"] call ALIVE_fnc_profileEntity;
                } else {
                    //player sidechat format["Despawning Profile %1",time];
                    [_profile, "despawn"] call ALIVE_fnc_profileEntity;
                };
				sleep 0.03;
            } forEach _profiles;
            
            //[ALIVE_profileHandler, "debug",true] call ALIVE_fnc_profileHandler;

            false;
       };

	};
    true;