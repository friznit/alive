#include "script_component.hpp"
#include "\A3\editor_f\Data\Scripts\dikCodes.h"

ADDON = false;
LOG(MSG_INIT);

GVAR(key_pid) = [] spawn {};

PREP(keypressed);
PREP(check);
PREP(bipod);
PREP(sb);
PREP(canRestWeapon);

[57, [true,false,false], { _this call FUNC(keyPressed)},"keydown","Rest_Weapon"] call CBA_fnc_addKeyHandler;

ADDON = true;
