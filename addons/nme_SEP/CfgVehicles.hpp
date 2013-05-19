class CfgVehicles {
        class ModuleAliveEnemyBase;
        class ADDON : ModuleAliveEnemyBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_SEP";
                function = "ALIVE_fnc_SEPInit";
                isGlobal = 1;
                isPersistent = 1;
				icon = "x\alive\addons\nme_SEP\icon_nme_SEP.paa";
				picture = "x\alive\addons\nme_SEP\icon_nme_SEP.paa";
                class Arguments
                {
                        class SEP_debug_setting
                        {
                                displayName = "$STR_ALIVE_SEP_DEBUG";
                                description = "$STR_ALIVE_SEP_DEBUG_COMMENT";
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
                        class SEP_spawn_setting
                        {
                                displayName = "$STR_ALIVE_SEP_SPAWN";
                                description = "$STR_ALIVE_SEP_SPAWN_COMMENT";
                                class Values
                                {
                                        class SEP_spawn_10
                                        {
                                                name = "10%";
                                                value = 1;
						default = 1;
						SEP_spawn = 1;
                                        };
                                        class SEP_spawn_20
                                        {
                                                name = "20%";
                                                value = 2;
                                                SEP_spawn = 2;
                                        };
                                        class SEP_spawn_30
                                        {
                                                name = "30%";
                                                value = 3;
                                                SEP_spawn = 3;
                                        };
                                        class SEP_spawn_40
                                        {
                                                name = "40%";
                                                value = 4;
                                                SEP_spawn = 4;
                                        };
                                        class SEP_spawn_50
                                        {
                                                name = "50%";
                                                value = 5;
                                                SEP_spawn = 5;
                                        };
                                };
                        };
                };
                
        };
};
