class CfgVehicles {
        class ModuleAliveMilitaryBase;
        class ADDON : ModuleAliveMilitaryBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_CQB";
                function = "ALIVE_fnc_CQBInit";
                author = MODULE_AUTHOR;
                isGlobal = 1;
                isPersistent = 1;
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
                                                default = true;
                                        };
                                        class No
                                        {
                                                name = "No";
                                                value = false;
                                        };
                                };
                        };
                        class CQB_spawn_setting
                        {
                                displayName = "$STR_ALIVE_CQB_SPAWN";
                                description = "$STR_ALIVE_CQB_SPAWN_COMMENT";
                                class Values
                                {
                                        class CQB_spawn_5
                                        {
                                                name = "5%";
                                                value = 5;
                                                default = 5;
												CQB_spawn = 5;
                                        };
                                        class CQB_spawn_10
                                        {
                                                name = "10%";
                                                value = 10;
												CQB_spawn = 10;
                                        };
                                        class CQB_spawn_20
                                        {
                                                name = "20%";
                                                value = 20;
                                                CQB_spawn = 20;
                                        };
                                        class CQB_spawn_30
                                        {
                                                name = "30%";
                                                value = 30;
                                                CQB_spawn = 30;
                                        };
                                        class CQB_spawn_40
                                        {
                                                name = "40%";
                                                value = 40;
                                                CQB_spawn = 40;
                                        };
                                        class CQB_spawn_50
                                        {
                                                name = "50%";
                                                value = 50;
                                                CQB_spawn = 50;
                                        };
                                };
                        };
                        class CQB_FACTIONS_STRAT
                        {
                                displayName = "$STR_ALIVE_CQB_FACTIONS_STRAT";
                                description = "$STR_ALIVE_CQB_FACTIONS_STRAT_COMMENT";
                                defaultValue = ["OPF_F"];
                        };
                        class CQB_FACTIONS_REG
                        {
                                displayName = "$STR_ALIVE_CQB_FACTIONS_REG";
                                description = "$STR_ALIVE_CQB_FACTIONS_REG_COMMENT";
                                defaultValue = ["OPF_F"];
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
