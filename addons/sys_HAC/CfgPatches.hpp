// Simply a package which requires other addons.
class CfgPatches {
	class ADDON {
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {"ALIVE_main","ALIVE_fnc_strategic"};
		versionDesc = "ALiVE";
		versionAct = "['sys_HAC',_this] execVM '\x\alive\addons\main\about.sqf';";
		VERSION_CONFIG;
		author[] = {"HAC_iger, Highhead"};
		authorUrl = "http://dev-heaven.net/projects/alive";
	};
};
class Extended_PreInit_EventHandlers {
	class ADDON {
		init = QUOTE(call COMPILE_FILE(XEH_preInit));
	};
};

