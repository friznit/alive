// Simply a package which requires other addons.
class CfgPatches {
	class ADDON {
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {"ALIVE_main"};
		versionDesc = "ALiVE";
		//versionAct = "['SYS_REVIVE',_this] execVM '\x\alive\addons\main\about.sqf';";
		VERSION_CONFIG;
		author[] = {"Raptor"};
		authorUrl = "https://dev.withsix.com/projects/alive";
	};
};

class CfgSounds {
	sounds[] = {REV_Heartbeat,REV_Breathing,REV_Blood1,REV_Blood2,REV_Blood3,REV_Blood4,REV_Blood5,REV_DeafTone};
	class REV_Heartbeat {
		name = "REV_Wounded_Heartbeat";
		sound[] = {"\x\alive\addons\sys_revive\_revive\Sounds\HeartBeat_01_8.ogg",db-4.5,1};
		titles[] = {};
	};
	class REV_Breathing {
		name = "REV_Wounded_Breath";
		sound[] = {"\x\alive\addons\sys_revive\_revive\Sounds\Breathing_01_8.ogg",db-4.5,1};
		titles[] = {};
	};
	class REV_Blood1 {
		name = "REV_Wounded_Blood1";
		sound[] = {"\x\alive\addons\sys_revive\_revive\Sounds\blood1.ogg",db-5,1};
		titles[] = {};
	};
	class REV_Blood2 {
		name = "REV_Wounded_Blood2";
		sound[] = {"\x\alive\addons\sys_revive\_revive\Sounds\blood2.ogg",db-5,1};
		titles[] = {};
	};
	class REV_Blood3 {
		name = "REV_Wounded_Blood3";
		sound[] = {"\x\alive\addons\sys_revive\_revive\Sounds\blood3.ogg",db-5,1};
		titles[] = {};
	};
	class REV_Blood4 {
		name = "REV_Wounded_Blood4";
		sound[] = {"\x\alive\addons\sys_revive\_revive\Sounds\blood4.ogg",db-5,1};
		titles[] = {};
	};
	class REV_Blood5 {
		name = "REV_Wounded_Blood5";
		sound[] = {"\x\alive\addons\sys_revive\_revive\Sounds\blood5.ogg",db-5,1};
		titles[] = {};
	};
	class REV_DeafTone {
		name = "REV_Wounded_DeafTone";
		sound[] = {"\x\alive\addons\sys_revive\_revive\Sounds\deafTone.ogg",db-5,1};
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
			text = "\x\alive\addons\sys_revive\_revive\Textures\Blood.paa";
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
			text = "\x\alive\addons\sys_revive\_revive\Textures\EyeHurt.paa";
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
