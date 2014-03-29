class cfgFunctions {
	class PREFIX {
		class COMPONENT {
			class baseClass {
				description = "Base class";
				file = "\x\alive\addons\main\fnc_baseClass.sqf";
				recompile = RECOMPILE;
			};
			class baseClassHash {
				description = "Base class Has";
				file = "\x\alive\addons\main\fnc_baseClassHash.sqf";
				recompile = RECOMPILE;
			};
			class buttonAbort {
				description = "Calls any scripts required when the user disconnects";
				file = "\x\alive\addons\main\fnc_buttonAbort.sqf";
				recompile = RECOMPILE;
			};
			class isHC {
				description = "Initialises isHC to indicate a player is a headless client.";
				file = "\x\alive\addons\main\fnc_isHC.sqf";
				recompile = RECOMPILE;
			};
			class isServerAdmin {
				description = "Checks if a player is currently logged in as server admin.";
				file = "\x\alive\addons\main\fnc_isServerAdmin.sqf";
				recompile = RECOMPILE;
			};
			class logger {
				description = "Logs to RPT.";
				file = "\x\alive\addons\main\fnc_logger.sqf";
				recompile = RECOMPILE;
			};
			class aliveInit {
				description = "ALiVE init function";
				file = "\x\alive\addons\main\fnc_aliveInit.sqf";
				recompile = RECOMPILE;
			};
			class isAbleToHost {
				description = "Checks if a player shall host AI.";
				file = "\x\alive\addons\main\fnc_isAbleToHost.sqf";
				recompile = RECOMPILE;
			};
			class anyAutonomousInRange {
				description = "Checks if UAVs/UGVs are in range.";
				file = "\x\alive\addons\main\fnc_anyAutonomousInRange.sqf";
				recompile = RECOMPILE;
			};
			class anyPlayersInRange {
				description = "Checks if players are in range.";
				file = "\x\alive\addons\main\fnc_anyPlayersInRange.sqf";
				recompile = RECOMPILE;
			};
			class anyPlayersInRangeExcludeAir {
				description = "Checks if players are in range, excludes players in air units";
				file = "\x\alive\addons\main\fnc_anyPlayersInRangeExcludeAir.sqf";
				recompile = RECOMPILE;
			};
			class anyPlayersInRangeIncludeAir {
                description = "Checks if players are in range, includes players in air units";
                file = "\x\alive\addons\main\fnc_anyPlayersInRangeIncludeAir.sqf";
                recompile = RECOMPILE;
            };
			class chooseRandomUnits {
				description = "Selects random unittypes of certain factions.";
				file = "\x\alive\addons\main\fnc_chooseRandomUnits.sqf";
				recompile = RECOMPILE;
			};
			class findVehicleType {
				description = "Selects vehicletypes of certain factions.";
				file = "\x\alive\addons\main\fnc_findVehicleType.sqf";
				recompile = RECOMPILE;
			};
			class createLink {
				description = "Used for debugging and drawing lines between two objects on the map";
				file = "\x\alive\addons\main\fnc_createLink.sqf";
				recompile = RECOMPILE;
			};
			class deleteLink {
				description = "Used for removing debugging lines between two objects on the map";
				file = "\x\alive\addons\main\fnc_deleteLink.sqf";
				recompile = RECOMPILE;
			};
			class BUS {
				description = "ALiVE Service Bus";
				file = "\x\alive\addons\main\fnc_bus.sqf";
				recompile = RECOMPILE;
			};
			class markerExists {
				description = "Checks if there is the marker given on map";
				file = "\x\alive\addons\main\fnc_MarkerExists.sqf";
				recompile = RECOMPILE;
			};
			class OOsimpleOperation {
				description = "Provides simple set/get code for objects";
				file = "\x\alive\addons\main\fnc_OOsimpleOperation.sqf";
				recompile = RECOMPILE;
			};
			class hashCreate {
				description = "Wrapper for CBA hash create";
				file = "\x\alive\addons\main\fnc_hashCreate.sqf";
				recompile = RECOMPILE;
			};
			class hashGet {
				description = "Wrapper for CBA hash get";
				file = "\x\alive\addons\main\fnc_hashGet.sqf";
				recompile = RECOMPILE;
			};
			class hashSet {
				description = "Wrapper for CBA hash set";
				file = "\x\alive\addons\main\fnc_hashSet.sqf";
				recompile = RECOMPILE;
			};
			class hashRem {
				description = "Wrapper for CBA hash remove";
				file = "\x\alive\addons\main\fnc_hashRem.sqf";
				recompile = RECOMPILE;
			};
			class hashCopy {
                description = "Duplicates a hash";
                file = "\x\alive\addons\main\fnc_hashCopy.sqf";
                recompile = RECOMPILE;
            };
			class sendHint {
				description = "Displays a hint message on screen";
				file = "\x\alive\addons\main\fnc_sendHint.sqf";
				recompile = RECOMPILE;
			};
			class Nuke {
				description = "Fires a Nuke at given position";
				file = "\x\alive\addons\main\fnc_Nuke.sqf";
				recompile = RECOMPILE;
			};
			class getDominantFaction {
				description = "Gets the dominant faction in given radius";
				file = "\x\alive\addons\main\fnc_getDominantFaction.sqf";
				recompile = RECOMPILE;
			};
			class isModuleSynced {
				description = "Checks if modules are synced";
				file = "\x\alive\addons\main\fnc_isModuleSynced.sqf";
				recompile = RECOMPILE;
			};
			class isModuleAvailable {
				description = "Checks if modules are available";
				file = "\x\alive\addons\main\fnc_isModuleAvailable.sqf";
				recompile = RECOMPILE;
			};
			class versioning {
				description = "Warns or kicks players on version mismatch";
				file = "\x\alive\addons\main\fnc_versioning.sqf";
				recompile = RECOMPILE;
			};
			class getRandomPositionLand {
                description = "Get a random position on land";
                file = "\x\alive\addons\main\fnc_getRandomPositionLand.sqf";
                recompile = RECOMPILE;
            };
			class getEnvironment {
                description = "Sets and gets current environment";
                file = "\x\alive\addons\main\fnc_getEnvironment.sqf";
                recompile = RECOMPILE;
            };
            class getRandomPlayerNear {
                description = "Gets a random nearby player";
                file = "\x\alive\addons\main\fnc_getRandomPlayerNear.sqf";
                recompile = RECOMPILE;
            };
            class getRandomManNear {
                description = "Gets a random nearby man";
                file = "\x\alive\addons\main\fnc_getRandomManNear.sqf";
                recompile = RECOMPILE;
            };
            class getRandomManOrPlayerNear {
                description = "Gets a random nearby player or man";
                file = "\x\alive\addons\main\fnc_getRandomManOrPlayerNear.sqf";
                recompile = RECOMPILE;
            };
            class addToEnemyGroup {
                description = "Adds a unit to an enemy group of a target";
                file = "\x\alive\addons\main\fnc_addToEnemyGroup.sqf";
                recompile = RECOMPILE;
            };
			class randomGroup {
                description = "Spawns a random group";
                file = "\x\alive\addons\main\fnc_randomGroup.sqf";
				recompile = RECOMPILE;
			};
			class randomGroupByType {
                description = "Random group by type (fallback for non configs)";
                file = "\x\alive\addons\main\fnc_randomGroupbyType.sqf";
				recompile = RECOMPILE;
			};
			class selectRandom {
                description = "Selects randomly on bias";
                file = "\x\alive\addons\main\fnc_selectRandom.sqf";
				recompile = RECOMPILE;
			};
			class isModuleInitialised {
                description = "Checks if given modules are initialised";
                file = "\x\alive\addons\main\fnc_isModuleInitialised.sqf";
				recompile = RECOMPILE;
			};
			class pauseModule {
                description = "Pauses given module(s)";
                file = "\x\alive\addons\main\fnc_pauseModule.sqf";
				recompile = RECOMPILE;
			};
			class unPauseModule {
                description = "activates given module(s) after pausing";
                file = "\x\alive\addons\main\fnc_unPauseModule.sqf";
				recompile = RECOMPILE;
			};
			/* Enable when ZEUS is stable
			class ZEUSinit {
				description = "Initialises Zeus for ALiVE";
				file = "\x\alive\addons\main\fnc_ZEUSinit.sqf";
				recompile = RECOMPILE;
			};
			*/
		};
	};
};
