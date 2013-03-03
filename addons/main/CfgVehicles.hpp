// Add a game logic which does nothing except requires the addon in the mission.

class CfgVehicles
{
	class Logic;
	class ALIVE_main_require : Logic
	{
		displayName = "$STR_ALIVE_REQUIRES_ALIVE";
		icon = "x\alive\addons\main\icon_REQUIRES_ALIVE.paa";
		picture = "x\alive\addons\main\icon_REQUIRES_ALIVE.paa";
		vehicleClass = "Modules";
	};
};
