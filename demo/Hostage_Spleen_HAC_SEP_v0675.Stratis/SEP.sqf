_debug = false;

if (isServer) then {
	
	player sidechat "Analyzing map for strategic objects...";
	_obj_array = [
	"hbarrier",
	"razorwire",
	"mil_wired",
	"mil_wall",
	"barrack",
	"miloffices",
	"bunker"
	] call ALIVE_fnc_getObjectsByType;
	
	player sidechat " Building clusters...";
	_clusters = [_obj_array,175] call ALIVE_fnc_findClusters;

	_sites = [];
	{
        private["_max","_center","_pos"];
        _max = 0;
        _agent = _x;
		_pos = [_agent, "center"] call ALiVE_fnc_cluster;
		_max = [_agent, "size"] call ALIVE_fnc_cluster;

		if (_pos distance [0,0,0] > 500) then {
			if (_max > 50) then {
                _pos = [_pos,100] call ALiVE_fnc_findFlatArea;
		player sidechat format["Placing site %1...",_pos];

				_site = createAgent ["Site_OPFOR", _pos, [], 0, "NONE"];
				_site setvariable ["buildingOccupationIndex","0.3"];
				_site setVariable ["faction","Red"];
				_site setvariable ["axisA",str(_max)];
				_site setvariable ["side","OPFOR"];
				_site setvariable ["description",""];
				_site setvariable ["interactive","No"];
				_site setvariable ["fastTravel","Disabled"];
				_site call initSite;
				
				_sites set [count _sites,_site];
				diag_log format ["Init Site: %1 on %6 | %2 | %3 | %4 | %5",_site,_site getvariable "buildingOccupationIndex",_site getvariable "faction",_site getvariable "axisA",_site getvariable "side",_center];
			};
		};
	} forEach _clusters;
	BIS_missionScope setVariable ["sites",_sites,true];
    
    //Get all units from sites
	_spawnedBySites = [];
	{
		if (!(isNil {_x getVariable "garrison"})) then {
			_site = _x;
			{_spawnedBySites = _spawnedBySites + units _x} forEach (_site getVariable "garrison")
		}
	} forEach (BIS_missionScope getVariable "sites");

	//exclude from caching (optional)
	if (isNil "BIS_persistent") then {BIS_persistent = []};	
	_grabMissionObjs = {
		_ret = [];
		{
			if (typeOf _x != "" && !(_x in (BIS_persistent)) && !(_x isKindOf "Logic")) then {
				_ret = _ret + [_x];
				if (vehicle _x != _x && !(vehicle _x  in _ret)) then {_ret = _ret + [vehicle _x]}
			}
		} forEach _spawnedBySites;
		{if (vehicleVarName _x != "" && !(_x in BIS_persistent)) then {BIS_persistent = BIS_persistent + [_x]}} forEach _ret;
		{if (vehicle _x != _x && !(vehicle _x  in BIS_persistent)) then {BIS_persistent = BIS_persistent + [vehicle _x]}} forEach BIS_persistent;
		_ret
	};
	_units = [] call _grabMissionObjs;
    
    //Add groupleaders to HAC
	HAC_leaders = [];
	{
		_leader = leader group _x;
	
		if (!(_leader in HAC_leaders) && {random 1 < 0.5}) then {
			HAC_leaders set [count HAC_leaders, _leader];
	        BIS_persistent = BIS_persistent + units (group _leader);
		};
	} foreach _units;
    
    _instance = (missionNameSpace getvariable ["HAC_instances",[]]) select 0;
    for "_i" from 0 to (count (missionNameSpace getvariable ["HAC_instances",[]]) - 1) do {
        _instance = (missionNameSpace getvariable ["HAC_instances",[]]) select _i;
        if (side _instance == EAST) exitwith {};
    };
    
	player sidechat format["Adding units to HAC %1...",_instance];
	_instance synchronizeObjectsAdd HAC_leaders;
	
	initAllSitesFinished = true; Publicvariable "initAllSitesFinished";
	diag_log format ["Sites finished: %1...",BIS_missionScope getVariable "sites"];
};