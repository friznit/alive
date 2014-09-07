#include <\x\alive\addons\sys_patrolrep\script_component.hpp>
SCRIPT(patrolrepCreateDiaryRecord);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_patrolrepCreateDiaryRecord
Description:
Creates a diary record

Parameters:
array - diary values

Returns:
bool

Examples:
(begin example)
                    [
                        _patrolrepName,
                        [_patrolrepHash, QGVAR(callsign)] call ALIVE_fnc_hashGet,
                        [_patrolrepHash, QGVAR(DTG)] call ALIVE_fnc_hashGet,
                        [_patrolrepHash, QGVAR(dateTime)] call ALIVE_fnc_hashGet,
                        [_patrolrepHash, QGVAR(sloc)] call ALIVE_fnc_hashGet,
                        [_patrolrepHash, QGVAR(eloc)] call ALIVE_fnc_hashGet,
                        [_patrolrepHash, QGVAR(patcomp)] call ALIVE_fnc_hashGet,
                        [_patrolrepHash, QGVAR(task)] call ALIVE_fnc_hashGet,
                        [_patrolrepHash, QGVAR(enbda)] call ALIVE_fnc_hashGet,
                        [_patrolrepHash, QGVAR(results)] call ALIVE_fnc_hashGet,
                        [_patrolrepHash, QGVAR(cs)] call ALIVE_fnc_hashGet,
                        [_patrolrepHash, QGVAR(ammo)] call ALIVE_fnc_hashGet,
                        [_patrolrepHash, QGVAR(cas)] call ALIVE_fnc_hashGet,
                        [_patrolrepHash, QGVAR(veh)] call ALIVE_fnc_hashGet,
                        [_patrolrepHash, QGVAR(spotreps)] call ALIVE_fnc_hashGet,
                        [_patrolrepHash, QGVAR(sitreps)] call ALIVE_fnc_hashGet,
                        [_patrolrepHash, QGVAR(group)] call ALIVE_fnc_hashGet,
                        [_patrolrepHash, QGVAR(spos)] call ALIVE_fnc_hashGet,
                        [_patrolrepHash, QGVAR(epos)] call ALIVE_fnc_hashGet
                    ] call ALIVE_fnc_patrolrepCreateDiaryRecord;
(end)

See Also:
- <ALIVE_fnc_patrolrep>

Author:
Tupolov
Peer Reviewed:
nil
---------------------------------------------------------------------------- */

_params = _this;

LOG(str _params);

_markerName = _params select 0;

_markers = createMarkerLocal [_markerName, _params select 16];

_markers setMarkerPosLocal (_params select 16);
_markers setMarkerAlphaLocal 1;

_markers setMarkerTextLocal format["%1 START",_markerName];
_markers setMarkerTypeLocal "mil_marker";

_markere = createMarkerLocal [_markerName + "END", _params select 17];

_markere setMarkerPosLocal (_params select 17);
_markere setMarkerAlphaLocal 1;

_markere setMarkerTextLocal format["%1 END",_markerName];
_markere setMarkerTypeLocal "mil_marker";

if !(player diarySubjectExists "PATROLREP") then {
    player createDiarySubject ["PATROLREP","PATROLREP"];
};

player createDiaryRecord ["patrolrep", [
    format ["DTG:%1 - %2", ( _params select 2), ( _params select 0)],
    format [
        "Callsign: %1 - Unit: %15<br/>" +
        "Timing: %2<br/>" +
        "Start Location: <marker name='%14'>%3</marker><br/>" +
        "End Location: <marker name='%15'>%4</marker><br/>" +
        "Patrol Composition: %5<br/>" +
        "Task: %6<br/><br/>" +
        "Enemy/Battle Damage Assessment: %7<br/>" +
        "Results of Encounters: %8<br/><br/>" +
        "Patrol Ammo: %10<br/>" +
        "Patrol Casualties: %11<br/>" +
        "Patrol Support: %9<br/>" +
        "Patrol Vehicles: %12<br/><br/>" +
        "SPOTREPs: %13<br/>" +
        "SITREPs: %14<br/>",
         _params select 1,
         _params select 3,
         _params select 4,
         _params select 5,
         _params select 6,
         _params select 7,
         _params select 8,
         _params select 9,
         _params select 10,
         _params select 11,
         _params select 12,
         _params select 13,
         _params select 14,
         _params select 15,
         _markers,
         _markere,
         _params select 16
    ]
]];




