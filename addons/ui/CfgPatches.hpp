// Simply a package which requires other addons.
class CfgPatches {
	class ADDON {
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {"ALIVE_main"};
		versionDesc = "ALiVE";
		versionAct = "['UI',_this] execVM '\x\alive\addons\main\about.sqf';";
		VERSION_CONFIG;
		author[] = {"ALiVE Team - Wolffy_au, Tupolov, HighHead, JMan, Friznit"};
		authorUrl = "http://dev-heaven.net/projects/alive";
	};
};


