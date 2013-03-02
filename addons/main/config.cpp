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

class CfgMods {
	class PREFIX {
		dir = "@ALIVE";
		name = "ArmA 3 ALiVE";
		picture = "\x\alive\addons\main\logo_alive.paa";
		hash = VERSION_CONFIG;
		hidePicture = 0;
		hideName = 0;
		actionName = "Website";
		action = "http://dev-heaven.net/projects/alive";
		description = "Bugtracker: https://dev-heaven.net/projects/alive/issues<br/>Documentation: https://dev-heaven.net/projects/alive/documents";
	};
};

class CfgSettings {
	class ALiVE {
		class Registry {
			class PREFIX {
				removed[] = {};
			};
		};
	};
};

#include "CfgVehicles.hpp"
