#include "script_component.hpp"

PREPMAIN(isHC);
call ALIVE_fnc_isHC;


//To be enabled when ZEUS is stable
PREPMAIN(ZEUSinit);
[] call ALIVE_fnc_ZEUSinit;


//ALiVE Loading screen
[] spawn {

    //If ALiVE_Require isnt placed or not client exit
    if (!(["ALiVE_require"] call ALiVE_fnc_isModuleAvailable)) exitwith {};

    //Start ALiVE loading screen
	["ALiVE_LOADINGSCREEN"] call BIS_fnc_startLoadingScreen;
    
    //Wait until ALiVE require module has loaded and end loading screen
    waituntil {!isnil "ALiVE_REQUIRE_INITIALISED"};
    ["ALiVE_LOADINGSCREEN"] call BIS_fnc_EndLoadingScreen;
};