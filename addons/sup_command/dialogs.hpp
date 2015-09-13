//-- Call Defines
#include "Base_Classes.hpp"


//-- RscText overlay that coveres the darkened inside portion of the tablet. For use with editing in GUI editor.
		//class ALiVECommandTablet_TEST: RscText
		//{
		//	idc = 723004;
		//	x = 4.7 * GUI_GRID_W + GUI_GRID_X;
		//	y = -1 * GUI_GRID_H + GUI_GRID_Y;
		//	w = 28 * GUI_GRID_W;
		//	h = 24 * GUI_GRID_H;
		//	colorBackground[] = {0.631,0,0.18,.8};
		//	colorActive[] = {0.631,0,0.18,.8};
		//};


//-- Main dialog
class Spyder_TacticalCommandMain
{
	idd = 723;
	movingEnable = 0;
   	 onLoad = "['main'] spawn ALiVE_fnc_onLoad";
	onUnload = "['main'] spawn ALiVE_fnc_unLoad";
	class controls
	{
		class SpyderCommandTablet_Background : STCRscPicture
		{
			idc = 7231;
			x = 0.112424 * safezoneW + safezoneX;
			y = 0.0632 * safezoneH + safezoneY;
			w = 0.73 * safezoneW;
			h = 0.84 * safezoneH;
			text = "x\alive\addons\main\data\ui\ALIVE_toughbook_2.paa";
			moving = 0;
		};
		class SpyderCommandTablet_Map : STCRscMapControl
		{
			idc = 7232;
			x = 0.489796 * safezoneW + safezoneX;
			y = 0.1584 * safezoneH + safezoneY;
			w = 0.216525 * safezoneW;
			h = 0.42 * safezoneH;
		};
		class SpyderCommandTablet_GroupManger: STCRscButtonGreen
		{
			idc = 7233;
			action = "closeDialog 0;CreateDialog 'Spyder_TacticalCommandGroupManager'";
			text = "Group Manager";
			x = 19.5 * GUI_GRID_W + GUI_GRID_X;
			y = 17 * GUI_GRID_H + GUI_GRID_Y;
			w = 12.5 * GUI_GRID_W;
			h = 1.2 * GUI_GRID_H;
		};
		class SpyderCommandTablet_HighCommand: STCRscButtonGreen
		{
			idc = 7234;
			action = "closeDialog 0;CreateDialog 'Spyder_TacticalCommandHighCommand'";
			text = "High Command";
			x = 19.5 * GUI_GRID_W + GUI_GRID_X;
			y = 18.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 12.5 * GUI_GRID_W;
			h = 1.2 * GUI_GRID_H;
		};
		class SpyderCommandTablet_Close: STCRscButtonRed
		{
			idc = 7235;
			action = "closeDialog 0";
			text = "Close";
			x = 19.5 * GUI_GRID_W + GUI_GRID_X;
			y = 20 * GUI_GRID_H + GUI_GRID_Y;
			w = 12.5 * GUI_GRID_W;
			h = 1.2 * GUI_GRID_H;
		};
		class SpyderCommandTablet_BattlefieldAnalysisTitle: STCRscText
		{
			idc = 7236;

			text = "Battlefield Analysis";
			x = 6.3 * GUI_GRID_W + GUI_GRID_X;
			y = 0 * GUI_GRID_H + GUI_GRID_Y;
			w = 7.6 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorActive[] = {0,0,0,0};
			sizeEx = .85 * GUI_GRID_H;
		};
		class SpyderCommandTablet_BattlefieldAnalysisOptions: STCRscListBox
		{
			idc = 7237;

			x = 5.5 * GUI_GRID_W + GUI_GRID_X;
			y = 1.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 3.5 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0};
			sizeEx = .7 * GUI_GRID_H;
		};
		class SpyderCommandTablet_AvailableMissionsTitle: STCRscText
		{
			idc = 7238;

			text = "Available Missions";
			x = 6.3 * GUI_GRID_W + GUI_GRID_X;
			y = 7.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorActive[] = {0,0,0,0};
			sizeEx = .85 * GUI_GRID_H;
		};
		class SpyderCommandTablet_AvailableMissionsOptions: STCRscListBox
		{
			idc = 7239;

			x = 5.5 * GUI_GRID_W + GUI_GRID_X;
			y = 9 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 7.5 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0};
			sizeEx = .7 * GUI_GRID_H;
		};
		class SpyderCommandTablet_RadiusTitle: STCRscText
		{
			idc = 72310;

			text = "Radius";
			x = 6.5 * GUI_GRID_W + GUI_GRID_X;
			y = 17 * GUI_GRID_H + GUI_GRID_Y;
			w = 2.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorActive[] = {0,0,0,0};
			sizeEx = .7 * GUI_GRID_H;
		};
		class SpyderCommandTablet_RadiusInput: STCRscEdit
		{
			idc = 72311;

			text = "2000";
			x = 6 * GUI_GRID_W + GUI_GRID_X;
			y = 18.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class SpyderCommandTablet_GroupsToSendTitle: STCRscText
		{
			idc = 72312;

			text = "Groups to send";
			x = 12.5 * GUI_GRID_W + GUI_GRID_X;
			y = 17 * GUI_GRID_H + GUI_GRID_Y;
			w = 5.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorActive[] = {0,0,0,0};
			sizeEx = .7 * GUI_GRID_H;
		};
		class SpyderCommandTablet_GroupsToSendInput: STCRscEdit
		{
			idc = 72313;

			text = "3";
			x = 12.5 * GUI_GRID_W + GUI_GRID_X;
			y = 18.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 5.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class SpyderCommandTablet_BattlefieldAnalysisExecute: STCRscButtonGreen
		{
			idc = 72314;

			action = "[] spawn ALiVE_fnc_executeAnalysis";
			text = "Toggle Analysis";
			x = 5.5 * GUI_GRID_W + GUI_GRID_X;
			y = 5.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 1.2 * GUI_GRID_H;
		};
		class SpyderCommandTablet_AvailableMissionsExecute: STCRscButtonGreen
		{
			idc = 72315;

			action = "[] spawn ALiVE_fnc_executeMission";
			text = "Confirm Mission";
			x = 5.5 * GUI_GRID_W + GUI_GRID_X;
			y = 20 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 1.2 * GUI_GRID_H;
		};

	};
};


//-- Group manager dialog
class Spyder_TacticalCommandGroupManager
{
	idd = 724;
	movingEnable = 0;
   	 onLoad = "['groupmanager'] spawn ALiVE_fnc_onLoad";
	onUnload = "['groupmanager'] spawn ALiVE_fnc_unLoad";
	class controls
	{
		class SpyderCommandTablet_Background : STCRscPicture
		{
			idc = 7241;
			x = 0.112424 * safezoneW + safezoneX;
			y = 0.0632 * safezoneH + safezoneY;
			w = 0.73 * safezoneW;
			h = 0.84 * safezoneH;
			text = "x\alive\addons\main\data\ui\ALIVE_toughbook_2.paa";
			moving = 0;
		};
		class SpyderCommandTablet_Close: STCRscButtonRed
		{
			idc = 7242;
			action = "closeDialog 0;CreateDialog 'Spyder_TacticalCommandMain'";
			text = "Switch to main screen";
			x = 19.5 * GUI_GRID_W + GUI_GRID_X;
			y = 21 * GUI_GRID_H + GUI_GRID_Y;
			w = 12.5 * GUI_GRID_W;
			h = 1.2 * GUI_GRID_H;
		};
		class SpyderCommandTabletGroupManager_GearList: STCRscListbox
		{
			idc = 7244;
			x = 19 * GUI_GRID_W + GUI_GRID_X;
			y = -0.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 16 * GUI_GRID_H;
			sizeEx = .65 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0};
		};
		class SpyderCommandTabletGroupManager_SquadList: STCRscListbox
		{
			idc = 7245;
			x = 5.5 * GUI_GRID_W + GUI_GRID_X;
			y = -0.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 16 * GUI_GRID_H;
			sizeEx = .75 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0};
		};
		class SpyderCommandTabletGroupManager_FormationCombo: STCRscCombo
		{
			idc = 7246;
			x = 5.5 * GUI_GRID_W + GUI_GRID_X;
			y = 16 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class SpyderCommandTabletGroupManager_FormationButton: STCRscButtonGreen
		{
			idc = 7247;
			action = "[] spawn ALiVE_fnc_changeFormation";
			text = "Change Formation";
			x = 5.5 * GUI_GRID_W + GUI_GRID_X;
			y = 17.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1.2 * GUI_GRID_H;
		};
		class SpyderCommandTabletGroupManager_BehaviorCombo: STCRscCombo
		{
			idc = 7248;
			x = 5.5 * GUI_GRID_W + GUI_GRID_X;
			y = 19.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class SpyderCommandTabletGroupManager_BehaviorButton: STCRscButtonGreen
		{
			idc = 7249;
			action = "[] spawn ALiVE_fnc_changeBehavior";
			text = "Change Behavior";
			x = 5.5 * GUI_GRID_W + GUI_GRID_X;
			y = 21 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1.2 * GUI_GRID_H;
		};
		class SpyderCommandTabletGroupManager_RemoveUnitButton: STCRscButtonGreen
		{
			idc = 72410;
			action = "['remove'] call ALiVE_fnc_removeUnit";
			text = "Remove unit from group";
			x = 19.5 * GUI_GRID_W + GUI_GRID_X;
			y = 18 * GUI_GRID_H + GUI_GRID_Y;
			w = 12.5 * GUI_GRID_W;
			h = 1.2 * GUI_GRID_H;
		};
		class SpyderCommandTabletGroupManager_DeleteUnitButton: STCRscButtonGreen
		{
			idc = 72411;
			action = "['delete'] call ALiVE_fnc_removeUnit";
			text = "Delete unit from group";
			x = 19.5 * GUI_GRID_W + GUI_GRID_X;
			y = 19.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 12.5 * GUI_GRID_W;
			h = 1.2 * GUI_GRID_H;
		};
	};
};


//-- High command dialog
class Spyder_TacticalCommandHighCommand
{
	idd = 725;
	movingEnable = 0;
   	 onLoad = "['highcommand'] spawn ALiVE_fnc_onLoad";
	onUnload = "['highcommand'] spawn ALiVE_fnc_unLoad";
	class controls
	{
		class SpyderHighCommandTablet_Background : STCRscPicture
		{
			idc = 7251;
			x = 0.112424 * safezoneW + safezoneX;
			y = 0.0632 * safezoneH + safezoneY;
			w = 0.73 * safezoneW;
			h = 0.84 * safezoneH;
			text = "x\alive\addons\main\data\ui\ALIVE_toughbook_2.paa";
			moving = 0;
		};
		class SpyderHighCommandTablet_CommandMap : STCRscMapControl
		{
			idc = 7252;
			x = 0.489796 * safezoneW + safezoneX;
			y = 0.1584 * safezoneH + safezoneY;
			w = 0.216525 * safezoneW;
			h = 0.42 * safezoneH;
		};
		class SpyderHighCommandTablet_Close: STCRscButtonRed
		{
			idc = 7253;
			action = "closeDialog 0;CreateDialog 'Spyder_TacticalCommandMain'";
			text = "Switch to main screen";
			x = 19.5 * GUI_GRID_W + GUI_GRID_X;
			y = 20 * GUI_GRID_H + GUI_GRID_Y;
			w = 12.5 * GUI_GRID_W;
			h = 1.2 * GUI_GRID_H;
		};
		class SpyderHighCommandTablet_GroupLister: STCRscListbox
		{
			idc = 7254;
			x = 5.5 * GUI_GRID_W + GUI_GRID_X;
			y = -0.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 13.5 * GUI_GRID_W;
			h = 14 * GUI_GRID_H;
			sizeEx = .72 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0};
		};
		class SpyderHighCommandTablet_WaypointModeButton: STCRscButtonGreen
		{
			idc = 7255;
			action = "STCHighCommandMode = 'WaypointSelect'";
			text = "Waypoint Mode";
			x = 19.5 * GUI_GRID_W + GUI_GRID_X;
			y = 17 * GUI_GRID_H + GUI_GRID_Y;
			w = 12.5 * GUI_GRID_W;
			h = 1.2 * GUI_GRID_H;
		};
		class SpyderHighCommandTablet_GroupSelectModeButton: STCRscButtonGreen
		{
			idc = 7256;
			action = "STCHighCommandMode = 'GroupSelect'";
			text = "Group Select Mode";
			x = 19.5 * GUI_GRID_W + GUI_GRID_X;
			y = 18.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 12.5 * GUI_GRID_W;
			h = 1.2 * GUI_GRID_H;
		};
		class SpyderHighCommandTablet_ConfirmWaypoints: STCRscButtonGreen
		{
			idc = 7257;
			action = "[] spawn ALiVE_fnc_confirmWaypoints";
			text = "Confirm Waypoints";
			x = 5.5 * GUI_GRID_W + GUI_GRID_X;
			y = 15.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 12.5 * GUI_GRID_W;
			h = 1.2 * GUI_GRID_H;
		};
		class SpyderHighCommandTablet_ClearWaypoints: STCRscButtonGreen
		{
			idc = 7258;
			action = "[] spawn ALiVE_fnc_clearWaypoints";
			text = "Clear Waypoints";
			x = 5.5 * GUI_GRID_W + GUI_GRID_X;
			y = 17 * GUI_GRID_H + GUI_GRID_Y;
			w = 12.5 * GUI_GRID_W;
			h = 1.2 * GUI_GRID_H;
		};
		class SpyderHighCommandTablet_WaypointSettings: STCRscButtonGreen
		{
			idc = 7259;
			action = "CreateDialog 'Spyder_TacticalCommandWaypointSettings'";
			text = "Waypoint Settings";
			x = 5.5 * GUI_GRID_W + GUI_GRID_X;
			y = 18.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 12.5 * GUI_GRID_W;
			h = 1.2 * GUI_GRID_H;
		};
		class SpyderHighCommandTablet_AmbientCommands: STCRscButtonGreen
		{
			idc = 72510;
			action = "";
			text = "Ambient Commands";
			x = 5.5 * GUI_GRID_W + GUI_GRID_X;
			y = 20 * GUI_GRID_H + GUI_GRID_Y;
			w = 12.5 * GUI_GRID_W;
			h = 1.2 * GUI_GRID_H;
		};
	};
};

//-- Waypoint Settings dialog
class Spyder_TacticalCommandWaypointSettings
{
	idd = 726;
	movingEnable = 0;
   	 onLoad = "['waypointsettings'] spawn ALiVE_fnc_onLoad";
	onUnload = "";
	class controls
	{
		class SpyderWaypointSettingsTablet_Background : STCRscPicture
		{
			idc = 7261;
			x = 0.112424 * safezoneW + safezoneX;
			y = 0.0632 * safezoneH + safezoneY;
			w = 0.73 * safezoneW;
			h = 0.84 * safezoneH;
			text = "x\alive\addons\main\data\ui\ALIVE_toughbook_2.paa";
			moving = 0;
		};
		class SpyderWaypointSettingsTablet_UpdateWaypointSettings: STCRscButtonGreen
		{
			idc = 7262;
			action = "[] spawn ALiVE_fnc_updateWaypointSettings";
			text = "Update Settings";
			x = 19.5 * GUI_GRID_W + GUI_GRID_X;
			y = 18.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 12.5 * GUI_GRID_W;
			h = 1.2 * GUI_GRID_H;
		};
		class SpyderWaypointSettingsTablet_Close: STCRscButtonRed
		{
			idc = 7262;
			action = "closeDialog 0";
			text = "Back";
			x = 19.5 * GUI_GRID_W + GUI_GRID_X;
			y = 20 * GUI_GRID_H + GUI_GRID_Y;
			w = 12.5 * GUI_GRID_W;
			h = 1.2 * GUI_GRID_H;
		};
		class SpyderWaypointSettingsTablet_WaypointSettingsTitle: STCRscText
		{
			idc = 7263;
			text = "Waypoint Settings"; //--- ToDo: Localize;
			x = 12.55 * GUI_GRID_W + GUI_GRID_X;
			y = -0.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			sizeEx = 1.2 * GUI_GRID_H;
		};
		class SpyderWaypointSettingsTablet_SpyderWaypointSettingsTablet_WaypointTypeTitle: STCRscText
		{
			idc = 7264;
			text = "Waypoint Type"; //--- ToDo: Localize;
			x = 7.5 * GUI_GRID_W + GUI_GRID_X;
			y = 1.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
			sizeEx = .88 * GUI_GRID_H;
		};
		class SpyderWaypointSettingsTablet_WaypointTypeList: STCRscListbox
		{
			idc = 7265;
			x = 7 * GUI_GRID_W + GUI_GRID_X;
			y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 9 * GUI_GRID_W;
			h = 5.5 * GUI_GRID_H;
			sizeEx = .7 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0};
		};
		class SpyderWaypointSettingsTablet_WaypointSpeedTitle: STCRscText
		{
			idc = 7266;
			text = "Waypoint Speed"; //--- ToDo: Localize;
			x = 22 * GUI_GRID_W + GUI_GRID_X;
			y = 1.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 6.5 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
			sizeEx = .88 * GUI_GRID_H;
		};
		class SpyderWaypointSettingsTablet_WaypointSpeedList: STCRscListbox
		{
			idc = 7267;
			x = 21.5 * GUI_GRID_W + GUI_GRID_X;
			y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 9 * GUI_GRID_W;
			h = 5.5 * GUI_GRID_H;
			sizeEx = .7 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0};
		};
		class SpyderWaypointSettingsTablet_WaypointFormationTitle: STCRscText
		{
			idc = 7268;
			text = "Waypoint Formation"; //--- ToDo: Localize;
			x = 7.5 * GUI_GRID_W + GUI_GRID_X;
			y = 9 * GUI_GRID_H + GUI_GRID_Y;
			w = 9 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
			sizeEx = .88 * GUI_GRID_H;
		};
		class SpyderWaypointSettingsTablet_WaypointFormationList: STCRscListbox
		{
			idc = 7269;
			x = 7 * GUI_GRID_W + GUI_GRID_X;
			y = 11 * GUI_GRID_H + GUI_GRID_Y;
			w = 9 * GUI_GRID_W;
			h = 7.5 * GUI_GRID_H;
			sizeEx = .7 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0};
		};
		class SpyderWaypointSettingsTablet_WaypointBehaviorTitle: STCRscText
		{
			idc = 7270;
			text = "Waypoint Behavior"; //--- ToDo: Localize;
			x = 22 * GUI_GRID_W + GUI_GRID_X;
			y = 9 * GUI_GRID_H + GUI_GRID_Y;
			w = 9 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
			sizeEx = .88 * GUI_GRID_H;
		};
		class SpyderWaypointSettingsTablet_WaypointBehaviorList: STCRscListbox
		{
			idc = 7271;
			x = 22 * GUI_GRID_W + GUI_GRID_X;
			y = 11 * GUI_GRID_H + GUI_GRID_Y;
			w = 9 * GUI_GRID_W;
			h = 7.5 * GUI_GRID_H;
			sizeEx = .7 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0};
		};
	};
};