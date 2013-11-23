#include "common.hpp"

class NEO_resourceRadio
{
	idd = 655555;
	onLoad = "[] spawn NEO_fnc_radioOnLoad; ";
	onUnload = "_this call NEO_fnc_radioOnUnload";
	
	class controls
	{
				
	//Background
		class NEO_radioBackground : RscPicture
		{
			idc = -1;
			x = 0.142424 * safezoneW + safezoneX;
			y = 0.0632 * safezoneH + safezoneY;
			w = 0.73 * safezoneW;
			h = 0.84 * safezoneH;
			text = "x\alive\addons\sup_combatsupport\scripts\NEO_radio\hpp\ALIVE_toughbook_2.paa";
			moving = 0;
			colorBackground[] = {0,0,0,0};
		};
		//MAP
		class NEO_radioMap : NEO_RscMap
		{
			idc = 655560;
			x = 0.519796 * safezoneW + safezoneX;
			y = 0.1584 * safezoneH + safezoneY;
			w = 0.216525 * safezoneW;
			h = 0.42 * safezoneH;
		};
		
		//Main Support Title
		class NEO_radioMainTitle : NEO_RscText
		{
			idc = -1;
			text = "Support Available"; //--- ToDo: Localize;
			x = 0.271103 * safezoneW + safezoneX;
			y = 0.1584 * safezoneH + safezoneY;
			w = 0.159596 * safezoneW;
			h = 0.0308 * safezoneH;
			colorBackground[] = {0,0,0,0};
			class Attributes 
			{ 
				font = "PuristaMedium"; 
				color = "#B4B4B4"; 
				align = "left"; 
				valign = "middle"; 
				shadow = true; 
				shadowColor = "#000000";
				size = 0.8;
			};		
		};
		
		//Abort Button
		class NEO_radioAbort : NEO_RscButton
		{
			idc = 655561;
			text = "Close";
			style = 0x02;
			x = 0.519796 * safezoneW + safezoneX;
			y = 0.7184 * safezoneH + safezoneY;
			w = 0.216525 * safezoneW;
			h = 0.028 * safezoneH;
			sizeEx = 0.8 * GUI_GRID_H;
			colorBackground[] = {0.376,0.196,0.204,1};
			colorText[] = {0.706,0.706,0.706,1};
			action = "closeDialog 0";
		};
		
		//Main Support ListBox
		class NEO_radioMainList : NEO_RscGUIListBox
		{
			idc = 655565;
			x = 0.271102 * safezoneW + safezoneX;
			y = 0.1892 * safezoneH + safezoneY;
			w = 0.241271 * safezoneW;
			h = 0.084 * safezoneH;
			colorBackground[] = {0,0,0,0};
			colorActive[] = {0.384,0.439,0.341,1};
			sizeEx = (safeZoneW / 75) + (safeZoneH / 275);
			rowHeight = (safeZoneW / 75) + (safeZoneH / 275);
		};
		
		//=========================
		//Transport Unit ListBox
		class NEO_radioTransportUnitList : NEO_RscGUIListBox
		{
			idc = 655568;
			sizeEx = (safeZoneW / 75) + (safeZoneH / 275);
			rowHeight = (safeZoneW / 75) + (safeZoneH / 275);
			x = 0.269865 * safezoneW + safezoneX;
			y = 0.3068 * safezoneH + safezoneY;
			w = 0.242507 * safezoneW;
			h = 0.084 * safezoneH;
			colorActive[] = {0.384,0.439,0.341,1};
		};

		//Transport Task ListBox
		class NEO_radioTransportTaskList : NEO_radioTransportUnitList
		{
			idc = 655569;
			sizeEx = (safeZoneW / 75) + (safeZoneH / 275);
			rowHeight = (safeZoneW / 75) + (safeZoneH / 275);
			x = 0.269865 * safezoneW + safezoneX;
			y = 0.4272 * safezoneH + safezoneY;
			w = 0.242507 * safezoneW;
			h = 0.084 * safezoneH;
			colorActive[] = {0.384,0.439,0.341,1};
		};
		
		//Transport Unit LB Text
		class NEO_radioTransportUnitText : NEO_RscText
		{
			idc = 655570;
			x = 0.271103 * safezoneW + safezoneX;
			y = 0.2732 * safezoneH + safezoneY;
			w = 0.0779492 * safezoneW;
			h = 0.0308 * safezoneH;
			colorText[] = {0.384,0.439,0.341,1};
			colorBackground[] = {0,0,0,0};
			sizeEx = 0.8 * GUI_GRID_H;
			text = "";
		};
		
		//Transport Task LB Text
		class NEO_radioTransportTaskText : NEO_radioTransportUnitText
		{
			idc = 655571;
			x = 0.271103 * safezoneW + safezoneX;
			y = 0.3936 * safezoneH + safezoneY;
			w = 0.0742373 * safezoneW;
			h = 0.0308 * safezoneH;
			colorText[] = {0.384,0.439,0.341,1};
			colorBackground[] = {0,0,0,0};
			sizeEx = 0.8 * GUI_GRID_H;
			text = "";
		};
		
		//Transport Help Unit Text
		class NEO_radioTransportHelpUnitText : NEO_radioTransportUnitText
		{
			idc = 655572;
			x = 0.351527 * safezoneW + safezoneX;
			y = 0.2732 * safezoneH + safezoneY;
			w = 0.160845 * safezoneW;
			h = 0.0308 * safezoneH;
			colorBackground[] = {0,0,0,0};
			sizeEx = 0.6 * GUI_GRID_H;
			text = "";
		};
		
		//Transport Help Task Text
		class NEO_radioTransportHelpTaskText : NEO_radioTransportHelpUnitText
		{
			idc = 655573;
			x = 0.351525 * safezoneW + safezoneX;
			y = 0.3936 * safezoneH + safezoneY;
			w = 0.160845 * safezoneW;
			h = 0.0308 * safezoneH;
			colorBackground[] = {0,0,0,0};
			sizeEx = 0.6 * GUI_GRID_H;
			text = "";
		};
		
		//Transport Confirm Button
		class NEO_radioTransportConfirmButton : NEO_RscButton
		{
			idc = 655574;
			x = 0.519796 * safezoneW + safezoneX;
			y = 0.6848 * safezoneH + safezoneY;
			w = safeZoneW / 1000;
			h = safeZoneH / 1000;
			text = "Confirm";
			colorBackground[] = {0.384,0.439,0.341,1};
			sizeEx = 0.8 * GUI_GRID_H;
		};
		
		//Transport Base Button
		class NEO_radioTransportBaseButton : NEO_radioTransportConfirmButton
		{
			idc = 655575;
			x = 0.519796 * safezoneW + safezoneX;
			y = 0.6512 * safezoneH + safezoneY;
			w = safeZoneW / 1000;
			h = safeZoneH / 1000;
			text = "Order Unit RTB";
			colorBackground[] = {0.173,0.173,0.173,1};
			sizeEx = 0.8 * GUI_GRID_H;
		};
		
		//Transport Smoke Found Button
		class NEO_radioTransportSmokeFoundButton : NEO_radioTransportConfirmButton
		{
			idc = 655576;
			x = 1000 * safezoneW + safezoneX;
			y = 0.6176 * safezoneH + safezoneY;
			w = safeZoneW / 1000;
			h = safeZoneH / 1000;
			text = "Confirm Smoke";
			colorBackground[] = {0.431,0.494,0.596,1};
			sizeEx = 0.8 * GUI_GRID_H;
		};
		
		//Transport Smoke Found Button same as return to base button
		class NEO_radioTransportSmokeNotFoundButton : NEO_radioTransportBaseButton
		{
			idc = 655577;
			x = 0.519796 * safezoneW + safezoneX;
			y = 0.584 * safezoneH + safezoneY;
			w = safeZoneW / 1000;
			h = safeZoneH / 1000;
			text = "New Smoke";
			colorBackground[] = {0.722,0.439,0.282,1};
			sizeEx = 0.8 * GUI_GRID_H;
		};
		
		//Circle Slider
		class NEO_radioTransportCircleSlider : NEO_RscSlider
		{
			idc = 655578;
			x = 0.281002 * safezoneW + safezoneX;
			y = 0.5504 * safezoneH + safezoneY;
			w = safeZoneW / 1000;
			h = safeZoneH / 1000;
			colorText[] = {0.384,0.439,0.341,1};
			colorActive[] = {0.384,0.439,0.341,1};
			color[] = {0.384,0.439,0.341,1};
			colorDisabled[] = {10.384,0.439,0.341,1};
			sizeEx = 0.8 * GUI_GRID_H;
		};

		
		//Circle Slider Text
		class NEO_radioTransportCircleSliderText : NEO_radioTransportHelpUnitText
		{
			idc = 655579;
			x = 0.280111 * safezoneW + safezoneX;
			y = 0.514 * safezoneH + safezoneY;
			w = safeZoneW / 1000;
			h = safeZoneH / 1000;
			text = "Radius: 100/300";
			colorText[] = {0.706,0.706,0.706,1};
			colorBackground[] = {0,0,0,0};
			sizeEx = 0.8 * GUI_GRID_H;
			/*class Attributes 
			{ 
				font = "PuristaLight"; 
				color = "#FFFFFF"; 
				align = "center"; 
				valign = "middle"; 
				shadow = true; 
				shadowColor = "#000000";
				size = "1";
			};*/
		};
		
		//Properties Text
		class NEO_radioTransportPropertiesText : NEO_radioTransportCircleSliderText
		{
			idc = 655633;
			text = "Behaviour";
			x = 0.363898 * safezoneW + safezoneX;
			y = 0.598 * safezoneH + safezoneY;
			w = safeZoneW / 1000;
			h = safeZoneH / 1000;
			colorText[] = {0.706,0.706,0.706,1};
			colorBackground[] = {0,0,0,0};
			sizeEx = 0.8 * GUI_GRID_H;
		};
		
		//FlyInHeight CB
		class NEO_radioTransportHeightCb : NEO_RscComboBox
		{
			idc = 655630;
			x = 0.278525 * safezoneW + safezoneX;
			y = 0.64 * safezoneH + safezoneY;
			w = safeZoneW / 1000;
			h = safeZoneH / 1000;
			colorSelectBackground[] = {0.384,0.439,0.341,1};
			colorSelect[] = {0.023529, 0, 0.0313725, 1.000};
			colorText[] = {0.384,0.439,0.341,1};
			colorBackground[] = {0.094,0.09,0.094,1};
			colorScrollbar[] = {0.384,0.439,0.341,1};
			sizeEx = (safeZoneW / 75) + (safeZoneH / 275);
			rowHeight = (safeZoneW / 75) + (safeZoneH / 275);
		};
		
		//Speed CB
		class NEO_radioTransportSpeedCb : NEO_radioTransportHeightCb
		{
			idc = 655631;
			x = 0.401017 * safezoneW + safezoneX;
			y = 0.64 * safezoneH + safezoneY;
			w = safeZoneW / 1000;
			h = safeZoneH / 1000;
		};
		
		//ROE
		class NEO_radioTransportRoeCb : NEO_radioTransportHeightCb
		{
			idc = 655632;
			x = 0.339153 * safezoneW + safezoneX;
			y = 0.696 * safezoneH + safezoneY;
			w = safeZoneW / 1000;
			h = safeZoneH / 1000;
		};
		
		//=======================
		//Cas Unit ListBox
		class NEO_radioCasUnitList : NEO_RscGUIListBox
		{
			idc = 655582;
			x = 0.269865 * safezoneW + safezoneX;
			y = 0.3068 * safezoneH + safezoneY;
			w = 0.242507 * safezoneW;
			h = 0.084 * safezoneH;
			colorBackground[] = {0,0,0,0};
			colorActive[] = {0.384,0.439,0.341,1};
			sizeEx = (safeZoneW / 75) + (safeZoneH / 275);
			rowHeight = (safeZoneW / 75) + (safeZoneH / 275);
		};
		
		//Cas Unit LB Text
		class NEO_radioCasUnitText : NEO_RscText
		{
			idc = 655583;
			x = 0.271103 * safezoneW + safezoneX;
			y = 0.2732 * safezoneH + safezoneY;
			w = 0.0779492 * safezoneW;
			h = 0.0308 * safezoneH;
			colorText[] = {0.706,0.706,0.706,1};
			colorBackground[] = {0,0,0,0};
			sizeEx = 0.8 * GUI_GRID_H;
			text = "";
		};
		
		//Cas Help Unit Text
		class NEO_radioCasHelpUnitText : NEO_radioCasUnitText
		{
			idc = 655584;
			x = 0.351527 * safezoneW + safezoneX;
			y = 0.2732 * safezoneH + safezoneY;
			w = 0.160845 * safezoneW;
			h = 0.0308 * safezoneH;
			colorBackground[] = {0,0,0,0};
			sizeEx = (safeZoneW / 75) + (safeZoneH / 275);
			rowHeight = (safeZoneW / 75) + (safeZoneH / 275);
			text = "";
		};
		
		//Cas Confirm Button
		class NEO_radioCasConfirmButton : NEO_radioTransportConfirmButton
		{
			idc = 655585;
			x = 0.519796 * safezoneW + safezoneX;
			y = 0.6848 * safezoneH + safezoneY;
			w = safeZoneW / 1000;
			h = safeZoneH / 1000;
			text = "Confirm";
			colorBackground[] = {0.384,0.439,0.341,1};
			sizeEx = 0.8 * GUI_GRID_H;
		};
		
		//Cas Base Button
		class NEO_radioCasBaseButton : NEO_radioCasConfirmButton
		{
			idc = 655586;
			x = 0.519796 * safezoneW + safezoneX;
			y = 0.6512 * safezoneH + safezoneY;
			w = safeZoneW / 1000;
			h = safeZoneH / 1000;
			text = "Order Unit RTB";
			colorBackground[] = {0.173,0.173,0.173,1};
			sizeEx = 0.8 * GUI_GRID_H;
		};
		
		//CAS Task LB
		class NEO_radioCasTaskList : NEO_radioCasUnitList
		{
			idc = 655587;
			x = 0.269865 * safezoneW + safezoneX;
			y = 0.4272 * safezoneH + safezoneY;
			w = 0.242507 * safezoneW;
			h = 0.084 * safezoneH;
			colorBackground[] = {0,0,0,0};
			colorActive[] = {0.384,0.439,0.341,1};
	        sizeEx = (safeZoneW / 75) + (safeZoneH / 275);
			rowHeight = (safeZoneW / 75) + (safeZoneH / 275);
		};
		
		//Cas Task Text
		class NEO_radioCasTaskText : NEO_radioCasUnitText
		{
			idc = 655588;
			x = 0.271103 * safezoneW + safezoneX;
			y = 0.3936 * safezoneH + safezoneY;
			w = 0.0742373 * safezoneW;
			h = 0.0308 * safezoneH;
			colorText[] = {0.706,0.706,0.706,1};
			colorBackground[] = {0,0,0,0};
			sizeEx = 0.8 * GUI_GRID_H;
			text = "";
		};
		
		//Cas Task Help Text
		class NEO_radioCasHelpTaskText : NEO_radioCasHelpUnitText
		{
			idc = 655589;
			x = 0.351525 * safezoneW + safezoneX;
			y = 0.3936 * safezoneH + safezoneY;
			w = 0.160845 * safezoneW;
			h = 0.0308 * safezoneH;
			colorBackground[] = {0,0,0,0};
			sizeEx = 0.6 * GUI_GRID_H;
			text = "";
		};
		
		//Cas FlyInHeight Slider
		class NEO_radioCasFlyHeightSlider : NEO_radioTransportCircleSlider
		{
			idc = 655590;
			x = 0.402708 * safezoneW + safezoneX;
			y = 0.5508 * safezoneH + safezoneY;
			w = safeZoneW / 1000;
			h = safeZoneH / 1000;
            colorActive[] = {0.384,0.439,0.341,1};
			color[] = {0.384,0.439,0.341,1};
			colorDisabled[] = {10.384,0.439,0.341,1};
		};
		
		//Cas FlyInHeight Slider Text
		class NEO_radioCasFlyHeightText : NEO_radioTransportCircleSliderText
		{
			idc = 655591;
			x = 0.402708 * safezoneW + safezoneX;
			y = 0.5508 * safezoneH + safezoneY;
			w = safeZoneW / 1000;
			h = safeZoneH / 1000;
			colorText[] = {0.706,0.706,0.706,1};
			colorActive[] = {0.384,0.439,0.341,1};
			sizeEx = 0.8 * GUI_GRID_H;
			text = "";
		};
		
		//Cas Radius Slider
		class NEO_radioCasRadiusSlider : NEO_radioTransportCircleSlider
		{
			idc = 655592;
			x = 0.281002 * safezoneW + safezoneX;
			y = 0.5504 * safezoneH + safezoneY;
			w = safeZoneW / 1000;
			h = safeZoneH / 1000;
			colorText[] = {0.384,0.439,0.341,1};
			colorActive[] = {0.384,0.439,0.341,1};
			color[] = {0.384,0.439,0.341,1};
			colorDisabled[] = {10.384,0.439,0.341,1};
			sizeEx = 0.8 * GUI_GRID_H;
		};
		
		//Cas Radius Slider Text
		class NEO_radioCasRadiusText : NEO_radioTransportCircleSliderText
		{
			idc = 655593;
			x = 0.280111 * safezoneW + safezoneX;
			y = 0.514 * safezoneH + safezoneY;
			w = safeZoneW / 1000;
			h = safeZoneH / 1000;
			text = "";
			colorText[] = {0.706,0.706,0.706,1};
			colorBackground[] = {0,0,0,0};
			sizeEx = 0.8 * GUI_GRID_H;
		};

	};
};
