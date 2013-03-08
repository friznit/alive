// Add a game logic which does nothing except requires the addon in the mission.

class CfgFactionClasses
{
        class AliveSystem
        {
                displayName = "$STR_ALIVE_SYS";
                priority = 101;
                side = 7;
        };
        class AliveSupport
        {
                displayName = "$STR_ALIVE_SUPPORT";
                priority = 102;
                side = 7;
        };
        class AliveAmbient
        {
                displayName = "$STR_ALIVE_AMBIENT";
                priority = 103;
                side = 7;
        };
        class AliveEnemy
        {
                displayName = "$STR_ALIVE_ENEMY";
                priority = 104;
                side = 7;
        };
};
class CfgVehicles {
	class Logic;
	class Module_F: Logic
	{
		class ArgumentsBaseUnits
		{
			class Units;
		};
	};
        class ModuleAliveSystemBase: Module_F
        {
                scope = 1;
                displayName = "EditorAliveSystemBase";
                category = "AliveSystem";
        };
        class ALiVE_require : ModuleAliveSystemBase {
                scope = 2;
		displayName = "$STR_ALIVE_REQUIRES_ALIVE";
                isGlobal = 1;
		icon = "x\alive\addons\main\icon_REQUIRES_ALIVE.paa";
		picture = "x\alive\addons\main\icon_REQUIRES_ALIVE.paa";
	};
};
