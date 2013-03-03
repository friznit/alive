#include "script_component.hpp"

// Simply a package which requires other addons.
class CfgPatches {
	class ADDON	{
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {};
		versionDesc = "ALiVE";
		VERSION_CONFIG;
		author[] = {"ALiVE Team"};
		authorUrl = "http://dev-heaven.net/projects/alive";
	};
};

#include "CfgVehicles.hpp"
