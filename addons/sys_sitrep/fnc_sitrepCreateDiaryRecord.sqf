#include <\x\alive\addons\sys_sitrep\script_component.hpp>
SCRIPT(sitrepCreateDiaryRecord);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_sitrepCreateDiaryRecord
Description:
Creates a diary record

Parameters:
array - diary values

Returns:
bool

Examples:
(begin example)
                        _sitrepName,
                        [_sitRepHash, QGVAR(callsign)] call ALIVE_fnc_hashGet,
                        [_sitRepHash, QGVAR(DTG)] call ALIVE_fnc_hashGet,
                        [_sitRepHash, QGVAR(dateTime)] call ALIVE_fnc_hashGet,
                        [_sitRepHash, QGVAR(loc)] call ALIVE_fnc_hashGet,
                        [_sitRepHash, QGVAR(faction)] call ALIVE_fnc_hashGet,
                        [_sitRepHash, QGVAR(size)] call ALIVE_fnc_hashGet,
                        [_sitRepHash, QGVAR(type)] call ALIVE_fnc_hashGet,
                        [_sitRepHash, QGVAR(activity)] call ALIVE_fnc_hashGet,
                        [_sitRepHash, QGVAR(factivity)] call ALIVE_fnc_hashGet,
                        [_sitRepHash, QGVAR(remarks),"NONE"] call ALIVE_fnc_hashGet,
                        [_sitRepHash, QGVAR(markername),"NONE"] call ALIVE_fnc_hashGet
                    ] call ALIVE_fnc_sitrepCreateDiaryRecord;
(end)

See Also:
- <ALIVE_fnc_sitrep>

Author:
Tupolov
Peer Reviewed:
nil
---------------------------------------------------------------------------- */
LOG(str _this);
_params = _this;

if !(player diarySubjectExists "SITREP") then {
    player createDiarySubject ["SITREP","SITREP"];
};

player createDiaryRecord ["SITREP", [
    format ["DTG:%1 - %2", ( _params select 2), ( _params select 0)],
    format [
        "Callsign: %1<br/>" +
        "Timing: %2<br/>" +
        "Location: <marker name='%10'>%3</marker><br/>" +
        "<br/>" +
        "Enemy: %4<br/>" +
        "Enemy Size: %5<br/>" +
        "Enemy Type: %6<br/>" +
        "Enemy Actions: %7<br/><br/>" +
        "Friendly Actions: %8<br/><br/>" +
        "Remarks:<br/>" +
        "%9<br/>",
         _params select 1,
         _params select 3,
         _params select 4,
         _params select 5,
         _params select 6,
         _params select 7,
         _params select 8,
         _params select 9,
         _params select 10,
         _params select 11
    ]
]];

