#include <\x\alive\addons\sys_rwg\script_component.hpp>
SCRIPT(RWGExec);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_RWGexec
Description:
Places RWG respawn handler and adds actions

Parameters:

See Also:

Author:
Highhead
Peer reviewed:
nil
---------------------------------------------------------------------------- */
RWG_HANDLE = player addeventhandler ["respawn", {
        _unit = _this select 0;
        _corpse = _this select 1;
        diag_log format["Respawn: %1", _unit];

        [_unit] call ALIVE_fnc_RWGloadgear;
	removeallweapons _corpse;
        removeallitems _corpse;
        removebackpack _corpse;

	RWG_HANDLE_actSave = _unit addAction [("<t color=""#ffc600"">" + ("Save Gear") + "</t>"),{[_unit] call ALIVE_fnc_RWGsavegear},["RWG"],-1000,false,false,'',""];
        RWG_HANDLE_actLoad = _unit addAction [("<t color=""#ffc600"">" + ("Load Gear") + "</t>"),{[_unit] call ALIVE_fnc_RWGloadgear},["RWG"],-1001,false,false,'',""];
}];

[player] call ALIVE_fnc_RWGsavegear;
RWG_HANDLE_actSave = player addAction [("<t color=""#ffc600"">" + ("Save Gear") + "</t>"),{[player] call ALIVE_fnc_RWGsavegear},["RWG"],-1002,false,false,'',""];
RWG_HANDLE_actLoad = player addAction [("<t color=""#ffc600"">" + ("Load Gear") + "</t>"),{[player] call ALIVE_fnc_RWGloadgear},["RWG"],-1003,false,false,'',""];
