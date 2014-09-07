#include <\x\alive\addons\sys_patrolrep\script_component.hpp>

SCRIPT(patrolrepButtonAction);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_patrolrepButtonAction
Description:
Handles the button action event for a dialog

Parameters:
_this select 0: DISPLAY - Reference to calling display

Returns:
Nil

See Also:
- <ALIVE_fnc_patrolrep>

Author:
Tupolov

Peer Reviewed:
nil
---------------------------------------------------------------------------- */

private ["_params","_display","_patrolrepName","_patrolrepsHash"];

_display = findDisplay 90001;

_patrolrepName = "PR" + str(random time + 1);

_patrolrepName = [_patrolrepName, ".", "N"] call CBA_fnc_replace;

_patrolrepHash = [] call ALIVE_fnc_hashCreate;

// Get all the patrolrep info
_DTG = ctrlText DTG_VALUE;
_dateTime = [ctrlText DATE_VALUE,"\","-"] call CBA_fnc_replace;
_sloc = [ctrlText SLOC_VALUE,"\","-"] call CBA_fnc_replace;
_eloc = [ctrlText ELOC_VALUE,"\","-"] call CBA_fnc_replace;
_eyesIndex = lbCurSel EYES_LIST;
_eyes = lbData [EYES_LIST,_eyesIndex];
_callSign = [ctrlText NAME_VALUE,"\","-"] call CBA_fnc_replace;

_patcomp = [ctrlText PATCOMP_VALUE,"\","-"] call CBA_fnc_replace;
_task = [ctrlText TASK_VALUE,"\","-"] call CBA_fnc_replace;
_enbda= [ctrlText ENBDA_VALUE,"\","-"] call CBA_fnc_replace;
_results = [ctrlText RESULTS_VALUE,"\","-"] call CBA_fnc_replace;
_veh = [ctrlText VEH_VALUE,"\","-"] call CBA_fnc_replace;
_cs = [ctrlText CS_VALUE,"\","-"] call CBA_fnc_replace;

_spotreps = [ctrlText SPOTREPS_LIST,"\","-"] call CBA_fnc_replace;
_sitreps = [ctrlText SITREPS_LIST,"\","-"] call CBA_fnc_replace;

_ammo = lbData [AMMO_LIST, lbCurSel AMMO_LIST];
_cas = lbData [CAS_LIST, lbCurSel CAS_LIST];

[_patrolrepsHash, QGVAR(player), getPlayerUID player] call ALIVE_fnc_hashSet;
[_patrolrepHash, QGVAR(callsign), _callsign] call ALIVE_fnc_hashSet;
[_patrolrepHash, QGVAR(DTG), _DTG] call ALIVE_fnc_hashSet;
[_patrolrepHash, QGVAR(dateTime), _dateTime] call ALIVE_fnc_hashSet;
[_patrolrepHash, QGVAR(sloc), _sloc] call ALIVE_fnc_hashSet;
[_patrolrepHash, QGVAR(eloc), _eloc] call ALIVE_fnc_hashSet;
[_patrolrepHash, QGVAR(patcomp), _patcomp] call ALIVE_fnc_hashSet;
[_patrolrepHash, QGVAR(task), _task] call ALIVE_fnc_hashSet;
[_patrolrepHash, QGVAR(enbda), _enbda] call ALIVE_fnc_hashSet;
[_patrolrepHash, QGVAR(results)] call ALIVE_fnc_hashSet;
[_patrolrepHash, QGVAR(cs), _cs] call ALIVE_fnc_hashSet;
[_patrolrepHash, QGVAR(ammo),_ammo] call ALIVE_fnc_hashSet;
[_patrolrepHash, QGVAR(cas),_cas] call ALIVE_fnc_hashSet;
[_patrolrepHash, QGVAR(veh), _veh] call ALIVE_fnc_hashSet;
[_patrolrepHash, QGVAR(spotreps), _spotreps] call ALIVE_fnc_hashSet;
[_patrolrepHash, QGVAR(sitreps), _sitreps] call ALIVE_fnc_hashSet;

[_patrolrepHash, QGVAR(group), str(group player)] call ALIVE_fnc_hashSet;

[_patrolrepHash, QGVAR(spos), GVAR(spos)] call ALIVE_fnc_hashSet;
[_patrolrepHash, QGVAR(epos), GVAR(epos)] call ALIVE_fnc_hashSet;

switch _eyes do {
	case "SIDE" : {
		[_patrolrepHash, QGVAR(localityValue), str(side (group player))] call ALIVE_fnc_hashSet;
	};
	case "GROUP" : {
		[_patrolrepHash, QGVAR(localityValue), str (group player)] call ALIVE_fnc_hashSet;
	};
	case "FACTION" : {
		[_patrolrepHash, QGVAR(localityValue), faction player] call ALIVE_fnc_hashSet;
	};
};

// Create a patrolrep

[MOD(SYS_patrolrep), "addpatrolrep", [_patrolrepName, _patrolrepHash]] call ALiVE_fnc_patrolrep;

closeDialog 0;
