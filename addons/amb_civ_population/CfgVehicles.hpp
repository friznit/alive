class CfgVehicles {
        class ModuleAliveAmbientBase;
                class ADDON : ModuleAliveAmbientBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_CIV_POP";
                function = "ALIVE_fnc_civilianPopulationSystemInit";
                author = MODULE_AUTHOR;
                functionPriority = 1;
                isGlobal = 1;
                isPersistent = 1;
				icon = "x\alive\addons\amb_civ_population\icon_civ_pop.paa";
				picture = "x\alive\addons\amb_civ_population\icon_civ_pop.paa";
                class Arguments
                {
                        class debug
                        {
                                displayName = "$STR_ALIVE_CIV_POP_DEBUG";
                                description = "$STR_ALIVE_CIV_POP_DEBUG_COMMENT";
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
						class spawnRadius
                        {
                                displayName = "$STR_ALIVE_CIV_POP_SPAWN_RADIUS";
                                description = "$STR_ALIVE_CIV_POP_SPAWN_RADIUS_COMMENT";
								defaultvalue = "1500";
                        };
                        class spawnTypeHeliRadius
                        {
                                displayName = "$STR_ALIVE_CIV_POP_SPAWN_HELI_RADIUS";
                                description = "$STR_ALIVE_CIV_POP_SPAWN_HELI_RADIUS_COMMENT";
                                defaultvalue = "1500";
                        };
                        class spawnTypeJetRadius
                        {
                                displayName = "$STR_ALIVE_CIV_POP_SPAWN_JET_RADIUS";
                                description = "$STR_ALIVE_CIV_POP_SPAWN_JET_RADIUS_COMMENT";
                                defaultvalue = "0";
                        };
                        class activeLimiter
                        {
                                displayName = "$STR_ALIVE_CIV_POP_ACTIVE_LIMITER";
                                description = "$STR_ALIVE_CIV_POP_ACTIVE_LIMITER_COMMENT";
                                defaultvalue = "50";
                        };
                };
                
        };
};