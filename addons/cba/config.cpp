#include <script_component.hpp>

// Simply a package which requires other addons.
class CfgPatches {
	class ADDON {
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {};
		versionDesc = "C.B.A.";
		author[] = {"Sickboy","Spooner","Kronzky","Rommel","Xeno"};
		authorUrl = "http://dev-heaven.net/projects/cca";
	};
};

#include <\x\alive\addons\main\CfgMods.hpp>

#include <CfgFunctions.hpp>
