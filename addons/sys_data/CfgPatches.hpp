// Simply a package which requires other addons.
class CfgPatches {
	class ADDON {
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {"ALIVE_main","cba_ui","Extended_Eventhandlers"};
		versionDesc = "ALiVE";
		//versionAct = "['SYS_DATA',_this] execVM '\x\alive\addons\main\about.sqf';";
		VERSION_CONFIG;
		author[] = {"Tupolov","Wolffy"};
		authorUrl = "http://dev-heaven.net/projects/alive";
	};
};
