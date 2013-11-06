// Simply a package which requires other addons.
class CfgPatches {
	class ADDON {
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {"ALIVE_main"};
		versionDesc = "ALiVE";
		versionAct = "['SYS_REVIVE',_this] execVM '\x\alive\addons\main\about.sqf';";
		VERSION_CONFIG;
		author[] = {"[VRC]Raps"};
		authorUrl = "http://dev-heaven.net/projects/alive";
	};
};

class CfgSounds {
	sounds[] = {Vent,Para,REV_Heartbeat};
	class REV_Heartbeat {
		name = "REV_Wounded_Heartbeat";
		sound[] = {"\x\alive\addons\sys_revive\sys_revive\Sounds\HEARTBEAT.ogg",db-11,1};
		titles[] = {};
	};
};

class RscTitles {
	class REV_Wounded_BloodSplash {
		idd = -1;
		movingEnable = 0;
		duration = 0.5;
		fadein = 0;
		fadeout = 6;
		name = "Revive Blood Splash";
		controls[] = {"REV_BloodSplash"};

		class REV_BloodSplash {
			idc=-1;
			type=0;
			style = 48;
			text = "\x\alive\addons\sys_revive\sys_revive\Textures\Blood.paa";
			colorBackground[] = {1,1,1,0.4 };
			colorText[] = { 1, 1, 1, 1 };
			font = "PuristaMedium";
			sizeEx = 0.05;
			x = safezoneX;
			y = safezoneY;
			w = safezoneW;
			h = safezoneH;  
		};
	};
	class REV_Wounded_EyePain {
		idd = -1;
		movingEnable = 0;
		duration = 0.5;
		fadein = 0;
		fadeout = 6;
		name = "Revive Eye Pain";
		controls[] = {"REV_EyePain"};

		class REV_EyePain {
			idc=-1;
			type=0;
			style = 48;
			text = "\x\alive\addons\sys_revive\sys_revive\Textures\EyeHurt.paa";
			colorBackground[] = { 1,1,1,0.4 };
			colorText[] = { 1, 1, 1, 1 };
			font = "PuristaMedium";
			sizeEx = 0.05;
			x = safezoneX;
			y = safezoneY;
			w = safezoneW;
			h = safezoneH;  
		};
	};
};