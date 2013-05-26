class cfgFunctions {
        class PREFIX {
                class COMPONENT {
			class baseClass {
				description = "Base class";
	                        file = "\x\alive\addons\main\fnc_baseClass.sqf";
				recompile = 1;
			};
			class isHC {
				description = "Initialises isHC to indicate a player is a headless client.";
	                        file = "\x\alive\addons\main\fnc_isHC.sqf";
				recompile = 1;
			};
			class isServerAdmin {
				description = "Checks if a player is currently logged in as server admin.";
	                        file = "\x\alive\addons\main\fnc_isServerAdmin.sqf";
				recompile = 1;
			};
			class logger {
				description = "Logs to RPT.";
	                        file = "\x\alive\addons\main\fnc_logger.sqf";
				recompile = 1;
			};
			class isAbleToHost {
				description = "Checks if a player shall host AI.";
	                        file = "\x\alive\addons\main\fnc_isAbleToHost.sqf";
				recompile = 1;
			};
			class anyPlayersInRange {
				description = "Checks if players are in range.";
	                        file = "\x\alive\addons\main\fnc_anyPlayersInRange.sqf";
				recompile = 1;
			};
			class chooseRandomUnits {
				description = "Selects random unittypes of certain factions.";
	                        file = "\x\alive\addons\main\fnc_chooseRandomUnits.sqf";
				recompile = 1;
			};
			class findVehicleType {
				description = "Selects vehicletypes of certain factions.";
	                        file = "\x\alive\addons\main\fnc_findVehicleType.sqf";
				recompile = 1;
			};
			class createLink {
				description = "Used for debugging and drawing lines between two objects on the map";
	                        file = "\x\alive\addons\main\fnc_createLink.sqf";
				recompile = 1;
			};
			class deleteLink {
				description = "Used for removing debugging lines between two objects on the map";
	                        file = "\x\alive\addons\main\fnc_deleteLink.sqf";
				recompile = 1;
			};
			class exMP {
				description = "Multi-Locality execution with network-optimized commands PublicvariableServer and PublicvariableClient";
	                        file = "\x\alive\addons\main\fnc_exMP.sqf";
				recompile = 1;
			};
			class BUS {
				description = "ALiVE Service Bus";
	                        file = "\x\alive\addons\main\fnc_bus.sqf";
				recompile = 1;
			};
			class MarkerExists {
				description = "Checks if there is the marker given on map";
	                        file = "\x\alive\addons\main\fnc_MarkerExists.sqf";
				recompile = 1;
			};
                };
        };
};
