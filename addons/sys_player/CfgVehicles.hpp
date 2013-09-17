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
                                displayName = "$STR_ALIVE_player_ALLOWRESET";
                                description = "$STR_ALIVE_player_ALLOWRESET_COMMENT";
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
                        class allowDiffClass
                        {
                                displayName = "$STR_ALIVE_player_ALLOWDIFFCLASS";
                                description = "$STR_ALIVE_player_ALLOWDIFFCLASS_COMMENT";
                                class Values
                                {
                                        class Yes
                                        {
                                                name = "Yes";
                                                value = 1;
                                        };
                                        class No
                                        {
                                                name = "No";
                                                value = 0;
						default = 0;
                                        };
                                };
                        };                        
                        class allowManualSave
                        {
                                displayName = "$STR_ALIVE_player_ALLOWMANUALSAVE";
                                description = "$STR_ALIVE_player_ALLOWMANUALSAVE_COMMENT";
                                class Values
                                {
                                        class Yes
                                        {
                                                name = "Yes";
                                                value = 1;
                                        };
                                        class No
                                        {
                                                name = "No";
                                                value = 0;
						default = 1;
                                        };
                                };
                        };
                        class autoSaveTime
                        {
                                displayName = "$STR_ALIVE_player_AUTOSAVETIME";
                                description = "$STR_ALIVE_player_AUTOSAVETIME_COMMENT";
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
                                        };
                                        class No
                                        {
                                                name = "No";
                                                value = false;
                                                default = false;
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
                                                default = true;
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
                                                default = true;
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
                                                default = true;
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
                                displayName = "$STR_ALIVE_player_STORETODB";
                                description = "$STR_ALIVE_player_STORETODB_COMMENT";
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
