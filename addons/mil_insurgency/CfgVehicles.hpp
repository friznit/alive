class CfgVehicles {
        class ModuleAliveBase;
        class ADDON : ModuleAliveBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_insurgency";
                function = "ALIVE_fnc_insurgencyInit";
                author = MODULE_AUTHOR;
                functionPriority = 140;
                isGlobal = 2;
                icon = "x\alive\addons\mil_insurgency\icon_mil_insurgency.paa";
                picture = "x\alive\addons\mil_insurgency\icon_mil_insurgency.paa";
                class Arguments
                {
                        class insurgency_debug_setting
                        {
                                displayName = "$STR_ALIVE_insurgency_DEBUG";
                                description = "$STR_ALIVE_insurgency_DEBUG_COMMENT";
                                class Values
                                {
                                        class Yes
                                        {
                                                name = "Yes";
                                                value = true;
                                        };
                                        class No
                                        {
                                                name = "No";
                                                value = false;
                                                default = 1;
                                        };
                                };
                        };
                        class insurgency_persistent
                        {
                                displayName = "$STR_ALIVE_insurgency_PERSISTENT";
                                description = "$STR_ALIVE_insurgency_PERSISTENT_COMMENT";

                                class Values
                                {
                                        class Yes
                                        {
                                                name = "Yes";
                                                value = true;
                                        };
                                        class No
                                        {
                                                name = "No";
                                                value = false;
                                                default = 1;
                                        };
                                };
                        };
                        class insurgency_locality_setting
                        {
                                displayName = "$STR_ALIVE_insurgency_LOCALITY";
                                description = "$STR_ALIVE_insurgency_LOCALITY_COMMENT";
                                class Values
                                {
                                        class client
                                        {
                                                name = "JIP clients";
                                                value = "client";
                                                default = 1;
                                        };
                                        class server
                                        {
                                                name = "Server";
                                                value = "server";
                                        };
                                        class headless
                                        {
                                                name = "Headless Client";
                                                value = "HC";
                                        };
                                };
                        };
                        class insurgency_TYPE
                        {
                                displayName = "$STR_ALIVE_insurgency_TYPE";
                                description = "$STR_ALIVE_insurgency_TYPE_COMMENT";
                                class Values
                                {
                                        class MIL
                                        {
                                                name = "Strategic";
                                                value = "strategic";
                                        };
                                        class CIV
                                        {
                                                name = "Civilian";
                                                value = "regular";
                                                default = 1;
                                        };
                                };
                        };
                        class insurgency_LOCATIONTYPE
                        {
                                displayName = "$STR_ALIVE_insurgency_LOCATIONTYPE";
                                description = "$STR_ALIVE_insurgency_LOCATIONTYPE_COMMENT";
                                class Values
                                {
                                        class Towns
                                        {
                                                name = "Towns";
                                                value = "towns";
                                        };
                                        class All
                                        {
                                                name = "Complete map";
                                                value = "all";
                                                default = 1;
                                        };
                                };
                        };
                        class insurgency_spawn_setting
                        {
                                displayName = "$STR_ALIVE_insurgency_SPAWN";
                                description = "$STR_ALIVE_insurgency_SPAWN_COMMENT";
                                class Values
                                {
                                        class insurgency_spawn_2
                                        {
                                                name = "2%";
                                                value = 0.02;
                                                default = 1;

                                        };
                                        class insurgency_spawn_5
                                        {
                                                name = "5%";
                                                value = 0.05;

                                        };
                                        class insurgency_spawn_10
                                        {
                                                name = "10%";
                                                value = 0.10;

                                        };
                                        class insurgency_spawn_20
                                        {
                                                name = "20%";
                                                value = 0.20;

                                        };
                                        class insurgency_spawn_30
                                        {
                                                name = "30%";
                                                value = 0.30;

                                        };
                                        class insurgency_spawn_40
                                        {
                                                name = "40%";
                                                value = 0.40;

                                        };
                                        class insurgency_spawn_50
                                        {
                                                name = "50%";
                                                value = 0.50;

                                        };
                                };
                        };
                        class insurgency_DENSITY
                        {
                                displayName = "$STR_ALIVE_insurgency_DENSITY";
                                description = "$STR_ALIVE_insurgency_DENSITY_COMMENT";
                                class Values
                                {
                                        class insurgency_DENSITY_0
                                        {
                                                name = "off";
                                                value = 99999;
                                                default = 1;
                                        };
                                        class insurgency_DENSITY_2
                                        {
                                                name = "very high";
                                                value = 300;

                                        };
                                        class insurgency_DENSITY_5
                                        {
                                                name = "high";
                                                value = 700;
                                        };
                                        class insurgency_DENSITY_10
                                        {
                                                name = "medium";
                                                value = 1000;
                                        };
                                        class insurgency_DENSITY_20
                                        {
                                                name = "low";
                                                value = 2000;

                                        };
                                };
                        };
                        class insurgency_amount
                        {
                                displayName = "$STR_ALIVE_insurgency_AMOUNT";
                                description = "$STR_ALIVE_insurgency_AMOUNT_COMMENT";
                                class Values
                                {
                                        class Solo
                                        {
                                                name = "Solo";
                                                value = 1;
                                        };
                                        class Pair
                                        {
                                                name = "Pair";
                                                value = 3;
                                                default = 1;
                                        };
                                        class Fireteam
                                        {
                                                name = "Fireteam";
                                                value = 5;
                                        };
                                };
                        };
                        class insurgency_UseDominantFaction
                        {
                                displayName = "$STR_ALIVE_insurgency_USEDOMINANTFACTION";
                                description = "$STR_ALIVE_insurgency_USEDOMINANTFACTION_COMMENT";
                                class Values
                                {
                                        class Yes
                                        {
                                                name = "Dominant";
                                                value = "true";
                                                default = 1;
                                        };
                                        class No
                                        {
                                                name = "Static";
                                                value = "false";
                                        };
                                };
                        };
                        class insurgency_spawndistance
                        {
                                displayName = "$STR_ALIVE_insurgency_SPAWNDISTANCE";
                                description = "$STR_ALIVE_insurgency_SPAWNDISTANCE_COMMENT";
                                defaultValue = 700;
                        };
                        class insurgency_spawndistanceHeli
                        {
                                displayName = "$STR_ALIVE_insurgency_SPAWNDISTANCEHELI";
                                description = "$STR_ALIVE_insurgency_SPAWNDISTANCEHELI_COMMENT";
                                defaultValue = 0;
                        };
                        class insurgency_spawndistanceJet
                        {
                                displayName = "$STR_ALIVE_insurgency_SPAWNDISTANCEJET";
                                description = "$STR_ALIVE_insurgency_SPAWNDISTANCEJET_COMMENT";
                                defaultValue = 0;
                        };
                        class insurgency_FACTIONS
                        {
                                displayName = "$STR_ALIVE_insurgency_FACTIONS";
                                description = "$STR_ALIVE_insurgency_FACTIONS_COMMENT";
                                defaultValue = "OPF_F";
                        };
                        class whitelist
                        {
                                displayName = "$STR_ALIVE_insurgency_WHITELIST";
                                description = "$STR_ALIVE_insurgency_WHITELIST_COMMENT";
                                defaultValue = "";
                        };
                        class blacklist
                        {
                                displayName = "$STR_ALIVE_insurgency_BLACKLIST";
                                description = "$STR_ALIVE_insurgency_BLACKLIST_COMMENT";
                                defaultValue = "";
                        };
                };
                class ModuleDescription
                                {
                                        //description = "$STR_ALIVE_insurgency_COMMENT"; // Short description, will be formatted as structured text
                                        description[] = {
                                                        "$STR_ALIVE_insurgency_COMMENT",
                                                        "",
                                                        "$STR_ALIVE_insurgency_USAGE"
                                        };
                                        sync[] = {"ALiVE_civ_placement","ALiVE_mil_placement"}; // Array of synced entities (can contain base classes)

                                        class ALiVE_civ_placement
                                        {
                                                description[] = { // Multi-line descriptions are supported
                                                        "$STR_ALIVE_CP_COMMENT",
                                                        "",
                                                        "$STR_ALIVE_CP_USAGE"
                                                };
                                                position = 0; // Position is taken into effect
                                                direction = 0; // Direction is taken into effect
                                                optional = 1; // Synced entity is optional
                                                duplicate = 1; // Multiple entities of this type can be synced
                                        };
                                        class ALiVE_mil_placement
                                        {
                                                description[] = { // Multi-line descriptions are supported
                                                        "$STR_ALIVE_MP_COMMENT",
                                                        "",
                                                        "$STR_ALIVE_MP_USAGE"
                                                };
                                                position = 0; // Position is taken into effect
                                                direction = 0; // Direction is taken into effect
                                                optional = 1; // Synced entity is optional
                                                duplicate = 1; // Multiple entities of this type can be synced
                                        };
                                };

        };
};
