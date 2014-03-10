#include "script_component.hpp"

[] spawn {
    //If ALiVE_Require isnt placed or not client exit
    if (!(["ALiVE_require"] call ALiVE_fnc_isModuleAvailable) || {!hasInterface}) exitwith {};
    
    //Start ALiVE loading screen
	["ALiVE_LOADINGSCREEN"] call BIS_fnc_startLoadingScreen;
    
    //Wait until ALiVE require module has loaded and end loading screen
    waituntil {!isnil "ALiVE_REQUIRE_INITIALISED"};
    ["ALiVE_LOADINGSCREEN"] call BIS_fnc_EndLoadingScreen;
};

/*
//To be enabled when ZEUS is stable
PREPMAIN(ZEUSinit);
[] call ALIVE_fnc_ZEUSinit;
*/