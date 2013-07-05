player sidechat format["SEP INIT starting - time: %1...",time];
startLoadingScreen ["Loading mish, please wait..."];
_timeStart = time;
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
	_clusters = [_obj_array,175] call ALIVE_fnc_findClusters;
	player sidechat format["Clusters built: %1...",count _clusters];
    
	_nearestClusters = [];
	{
        private["_max","_center","_pos"];
        _max = 0;
        _agent = _x;
		_pos = [_agent, "center"] call ALiVE_fnc_cluster;
		_size = [_agent, "size"] call ALIVE_fnc_cluster;
        _type = [_agent, "type"] call ALIVE_fnc_cluster;
        _prio = [_agent, "priority"] call ALIVE_fnc_cluster;
                
		if (_pos distance [0,0,0] > 500) then {
            _nearestClusters set [count _nearestClusters,[_pos,_size,_type,_prio]];
            diag_log format ["Init cluster: %1 on %6 | %2 | %3 | %4 | %5",_pos,_size,_type,_prio];
        };
	} forEach _clusters;
    OPCOM_NEARESTCLUSTERS = [_nearestClusters,[],{player distance (_x select 0)},"ASCEND"] call BIS_fnc_sortBy;
    OPCOM_BIGGESTCLUSTERS = [_nearestClusters,[],{_x select 1},"DESCEND"] call BIS_fnc_sortBy;
    
	progressLoadingScreen 0.8;

	SEP_INIT_FINISHED = true; Publicvariable "SEP_INIT_FINISHED";
	diag_log format ["Sites finished: %1...",BIS_missionScope getVariable "sites"];
};
waituntil {!isnil "SEP_INIT_FINISHED"};
endloadingscreen;
player sidechat format["SEP INIT finished - time: %1 | duration: %2...",time,(time - _timeStart)];