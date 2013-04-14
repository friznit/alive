class cfgFunctions {
        class PREFIX {
                class COMPONENT {
                        class multispawn {
                                description = "The main class";
                                file = "\x\alive\addons\sup_multispawn\fnc_multispawn.sqf";
                        };
                        class multispawnInit {
                                description = "The module initialisation function";
                                file = "\x\alive\addons\sup_multispawn\fnc_multispawnInit.sqf";
                        };
                        class multispawnMenuDef {
                                description = "The module menu definition";
                                file = "\x\alive\addons\sup_multispawn\fnc_multispawnMenuDef.sqf";
                        };
                        class multispawnPlayerSetSpawn {
                                description = "The player function to update their spawn Object";
                                file = "\x\alive\addons\sup_multispawn\functions\fnc_multispawnPlayerSetSpawn.sqf";
                        };
                        class multispawnDeploy {
                                description = "The player funciton to deploy a mobile hq object";
                                file = "\x\alive\addons\sup_multispawn\functions\fnc_multispawnDeploy.sqf";
                        };
                        class multispawnUndeploy {
                                description = "The player funciton to undeploy a mobile hq object";
                                file = "\x\alive\addons\sup_multispawn\functions\fnc_multispawnUndeploy.sqf";
                        };
                        class multispawnRelocatePlayer {
                                description = "The function update a players location when they respawn";
                                file = "\x\alive\addons\sup_multispawn\functions\fnc_multispawnRelocatePlayer.sqf";
                        };
                        class multispawnMHQType {
                                description = "The function to return the matched hq object when deploying or undeploying";
                                file = "\x\alive\addons\sup_multispawn\functions\fnc_multispawnMHQType.sqf";
                        };
                        class multispawnAddAction {
                                description = "The player function to add the hq actions to the hq objects";
                                file = "\x\alive\addons\sup_multispawn\functions\fnc_multispawnAddAction.sqf";
                        };
                        class multispawnSyncState {
                                description = "The function used by client and server to handle changes to an hq objects state change";
                                file = "\x\alive\addons\sup_multispawn\functions\fnc_multispawnSyncState.sqf";
                        };
                         class multispawnConvert {
                                description = "The server function to convert hq objects from deployed to undeployed and vice versa";
                                file = "\x\alive\addons\sup_multispawn\functions\fnc_multispawnConvert.sqf";
                        };
                };
        };
};
