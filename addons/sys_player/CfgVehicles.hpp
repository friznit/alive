class CfgVehicles {
        class ModuleAliveSystemBase;
        class ADDON : ModuleAliveSystemBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_player";
                function = "ALIVE_fnc_playerInit";
                isGlobal = 1;
                isPersistent = 1;
		icon = "x\alive\addons\sys_player\icon_sys_player.paa";
		picture = "x\alive\addons\sys_player\icon_sys_player.paa";
                class Arguments
                {
                        class key
                        {
                                displayName = "$STR_ALIVE_player_KEY";
                                description = "$STR_ALIVE_player_KEY_COMMENT";
				defaultValue = "";
                        };                
                        class allowReset
                        {
                                displayName = "$STR_ALIVE_player_allowReset";
                                description = "$STR_ALIVE_player_allowReset_COMMENT";
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
                        class allowDiffClass
                        {
                                displayName = "$STR_ALIVE_player_allowDiffClass";
                                description = "$STR_ALIVE_player_allowDiffClass_COMMENT";
                                class Values
                                {
                                        class Yes
                                        {
                                                name = "Yes";
                                                value = true;
                                        };
                                        class No
                                        {
                                                name = "No";
                                                value = false;
                                                default = 1;
                                        };
                                };
                        };                        
                        class allowManualSave
                        {
                                displayName = "$STR_ALIVE_player_allowManualSave";
                                description = "$STR_ALIVE_player_allowManualSave_COMMENT";
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
                        class autoSaveTime
                        {
                                displayName = "$STR_ALIVE_player_autoSaveTime";
                                description = "$STR_ALIVE_player_autoSaveTime_COMMENT";
				defaultValue = "0";
                        };

                        class saveLoadout
                        {
                                displayName = "$STR_ALIVE_player_SAVELOADOUT";
                                description = "$STR_ALIVE_player_SAVELOADOUT_COMMENT";
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
                        class saveAmmo
                        {
                                displayName = "$STR_ALIVE_player_SAVEAMMO";
                                description = "$STR_ALIVE_player_SAVEAMMO_COMMENT";
                                class Values
                                {
                                        class Yes
                                        {
                                                name = "Yes";
                                                value = true;
                                        };
                                        class No
                                        {
                                                name = "No";
                                                value = false;
                                                default = 1;
                                        };
                                };
                        };
                        class saveHealth
                        {
                                displayName = "$STR_ALIVE_player_SAVEHEALTH";
                                description = "$STR_ALIVE_player_SAVEHEALTH_COMMENT";
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
                        class savePosition
                        {
                                displayName = "$STR_ALIVE_player_SAVEPOSITION";
                                description = "$STR_ALIVE_player_SAVEPOSITION_COMMENT";
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
                        class saveScores
                        {
                                displayName = "$STR_ALIVE_player_SAVESCORES";
                                description = "$STR_ALIVE_player_SAVESCORES_COMMENT";
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
                        class storeToDB
                        {
                                displayName = "$STR_ALIVE_player_storeToDB";
                                description = "$STR_ALIVE_player_storeToDB_COMMENT";
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
                };
                
        };
};
