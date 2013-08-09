class CfgVehicles {
        class ModuleAliveSystemBase;
        class ADDON : ModuleAliveSystemBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_PROFILE_SYSTEM";
                function = "ALIVE_fnc_profileSystemInit";
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
                };
                
        };
};