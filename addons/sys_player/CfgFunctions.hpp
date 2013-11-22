class cfgFunctions {
        class PREFIX {
                class COMPONENT {
                        class player {
                                description = "The main class";
                                file = "\x\alive\addons\sys_player\fnc_player.sqf";
				recompile = RECOMPILE;
                        };
                        class playerInit {
                                description = "The module initialisation function";
                                file = "\x\alive\addons\sys_player\fnc_playerInit.sqf";
				recompile = RECOMPILE;
                        };
                        class playerMenuDef {
                                description = "The module menu definition";
                                file = "\x\alive\addons\sys_player\fnc_playerMenuDef.sqf";
				recompile = RECOMPILE;
                        };
                        class loadPlayers {
                                description = "Loads all player data from external db into the store";
                                file = "\x\alive\addons\sys_player\fnc_loadPlayers.sqf";
				recompile = RECOMPILE;
                        };
                        class savePlayers {
                                description = "Saves all player data from the store into the external db";
                                file = "\x\alive\addons\sys_player\fnc_savePlayers.sqf";
				recompile = RECOMPILE;
                        };
                        class getPlayer {
                                description = "Gets player data from the store and applies it to the player object";
                                file = "\x\alive\addons\sys_player\fnc_getPlayer.sqf";
				recompile = RECOMPILE;
                        };
                        class setPlayer {
                                description = "Sets player data to the store";
                                file = "\x\alive\addons\sys_player\fnc_setPlayer.sqf";
				recompile = RECOMPILE;
                        };
                        class player_OnPlayerDisconnected {
                                        description = "The module onPlayerDisconnected handler";
                                        file = "\x\alive\addons\sys_player\fnc_player_onPlayerDisconnected.sqf";
                                        recompile = RECOMPILE;
                        };
                        class player_OnPlayerConnected {
                                        description = "The module onPlayerConnected handler";
                                        file = "\x\alive\addons\sys_player\fnc_player_onPlayerConnected.sqf";
                                        recompile = RECOMPILE;
                        };                                                                        
                };
        };
};
