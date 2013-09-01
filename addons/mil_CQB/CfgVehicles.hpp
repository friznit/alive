class CfgVehicles {
        class ModuleAliveEnemyBase;
        class ADDON : ModuleAliveEnemyBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_CQB";
                function = "ALIVE_fnc_CQBInit";
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
                                        class CQB_spawn_10
                                        {
                                                name = "10%";
                                                value = 1;
												default = 1;
												CQB_spawn = 1;
                                        };
                                        class CQB_spawn_20
                                        {
                                                name = "20%";
                                                value = 2;
                                                CQB_spawn = 2;
                                        };
                                        class CQB_spawn_30
                                        {
                                                name = "30%";
                                                value = 3;
                                                CQB_spawn = 3;
                                        };
                                        class CQB_spawn_40
                                        {
                                                name = "40%";
                                                value = 4;
                                                CQB_spawn = 4;
                                        };
                                        class CQB_spawn_50
                                        {
                                                name = "50%";
                                                value = 5;
                                                CQB_spawn = 5;
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
                                defaultValue = ["OPF_F","BLAH"];
                        };
                };
                
        };
};