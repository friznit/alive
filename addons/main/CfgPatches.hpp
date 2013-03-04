// Simply a package which requires other addons.
class CfgPatches {
	class ADDON {
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {};
		versionDesc = "ALiVE";
		versionAct = "['MAIN',_this] execVM '\x\alive\addons\main\about.sqf';";
		VERSION_CONFIG;
		author[] = {"ALiVE Team - Wolffy.au, Tupolov, HighHead, JMan, Friznit"};
		authorUrl = "http://dev-heaven.net/projects/alive";
	};
};
