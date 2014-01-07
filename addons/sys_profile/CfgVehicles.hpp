class CfgVehicles {
        class ModuleAliveSystemBase;
        class ADDON : ModuleAliveSystemBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_PROFILE_SYSTEM";
                function = "ALIVE_fnc_profileSystemInit";
                author = MODULE_AUTHOR;
                functionPriority = 0;
                isGlobal = 1;
                isPersistent = 1;
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
                                };
                        };
						class spawnRadius
                        {
                                displayName = "$STR_ALIVE_PROFILE_SYSTEM_SPAWN_RADIUS";
                                description = "$STR_ALIVE_PROFILE_SYSTEM_SPAWN_RADIUS_COMMENT";
								defaultvalue = "1500";
                        };
                        class spawnTypeJet
                        {
                                displayName = "$STR_ALIVE_PROFILE_SYSTEM_SPAWN_JET";
                                description = "$STR_ALIVE_PROFILE_SYSTEM_SPAWN_JET_COMMENT";
                                class Values
                                {
                                        class Yes
                                        {
                                                name = "$STR_ALIVE_PROFILE_SYSTEM_SPAWN_JET_YES";
                                                value = true;
                                        };
                                        class No
                                        {
                                                name = "$STR_ALIVE_PROFILE_SYSTEM_SPAWN_JET_NO";
                                                value = false;
                                                default = true;
                                        };
                                };
                        };
                        class spawnTypeJetRadius
                        {
                                displayName = "$STR_ALIVE_PROFILE_SYSTEM_SPAWN_JET_RADIUS";
                                description = "$STR_ALIVE_PROFILE_SYSTEM_SPAWN_JET_RADIUS_COMMENT";
                                defaultvalue = "2000";
                        };
                        class spawnTypeHeli
                        {
                                displayName = "$STR_ALIVE_PROFILE_SYSTEM_SPAWN_HELI";
                                description = "$STR_ALIVE_PROFILE_SYSTEM_SPAWN_HELI_COMMENT";
                                class Values
                                {
                                        class Yes
                                        {
                                                name = "$STR_ALIVE_PROFILE_SYSTEM_SPAWN_HELI_YES";
                                                value = true;
                                                default = true;
                                        };
                                        class No
                                        {
                                                name = "$STR_ALIVE_PROFILE_SYSTEM_SPAWN_HELI_NO";
                                                value = false;
                                        };
                                };
                        };
                        class spawnTypeHeliRadius
                        {
                                displayName = "$STR_ALIVE_PROFILE_SYSTEM_SPAWN_HELI_RADIUS";
                                description = "$STR_ALIVE_PROFILE_SYSTEM_SPAWN_HELI_RADIUS_COMMENT";
                                defaultvalue = "2000";
                        };
                        class activeLimiter
                        {
                                displayName = "$STR_ALIVE_PROFILE_SYSTEM_ACTIVE_LIMITER";
                                description = "$STR_ALIVE_PROFILE_SYSTEM_ACTIVE_LIMITER_COMMENT";
                                defaultvalue = "50";
                        };
                };
                
        };
};