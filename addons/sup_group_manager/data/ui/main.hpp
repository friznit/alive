#include "common.hpp"

// GUI editor: configfile >> "GMTablet"

class GMTablet
{
    idd = 11001;
    movingEnable = true;
    onLoad = "[] call ALIVE_fnc_GMTabletOnLoad;";
    onUnload = "[] call ALIVE_fnc_GMTabletOnUnLoad;";

    class controlsBackground {
        class GMTablet_background : RscPicture
        {
            idc = -1;
            x = 0.142424 * safezoneW + safezoneX;
            y = 0.0632 * safezoneH + safezoneY;
            w = 0.73 * safezoneW;
            h = 0.84 * safezoneH;
            text = "x\alive\addons\sup_group_manager\data\ui\ALIVE_toughbook_2.paa";
            moving = 0;
            colorBackground[] = {0,0,0,0};
        };
    };

    class controls
    {

        class GMTablet_mainTitle : GMTablet_RscText
        {
            idc = 11007;
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

        class GMTablet_subMenuBackButton : GMTablet_RscButton
        {
            idc = 11006;
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

        class GMTablet_subMenuAbortButton : GMTablet_RscButton
        {
            idc = 11010;
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

        class GMTablet_mainList : GMTablet_RscListNBox
        {
            idc = 11011;
            text = "";
            x = 0.271102 * safezoneW + safezoneX;
            y = 0.1600 * safezoneH + safezoneY;
            w = 0.465 * safezoneW;
            h = 0.35 * safezoneH;
            colorBackground[] = {0.173,0.173,0.173,1};
            color[] = {0.8,0.8,0.8,1};
            colorActive[] = {0.384,0.439,0.341,1};
            sizeEx = (safeZoneW / 75) + (safeZoneH / 275);
            rowHeight = (safeZoneW / 75) + (safeZoneH / 275);
            columns[] = {0,0.2,0.7,0.9};
            drawSideArrows = false;
            idcLeft = -1;
            idcRight = -1;
        };

        class GMTablet_leftList : GMTablet_RscListNBox
        {
            idc = 11012;
            text = "";
            x = 0.271102 * safezoneW + safezoneX;
            y = 0.1600 * safezoneH + safezoneY;
            w = 0.2325 * safezoneW;
            h = 0.35 * safezoneH;
            colorBackground[] = {0.173,0.173,0.173,1};
            color[] = {0.8,0.8,0.8,1};
            colorActive[] = {0.384,0.439,0.341,1};
            sizeEx = (safeZoneW / 75) + (safeZoneH / 275);
            rowHeight = (safeZoneW / 75) + (safeZoneH / 275);
            columns[] = {0,0.2,0.6,0.8};
            drawSideArrows = false;
            idcLeft = -1;
            idcRight = -1;
        };

        class GMTablet_rightList : GMTablet_RscListNBox
        {
            idc = 11013;
            text = "";
            x = 0.5 * safezoneW + safezoneX;
            y = 0.1600 * safezoneH + safezoneY;
            w = 0.2325 * safezoneW;
            h = 0.35 * safezoneH;
            colorBackground[] = {0.173,0.173,0.173,1};
            color[] = {0.8,0.8,0.8,1};
            colorActive[] = {0.384,0.439,0.341,1};
            sizeEx = (safeZoneW / 75) + (safeZoneH / 275);
            rowHeight = (safeZoneW / 75) + (safeZoneH / 275);
            columns[] = {0,0.2,0.5,0.7};
            drawSideArrows = false;
            idcLeft = -1;
            idcRight = -1;
        };

        class GMTablet_1ButtonL : GMTablet_RscButton
        {
            idc = 11014;
            x = 0.271203 * safezoneW + safezoneX;
            y = 0.5150 * safezoneH + safezoneY;
            w = 0.2325 * safezoneW;
            h = 0.028 * safezoneH;
            text = "Button1";
            sizeEx = 0.8 * GUI_GRID_H;
            colorBackground[] = {0.384,0.439,0.341,1};
            colorBackgroundFocused[] = {0.706,0.706,0.706,1};
            colorFocused[] = {0.706,0.706,0.706,1};
        };

        class GMTablet_2ButtonL : GMTablet_RscButton
        {
            idc = 11015;
            x = 0.271203 * safezoneW + safezoneX;
            y = 0.5480 * safezoneH + safezoneY;
            w = 0.2325 * safezoneW;
            h = 0.028 * safezoneH;
            text = "Button2";
            sizeEx = 0.8 * GUI_GRID_H;
            colorBackground[] = {0.384,0.439,0.341,1};
            colorBackgroundFocused[] = {0.706,0.706,0.706,1};
            colorFocused[] = {0.706,0.706,0.706,1};
        };

        class GMTablet_3ButtonL : GMTablet_RscButton
        {
            idc = 11016;
            x = 0.271203 * safezoneW + safezoneX;
            y = 0.5820 * safezoneH + safezoneY;
            w = 0.2325 * safezoneW;
            h = 0.028 * safezoneH;
            text = "Button3";
            sizeEx = 0.8 * GUI_GRID_H;
            colorBackground[] = {0.384,0.439,0.341,1};
            colorBackgroundFocused[] = {0.706,0.706,0.706,1};
            colorFocused[] = {0.706,0.706,0.706,1};
        };

        class GMTablet_1ButtonR : GMTablet_RscButton
        {
            idc = 11017;
            x = 0.507 * safezoneW + safezoneX;
            y = 0.5150 * safezoneH + safezoneY;
            w = 0.2325 * safezoneW;
            h = 0.028 * safezoneH;
            text = "Button1";
            sizeEx = 0.8 * GUI_GRID_H;
            colorBackground[] = {0.384,0.439,0.341,1};
            colorBackgroundFocused[] = {0.706,0.706,0.706,1};
            colorFocused[] = {0.706,0.706,0.706,1};
        };

        class GMTablet_2ButtonR : GMTablet_RscButton
        {
            idc = 11018;
            x = 0.507 * safezoneW + safezoneX;
            y = 0.5480 * safezoneH + safezoneY;
            w = 0.2325 * safezoneW;
            h = 0.028 * safezoneH;
            text = "Button2";
            sizeEx = 0.8 * GUI_GRID_H;
            colorBackground[] = {0.384,0.439,0.341,1};
            colorBackgroundFocused[] = {0.706,0.706,0.706,1};
            colorFocused[] = {0.706,0.706,0.706,1};
        };

        class GMTablet_3ButtonR : GMTablet_RscButton
        {
            idc = 11019;
            x = 0.507 * safezoneW + safezoneX;
            y = 0.5820 * safezoneH + safezoneY;
            w = 0.2325 * safezoneW;
            h = 0.028 * safezoneH;
            text = "Button3";
            sizeEx = 0.8 * GUI_GRID_H;
            colorBackground[] = {0.384,0.439,0.341,1};
            colorBackgroundFocused[] = {0.706,0.706,0.706,1};
            colorFocused[] = {0.706,0.706,0.706,1};
        };

        /*
        class GMTablet_currentTaskList : GMTablet_RscGUIListBox
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

        class GMTablet_createTaskButton : GMTablet_RscButton
        {
            idc = 11016;
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

        class GMTablet_generateTaskButton : GMTablet_RscButton
        {
            idc = 11038;
            x = 0.271203 * safezoneW + safezoneX;
            y = 0.5480 * safezoneH + safezoneY;
            w = 0.465 * safezoneW;
            h = 0.028 * safezoneH;
            text = "Generate a task";
            sizeEx = 0.8 * GUI_GRID_H;
            colorBackground[] = {0.384,0.439,0.341,1};
            colorBackgroundFocused[] = {0.706,0.706,0.706,1};
            colorFocused[] = {0.706,0.706,0.706,1};
        };

        class GMTablet_autoGenerateTaskButton : GMTablet_RscButton
        {
            idc = 11048;
            x = 0.271203 * safezoneW + safezoneX;
            y = 0.5820 * safezoneH + safezoneY;
            w = 0.465 * safezoneW;
            h = 0.028 * safezoneH;
            text = "Auto generate tasks for my side";
            sizeEx = 0.8 * GUI_GRID_H;
            colorBackground[] = {0.384,0.439,0.341,1};
            colorBackgroundFocused[] = {0.706,0.706,0.706,1};
            colorFocused[] = {0.706,0.706,0.706,1};
        };

        class GMTablet_taskingCurrentTaskListEditButton : GMTablet_RscButton
        {
            idc = 11026;
            text = "Edit Task";
            style = 0x02;
            x = 0.271102 * safezoneW + safezoneX;
            y = 0.6160 * safezoneH + safezoneY;
            w = 0.465 * safezoneW;
            h = 0.028 * safezoneH;
            sizeEx = 0.8 * GUI_GRID_H;
            colorBackground[] = {0.384,0.439,0.341,1};
            colorBackgroundFocused[] = {0.706,0.706,0.706,1};
            colorFocused[] = {0.706,0.706,0.706,1};
        };

        class GMTablet_taskingCurrentTaskListDeleteButton : GMTablet_RscButton
        {
            idc = 11027;
            text = "Delete Task";
            style = 0x02;
            x = 0.271102 * safezoneW + safezoneX;
            y = 0.6500 * safezoneH + safezoneY;
            w = 0.465 * safezoneW;
            h = 0.028 * safezoneH;
            sizeEx = 0.8 * GUI_GRID_H;
            colorBackground[] = {0.376,0.196,0.204,1};
            colorText[] = {0.706,0.706,0.706,1};
            colorBackgroundFocused[] = {0.706,0.706,0.706,1};
            colorFocused[] = {0.706,0.706,0.706,1};
        };

        class GMTablet_taskPlayerList : GMTablet_RscGUIListBox
        {
            idc = 11011;
            x = 0.271102 * safezoneW + safezoneX;
            y = 0.1600 * safezoneH + safezoneY;
            w = 0.465 * safezoneW;
            h = 0.13 * safezoneH;
            colorBackground[] = {0.173,0.173,0.173,1};
            colorActive[] = {0.384,0.439,0.341,1};
            sizeEx = (safeZoneW / 75) + (safeZoneH / 275);
            rowHeight = (safeZoneW / 75) + (safeZoneH / 275);
        };

        class GMTablet_taskSelectGroupButton : GMTablet_RscButton
        {
            idc = 11014;
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

        class GMTablet_taskSelectedPlayerTitle : GMTablet_RscText
        {
            idc = 11012;
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

        class GMTablet_taskSelectedPlayerList : GMTablet_RscGUIListBox
        {
            idc = 11013;
            x = 0.271102 * safezoneW + safezoneX;
            y = 0.3460 * safezoneH + safezoneY;
            w = 0.465 * safezoneW;
            h = 0.13 * safezoneH;
            colorBackground[] = {0.173,0.173,0.173,1};
            colorActive[] = {0.384,0.439,0.341,1};
            sizeEx = (safeZoneW / 75) + (safeZoneH / 275);
            rowHeight = (safeZoneW / 75) + (safeZoneH / 275);
        };

        class GMTablet_taskSelectedPlayerListDeleteButton : GMTablet_RscButton
        {
            idc = 11015;
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

        class GMTablet_taskSelectedPlayersClearButton : GMTablet_RscButton
        {
            idc = 11029;
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

        class GMTablet_taskingAddTaskTitleEditTitle : GMTablet_RscText
        {
            idc = 11018;
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

        class GMTablet_taskingAddTaskTitleEdit : GMTablet_RscEdit
        {
            idc = 11019;
            x = 0.271102 * safezoneW + safezoneX;
            y = 0.1770 * safezoneH + safezoneY;
            w = 0.241271 * safezoneW;
            h = 0.028 * safezoneH;
        };

        class GMTablet_taskingAddTaskDescriptionEditTitle : GMTablet_RscText
        {
            idc = 11020;
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

        class GMTablet_taskingAddTaskDescriptionEdit : GMTablet_RscEdit
        {
            idc = 11021;
            x = 0.271102 * safezoneW + safezoneX;
            y = 0.2270 * safezoneH + safezoneY;
            w = 0.241271 * safezoneW;
            h = 0.13 * safezoneH;
            style = 16;
        };

        class GMTablet_taskingAddTaskStateEditTitle : GMTablet_RscText
        {
            idc = 11030;
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

        class GMTablet_taskingAddTaskStateEditList : GMTablet_RscGUIListBox
        {
            idc = 11031;
            x = 0.271102 * safezoneW + safezoneX;
            y = 0.3770 * safezoneH + safezoneY;
            w = 0.241271 * safezoneW;
            h = 0.1 * safezoneH;
            colorBackground[] = {0.173,0.173,0.173,1};
            colorActive[] = {0.384,0.439,0.341,1};
            sizeEx = (safeZoneW / 75) + (safeZoneH / 275);
            rowHeight = (safeZoneW / 75) + (safeZoneH / 275);
        };

        class GMTablet_taskingMap : GMTablet_RscMap
        {
            idc = 11022;
            x = 0.519796 * safezoneW + safezoneX;
            y = 0.1584 * safezoneH + safezoneY;
            w = 0.216525 * safezoneW;
            h = 0.4 * safezoneH;
        };

        class GMTablet_taskingAddTaskCreateButton : GMTablet_RscButton
        {
            idc = 11023;
            text = "Create Task";
            style = 0x02;
            x = 0.519796 * safezoneW + safezoneX;
            y = 0.6650 * safezoneH + safezoneY;
            w = 0.216525 * safezoneW;
            h = 0.028 * safezoneH;
            sizeEx = 0.8 * GUI_GRID_H;
            colorBackground[] = {0.384,0.439,0.341,1};
            colorBackgroundFocused[] = {0.706,0.706,0.706,1};
            colorFocused[] = {0.706,0.706,0.706,1};
        };

        class GMTablet_taskingEditTaskUpdateButton : GMTablet_RscButton
        {
            idc = 11028;
            text = "Update Task";
            style = 0x02;
            x = 0.519796 * safezoneW + safezoneX;
            y = 0.6650 * safezoneH + safezoneY;
            w = 0.216525 * safezoneW;
            h = 0.028 * safezoneH;
            sizeEx = 0.8 * GUI_GRID_H;
            colorBackground[] = {0.384,0.439,0.341,1};
            colorBackgroundFocused[] = {0.706,0.706,0.706,1};
            colorFocused[] = {0.706,0.706,0.706,1};
        };

        class GMTablet_taskingEditTaskManagePlayersButton : GMTablet_RscButton
        {
            idc = 11032;
            text = "Assign Players";
            style = 0x02;
            x = 0.519796 * safezoneW + safezoneX;
            y = 0.6300 * safezoneH + safezoneY;
            w = 0.216525 * safezoneW;
            h = 0.028 * safezoneH;
            sizeEx = 0.8 * GUI_GRID_H;
            colorBackground[] = {0.384,0.439,0.341,1};
            colorBackgroundFocused[] = {0.706,0.706,0.706,1};
            colorFocused[] = {0.706,0.706,0.706,1};
        };

        class GMTablet_taskingAddTaskApplyEditTitle : GMTablet_RscText
        {
            idc = 11033;
            text = "Applied to players";
            x = 0.271203 * safezoneW + safezoneX;
            y = 0.4800 * safezoneH + safezoneY;
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

        class GMTablet_taskingAddTaskApplyEditList : GMTablet_RscGUIListBox
        {
            idc = 11034;
            x = 0.271102 * safezoneW + safezoneX;
            y = 0.4970 * safezoneH + safezoneY;
            w = 0.241271 * safezoneW;
            h = 0.06 * safezoneH;
            colorBackground[] = {0.173,0.173,0.173,1};
            colorActive[] = {0.384,0.439,0.341,1};
            sizeEx = (safeZoneW / 75) + (safeZoneH / 275);
            rowHeight = (safeZoneW / 75) + (safeZoneH / 275);
        };

        class GMTablet_taskingAddTaskSetCurrent : GMTablet_RscText
        {
            idc = 11035;
            text = "Set Current";
            x = 0.271203 * safezoneW + safezoneX;
            y = 0.5600 * safezoneH + safezoneY;
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

        class GMTablet_taskingAddTaskSetCurrentList : GMTablet_RscGUIListBox
        {
            idc = 11036;
            x = 0.271102 * safezoneW + safezoneX;
            y = 0.5770 * safezoneH + safezoneY;
            w = 0.241271 * safezoneW;
            h = 0.04 * safezoneH;
            colorBackground[] = {0.173,0.173,0.173,1};
            colorActive[] = {0.384,0.439,0.341,1};
            sizeEx = (safeZoneW / 75) + (safeZoneH / 275);
            rowHeight = (safeZoneW / 75) + (safeZoneH / 275);
        };

        class GMTablet_taskingAddTaskStatus : GMTablet_RscText
        {
            idc = 11037;
            text = "STATUS";
            x = 0.519796 * safezoneW + safezoneX;
            y = 0.5800 * safezoneH + safezoneY;
            w = 0.216525 * safezoneW;
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

        class GMTablet_taskingAddTaskSelectParent : GMTablet_RscText
        {
            idc = 11039;
            text = "Select Parent Task";
            x = 0.271203 * safezoneW + safezoneX;
            y = 0.6250 * safezoneH + safezoneY;
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

        class GMTablet_taskingCurrentParentTaskList : GMTablet_RscGUIListBox
        {
            idc = 11040;
            x = 0.271102 * safezoneW + safezoneX;
            y = 0.6420 * safezoneH + safezoneY;
            w = 0.241271 * safezoneW;
            h = 0.11 * safezoneH;
            colorBackground[] = {0.173,0.173,0.173,1};
            colorActive[] = {0.384,0.439,0.341,1};
            sizeEx = (safeZoneW / 75) + (safeZoneH / 275);
            rowHeight = (safeZoneW / 75) + (safeZoneH / 275);
        };

        class GMTablet_taskingGenerateTaskTypeEditTitle : GMTablet_RscText
        {
            idc = 11041;
            text = "Task Type";
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

        class GMTablet_taskingGenerateTaskTypeEdit : GMTablet_RscGUIListBox
        {
            idc = 11042;
            x = 0.271102 * safezoneW + safezoneX;
            y = 0.1770 * safezoneH + safezoneY;
            w = 0.241271 * safezoneW;
            h = 0.11 * safezoneH;
            colorBackground[] = {0.173,0.173,0.173,1};
            colorActive[] = {0.384,0.439,0.341,1};
            sizeEx = (safeZoneW / 75) + (safeZoneH / 275);
            rowHeight = (safeZoneW / 75) + (safeZoneH / 275);
        };

        class GMTablet_taskingGenerateTaskCreateButton : GMTablet_RscButton
        {
            idc = 11043;
            text = "Generate Task";
            style = 0x02;
            x = 0.519796 * safezoneW + safezoneX;
            y = 0.6650 * safezoneH + safezoneY;
            w = 0.216525 * safezoneW;
            h = 0.028 * safezoneH;
            sizeEx = 0.8 * GUI_GRID_H;
            colorBackground[] = {0.384,0.439,0.341,1};
            colorBackgroundFocused[] = {0.706,0.706,0.706,1};
            colorFocused[] = {0.706,0.706,0.706,1};
        };

        class GMTablet_taskingGenerateTaskLocationEditTitle : GMTablet_RscText
        {
            idc = 11044;
            text = "Task Location";
            x = 0.271203 * safezoneW + safezoneX;
            y = 0.2900 * safezoneH + safezoneY;
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

        class GMTablet_taskingGenerateTaskLocationEdit : GMTablet_RscGUIListBox
        {
            idc = 11045;
            x = 0.271102 * safezoneW + safezoneX;
            y = 0.3070 * safezoneH + safezoneY;
            w = 0.241271 * safezoneW;
            h = 0.08 * safezoneH;
            colorBackground[] = {0.173,0.173,0.173,1};
            colorActive[] = {0.384,0.439,0.341,1};
            sizeEx = (safeZoneW / 75) + (safeZoneH / 275);
            rowHeight = (safeZoneW / 75) + (safeZoneH / 275);
        };

        class GMTablet_taskingGenerateTaskFactionEditTitle : GMTablet_RscText
        {
            idc = 11046;
            text = "Task Enemy Faction";
            x = 0.271203 * safezoneW + safezoneX;
            y = 0.3900 * safezoneH + safezoneY;
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

        class GMTablet_taskingGenerateTaskFactionEdit : GMTablet_RscGUIListBox
        {
            idc = 11047;
            x = 0.271102 * safezoneW + safezoneX;
            y = 0.4070 * safezoneH + safezoneY;
            w = 0.241271 * safezoneW;
            h = 0.12 * safezoneH;
            colorBackground[] = {0.173,0.173,0.173,1};
            colorActive[] = {0.384,0.439,0.341,1};
            sizeEx = (safeZoneW / 75) + (safeZoneH / 275);
            rowHeight = (safeZoneW / 75) + (safeZoneH / 275);
        };

        class GMTablet_taskingAutoGenerateTaskFactionEditTitle : GMTablet_RscText
        {
            idc = 11049;
            text = "Task Enemy Faction";
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

        class GMTablet_taskingAutoGenerateTaskFactionEdit : GMTablet_RscGUIListBox
        {
            idc = 11050;
            x = 0.271102 * safezoneW + safezoneX;
            y = 0.1770 * safezoneH + safezoneY;
            w = 0.241271 * safezoneW;
            h = 0.2 * safezoneH;
            colorBackground[] = {0.173,0.173,0.173,1};
            colorActive[] = {0.384,0.439,0.341,1};
            sizeEx = (safeZoneW / 75) + (safeZoneH / 275);
            rowHeight = (safeZoneW / 75) + (safeZoneH / 275);
        };

        class GMTablet_taskingAutoGenerateTaskCreateButton : GMTablet_RscButton
        {
            idc = 11051;
            text = "Enable Auto Generated Tasks";
            style = 0x02;
            x = 0.519796 * safezoneW + safezoneX;
            y = 0.6650 * safezoneH + safezoneY;
            w = 0.216525 * safezoneW;
            h = 0.028 * safezoneH;
            sizeEx = 0.8 * GUI_GRID_H;
            colorBackground[] = {0.384,0.439,0.341,1};
            colorBackgroundFocused[] = {0.706,0.706,0.706,1};
            colorFocused[] = {0.706,0.706,0.706,1};
        };

        class GMTablet_taskingGenerateApplyEditTitle : GMTablet_RscText
        {
            idc = 11052;
            text = "Applied to players";
            x = 0.271203 * safezoneW + safezoneX;
            y = 0.5300 * safezoneH + safezoneY;
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

        class GMTablet_taskingGenerateApplyEditList : GMTablet_RscGUIListBox
        {
            idc = 11053;
            x = 0.271102 * safezoneW + safezoneX;
            y = 0.5470 * safezoneH + safezoneY;
            w = 0.241271 * safezoneW;
            h = 0.06 * safezoneH;
            colorBackground[] = {0.173,0.173,0.173,1};
            colorActive[] = {0.384,0.439,0.341,1};
            sizeEx = (safeZoneW / 75) + (safeZoneH / 275);
            rowHeight = (safeZoneW / 75) + (safeZoneH / 275);
        };

        class GMTablet_taskingGenerateSetCurrent : GMTablet_RscText
        {
            idc = 11054;
            text = "Set Current";
            x = 0.271203 * safezoneW + safezoneX;
            y = 0.6100 * safezoneH + safezoneY;
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

        class GMTablet_taskingGenerateSetCurrentList : GMTablet_RscGUIListBox
        {
            idc = 11055;
            x = 0.271102 * safezoneW + safezoneX;
            y = 0.6270 * safezoneH + safezoneY;
            w = 0.241271 * safezoneW;
            h = 0.04 * safezoneH;
            colorBackground[] = {0.173,0.173,0.173,1};
            colorActive[] = {0.384,0.439,0.341,1};
            sizeEx = (safeZoneW / 75) + (safeZoneH / 275);
            rowHeight = (safeZoneW / 75) + (safeZoneH / 275);
        };
        */

    };
};