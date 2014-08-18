#include "common.hpp"

// GUI editor: configfile >> "C2Tablet"

class C2Tablet
{
    idd = 70001;
    onLoad = "[] call ALIVE_fnc_C2TabletOnLoad;";
    onUnload = "[] call ALIVE_fnc_C2TabletOnUnLoad;";

    class controls
    {

        class C2Tablet_background : RscPicture
        {
            idc = -1;
            x = 0.142424 * safezoneW + safezoneX;
            y = 0.0632 * safezoneH + safezoneY;
            w = 0.73 * safezoneW;
            h = 0.84 * safezoneH;
            text = "x\alive\addons\sup_player_resupply\data\ui\ALIVE_toughbook_2.paa";
            moving = 0;
            colorBackground[] = {0,0,0,0};
        };

        class C2Tablet_mainTaskButton : C2Tablet_RscButton
        {
            idc = 70002;
            text = "Tasking";
            style = 0x02;
            x = 0.4 * safezoneW + safezoneX;
            y = 0.2400 * safezoneH + safezoneY;
            w = 0.216525 * safezoneW;
            h = 0.028 * safezoneH;
            colorBackground[] = {0.384,0.439,0.341,1};
            sizeEx = 0.8 * GUI_GRID_H;
            colorBackgroundFocused[] = {0.706,0.706,0.706,1};
            colorFocused[] = {0.706,0.706,0.706,1};
        };

        class C2Tablet_mainAARButton : C2Tablet_RscButton
        {
            idc = 70003;
            text = "AAR";
            style = 0x02;
            x = 0.4 * safezoneW + safezoneX;
            y = 0.2900 * safezoneH + safezoneY;
            w = 0.216525 * safezoneW;
            h = 0.028 * safezoneH;
            colorBackground[] = {0.384,0.439,0.341,1};
            sizeEx = 0.8 * GUI_GRID_H;
            colorBackgroundFocused[] = {0.706,0.706,0.706,1};
            colorFocused[] = {0.706,0.706,0.706,1};
        };

        class C2Tablet_mainISTARButton : C2Tablet_RscButton
        {
            idc = 70004;
            text = "ISTAR";
            style = 0x02;
            x = 0.4 * safezoneW + safezoneX;
            y = 0.3400 * safezoneH + safezoneY;
            w = 0.216525 * safezoneW;
            h = 0.028 * safezoneH;
            colorBackground[] = {0.384,0.439,0.341,1};
            sizeEx = 0.8 * GUI_GRID_H;
            colorBackgroundFocused[] = {0.706,0.706,0.706,1};
            colorFocused[] = {0.706,0.706,0.706,1};
        };

        class C2Tablet_mainTitle : C2Tablet_RscText
        {
            idc = 70007;
            text = "";
            x = 0.271203 * safezoneW + safezoneX;
            y = 0.1430 * safezoneH + safezoneY;
            w = 0.159596 * safezoneW;
            h = 0.0308 * safezoneH;
            colorBackground[] = {0,0,0,0};
            class Attributes
            {
                font = "PuristaMedium";
                color = "#627057";
                align = "left";
                valign = "middle";
                shadow = true;
                shadowColor = "#000000";
                size = 0.8;
            };
        };

        class C2Tablet_mainAbortButton : C2Tablet_RscButton
        {
            idc = 70005;
            text = "Close";
            style = 0x02;
            x = 0.4 * safezoneW + safezoneX;
            y = 0.3900 * safezoneH + safezoneY;
            w = 0.216525 * safezoneW;
            h = 0.028 * safezoneH;
            sizeEx = 0.8 * GUI_GRID_H;
            colorBackground[] = {0.376,0.196,0.204,1};
            colorText[] = {0.706,0.706,0.706,1};
            colorBackgroundFocused[] = {0.706,0.706,0.706,1};
            colorFocused[] = {0.706,0.706,0.706,1};
            action = "closeDialog 0";
        };

        class C2Tablet_subMenuBackButton : C2Tablet_RscButton
        {
            idc = 70006;
            text = "Back";
            style = 0x02;
            x = 0.519796 * safezoneW + safezoneX;
            y = 0.7000 * safezoneH + safezoneY;
            w = 0.216525 * safezoneW;
            h = 0.028 * safezoneH;
            sizeEx = 0.8 * GUI_GRID_H;
            colorBackground[] = {0.376,0.196,0.204,1};
            colorText[] = {0.706,0.706,0.706,1};
            colorBackgroundFocused[] = {0.706,0.706,0.706,1};
            colorFocused[] = {0.706,0.706,0.706,1};
        };

        class C2Tablet_subMenuAbortButton : C2Tablet_RscButton
        {
            idc = 70010;
            text = "Close";
            style = 0x02;
            x = 0.519796 * safezoneW + safezoneX;
            y = 0.7350 * safezoneH + safezoneY;
            w = 0.216525 * safezoneW;
            h = 0.028 * safezoneH;
            sizeEx = 0.8 * GUI_GRID_H;
            colorBackground[] = {0.376,0.196,0.204,1};
            colorText[] = {0.706,0.706,0.706,1};
            colorBackgroundFocused[] = {0.706,0.706,0.706,1};
            colorFocused[] = {0.706,0.706,0.706,1};
            action = "closeDialog 0";
        };

        class C2Tablet_currentTaskList : C2Tablet_RscGUIListBox
        {
            idc = 70025;
            x = 0.271102 * safezoneW + safezoneX;
            y = 0.1600 * safezoneH + safezoneY;
            w = 0.465 * safezoneW;
            h = 0.35 * safezoneH;
            colorBackground[] = {0.173,0.173,0.173,1};
            colorActive[] = {0.384,0.439,0.341,1};
            sizeEx = (safeZoneW / 75) + (safeZoneH / 275);
            rowHeight = (safeZoneW / 75) + (safeZoneH / 275);
        };

        class C2Tablet_createTaskButton : C2Tablet_RscButton
        {
            idc = 70016;
            x = 0.271203 * safezoneW + safezoneX;
            y = 0.5150 * safezoneH + safezoneY;
            w = 0.465 * safezoneW;
            h = 0.028 * safezoneH;
            text = "Create task";
            sizeEx = 0.8 * GUI_GRID_H;
            colorBackground[] = {0.384,0.439,0.341,1};
            colorBackgroundFocused[] = {0.706,0.706,0.706,1};
            colorFocused[] = {0.706,0.706,0.706,1};
        };

        class C2Tablet_taskingCurrentTaskListEditButton : C2Tablet_RscButton
        {
            idc = 70026;
            text = "Edit Task";
            style = 0x02;
            x = 0.271102 * safezoneW + safezoneX;
            y = 0.5480 * safezoneH + safezoneY;
            w = 0.465 * safezoneW;
            h = 0.028 * safezoneH;
            sizeEx = 0.8 * GUI_GRID_H;
            colorBackground[] = {0.384,0.439,0.341,1};
            colorBackgroundFocused[] = {0.706,0.706,0.706,1};
            colorFocused[] = {0.706,0.706,0.706,1};
        };

        class C2Tablet_taskingCurrentTaskListDeleteButton : C2Tablet_RscButton
        {
            idc = 70027;
            text = "Delete Task";
            style = 0x02;
            x = 0.271102 * safezoneW + safezoneX;
            y = 0.5820 * safezoneH + safezoneY;
            w = 0.465 * safezoneW;
            h = 0.028 * safezoneH;
            sizeEx = 0.8 * GUI_GRID_H;
            colorBackground[] = {0.376,0.196,0.204,1};
            colorText[] = {0.706,0.706,0.706,1};
            colorBackgroundFocused[] = {0.706,0.706,0.706,1};
            colorFocused[] = {0.706,0.706,0.706,1};
        };

        class C2Tablet_taskPlayerList : C2Tablet_RscGUIListBox
        {
            idc = 70011;
            x = 0.271102 * safezoneW + safezoneX;
            y = 0.1600 * safezoneH + safezoneY;
            w = 0.465 * safezoneW;
            h = 0.13 * safezoneH;
            colorBackground[] = {0.173,0.173,0.173,1};
            colorActive[] = {0.384,0.439,0.341,1};
            sizeEx = (safeZoneW / 75) + (safeZoneH / 275);
            rowHeight = (safeZoneW / 75) + (safeZoneH / 275);
        };

        class C2Tablet_taskSelectGroupButton : C2Tablet_RscButton
        {
            idc = 70014;
            x = 0.271203 * safezoneW + safezoneX;
            y = 0.2900 * safezoneH + safezoneY;
            w = 0.465 * safezoneW;
            h = 0.028 * safezoneH;
            text = "Select all group members";
            sizeEx = 0.8 * GUI_GRID_H;
            colorBackground[] = {0.384,0.439,0.341,1};
            colorBackgroundFocused[] = {0.706,0.706,0.706,1};
            colorFocused[] = {0.706,0.706,0.706,1};
        };

        class C2Tablet_taskSelectedPlayerTitle : C2Tablet_RscText
        {
            idc = 70012;
            text = "Selected Players";
            x = 0.271203 * safezoneW + safezoneX;
            y = 0.3290 * safezoneH + safezoneY;
            w = 0.159596 * safezoneW;
            h = 0.0308 * safezoneH;
            colorBackground[] = {0,0,0,0};
            class Attributes
            {
                font = "PuristaMedium";
                color = "#627057";
                align = "left";
                valign = "middle";
                shadow = true;
                shadowColor = "#000000";
                size = 0.8;
            };
        };

        class C2Tablet_taskSelectedPlayerList : C2Tablet_RscGUIListBox
        {
            idc = 70013;
            x = 0.271102 * safezoneW + safezoneX;
            y = 0.3460 * safezoneH + safezoneY;
            w = 0.465 * safezoneW;
            h = 0.13 * safezoneH;
            colorBackground[] = {0.173,0.173,0.173,1};
            colorActive[] = {0.384,0.439,0.341,1};
            sizeEx = (safeZoneW / 75) + (safeZoneH / 275);
            rowHeight = (safeZoneW / 75) + (safeZoneH / 275);
        };

        class C2Tablet_taskSelectedPlayerListDeleteButton : C2Tablet_RscButton
        {
            idc = 70015;
            x = 0.271203 * safezoneW + safezoneX;
            y = 0.4770 * safezoneH + safezoneY;
            w = 0.465 * safezoneW;
            h = 0.028 * safezoneH;
            text = "Delete";
            sizeEx = 0.8 * GUI_GRID_H;
            colorBackground[] = {0.384,0.439,0.341,1};
            colorBackgroundFocused[] = {0.706,0.706,0.706,1};
            colorFocused[] = {0.706,0.706,0.706,1};
        };

        class C2Tablet_taskSelectedPlayersClearButton : C2Tablet_RscButton
        {
            idc = 70029;
            x = 0.271203 * safezoneW + safezoneX;
            y = 0.5100 * safezoneH + safezoneY;
            w = 0.465 * safezoneW;
            h = 0.028 * safezoneH;
            text = "Clear selected players";
            sizeEx = 0.8 * GUI_GRID_H;
            colorBackground[] = {0.384,0.439,0.341,1};
            colorBackgroundFocused[] = {0.706,0.706,0.706,1};
            colorFocused[] = {0.706,0.706,0.706,1};
        };

        class C2Tablet_taskingAddTaskTitleEditTitle : C2Tablet_RscText
        {
            idc = 70018;
            text = "Task Title";
            x = 0.271203 * safezoneW + safezoneX;
            y = 0.1600 * safezoneH + safezoneY;
            w = 0.159596 * safezoneW;
            h = 0.0308 * safezoneH;
            colorBackground[] = {0,0,0,0};
            class Attributes
            {
                font = "PuristaMedium";
                color = "#627057";
                align = "left";
                valign = "middle";
                shadow = true;
                shadowColor = "#000000";
                size = 0.8;
            };
        };

        class C2Tablet_taskingAddTaskTitleEdit : C2Tablet_RscEdit
        {
            idc = 70019;
            x = 0.271102 * safezoneW + safezoneX;
            y = 0.1770 * safezoneH + safezoneY;
            w = 0.241271 * safezoneW;
            h = 0.028 * safezoneH;
        };

        class C2Tablet_taskingAddTaskDescriptionEditTitle : C2Tablet_RscText
        {
            idc = 70020;
            text = "Task Description";
            x = 0.271203 * safezoneW + safezoneX;
            y = 0.2100 * safezoneH + safezoneY;
            w = 0.159596 * safezoneW;
            h = 0.0308 * safezoneH;
            colorBackground[] = {0,0,0,0};
            class Attributes
            {
                font = "PuristaMedium";
                color = "#627057";
                align = "left";
                valign = "middle";
                shadow = true;
                shadowColor = "#000000";
                size = 0.8;
            };
        };

        class C2Tablet_taskingAddTaskDescriptionEdit : C2Tablet_RscEdit
        {
            idc = 70021;
            x = 0.271102 * safezoneW + safezoneX;
            y = 0.2270 * safezoneH + safezoneY;
            w = 0.241271 * safezoneW;
            h = 0.13 * safezoneH;
            style = 16;
        };

        class C2Tablet_taskingAddTaskStateEditTitle : C2Tablet_RscText
        {
            idc = 70030;
            text = "Task State";
            x = 0.271203 * safezoneW + safezoneX;
            y = 0.3600 * safezoneH + safezoneY;
            w = 0.159596 * safezoneW;
            h = 0.0208 * safezoneH;
            colorBackground[] = {0,0,0,0};
            class Attributes
            {
                font = "PuristaMedium";
                color = "#627057";
                align = "left";
                valign = "middle";
                shadow = true;
                shadowColor = "#000000";
                size = 0.8;
            };
        };

        class C2Tablet_taskingAddTaskStateEditList : C2Tablet_RscGUIListBox
        {
            idc = 70031;
            x = 0.271102 * safezoneW + safezoneX;
            y = 0.3770 * safezoneH + safezoneY;
            w = 0.241271 * safezoneW;
            h = 0.1 * safezoneH;
            colorBackground[] = {0.173,0.173,0.173,1};
            colorActive[] = {0.384,0.439,0.341,1};
            sizeEx = (safeZoneW / 75) + (safeZoneH / 275);
            rowHeight = (safeZoneW / 75) + (safeZoneH / 275);
        };

        class C2Tablet_taskingMap : C2Tablet_RscMap
        {
            idc = 70022;
            x = 0.519796 * safezoneW + safezoneX;
            y = 0.1584 * safezoneH + safezoneY;
            w = 0.216525 * safezoneW;
            h = 0.4 * safezoneH;
        };

        class C2Tablet_taskingAddTaskCreateButton : C2Tablet_RscButton
        {
            idc = 70023;
            text = "Create Task";
            style = 0x02;
            x = 0.519796 * safezoneW + safezoneX;
            y = 0.6650 * safezoneH + safezoneY;
            w = 0.216525 * safezoneW;
            h = 0.028 * safezoneH;
            sizeEx = 0.8 * GUI_GRID_H;
            colorBackground[] = {0.376,0.196,0.204,1};
            colorText[] = {0.706,0.706,0.706,1};
            colorBackgroundFocused[] = {0.706,0.706,0.706,1};
            colorFocused[] = {0.706,0.706,0.706,1};
        };

        class C2Tablet_taskingEditTaskUpdateButton : C2Tablet_RscButton
        {
            idc = 70028;
            text = "Update Task";
            style = 0x02;
            x = 0.519796 * safezoneW + safezoneX;
            y = 0.6650 * safezoneH + safezoneY;
            w = 0.216525 * safezoneW;
            h = 0.028 * safezoneH;
            sizeEx = 0.8 * GUI_GRID_H;
            colorBackground[] = {0.376,0.196,0.204,1};
            colorText[] = {0.706,0.706,0.706,1};
            colorBackgroundFocused[] = {0.706,0.706,0.706,1};
            colorFocused[] = {0.706,0.706,0.706,1};
        };

        class C2Tablet_taskingEditTaskManagePlayersButton : C2Tablet_RscButton
        {
            idc = 70032;
            text = "Assign Players";
            style = 0x02;
            x = 0.519796 * safezoneW + safezoneX;
            y = 0.6300 * safezoneH + safezoneY;
            w = 0.216525 * safezoneW;
            h = 0.028 * safezoneH;
            sizeEx = 0.8 * GUI_GRID_H;
            colorBackground[] = {0.376,0.196,0.204,1};
            colorText[] = {0.706,0.706,0.706,1};
            colorBackgroundFocused[] = {0.706,0.706,0.706,1};
            colorFocused[] = {0.706,0.706,0.706,1};
        };

        class C2Tablet_taskingAddTaskApplyEditTitle : C2Tablet_RscText
        {
            idc = 70033;
            text = "Applied to players";
            x = 0.271203 * safezoneW + safezoneX;
            y = 0.5000 * safezoneH + safezoneY;
            w = 0.159596 * safezoneW;
            h = 0.0208 * safezoneH;
            colorBackground[] = {0,0,0,0};
            class Attributes
            {
                font = "PuristaMedium";
                color = "#627057";
                align = "left";
                valign = "middle";
                shadow = true;
                shadowColor = "#000000";
                size = 0.8;
            };
        };

        class C2Tablet_taskingAddTaskApplyEditList : C2Tablet_RscGUIListBox
        {
            idc = 70034;
            x = 0.271102 * safezoneW + safezoneX;
            y = 0.5170 * safezoneH + safezoneY;
            w = 0.241271 * safezoneW;
            h = 0.1 * safezoneH;
            colorBackground[] = {0.173,0.173,0.173,1};
            colorActive[] = {0.384,0.439,0.341,1};
            sizeEx = (safeZoneW / 75) + (safeZoneH / 275);
            rowHeight = (safeZoneW / 75) + (safeZoneH / 275);
        };


        /*
        class C2Tablet_map : C2Tablet_RscMap
        {
            idc = 70002;
            x = 0.519796 * safezoneW + safezoneX;
            y = 0.1584 * safezoneH + safezoneY;
            w = 0.216525 * safezoneW;
            h = 0.4 * safezoneH;
        };

        class C2Tablet_request : C2Tablet_RscButton
        {
            idc = 70003;
            text = "Send Request";
            style = 0x02;
            x = 0.519796 * safezoneW + safezoneX;
            y = 0.6900 * safezoneH + safezoneY;
            w = 0.216525 * safezoneW;
            h = 0.028 * safezoneH;
            colorBackground[] = {0.384,0.439,0.341,1};
            sizeEx = 0.8 * GUI_GRID_H;
            colorBackgroundFocused[] = {0.706,0.706,0.706,1};
            colorFocused[] = {0.706,0.706,0.706,1};
        };

        class C2Tablet_abort : C2Tablet_RscButton
        {
            idc = 70004;
            text = "Close";
            style = 0x02;
            x = 0.519796 * safezoneW + safezoneX;
            y = 0.7300 * safezoneH + safezoneY;
            w = 0.216525 * safezoneW;
            h = 0.028 * safezoneH;
            sizeEx = 0.8 * GUI_GRID_H;
            colorBackground[] = {0.376,0.196,0.204,1};
            colorText[] = {0.706,0.706,0.706,1};
            colorBackgroundFocused[] = {0.706,0.706,0.706,1};
            colorFocused[] = {0.706,0.706,0.706,1};
            action = "closeDialog 0";
        };


        class C2Tablet_payloadWeight : C2Tablet_RscText
        {
            text = "";
            idc = 70012;
            x = 0.519796 * safezoneW + safezoneX;
            y = 0.5700 * safezoneH + safezoneY;
            w = 0.159596 * safezoneW;
            h = 0.0308 * safezoneH;
            colorBackground[] = {0,0,0,0};
            class Attributes
            {
                font = "PuristaMedium";
                color = "#627057";
                align = "left";
                valign = "middle";
                shadow = true;
                shadowColor = "#000000";
                size = 0.8;
            };
        };

        class C2Tablet_payloadSize : C2Tablet_RscText
        {
            text = "";
            idc = 70023;
            x = 0.519796 * safezoneW + safezoneX;
            y = 0.5850 * safezoneH + safezoneY;
            w = 0.159596 * safezoneW;
            h = 0.0308 * safezoneH;
            colorBackground[] = {0,0,0,0};
            class Attributes
            {
                font = "PuristaMedium";
                color = "#627057";
                align = "left";
                valign = "middle";
                shadow = true;
                shadowColor = "#000000";
                size = 0.8;
            };
        };

        class C2Tablet_payloadGroups : C2Tablet_RscText
        {
            text = "";
            idc = 70013;
            x = 0.519796 * safezoneW + safezoneX;
            y = 0.6000 * safezoneH + safezoneY;
            w = 0.159596 * safezoneW;
            h = 0.0308 * safezoneH;
            colorBackground[] = {0,0,0,0};
            class Attributes
            {
                font = "PuristaMedium";
                color = "#627057";
                align = "left";
                valign = "middle";
                shadow = true;
                shadowColor = "#000000";
                size = 0.8;
            };
        };

        class C2Tablet_payloadVehicles : C2Tablet_RscText
        {
            text = "";
            idc = 70014;
            x = 0.519796 * safezoneW + safezoneX;
            y = 0.6150 * safezoneH + safezoneY;
            w = 0.159596 * safezoneW;
            h = 0.0308 * safezoneH;
            colorBackground[] = {0,0,0,0};
            class Attributes
            {
                font = "PuristaMedium";
                color = "#627057";
                align = "left";
                valign = "middle";
                shadow = true;
                shadowColor = "#000000";
                size = 0.8;
            };
        };

        class C2Tablet_payloadIndividuals : C2Tablet_RscText
        {
            text = "";
            idc = 70015;
            x = 0.519796 * safezoneW + safezoneX;
            y = 0.6300 * safezoneH + safezoneY;
            w = 0.159596 * safezoneW;
            h = 0.0308 * safezoneH;
            colorBackground[] = {0,0,0,0};
            class Attributes
            {
                font = "PuristaMedium";
                color = "#627057";
                align = "left";
                valign = "middle";
                shadow = true;
                shadowColor = "#000000";
                size = 0.8;
            };
        };

        class C2Tablet_payloadStatus : C2Tablet_RscText
        {
            text = "";
            idc = 70016;
            x = 0.519796 * safezoneW + safezoneX;
            y = 0.6500 * safezoneH + safezoneY;
            w = 0.159596 * safezoneW;
            h = 0.0308 * safezoneH;
            colorBackground[] = {0,0,0,0};
            class Attributes
            {
                font = "PuristaMedium";
                color = "#627057";
                align = "left";
                valign = "middle";
                shadow = true;
                shadowColor = "#000000";
                size = 0.8;
            };
        };

        class C2Tablet_deliveryTitle : C2Tablet_RscText
        {
            idc = 70017;
            text = "Delivery Type";
            x = 0.271203 * safezoneW + safezoneX;
            y = 0.1430 * safezoneH + safezoneY;
            w = 0.159596 * safezoneW;
            h = 0.0308 * safezoneH;
            colorBackground[] = {0,0,0,0};
            class Attributes
            {
                font = "PuristaMedium";
                color = "#627057";
                align = "left";
                valign = "middle";
                shadow = true;
                shadowColor = "#000000";
                size = 0.8;
            };
        };

        class C2Tablet_deliveryList : C2Tablet_RscGUIListBox
        {
            idc = 70005;
            x = 0.271102 * safezoneW + safezoneX;
            y = 0.1600 * safezoneH + safezoneY;
            w = 0.241271 * safezoneW;
            h = 0.06 * safezoneH;
            colorBackground[] = {0.173,0.173,0.173,1};
            colorActive[] = {0.384,0.439,0.341,1};
            sizeEx = (safeZoneW / 75) + (safeZoneH / 275);
            rowHeight = (safeZoneW / 75) + (safeZoneH / 275);
        };

        class C2Tablet_supplyTitle : C2Tablet_RscText
        {
            idc = 70018;
            text = "Supply List";
            x = 0.271203 * safezoneW + safezoneX;
            y = 0.2230 * safezoneH + safezoneY;
            w = 0.159596 * safezoneW;
            h = 0.0308 * safezoneH;
            colorBackground[] = {0,0,0,0};
            class Attributes
            {
                font = "PuristaMedium";
                color = "#627057";
                align = "left";
                valign = "middle";
                shadow = true;
                shadowColor = "#000000";
                size = 0.8;
            };
        };

        class C2Tablet_supplyList : C2Tablet_RscGUIListBox
        {
            idc = 70006;
            x = 0.271102 * safezoneW + safezoneX;
            y = 0.2400 * safezoneH + safezoneY;
            w = 0.241271 * safezoneW;
            h = 0.13 * safezoneH;
            colorBackground[] = {0.173,0.173,0.173,1};
            colorActive[] = {0.384,0.439,0.341,1};
            sizeEx = (safeZoneW / 75) + (safeZoneH / 275);
            rowHeight = (safeZoneW / 75) + (safeZoneH / 275);
        };

        class C2Tablet_reinforceTitle : C2Tablet_RscText
        {
            idc = 70019;
            text = "Reinforce List";
            x = 0.271203 * safezoneW + safezoneX;
            y = 0.3730 * safezoneH + safezoneY;
            w = 0.159596 * safezoneW;
            h = 0.0308 * safezoneH;
            colorBackground[] = {0,0,0,0};
            class Attributes
            {
                font = "PuristaMedium";
                color = "#627057";
                align = "left";
                valign = "middle";
                shadow = true;
                shadowColor = "#000000";
                size = 0.8;
            };
        };

        class C2Tablet_reinforceList : C2Tablet_RscGUIListBox
        {
            idc = 70007;
            x = 0.271102 * safezoneW + safezoneX;
            y = 0.3892 * safezoneH + safezoneY;
            w = 0.241271 * safezoneW;
            h = 0.13 * safezoneH;
            colorBackground[] = {0.173,0.173,0.173,1};
            colorActive[] = {0.384,0.439,0.341,1};
            sizeEx = (safeZoneW / 75) + (safeZoneH / 275);
            rowHeight = (safeZoneW / 75) + (safeZoneH / 275);
        };

        class C2Tablet_selectedTitle : C2Tablet_RscText
        {
            idc = 70020;
            text = "Payload";
            x = 0.271203 * safezoneW + safezoneX;
            y = 0.5230 * safezoneH + safezoneY;
            w = 0.159596 * safezoneW;
            h = 0.0308 * safezoneH;
            colorBackground[] = {0,0,0,0};
            class Attributes
            {
                font = "PuristaMedium";
                color = "#627057";
                align = "left";
                valign = "middle";
                shadow = true;
                shadowColor = "#000000";
                size = 0.8;
            };
        };

        class C2Tablet_selectedList : C2Tablet_RscGUIListBox
        {
            idc = 70008;
            x = 0.271102 * safezoneW + safezoneX;
            y = 0.5400 * safezoneH + safezoneY;
            w = 0.241271 * safezoneW;
            h = 0.1 * safezoneH;
            colorBackground[] = {0.173,0.173,0.173,1};
            colorActive[] = {0.384,0.439,0.341,1};
            sizeEx = (safeZoneW / 75) + (safeZoneH / 275);
            rowHeight = (safeZoneW / 75) + (safeZoneH / 275);
        };

        class C2Tablet_selectedInfo : C2Tablet_RscText
        {
            text = "";
            idc = 70009;
            x = 0.271203 * safezoneW + safezoneX;
            y = 0.6730 * safezoneH + safezoneY;
            w = 0.241271 * safezoneW;
            h = 0.0308 * safezoneH;
            colorBackground[] = {0,0,0,0};
            class Attributes
            {
                font = "PuristaMedium";
                color = "#627057";
                align = "left";
                valign = "middle";
                shadow = true;
                shadowColor = "#000000";
                size = 0.8;
            };
        };

        class C2Tablet_selectedDelete : C2Tablet_RscButton
        {
            idc = 70010;
            x = 0.271203 * safezoneW + safezoneX;
            y = 0.6400 * safezoneH + safezoneY;
            w = 0.241271 * safezoneW;
            h = 0.028 * safezoneH;
            text = "Delete";
            sizeEx = 0.8 * GUI_GRID_H;
            colorBackground[] = {0.384,0.439,0.341,1};
            colorBackgroundFocused[] = {0.706,0.706,0.706,1};
            colorFocused[] = {0.706,0.706,0.706,1};
        };

        class C2Tablet_selectedOptionList : C2Tablet_RscGUIListBox
        {
            idc = 70011;
            x = 0.271102 * safezoneW + safezoneX;
            y = 0.6900 * safezoneH + safezoneY;
            w = 0.241271 * safezoneW;
            h = 0.06 * safezoneH;
            colorBackground[] = {0.173,0.173,0.173,1};
            colorActive[] = {0.384,0.439,0.341,1};
            sizeEx = (safeZoneW / 75) + (safeZoneH / 275);
            rowHeight = (safeZoneW / 75) + (safeZoneH / 275);
        };

        class C2Tablet_requestedStatusTitle : C2Tablet_RscText
        {
            text = "";
            idc = 70021;
            x = 0.271203 * safezoneW + safezoneX;
            y = 0.2000 * safezoneH + safezoneY;
            w = 0.159596 * safezoneW;
            h = 0.0308 * safezoneH;
            colorBackground[] = {0,0,0,0};
            class Attributes
            {
                font = "PuristaMedium";
                color = "#627057";
                align = "left";
                valign = "middle";
                shadow = true;
                shadowColor = "#000000";
                size = 0.8;
            };
        };

        class C2Tablet_requestedStatus : C2Tablet_RscText
        {
            text = "";
            idc = 70022;
            x = 0.271102 * safezoneW + safezoneX;
            y = 0.2200 * safezoneH + safezoneY;
            w = 0.241271 * safezoneW;
            h = 0.2 * safezoneH;
            style = 528;
            colorBackground[] = {0,0,0,0};
            class Attributes
            {
                font = "PuristaMedium";
                color = "#a6a6a6";
                align = "left";
                valign = "middle";
                shadow = true;
                shadowColor = "#000000";
                size = 0.8;
            };
        };
        */

    };
};