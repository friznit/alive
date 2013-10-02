class CfgVehicles {
        class ModuleAliveSystemBase;
        class ADDON : ModuleAliveSystemBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_PROFILE_SYSTEM";
                function = "ALIVE_fnc_profileSystemInit";
				functionPriority = 0;
                isGlobal = 1;
				icon = "x\alive\addons\sys_profile\icon_sys_profile.paa";
				picture = "x\alive\addons\sys_profile\icon_sys_profile.paa";
                class Arguments
                {
                        class debug
                        {
                                displayName = "$STR_ALIVE_PROFILE_SYSTEM_DEBUG";
                                description = "$STR_ALIVE_PROFILE_SYSTEM_DEBUG_COMMENT";
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
						class plotSectors
                        {
                                displayName = "$STR_ALIVE_PROFILE_SYSTEM_PLOT_SECTORS";
                                description = "$STR_ALIVE_PROFILE_SYSTEM_PLOT_SECTORS_COMMENT";
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
						class syncronised
                        {
                                displayName = "$STR_ALIVE_PROFILE_SYSTEM_SYNC";
                                description = "$STR_ALIVE_PROFILE_SYSTEM_SYNC_COMMENT";
                                class Values
                                {
                                        class Add
                                        {
                                                name = "$STR_ALIVE_PROFILE_SYSTEM_SYNC_ADD";
                                                value = "ADD";
                                        };
                                        class Ignore
                                        {
                                                name = "$STR_ALIVE_PROFILE_SYSTEM_SYNC_IGNORE";
                                                value = "IGNORE";
                                        };
										class None
                                        {
                                                name = "$STR_ALIVE_PROFILE_SYSTEM_SYNC_NONE";
                                                value = "NONE";
												default = true;
                                        };
                                };
                        };
						 class spawnRadius
                        {
                                displayName = "$STR_ALIVE_PROFILE_SYSTEM_SPAWN_RADIUS";
                                description = "$STR_ALIVE_PROFILE_SYSTEM_SPAWN_RADIUS_COMMENT";
								defaultvalue = "1500";
                        };
                };
                
        };
};