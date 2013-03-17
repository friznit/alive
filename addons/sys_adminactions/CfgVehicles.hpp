class CfgVehicles {
        class ModuleAliveSystemBase;
        class ADDON : ModuleAliveSystemBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_ADMINACTIONS";
                function = "ALIVE_fnc_adminActionsInit";
                isGlobal = 1;
		icon = "x\alive\addons\sys_adminactions\icon_sys_adminactions.paa";
		picture = "x\alive\addons\sys_adminactions\icon_sys_adminactions.paa";
                class Arguments
                {
                        class Ghost
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
                        class Teleport
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
                        class Spectate
                        {
                                displayName = "$STR_ALIVE_ADMINACTIONS_SPECTATE";
                                description = "$STR_ALIVE_ADMINACTIONS_SPECTATE_COMMENT";
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
                        class Camera
                        {
                                displayName = "$STR_ALIVE_ADMINACTIONS_CAMERA";
                                description = "$STR_ALIVE_ADMINACTIONS_CAMERA_COMMENT";
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
                        class Condition
                        {
                                displayName = "Condition:";
                                description = "";
                                defaultValue = "true";
                        };                        
                };
                
        };
};
