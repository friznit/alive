class rscProgress
{
	idd = 2200;
	fadein = 0;
	fadeout = 0;
	duration = 10e10;
	onLoad = "uinamespace setvariable ['BIS_SC_progress',_this select 0]";
	onUnLoad = "uinamespace setvariable ['BIS_SC_progress',nil]";

	class controlsBackground
	{
		class BackgroundBlack: RscText
		{
			x = safezoneX;
			y = safezoneY;
			w = safezoneW;
			h = safezoneH;
			colorBackground[] = {0,0,0,1};
		};
		class RespawnMap: RscMapControl
		{
			IDC = 2201;
			x = safezoneXAbs - 0.17;
			y = safezoneY - 0.17;
			w = safezoneWAbs + 0.34;
			h = safezoneH + 0.34;
			maxSatelliteAlpha = 100;
			alphaFadeStartScale = 100;
			alphaFadeEndScale = 100;

			colorCountlines[] = {0.85, 0.8, 0.65, 1};
			colorMainCountlines[] = {0.45, 0.4, 0.25, 1};
			colorCountlinesWater[] = {0.25, 0.4, 0.5, 0.3};
			colorMainCountlinesWater[] = {0.25, 0.4, 0.5, 0.9};
			colorbackground[] = {1,1,1,1};

			sizeExLabel = 0;
			sizeExGrid = 0;
			sizeExUnits = 0;
			sizeExNames = 0;
			sizeExInfo = 0;
			sizeExLevel = 0;

			ptsPerSquareCLn = 8;   // count-lines

			showCountourInterval = false;
		};
	};

	#define BAR_HEIGHT	0.06

	class controls
	{
/*
		class BackgroundLineWest: RscPicture
		{
			x = safezoneXAbs;
			y = safezoneY + safezoneH - BAR_HEIGHT;
			w = safezoneWAbs;
			h = BAR_HEIGHT / 2;
			colorText[] = {1.0,0.9,0.7,0.5};
			text = "\ca\ui_f\data\ui_mainmenu_down_gr.paa";
		};
		class BackgroundLineEast: BackgroundLineWest
		{
			y = safezoneY + safezoneH - BAR_HEIGHT / 2;
		};
		class ProgressWest: RscPicture
		{
			idc = 2202;
			x = safezoneXAbs;
			y = safezoneY + safezoneH - BAR_HEIGHT;
			w = 0;
			h = BAR_HEIGHT / 2;
			colorText[] = {0.0,0.0,1.0,0.5};
			text = "\ca\ui_f\data\ui_mainmenu_up_gr.paa";
		};
		class ProgressEast: ProgressWest
		{
			idc = 2203;
			//x = 0.5;
			y = safezoneY + safezoneH - BAR_HEIGHT / 2;
			colorText[] = {1.0,0.0,0.0,0.5};
		};
*/
	};
};