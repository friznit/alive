class CfgVehicles {
        class ModuleAliveMilitaryBase;
        class ADDON : ModuleAliveMilitaryBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_CQB";
                function = "ALIVE_fnc_CQBInit";
                author = MODULE_AUTHOR;
                functionPriority = 8;
                isGlobal = 2;
				icon = "x\alive\addons\mil_cqb\icon_mil_cqb.paa";
				picture = "x\alive\addons\mil_cqb\icon_mil_cqb.paa";
                class Arguments
                {
                        class CQB_debug_setting
                        {
                                displayName = "$STR_ALIVE_CQB_DEBUG";
                                description = "$STR_ALIVE_CQB_DEBUG_COMMENT";
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
                        class CQB_persistent
                        {
                                displayName = "$STR_ALIVE_CQB_PERSISTENT";
                                description = "$STR_ALIVE_CQB_PERSISTENT_COMMENT";
                                
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
                        class CQB_locality_setting
                        {
                                displayName = "$STR_ALIVE_CQB_LOCALITY";
                                description = "$STR_ALIVE_CQB_LOCALITY_COMMENT";
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
                        class CQB_LOCATIONTYPE
                        {
                                displayName = "$STR_ALIVE_CQB_LOCATIONTYPE";
                                description = "$STR_ALIVE_CQB_LOCATIONTYPE_COMMENT";
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
                        class CQB_spawn_setting
                        {
                                displayName = "$STR_ALIVE_CQB_SPAWN";
                                description = "$STR_ALIVE_CQB_SPAWN_COMMENT";
                                class Values
                                {
                                        class CQB_spawn_2
                                        {
                                                name = "2%";
                                                value = 0.02;
                                                default = 1;
												
                                        };                                
                                        class CQB_spawn_5
                                        {
                                                name = "5%";
                                                value = 0.05;
												
                                        };
                                        class CQB_spawn_10
                                        {
                                                name = "10%";
                                                value = 0.10;
												
                                        };
                                        class CQB_spawn_20
                                        {
                                                name = "20%";
                                                value = 0.20;
                                                
                                        };
                                        class CQB_spawn_30
                                        {
                                                name = "30%";
                                                value = 0.30;
                                                
                                        };
                                        class CQB_spawn_40
                                        {
                                                name = "40%";
                                                value = 0.40;
                                                
                                        };
                                        class CQB_spawn_50
                                        {
                                                name = "50%";
                                                value = 0.50;
                                                
                                        };
                                };
                        };
                        class CQB_DENSITY
                        {
                                displayName = "$STR_ALIVE_CQB_DENSITY";
                                description = "$STR_ALIVE_CQB_DENSITY_COMMENT";
                                class Values
                                {
                                        class CQB_DENSITY_0
                                        {
                                                name = "off";
                                                value = 99999;
                                                default = 1;
                                        };
                                        class CQB_DENSITY_2
                                        {
                                                name = "very high";
                                                value = 300;
                                                
                                        };                                
                                        class CQB_DENSITY_5
                                        {
                                                name = "high";
                                                value = 700;
                                        };
                                        class CQB_DENSITY_10
                                        {
                                                name = "medium";
                                                value = 1000;
                                        };
                                        class CQB_DENSITY_20
                                        {
                                                name = "low";
                                                value = 2000;
                                                
                                        };
                                };
                        };
                        class CQB_UseDominantFaction
                        {
                                displayName = "$STR_ALIVE_CQB_USEDOMINANTFACTION";
                                description = "$STR_ALIVE_CQB_USEDOMINANTFACTION_COMMENT";
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
                        class CQB_spawndistance
                        {
                                displayName = "$STR_ALIVE_CQB_SPAWNDISTANCE";
                                description = "$STR_ALIVE_CQB_SPAWNDISTANCE_COMMENT";
                                defaultValue = 700;
                        };
                        class CQB_spawndistanceHeli
                        {
                                displayName = "$STR_ALIVE_CQB_SPAWNDISTANCEHELI";
                                description = "$STR_ALIVE_CQB_SPAWNDISTANCEHELI_COMMENT";
                                defaultValue = 0;
                        };
                        class CQB_spawndistanceJet
                        {
                                displayName = "$STR_ALIVE_CQB_SPAWNDISTANCEJET";
                                description = "$STR_ALIVE_CQB_SPAWNDISTANCEJET_COMMENT";
                                defaultValue = 0;
                        };
                        class CQB_FACTIONS_STRAT
                        {
                                displayName = "$STR_ALIVE_CQB_FACTIONS_STRAT";
                                description = "$STR_ALIVE_CQB_FACTIONS_STRAT_COMMENT";
                                defaultValue = "OPF_F";
                        };
                        class CQB_FACTIONS_REG
                        {
                                displayName = "$STR_ALIVE_CQB_FACTIONS_REG";
                                description = "$STR_ALIVE_CQB_FACTIONS_REG_COMMENT";
                                defaultValue = "OPF_F";
                        };
                        class whitelist
                        {
                                displayName = "$STR_ALIVE_CQB_WHITELIST";
                                description = "$STR_ALIVE_CQB_WHITELIST_COMMENT";
                                defaultValue = "";
                        };                        
                        class blacklist
                        {
                                displayName = "$STR_ALIVE_CQB_BLACKLIST";
                                description = "$STR_ALIVE_CQB_BLACKLIST_COMMENT";
                                defaultValue = "";
                        };
                };
                class ModuleDescription
				{
					//description = "$STR_ALIVE_CQB_COMMENT"; // Short description, will be formatted as structured text
					description[] = {
							"$STR_ALIVE_CQB_COMMENT",
							"",
							"$STR_ALIVE_CQB_USAGE"
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
