class CfgFunctions {
	class PREFIX {
		class COMPONENT {
			class C2ISTAR {
				description = "The main class";
				file = "\x\alive\addons\mil_C2ISTAR\fnc_C2ISTAR.sqf";
				recompile = RECOMPILE;
			};
			class C2ISTARInit {
				description = "The module initialisation function";
				file = "\x\alive\addons\mil_C2ISTAR\fnc_C2ISTARInit.sqf";
				recompile = RECOMPILE;
			};
			class C2MenuDef {
                description = "The module menu definition";
                file = "\x\alive\addons\mil_C2ISTAR\fnc_C2MenuDef.sqf";
                recompile = RECOMPILE;
            };
            class C2TabletOnAction {
                description = "The module Radio Action function";
                file = "\x\alive\addons\mil_C2ISTAR\fnc_C2TabletOnAction.sqf";
                recompile = RECOMPILE;
            };
            class C2TabletOnLoad {
                description = "The module tablet on load function";
                file = "\x\alive\addons\mil_C2ISTAR\fnc_C2TabletOnLoad.sqf";
                recompile = RECOMPILE;
            };
            class C2TabletOnUnLoad {
                description = "The module tablet on unload function";
                file = "\x\alive\addons\mil_C2ISTAR\fnc_C2TabletOnUnLoad.sqf";
                recompile = RECOMPILE;
            };
            class C2TabletEventToClient {
                description = "Call the tablet on the client from the server";
                file = "\x\alive\addons\mil_C2ISTAR\fnc_C2TabletEventToClient.sqf";
                recompile = RECOMPILE;
            };
            class C2OnPlayerConnected {
                description = "On player connected handler";
                file = "\x\alive\addons\mil_C2ISTAR\fnc_C2OnPlayerConnected.sqf";
                recompile = RECOMPILE;
            };
            class taskHandler {
                description = "Task Handler";
                file = "\x\alive\addons\mil_C2ISTAR\fnc_taskHandler.sqf";
                recompile = RECOMPILE;
            };
            class taskHandlerClient {
                description = "Task Handler Client";
                file = "\x\alive\addons\mil_C2ISTAR\fnc_taskHandlerClient.sqf";
                recompile = RECOMPILE;
            };
            class taskHandlerEventToClient {
                description = "Task Handler Event To Client";
                file = "\x\alive\addons\mil_C2ISTAR\fnc_taskHandlerEventToClient.sqf";
                recompile = RECOMPILE;
            };
            class taskGetEnemyCluster {
                description = "Utility get enemy cluster for tasks";
                file = "\x\alive\addons\mil_C2ISTAR\utils\fnc_taskGetEnemyCluster.sqf";
                recompile = RECOMPILE;
            };
            class taskGetEnemySectorCompositionPosition {
                description = "Utility get enemy sector for tasks";
                file = "\x\alive\addons\mil_C2ISTAR\utils\fnc_taskGetEnemySectorCompositionPosition.sqf";
                recompile = RECOMPILE;
            };
            class taskGetSectorPosition {
                description = "Utility get position based on sector data";
                file = "\x\alive\addons\mil_C2ISTAR\utils\fnc_taskGetSectorPosition.sqf";
                recompile = RECOMPILE;
            };
            class taskHavePlayersReachedDestination {
                description = "Utility check if players have reached the destination";
                file = "\x\alive\addons\mil_C2ISTAR\utils\fnc_taskHavePlayersReachedDestination.sqf";
                recompile = RECOMPILE;
            };
            class taskIsAreaClearOfEnemies {
                description = "Utility check if there are any enemies in the area";
                file = "\x\alive\addons\mil_C2ISTAR\utils\fnc_taskIsAreaClearOfEnemies.sqf";
                recompile = RECOMPILE;
            };
            class taskCreateMarkersForPlayers {
                description = "Utility mark target position on map";
                file = "\x\alive\addons\mil_C2ISTAR\utils\fnc_taskCreateMarkersForPlayers.sqf";
                recompile = RECOMPILE;
            };
            class taskCreateMarker {
                description = "Utility create a local marker";
                file = "\x\alive\addons\mil_C2ISTAR\utils\fnc_taskCreateMarker.sqf";
                recompile = RECOMPILE;
            };
            class taskDeleteMarkersForPlayers {
                description = "Utility delete any markers for players";
                file = "\x\alive\addons\mil_C2ISTAR\utils\fnc_taskDeleteMarkersForPlayers.sqf";
                recompile = RECOMPILE;
            };
            class taskDeleteMarkers {
                description = "Utility delete local markers";
                file = "\x\alive\addons\mil_C2ISTAR\utils\fnc_taskDeleteMarkers.sqf";
                recompile = RECOMPILE;
            };
            class taskCreateRadioBroadcastForPlayers {
                description = "Utility broadcast radio message for players";
                file = "\x\alive\addons\mil_C2ISTAR\utils\fnc_taskCreateRadioBroadcastForPlayers.sqf";
                recompile = RECOMPILE;
            };
            class taskMilAssault {
                description = "Task Mil Assault";
                file = "\x\alive\addons\mil_C2ISTAR\tasks\fnc_taskMilAssault.sqf";
                recompile = RECOMPILE;
            };
            class taskCivAssault {
                description = "Task Civ Assault";
                file = "\x\alive\addons\mil_C2ISTAR\tasks\fnc_taskCivAssault.sqf";
                recompile = RECOMPILE;
            };
            class taskAssassination {
                description = "Task Assassination";
                file = "\x\alive\addons\mil_C2ISTAR\tasks\fnc_taskAssassination.sqf";
                recompile = RECOMPILE;
            };
        };
	};
};
