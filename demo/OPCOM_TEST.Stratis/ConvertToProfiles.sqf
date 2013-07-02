    ALIVE_profileHandler = [nil, "create"] call ALIVE_fnc_profileHandler;
	[ALIVE_profileHandler, "init"] call ALIVE_fnc_profileHandler;	
	
	[] call ALIVE_fnc_createProfilesFromUnits;
	
	[ALIVE_profileHandler, "debug", true] call ALIVE_fnc_profileHandler;
	
    _profiles = [ALIVE_profileHandler, "getProfiles"] call ALIVE_fnc_profileHandler;
    player sidechat format["Count Profiles %1",count (_profiles select 2)];
    
    [] spawn ALIVE_fnc_simulateProfileMovement;
	
	[] spawn {[1000] call ALIVE_fnc_profileSpawner};
	
    true;