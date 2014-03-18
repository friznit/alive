class CfgVehicles {
        class ModuleAliveSupportBase;
        class ADDON : ModuleAliveSupportBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_multispawn";
                function = "ALIVE_fnc_multispawnInit";
                author = MODULE_AUTHOR;
                functionPriority = 2;
                isGlobal = 1;
				icon = "x\alive\addons\sup_multispawn\icon_sup_multispawn.paa";
				picture = "x\alive\addons\sup_multispawn\icon_sup_multispawn.paa";
                class Arguments
                {
                        class debug
                        {
                                displayName = "$STR_ALIVE_multispawn_DEBUG";
                                description = "$STR_ALIVE_multispawn_DEBUG_COMMENT";
                                class Values
                                {
                                        class Yes
                                        {
                                                name = "Yes";
                                                value = true;
												default = 1;
                                        };
                                        class No
                                        {
                                                name = "No";
                                                value = false;
                                        };
                                };
                        };
                        class spawntype
                        {
                                displayName = "$STR_ALIVE_multispawn_TYPE";
                                description = "$STR_ALIVE_multispawn_TYPE_COMMENT";
                                class Values
                                {
                                        class forwardspawn
                                        {
                                                name = "Spawn on squad";
                                                value = "forwardspawn";
                                                default = 1;
                                        };
                                };
                        };
                        class spawningnearenemiesallowed
                        {
                                displayName = "$STR_ALIVE_multispawn_SPAWNINGNEARENEMIESALLOWED";
                                description = "$STR_ALIVE_multispawn_SPAWNINGNEARENEMIESALLOWED_COMMENT";
                                class Values
                                {
                                        class Yes
                                        {
                                                name = "No";
                                                value = false;
												default = false;
                                        };
                                        class No
                                        {
                                                name = "Yes";
                                                value = true;
                                        };
                                };
                        };                          
                };
                
        };
};
