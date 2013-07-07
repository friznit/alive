// Simply a package which requires other addons.
class CfgPatches {
	class ADDON {
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {"A3_Modules_F","cba_xeh_a3"};
		versionDesc = "ALiVE";
		versionAct = "['MAIN',_this] execVM '\x\alive\addons\main\about.sqf';";
		VERSION_CONFIG;
		author[] = {"ALiVE Team - Wolffy_au, Tupolov, HighHead, JMan, Friznit, Raptor, WobbleyHeadedBob, ARJay"};
		authorUrl = "http://dev-heaven.net/projects/alive";
	};
};


