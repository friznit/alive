#include <script_component.hpp>

LOG(MSG_INIT);

PREPMAIN(isHC);
call ALIVE_fnc_isHC;

PREPMAIN(BUS);
[] call ALIVE_fnc_BUS;

//Default value to disable auto-saving due to out of mem crashes
enableSaving [false, false];

