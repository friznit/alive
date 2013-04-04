class cfgFunctions {
        class PREFIX {
                class COMPONENT {
			class baseClass {
				description = "Base class";
	                        file = "\x\alive\addons\main\fnc_baseClass.sqf";
			};
			class isHC {
				description = "Initialises isHC to indicate a player is a headless client.";
	                        file = "\x\alive\addons\main\fnc_isHC.sqf";
			};
			class isServerAdmin {
				description = "Checks if a player is currently logged in as server admin.";
	                        file = "\x\alive\addons\main\fnc_isServerAdmin.sqf";
			};
			class logger {
				description = "Logs to RPT.";
	                        file = "\x\alive\addons\main\fnc_logger.sqf";
			};
			class isAbleToHost {
				description = "Checks if a player shall host AI.";
	                        file = "\x\alive\addons\main\fnc_isAbleToHost.sqf";
			};
			class anyPlayersInRange {
				description = "Checks if players are in range.";
	                        file = "\x\alive\addons\main\fnc_anyPlayersInRange.sqf";
			};
			class chooseRandomUnits {
				description = "Selects random unittypes of certain factions.";
	                        file = "\x\alive\addons\main\fnc_chooseRandomUnits.sqf";
			};
			class findVehicleType {
				description = "Selects vehicletypes of certain factions.";
	                        file = "\x\alive\addons\main\fnc_findVehicleType.sqf";
			};
			class createLink {
				description = "Used for debugging and drawing lines between two objects on the map";
	                        file = "\x\alive\addons\main\fnc_createLink.sqf";
			};
			class deleteLink {
				description = "Used for removing debugging lines between two objects on the map";
	                        file = "\x\alive\addons\main\fnc_deleteLink.sqf";
			};
                };
        };
};
