#include <script_component.hpp>
#include <CfgMods.hpp>
#include <CfgPatches.hpp>
#include <CfgVehicles.hpp>
#include <CfgFunctions.hpp>

// ALiVE Main UI

class RscStandardDisplay;
class RscPicture;
class RscPictureKeepAspect;
class RscControlsGroup;

class RscDisplayStart: RscStandardDisplay
{
 class controls
 {
  class LoadingStart: RscControlsGroup
  {
    class controls
	{
      class Logo: RscPictureKeepAspect
	  {
	   idc = 1200;
	   text = "\x\alive\addons\Main\logo_alive.paa";
		x = "0.25 * safezoneW";
		y = "0.3125 * safezoneH";
		w = "0.5 * safezoneW";
		h = "0.25 * safezoneH";
	  };
	};
  };
 };
};

class RscDisplayMain: RscStandardDisplay
{
	class controls
	{
		class GameLogo: RscPicture
		{
			idc = 1202;
			text = "\x\alive\addons\Main\logo_alive_crop.paa";
			x = "1 * 			(			((safezoneW / safezoneH) min 1.2) / 40) + 			(safezoneX)";
			y = "9.3 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 			(safezoneY + safezoneH - 			(			((safezoneW / safezoneH) min 1.2) / 1.2))";
			w = "7.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "3.75 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			tooltip = "$STR_ALIVE_MAIN_TOOLTIP_LOGO_ABOUT";
		};
	};
};