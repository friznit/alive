#include "common.hpp"

class NEO_resourceRadio
{
	idd = 655555;
	onLoad = "[] spawn NEO_fnc_radioOnLoad; ";
	onUnload = "_this call NEO_fnc_radioOnUnload";
	
	class controls
	{
		//Background
		class NEO_radioBackground : NEO_RscBackground
		{
			idc = -1;
			x = 0.110255 * safezoneW + safezoneX;
			y = 0.108 * safezoneH + safezoneY;
			w = 0.748559 * safezoneW;
			h = 0.616 * safezoneH;
			text="";
			moving = 0;
			colorBackground[] = {0, 0, 0, 0.7};
		};
		
		//MAP
		class NEO_radioMap : NEO_RscMap
		{
			idc = 655560;
			x = 0.580424 * safezoneW + safezoneX;
	y = 0.178 * safezoneH + safezoneY;
	w = 0.25983 * safezoneW;
	h = 0.434 * safezoneH;
		};

		//Radio Title
		class NEO_radioTitle : NEO_RscText
		{
			idc = -1;
			x = 0.425763 * safezoneW + safezoneX;
			y = 0.122 * safezoneH + safezoneY;
			w = 0.0804237 * safezoneW;
			h = 0.028 * safezoneH;
			text = "SUPPORT RADIO";
			class Attributes 
			{ 
				font = "PuristaLight"; 
				color = "#FFFFFF"; 
				align = "center"; 
				valign = "middle"; 
				shadow = true;
				shadowColor = "#000000";
				size = "1.1";
			};
		};
		
		//Main Support Title
		class NEO_radioMainTitle : NEO_radioTitle
		{
			idc = -1;
			x = 0.153559 * safezoneW + safezoneX;
			y = 0.178 * safezoneH + safezoneY;
			w = 0.098983 * safezoneW;
			h = 0.028 * safezoneH;
			text = "AVAILABLE SUPPORT:";
			class Attributes 
			{ 
				font = "PuristaLight"; 
				color = "#FFFFFF"; 
				align = "center"; 
				valign = "middle"; 
				shadow = true; 
				shadowColor = "#000000";
				size = "0.8";
			};
		};
		
		//Abort Button
		class NEO_radioAbort : NEO_RscButton
		{
			idc = 655561;
			text = "CLOSE";
			style = 0x02;
			x = 0.159746 * safezoneW + safezoneX;
			y = 0.654 * safezoneH + safezoneY;
			w = 0.0804237 * safezoneW;
			h = 0.028 * safezoneH;
			colorBackground[] = {0.596,0,0,0.7};
			colorText[] = {1,1,1,1};
		};
		
		//Main Support ListBox
		class NEO_radioMainList : NEO_RscGUIListBox
		{
			idc = 655565;
			sizeEx = (safeZoneW / 75) + (safeZoneH / 275);
			rowHeight = (safeZoneW / 75) + (safeZoneH / 275);
			x = 0.128814 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.142288 * safezoneW;
			h = 0.126 * safezoneH;
		};
		
		//=========================
		//Transport Unit ListBox
		class NEO_radioTransportUnitList : NEO_RscGUIListBox
		{
			idc = 655568;
			sizeEx = (safeZoneW / 100) + (safeZoneH / 300);
			rowHeight = (safeZoneW / 100) + (safeZoneH / 300);
			x = 0.302034 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.098983 * safezoneW;
			h = 0.126 * safezoneH;
		};
		
		//Transport Task ListBox
		class NEO_radioTransportTaskList : NEO_radioTransportUnitList
		{
			idc = 655569;
			x = 0.438136 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.098983 * safezoneW;
			h = 0.126 * safezoneH;
		};
		
		//Transport Unit LB Text
		class NEO_radioTransportUnitText : NEO_RscText
		{
			idc = 655570;
				x = 0.302034 * safezoneW + safezoneX;
			y = 0.178 * safezoneH + safezoneY;
			w = 0.098983 * safezoneW;
			h = 0.028 * safezoneH;
			text = "";
		};
		
		//Transport Task LB Text
		class NEO_radioTransportTaskText : NEO_radioTransportUnitText
		{
			idc = 655571;
			x = 0.444322 * safezoneW + safezoneX;
			y = 0.178 * safezoneH + safezoneY;
			w = 0.098983 * safezoneW;
			h = 0.028 * safezoneH;
			text = "";
		};
		
		//Transport Help Unit Text
		class NEO_radioTransportHelpUnitText : NEO_radioTransportUnitText
		{
			idc = 655572;
			x = 0.302034 * safezoneW + safezoneX;
			y = 0.36 * safezoneH + safezoneY;
			w = 0.0927966 * safezoneW;
			h = 0.112 * safezoneH;
			text = "";
		};
		
		//Transport Help Task Text
		class NEO_radioTransportHelpTaskText : NEO_radioTransportHelpUnitText
		{
			idc = 655573;
			x = 0.444322 * safezoneW + safezoneX;
			y = 0.36 * safezoneH + safezoneY;
			w = 0.0927966 * safezoneW;
			h = 0.112 * safezoneH;
			text = "";
		};
		
		//Transport Confirm Button
		class NEO_radioTransportConfirmButton : NEO_RscButton
		{
			idc = 655574;
			x = 0.302034 * safezoneW + safezoneX;
			y = 0.654 * safezoneH + safezoneY;
			w = safeZoneW / 1000;
			h = safeZoneH / 1000;
			text = "Confirm";
			colorBackground[] = {0,0.4,0,0.7};
		};
		
		//Transport Base Button
		class NEO_radioTransportBaseButton : NEO_radioTransportConfirmButton
		{
			idc = 655575;
			x = 0.438136 * safezoneW + safezoneX;
			y = 0.654 * safezoneH + safezoneY;
			w = safeZoneW / 1000;
			h = safeZoneH / 1000;
			text = "Go back to Base";
			colorBackground[] = {0.2,0,0.6,0.7};
		};
		
		//Transport Smoke Found Button
		class NEO_radioTransportSmokeFoundButton : NEO_radioTransportConfirmButton
		{
			idc = 655576;
			x = 0.58661 * safezoneW + safezoneX;
			y = 0.654 * safezoneH + safezoneY;
			w = safeZoneW / 1000;
			h = safeZoneH / 1000;
			text = "Confirm Smoke";
			colorBackground[] = {0.4,0,0.6,0.7};
		};
		
		//Transport Smoke Found Button same as return to base button
		class NEO_radioTransportSmokeNotFoundButton : NEO_radioTransportBaseButton
		{
			idc = 655577;
				x = 0.728898 * safezoneW + safezoneX;
			y = 0.654 * safezoneH + safezoneY;
			w = safeZoneW / 1000;
			h = safeZoneH / 1000;
			text = "New Smoke";
			colorBackground[] = {0.4,0,0.6,0.7};
		};
		
		//Circle Slider
		class NEO_radioTransportCircleSlider : NEO_RscSlider
		{
			idc = 655578;
			x = 0.135 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = safeZoneW / 1000;
			h = safeZoneH / 1000;
		};

		
		//Circle Slider Text
		class NEO_radioTransportCircleSliderText : NEO_radioTransportHelpUnitText
		{
			idc = 655579;
			x = 0.153559 * safezoneW + safezoneX;
			y = 0.43 * safezoneH + safezoneY;
		w = safeZoneW / 1000;
			h = safeZoneH / 1000;
			text = "Radius: 100/300";
			class Attributes 
			{ 
				font = "PuristaLight"; 
				color = "#FFFFFF"; 
				align = "center"; 
				valign = "middle"; 
				shadow = true; 
				shadowColor = "#000000";
				size = "1";
			};
		};
		
		//Properties Text
		class NEO_radioTransportPropertiesText : NEO_radioTransportCircleSliderText
		{
			idc = 655633;
			text = "Behaviour";
			x = 0.32678 * safezoneW + safezoneX;
			y = 0.528 * safezoneH + safezoneY;
			w = safeZoneW / 1000;
			h = safeZoneH / 1000;
		};
		
		//FlyInHeight CB
		class NEO_radioTransportHeightCb : NEO_RscComboBox
		{
			idc = 655630;
			x = 0.135 * safezoneW + safezoneX;
			y = 0.57 * safezoneH + safezoneY;
		w = safeZoneW / 1000;
			h = safeZoneH / 1000;
			colorSelectBackground[] = {0.500, 0.800, 0.500, 1.000};
			colorSelect[] = {0.023529, 0, 0.0313725, 1.000};
			colorText[] = {1.000, 1.000, 1.000, 1.000};
			colorBackground[] = {0.050, 0.100, 0.050, 0.600};
			colorScrollbar[] = {0.95, 0.95, 0.95, 0.000};
		};
		
		//Speed CB
		class NEO_radioTransportSpeedCb : NEO_radioTransportHeightCb
		{
			idc = 655631;
			x = 0.283475 * safezoneW + safezoneX;
			y = 0.57 * safezoneH + safezoneY;
			w = safeZoneW / 1000;
			h = safeZoneH / 1000;
		};
		
		//ROE
		class NEO_radioTransportRoeCb : NEO_radioTransportHeightCb
		{
			idc = 655632;
			x = 0.438136 * safezoneW + safezoneX;
			y = 0.57 * safezoneH + safezoneY;
			w = safeZoneW / 1000;
			h = safeZoneH / 1000;
		};
		
		//=======================
		//Cas Unit ListBox
		class NEO_radioCasUnitList : NEO_RscGUIListBox
		{
			idc = 655582;
			sizeEx = (safeZoneW / 100) + (safeZoneH / 300);
			rowHeight = (safeZoneW / 100) + (safeZoneH / 300);
			x = 0.302034 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.098983 * safezoneW;
			h = 0.126 * safezoneH;
		};
		
		//Cas Unit LB Text
		class NEO_radioCasUnitText : NEO_RscText
		{
			idc = 655583;
			x = 0.302034 * safezoneW + safezoneX;
			y = 0.178 * safezoneH + safezoneY;
			w = 0.098983 * safezoneW;
			h = 0.028 * safezoneH;
			text = "";
		};
		
		//Cas Help Unit Text
		class NEO_radioCasHelpUnitText : NEO_radioCasUnitText
		{
			idc = 655584;
			x = 0.302034 * safezoneW + safezoneX;
			y = 0.36 * safezoneH + safezoneY;
			w = 0.0927966 * safezoneW;
			h = 0.112 * safezoneH;
			text = "";
		};
		
		//Cas Confirm Button
		class NEO_radioCasConfirmButton : NEO_radioTransportConfirmButton
		{
			idc = 655585;
			x = 0.302034 * safezoneW + safezoneX;
			y = 0.654 * safezoneH + safezoneY;
			w = safeZoneW / 1000;
			h = safeZoneH / 1000;
			text = "Confirm";
			colorBackground[] = {0,0.4,0,0.7};
		};
		
		//Cas Base Button
		class NEO_radioCasBaseButton : NEO_radioCasConfirmButton
		{
			idc = 655586;
			x = 0.438136 * safezoneW + safezoneX;
			y = 0.654 * safezoneH + safezoneY;
			w = safeZoneW / 1000;
			h = safeZoneH / 1000;
			text = "Go back to Base";
			colorBackground[] = {0.2,0,0.6,0.7};
		};
		
		//CAS Task LB
		class NEO_radioCasTaskList : NEO_radioCasUnitList
		{
			idc = 655587;
			sizeEx = (safeZoneW / 100) + (safeZoneH / 300);
			rowHeight = (safeZoneW / 100) + (safeZoneH / 300);
			x = 0.438136 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.098983 * safezoneW;
			h = 0.126 * safezoneH;
		};
		
		//Cas Task Text
		class NEO_radioCasTaskText : NEO_radioCasUnitText
		{
			idc = 655588;
			x = 0.444322 * safezoneW + safezoneX;
			y = 0.178 * safezoneH + safezoneY;
			w = 0.098983 * safezoneW;
			h = 0.028 * safezoneH;
			text = "";
		};
		
		//Cas Task Help Text
		class NEO_radioCasHelpTaskText : NEO_radioCasHelpUnitText
		{
			idc = 655589;
			x = 0.444322 * safezoneW + safezoneX;
			y = 0.36 * safezoneH + safezoneY;
			w = 0.0927966 * safezoneW;
			h = 0.112 * safezoneH;
		};
		
		//Cas FlyInHeight Slider
		class NEO_radioCasFlyHeightSlider : NEO_radioTransportCircleSlider
		{
			idc = 655590;
			x = 0.122627 * safezoneW + safezoneX;
			y = 0.514 * safezoneH + safezoneY;
			w = safeZoneW / 1000;
			h = safeZoneH / 1000;
		};
		
		//Cas FlyInHeight Slider Text
		class NEO_radioCasFlyHeightText : NEO_radioTransportCircleSliderText
		{
			idc = 655591;
			x = 0.153559 * safezoneW + safezoneX;
			y = 0.388 * safezoneH + safezoneY;
			w = safeZoneW / 1000;
			h = safeZoneH / 1000;
			text = "";
		};
		
		//Cas Radius Slider
		class NEO_radioCasRadiusSlider : NEO_radioTransportCircleSlider
		{
			idc = 655592;
			x = 0.135 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = safeZoneW / 1000;
			h = safeZoneH / 1000;
		};
		
		//Cas Radius Slider Text
		class NEO_radioCasRadiusText : NEO_radioTransportCircleSliderText
		{
			idc = 655593;
			x = 0.153559 * safezoneW + safezoneX;
			y = 0.43 * safezoneH + safezoneY;
			w = safeZoneW / 1000;
			h = safeZoneH / 1000;
			text = "";
		};
		
		//=============================
		//Arty Unit List Box
		class NEO_radioArtyUnitList : NEO_radioCasUnitList
		{
			idc = 655594;
		};
		
		//Arty Unit ListBox Title
		class NEO_radioArtyUnitText : NEO_radioCasUnitText
		{
			idc = 655595;
			text = "";
		};
		
		//Arty Unit Help text
		class NEO_radioArtyHelpUnitText : NEO_radioCasHelpUnitText
		{
			idc = 655596;
			x = "safeZoneX + (safeZoneW / 2.3)";
			y = "safeZoneY + (safeZoneH / 2.35)";
			w = "(safeZoneW / 10)";
			h = "(safeZoneH / 16)";
			text = "";
		};
		
		//Arty Confirm Button
		class NEO_radioArtyConfirmButton : NEO_radioCasConfirmButton
		{
			idc = 655597;
		};
		
		//Arty Base Button
		class NEO_radioArtyBaseButton : NEO_radioArtyConfirmButton
		{
			idc = 655610;
			text = "Go back to Base";
		};
		
		//Arty Ordnance Type Text
		class NEO_radioArtyOrdnanceTypeText : NEO_radioCasUnitText
		{
			idc = 655600;
			y = "safeZoneY + (safeZoneH / 2)";
			text = "";
		};
		
		//Arty Ordnance Type LB
		class NEO_radioArtyOrdnanceTypeLb : NEO_radioArtyUnitList
		{
			idc = 655601;
			y = "safeZoneY + (safeZoneH / 1.95)";
			h = "(safeZoneH / 17)";
		};
		
		//Arty Rate Of Fire Text
		class NEO_radioArtyRateOfFireText : NEO_radioArtyOrdnanceTypeText
		{
			idc = 655602;
			x = "safeZoneX + (safeZoneW / 2.25)";
		};
		
		//Arty Rate Of Fire Lb
		class NEO_radioArtyRateOfFireLb : NEO_radioArtyOrdnanceTypeLb
		{
			idc = 655603;
			x = "safeZoneX + (safeZoneW / 2.3)";
		};
		
		//Arty Round Count Text
		class NEO_radioArtyRoundCountText : NEO_radioArtyOrdnanceTypeText
		{
			idc = 655604;
			y = "safeZoneY + (safeZoneH / 1.70)";
		};
		
		//Arty Round Count Lb
		class NEO_radioArtyRoundCountLb : NEO_radioArtyOrdnanceTypeLb
		{
			idc = 655605;
			y = "safeZoneY + (safeZoneH / 1.66)";
		};
		
		//Arty Move button
		class NEO_radioArtyMoveButton : NEO_radioTransportSmokeFoundButton
		{
			idc = 655606;
			text = "Get in Range";
		};
		
		//Arty Dont Move
		class NEO_radioArtyDontMoveButton : NEO_radioTransportSmokeNotFoundButton
		{
			idc = 655607;
			text = "Don't Move";
		};
		
		//Arty Dispersion Text
		class NEO_radioArtyDispersionText : NEO_radioCasUnitText
		{
			idc = 655608;
			text = "";
			x = "safeZoneX + (safeZoneW / 2.25)";
			y = "safeZoneY + (safeZoneH / 1.70)";
			w = "(safeZoneW / 10)";
		};
		
		//Arty Dispersion Slider
		class NEO_radioArtyDispersionSlider : NEO_radioCasRadiusSlider
		{
			idc = 655609;
			x = "safeZoneX + (safeZoneW / 2.95)";
			y = "safeZoneY + (safeZoneH / 1.427)";
			w = "(safeZoneW / 1000)";
			h = "(safeZoneH / 1000)";
		};
		
		//Arty Rate Delay Text
		class NEO_radioArtyRateDelaySliderText : NEO_radioArtyDispersionText
		{
			idc = 655611;
			y = "safeZoneY + (safeZoneH / 1.60)";
		};
		
		//Arty Rate Delay Slider
		class NEO_radioArtyRateDelaySlider : NEO_radioArtyDispersionSlider
		{
			idc = 655612;
		};
		
		//=======================================
		//DMC BUTTON
		/*class NEO_radioDmcReconButton : NEO_RscButton
		{
			idc = -1;
			action = "[] execVM 'scripts\TDMC\misc\TDMC_requestinfo.sqf'";
			text = "REUEST UAV RECON";
			x = "safeZoneX + (safeZoneW / 5.5)";
			y = "safeZoneY + (safeZoneH / 1.425)";
			w = "(safeZoneW / 7.5)";
			h = "(safeZoneH / 20)";
		};*/
	};
};
