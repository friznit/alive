class CfgVehicles {
        class ModuleAliveSystemBase;
        class ADDON : ModuleAliveSystemBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_CQB";
                function = "ALIVE_fnc_CQBInit";
                isGlobal = 1;
                isPersistent = 1;
				icon = "x\alive\addons\nme_CQB\icon_nme_CQB.paa";
				picture = "x\alive\addons\nme_CQB\icon_nme_CQB.paa";
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
                                                default = false;
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
                };
                
        };
};
