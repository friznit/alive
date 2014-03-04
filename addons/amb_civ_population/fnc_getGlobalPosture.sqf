#include <\x\alive\addons\amb_civ_population\script_component.hpp>
SCRIPT(getGlobalPosture);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_getGlobalPosture

Description:
Determine from hostility settings the global posture of civilian population

Parameters:

Returns:
Array - empty if none found, 1 unit within if found

Examples:
(begin example)
//
_result = [] call ALIVE_fnc_getGlobalPosture;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_hostilitySettingsEAST","_hostilitySettingsWEST","_hostilitySettingsINDEP","_hostilitySides","_hostilityNumbers","_highest","_highestIndex"];

_hostilitySettingsEAST = [ALIVE_civilianHostility, "EAST"] call ALIVE_fnc_hashGet;
_hostilitySettingsWEST = [ALIVE_civilianHostility, "WEST"] call ALIVE_fnc_hashGet;
_hostilitySettingsINDEP = [ALIVE_civilianHostility, "INDEP"] call ALIVE_fnc_hashGet;

_hostilitySides = ["EAST","WEST","INDEP"];
_hostilityNumbers = [_hostilitySettingsEAST, _hostilitySettingsWEST, _hostilitySettingsINDEP];

_highest = 0;
_highestIndex = 0;
{
    if(_x > _highest) then {
        _highest = _x;
        _highestIndex = _forEachIndex;
    };
} foreach _hostilityNumbers;

 ALIVE_civilianGlobalPosture = "PEACEFUL";

switch(_highest) do {
    case 3: {
        ALIVE_civilianGlobalPosture = "ENRAGED";
    };
    case 2: {
        ALIVE_civilianGlobalPosture = "ANGRY";
    };
    case 1: {
        ALIVE_civilianGlobalPosture = "DISCONTENTED";
    };
    case 0: {
        ALIVE_civilianGlobalPosture = "PEACEFUL";
    };
};