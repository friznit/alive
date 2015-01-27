#include <script_component.hpp>

class CfgPatches
{
	class ADDON
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {"ALIVE_main"};
		versionDesc = "ALiVE";
		VERSION_CONFIG;
		author[] = {"Tupolov"};
		authorUrl = "http://dev-heaven.net/projects/alive";
	};
};
class CfgMissions
{
	class Cutscenes
	{
		class ALiVE_Intro_Stratis
		{
			directory = "x\alive\addons\intro\scenes\Intro.Stratis";
		};
		class ALiVE_Intro_Altis
		{
			directory = "x\alive\addons\intro\scenes\Intro.Altis";
		};		
	};
};

class CAWorld;

class CfgWorlds
{
	class Stratis: CAWorld
	{ 
			cutscenes[] = {"ALiVE_Intro_Stratis"};
	};
	class Altis: CAWorld
	{ 
			cutscenes[] = {"ALiVE_Intro_Altis"};
	};	
};

class CfgMusic
{
	class ALiVE_Intro
	{
		name = "ALiVE - This is War - Johari";
		sound[] = {"\x\alive\addons\intro\Music\ArmA.ogg",1.0,1.0};
		duration = 172;
		theme = "safe";
		musicClass = "Lead";
	};
};

class RscStandardDisplay;
class RscPicture;
class RscDisplayMain: RscStandardDisplay
{
	class controls
	{
		class JohariLogo: RscPicture
		{			
			idc = 1299;
			text = "\x\alive\addons\intro\data\johari.paa";	
			tooltip = "$STR_ALIVE_UI_TOOLTIP_JOHARI_ABOUT";
			x = "0 * 			(			((safezoneW / safezoneH) min 1.2) / 40) + 			(safezoneX)";
			y = "0.2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "10.24 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "10.24 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";			
		};		
	};
};