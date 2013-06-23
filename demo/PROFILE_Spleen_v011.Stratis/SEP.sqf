player sidechat format["SEP INIT starting - time: %1...",time];
startLoadingScreen ["Loading mish, please wait..."];
_timeStart = time;

initSite = compile preprocessfilelinenumbers "\A3\modules_f\sites\site_inits\military_base.sqf";
ConvertToProfiles = compile preprocessFilelineNumbers "ConvertToProfiles.sqf";
_debug = false;

if (isServer) then {
	_stat = 0.1;
	progressLoadingScreen _stat;
	
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
    	player sidechat format["Count Strategic objects: %1",count _obj_array];
	
	_stat = 0.2;
	progressLoadingScreen _stat;
	player sidechat "Building clusters...";
	_clusters = [_obj_array,175] call ALIVE_fnc_findClusters;
	_cnt = (count _clusters)*0.9;
	player sidechat format["Clusters built: %1...",_cnt];

	_statDiff = (1 - _stat) / (_cnt);

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
				_stat = _stat + _statDiff;
				progressLoadingScreen _stat;
				diag_log format ["Init Site: %1 on %6 | %2 | %3 | %4 | %5",_site,_site getvariable "buildingOccupationIndex",_site getvariable "faction",_site getvariable "axisA",_site getvariable "side",_pos];
			};
		};
	} forEach _clusters;
	BIS_missionScope setVariable ["sites",_sites,true];
	
	progressLoadingScreen 0.8;
    
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
	progressLoadingScreen 0.9;
    
    //Add groupleaders to HAC
	HAC_leaders = [];
	{
		_leader = leader group _x;
	
		if (!(_leader in HAC_leaders) && {((count (units (group _leader)) > 1) && (_leader distance ((getposATL _leader) nearestobject "house") > 10) || !(_leader == vehicle _leader))}) then {
			HAC_leaders set [count HAC_leaders, _leader];
	        BIS_persistent = BIS_persistent + units (group _leader);
		};
	} foreach _units;
    
    _converted = [] call ConvertToProfiles;
    
    /*
    _instance = (missionNameSpace getvariable ["HAC_instances",[]]) select 0;
    for "_i" from 0 to (count (missionNameSpace getvariable ["HAC_instances",[]]) - 1) do {
        _instance = (missionNameSpace getvariable ["HAC_instances",[]]) select _i;
        if (side _instance == EAST) exitwith {};
    };
    
	player sidechat format["Adding units to HAC %1...",_instance];
	_instance synchronizeObjectsAdd HAC_leaders;
    */
	
	SEP_INIT_FINISHED = true; Publicvariable "SEP_INIT_FINISHED";
	diag_log format ["Sites finished: %1...",BIS_missionScope getVariable "sites"];
};
waituntil {!isnil "SEP_INIT_FINISHED"};
endloadingscreen;
player sidechat format["SEP INIT finished - time: %1 | duration: %2...",time,(time - _timeStart)];