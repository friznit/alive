
_caller = _this select 0;
_group = _this select 1;
 diag_log format ["Player: %1, Group: %2", _caller, _group];

CASMENU_ACTIONS = _caller addAction [("<t color='#F07422'>"+ ("Call CAS") + "</t>"), {execFSM 'fsms\cas.bifsm'},["CAS"],-100,true,false,'',""];
player addEventHandler ["Respawn", {
        CASMENU_ACTIONS = player addAction [("<t color='#F07422'>"+ ("Call CAS") + "</t>"), {[HELI] call ALIVE_fnc_CallCAS},["RWG"],-100,true,false,'',""];
         }
];