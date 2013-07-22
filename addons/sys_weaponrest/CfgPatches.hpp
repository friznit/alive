// Simply a package which requires other addons.
class CfgPatches {
	class ADDON {
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {"ALIVE_main","cba_ui","Extended_Eventhandlers"};
		versionDesc = "ALiVE";
		versionAct = "['SYS_WEAPONREST',_this] execVM '\x\alive\addons\main\about.sqf';";
		VERSION_CONFIG;
		author[] = {"q1184","Letranger","Tupolov"};
		authorUrl = "http://dev-heaven.net/projects/alive";
	};
};
