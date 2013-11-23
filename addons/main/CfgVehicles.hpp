// Add a game logic which does nothing except requires the addon in the mission.

class CfgFactionClasses {
	class AliveSystem {
		displayName = "$STR_ALIVE_SYS";
		priority = 101;
		side = 7;
	};
	class AliveSupport {
		displayName = "$STR_ALIVE_SUPPORT";
		priority = 102;
		side = 7;
	};
	class AliveAmbient {
		displayName = "$STR_ALIVE_AMBIENT";
		priority = 103;
		side = 7;
	};
	class AliveEnemy {
		displayName = "$STR_ALIVE_ENEMY";
		priority = 104;
		side = 7;
	};
	class AliveMilitary {
		displayName = "$STR_ALIVE_MILITARY";
		priority = 105;
		side = 7;
	};
	class AliveCivilian {
		displayName = "$STR_ALIVE_CIVILIAN";
		priority = 106;
		side = 7;
	};
};
class CfgVehicles {
	class Logic;
	class Module_F: Logic {
		class ArgumentsBaseUnits {
			class Units;
		};
		class ModuleDescription
		{
			class AnyBrain;
		};
	};
	class ModuleAliveSystemBase: Module_F {
		scope = 1;
		displayName = "EditorAliveSystemBase";
		category = "AliveSystem";
	};
	class ModuleAliveSupportBase: Module_F {
		scope = 1;
		displayName = "EditorAliveSupportBase";
		category = "AliveSupport";
	};
	class ModuleAliveAmbientBase: Module_F {
		scope = 1;
		displayName = "EditorAliveAmbientBase";
		category = "AliveAmbient";
	};
	class ModuleAliveEnemyBase: Module_F {
		scope = 1;
		displayName = "EditorAliveEnemyBase";
		category = "AliveEnemy";
	};
	class ModuleAliveMilitaryBase: Module_F {
		scope = 1;
		displayName = "EditorAliveMilitaryBase";
		category = "AliveMilitary";
	};
	class ModuleAliveCivilianBase: Module_F {
		scope = 1;
		displayName = "EditorAliveCivilianBase";
		category = "AliveCivilian";
	};
	class ALiVE_require: ModuleAliveSystemBase {
		scope = 2;
		displayName = "$STR_ALIVE_REQUIRES_ALIVE";
		icon = "x\alive\addons\main\icon_requires_alive.paa";
		picture = "x\alive\addons\main\icon_requires_alive.paa";
	};
};
