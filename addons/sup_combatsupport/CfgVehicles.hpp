class CfgVehicles {
        class ModuleAliveSupportBase;
        class ADDON : ModuleAliveSupportBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_COMBATSUPPORT";
                function = "ALIVE_fnc_CombatSupportInit";
                isGlobal = 1;
                isPersistent = 1;
                icon = "x\alive\addons\sys_newsfeed\icon_sys_newsfeed.paa";
                picture = "x\alive\addons\sys_newsfeed\icon_sys_newsfeed.paa";
                 class Arguments
                {
                        class combatsupport_item
                        {
                                displayName = "$STR_ALIVE_CS_ALLOW";
                                description = "$STR_ALIVE_CS_ALLOW_COMMENT";
                                defaultValue = "LaserDesignator";
                        };
                };
                
        };

};
