class CfgVehicles {
        class ModuleAliveSystemBase;
        class ADDON : ModuleAliveSystemBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_GC";
                function = "ALIVE_fnc_GCInit";
                author = MODULE_AUTHOR;
				functionPriority = 8;
                isGlobal = 1;
                isPersistent = 1;
				icon = "x\alive\addons\sys_GC\icon_sys_GC.paa";
				picture = "x\alive\addons\sys_GC\icon_sys_GC.paa";
                class Arguments
                {
                        class debug
                        {
                                displayName = "$STR_ALIVE_GC_DEBUG";
                                description = "$STR_ALIVE_GC_DEBUG_COMMENT";
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
                        class ALiVE_GC_INTERVAL
                        {
                                displayName = "$STR_ALIVE_GC_INTERVAL";
                                description = "$STR_ALIVE_GC_INTERVAL_COMMENT";
                                defaultValue = 300;
                        };
                        class ALiVE_GC_INDIVIDUALTYPES
                        {
                                displayName = "$STR_ALIVE_GC_INDIVIDUALTYPES";
                                description = "$STR_ALIVE_GC_INDIVIDUALTYPES_COMMENT";
                                defaultValue = [];
                        };
                 };
                
        };
};
