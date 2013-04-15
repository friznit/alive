class CfgVehicles {
        class ModuleAliveSystemBase;
        class ADDON : ModuleAliveSystemBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_ADMINACTIONS";
                function = "ALIVE_fnc_adminActionsInit";
                isGlobal = 1;
                isPersistent = 1;
		icon = "x\alive\addons\sys_adminactions\icon_sys_adminactions.paa";
		picture = "x\alive\addons\sys_adminactions\icon_sys_adminactions.paa";
                class Arguments
                {
                        class ghost
                        {
                                displayName = "$STR_ALIVE_ADMINACTIONS_GHOST";
                                description = "$STR_ALIVE_ADMINACTIONS_GHOST_COMMENT";
                                class Values
                                {
                                        class Yes
                                        {
                                                name = "Yes";
                                                value = 1;
                                                default = 1;
                                        };
                                        class No
                                        {
                                                name = "No";
                                                value = 0;
                                        };
                                };
                        };
                        class teleport
                        {
                                displayName = "$STR_ALIVE_ADMINACTIONS_TELEPORT";
                                description = "$STR_ALIVE_ADMINACTIONS_TELEPORT_COMMENT";
                                class Values
                                {
                                        class Yes
                                        {
                                                name = "Yes";
                                                value = 1;
                                                default = 1;
                                        };
                                        class No
                                        {
                                                name = "No";
                                                value = 0;
                                        };
                                };
                        };
                        class mark_units
                        {
                                displayName = "$STR_ALIVE_ADMINACTIONS_MARK_UNITS";
                                description = "$STR_ALIVE_ADMINACTIONS_MARK_UNITS_COMMENT";
                                class Values
                                {
                                        class Yes
                                        {
                                                name = "Yes";
                                                value = 1;
                                                default = 1;
                                        };
                                        class No
                                        {
                                                name = "No";
                                                value = 0;
                                        };
                                };
                        };
                        class console
                        {
                                displayName = "$STR_ALIVE_ADMINACTIONS_CONSOLE";
                                description = "$STR_ALIVE_ADMINACTIONS_CONSOLE_COMMENT";
                                class Values
                                {
                                        class Yes
                                        {
                                                name = "Yes";
                                                value = 1;
                                                default = 1;
                                        };
                                        class No
                                        {
                                                name = "No";
                                                value = 0;
                                        };
                                };
                        };
                };
                
        };
};
