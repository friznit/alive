// Add a game logic which does nothing except requires the addon in the mission.

class CfgVehicles {
	class Logic;
	class Module_F: Logic
	{
		class ArgumentsBaseUnits
		{
			class Units;
		};
	};
        class ModuleALIVEBase_F: Module_F
        {
                scope = 1;
                displayName = "EditorALiVEBase";
                category = "STR_ALIVE";
        };
	class ALiVE_require : ModuleALIVEBase_F {
                scope = 2;
		displayName = "$STR_ALIVE_REQUIRES_ALIVE";
                isGlobal = 1;
		icon = "x\alive\addons\main\icon_REQUIRES_ALIVE.paa";
		picture = "x\alive\addons\main\icon_REQUIRES_ALIVE.paa";
	};
};
