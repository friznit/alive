
class HudNamesLeft {
	idd = -1;
    fadeout=0;
    fadein=0;
	duration = 10000000000;
	name= "HudNamesLeft";
	onLoad = "uiNamespace setVariable ['HudNamesLeft', _this select 0]";
	
	class controlsBackground {
		class HudNames_l:CIRscStructuredText
		{
			idc = 99999;
			type = CT_STRUCTURED_TEXT;
			size = 0.040;
			x = (SafeZoneX + 0.015);
			y = (SafeZoneY + 0.60);
			w = 0.4; h = 0.65;
			colorText[] = {1,1,1,1};
			lineSpacing = 3;
			colorBackground[] = {0,0,0,0};
			text = "";
			font = "PuristaLight";
			shadow = 2;
			class Attributes {
				align = "left";
			};
		};

	};
};