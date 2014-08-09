class Extended_PreInit_EventHandlers {
	class ADDON {
		init = QUOTE(call COMPILE_FILE(XEH_preInit));
	};
};

class Extended_PostInit_EventHandlers {
	class ADDON {
		serverInit = QUOTE(call COMPILE_FILE(XEH_postServerInit));
		init = QUOTE(call COMPILE_FILE(XEH_postInit));
	};
};

//To be enabled when ZEUS is stable
class Extended_Init_EventHandlers {
	class AllVehicles {
		init = "_this call ALiVE_fnc_ZeusRegister";
	};
};