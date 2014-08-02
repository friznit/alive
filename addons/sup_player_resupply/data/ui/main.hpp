#include "common.hpp"

// GUI editor: configfile >> "PRTablet"

class PRTablet
{
    idd = 60001;
    onLoad = "[] call ALIVE_fnc_PRTabletOnLoad;";
    onUnload = "[] call ALIVE_fnc_PRTabletOnUnLoad;";

    class controls
    {

        class PRTablet_background : RscPicture
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

        class PRTablet_map : PRTablet_RscMap
        {
            idc = 60002;
            x = 0.519796 * safezoneW + safezoneX;
            y = 0.1584 * safezoneH + safezoneY;
            w = 0.216525 * safezoneW;
            h = 0.4 * safezoneH;
        };

        class PRTablet_request : PRTablet_RscButton
        {
            idc = 60003;
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

        class PRTablet_abort : PRTablet_RscButton
        {
            idc = 60004;
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


        class PRTablet_payloadWeight : PRTablet_RscText
        {
            idc = 60012;
            text = "";
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

        class PRTablet_payloadGroups : PRTablet_RscText
        {
            idc = 60013;
            text = "";
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

        class PRTablet_payloadVehicles : PRTablet_RscText
        {
            idc = 60014;
            text = "";
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

        class PRTablet_payloadIndividuals : PRTablet_RscText
        {
            idc = 60015;
            text = "";
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

        class PRTablet_payloadStatus : PRTablet_RscText
        {
            idc = 60016;
            text = "";
            x = 0.519796 * safezoneW + safezoneX;
            y = 0.6450 * safezoneH + safezoneY;
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

        class PRTablet_deliveryTitle : PRTablet_RscText
        {
            idc = -1;
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

        class PRTablet_deliveryList : PRTablet_RscGUIListBox
        {
            idc = 60005;
            x = 0.271102 * safezoneW + safezoneX;
            y = 0.1600 * safezoneH + safezoneY;
            w = 0.241271 * safezoneW;
            h = 0.06 * safezoneH;
            colorBackground[] = {0.173,0.173,0.173,1};
            colorActive[] = {0.384,0.439,0.341,1};
            sizeEx = (safeZoneW / 75) + (safeZoneH / 275);
            rowHeight = (safeZoneW / 75) + (safeZoneH / 275);
        };

        class PRTablet_supplyTitle : PRTablet_RscText
        {
            idc = -1;
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

        class PRTablet_supplyList : PRTablet_RscGUIListBox
        {
            idc = 60006;
            x = 0.271102 * safezoneW + safezoneX;
            y = 0.2400 * safezoneH + safezoneY;
            w = 0.241271 * safezoneW;
            h = 0.13 * safezoneH;
            colorBackground[] = {0.173,0.173,0.173,1};
            colorActive[] = {0.384,0.439,0.341,1};
            sizeEx = (safeZoneW / 75) + (safeZoneH / 275);
            rowHeight = (safeZoneW / 75) + (safeZoneH / 275);
        };

        class PRTablet_reinforceTitle : PRTablet_RscText
        {
            idc = -1;
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

        class PRTablet_reinforceList : PRTablet_RscGUIListBox
        {
            idc = 60007;
            x = 0.271102 * safezoneW + safezoneX;
            y = 0.3892 * safezoneH + safezoneY;
            w = 0.241271 * safezoneW;
            h = 0.13 * safezoneH;
            colorBackground[] = {0.173,0.173,0.173,1};
            colorActive[] = {0.384,0.439,0.341,1};
            sizeEx = (safeZoneW / 75) + (safeZoneH / 275);
            rowHeight = (safeZoneW / 75) + (safeZoneH / 275);
        };

        class PRTablet_selectedTitle : PRTablet_RscText
        {
            idc = -1;
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

        class PRTablet_selectedList : PRTablet_RscGUIListBox
        {
            idc = 60008;
            x = 0.271102 * safezoneW + safezoneX;
            y = 0.5400 * safezoneH + safezoneY;
            w = 0.241271 * safezoneW;
            h = 0.1 * safezoneH;
            colorBackground[] = {0.173,0.173,0.173,1};
            colorActive[] = {0.384,0.439,0.341,1};
            sizeEx = (safeZoneW / 75) + (safeZoneH / 275);
            rowHeight = (safeZoneW / 75) + (safeZoneH / 275);
        };

        class PRTablet_selectedInfo : PRTablet_RscText
        {
            idc = 60009;
            text = ""
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

        class PRTablet_selectedDelete : PRTablet_RscButton
        {
            idc = 60010;
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

        class PRTablet_selectedOptionList : PRTablet_RscGUIListBox
        {
            idc = 60011;
            x = 0.271102 * safezoneW + safezoneX;
            y = 0.6900 * safezoneH + safezoneY;
            w = 0.241271 * safezoneW;
            h = 0.06 * safezoneH;
            colorBackground[] = {0.173,0.173,0.173,1};
            colorActive[] = {0.384,0.439,0.341,1};
            sizeEx = (safeZoneW / 75) + (safeZoneH / 275);
            rowHeight = (safeZoneW / 75) + (safeZoneH / 275);
        };

    };
};