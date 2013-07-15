    	ALIVE_profileHandler = [nil, "create"] call ALIVE_fnc_profileHandler;
	[ALIVE_profileHandler, "init"] call ALIVE_fnc_profileHandler;
	
	// turn on debug on profile handler to see profile registrations in RPT
	[ALIVE_profileHandler, "debug", true] call ALIVE_fnc_profileHandler;
	
	// create profiles for all map units that dont have profiles
	[true] call ALIVE_fnc_createProfilesFromUnits;
	
	//turn debug off
	[ALIVE_profileHandler, "debug", false] call ALIVE_fnc_profileHandler;
	
	_profiles = [ALIVE_profileHandler, "getProfiles"] call ALIVE_fnc_profileHandler;
    	player sidechat format["Count Profiles %1",count (_profiles select 2)];
    
	// start profile simulation with debug disabled
    	[] spawn {[false] call ALIVE_fnc_simulateProfileMovement};
	
	// start profile spawner with activation radius of 1000m and debug enabled
	[] spawn {[1000,true] call ALIVE_fnc_profileSpawner};
	
    	true;