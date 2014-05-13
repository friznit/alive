#include <\x\alive\addons\x_lib\script_component.hpp>
SCRIPT(dumpLogo);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_dumpLogo

Description:
Dumps logo to RPT

Parameters:
Mixed

Returns:

Examples:
(begin example)
// dump variable 
[] call ALIVE_fnc_dumpLogo;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

["__________________________________________"] call ALIVE_fnc_dump;
["__________________________________________"] call ALIVE_fnc_dump;
["    _______ _____   __ ___ ___ _______    "] call ALIVE_fnc_dump;
["__ |   _   |     |_|__|   |   |    ___| __"] call ALIVE_fnc_dump;
["__ |       |       |  |   |   |    ___| __"] call ALIVE_fnc_dump;
["__ |___|___|_______|__|\_____/|_______| __"] call ALIVE_fnc_dump;
["__________________________________________"] call ALIVE_fnc_dump;
["__________________________________________"] call ALIVE_fnc_dump;