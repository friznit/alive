class cfgFunctions {
	class PREFIX {
		class COMPONENT {
			class getObjectsByType {
				description = "Returns objects by their P3D name for the entire map";
				file = "\x\alive\addons\fnc_strategic\fnc_getObjectsByType.sqf";
				recompile = RECOMPILE;
			};
			class getNearestObjectInArray {
				description = "Returns the nearest object to the given object from a list of objects";
				file = "\x\alive\addons\fnc_strategic\fnc_getNearestObjectInArray.sqf";
				recompile = RECOMPILE;
			};
			class getNearestClusterInArray {
				description = "Returns the nearest cluster to the given cluster from a list of clusters";
				file = "\x\alive\addons\fnc_strategic\fnc_getNearestClusterInArray.sqf";
				recompile = RECOMPILE;
			};
			class findClusterCenter {
				description = "Return the centre position of an object cluster";
                file = "\x\alive\addons\fnc_strategic\fnc_findClusterCenter.sqf";
				recompile = RECOMPILE;
			};
			class consolidateClusters {
				description = "Merge cluster objects if they are within close proximity";
                file = "\x\alive\addons\fnc_strategic\fnc_consolidateClusters.sqf";
				recompile = RECOMPILE;
			};
			class findClusters {
				description = "Returns a list of object clusters";
                file = "\x\alive\addons\fnc_strategic\fnc_findClusters.sqf";
				recompile = RECOMPILE;
			};
			class getEnterableHouses {
				description = "Returns an array of all enterable Houses in a given radius";
                file = "\x\alive\addons\fnc_strategic\fnc_getEnterableHouses.sqf";
				recompile = RECOMPILE;
			};
			class getAllEnterableHouses {
				description = "Returns an array of all enterable Houses on the map";
                file = "\x\alive\addons\fnc_strategic\fnc_getAllEnterableHouses.sqf";
				recompile = RECOMPILE;
			};
			class findNearHousePositions {
				description = "Provide a list of house positions in the area";
                file = "\x\alive\addons\fnc_strategic\fnc_findNearHousePositions.sqf";
				recompile = RECOMPILE;
			};
			class findIndoorHousePositions {
				description = "Provide a list of indoor house positions in the area";
                file = "\x\alive\addons\fnc_strategic\fnc_findIndoorHousePositions.sqf";
				recompile = RECOMPILE;
			};
			class getBuildingPositions {
				description = "Returns the building positions for a given object";
                file = "\x\alive\addons\fnc_strategic\fnc_getBuildingPositions.sqf";
				recompile = RECOMPILE;
			};
			class getMaxBuildingPositions {
				description = "Returns the total number of building positions for a given object";
                file = "\x\alive\addons\fnc_strategic\fnc_getMaxBuildingPositions.sqf";
				recompile = RECOMPILE;
			};
			class isHouseEnterable {
				description = "Returns true if the building is enterable";
                file = "\x\alive\addons\fnc_strategic\fnc_isHouseEnterable.sqf";
				recompile = RECOMPILE;
			};
			class cluster {
				description = "Builds clusters";
                file = "\x\alive\addons\fnc_strategic\fnc_cluster.sqf";
				recompile = RECOMPILE;
			};
			class findFlatArea {
				description = "Finds a flat area within a give radius";
				file = "\x\alive\addons\fnc_strategic\fnc_findFlatArea.sqf";
				recompile = RECOMPILE;
			};
			class findObjectID {
				description = "Returns the Visitor object ID of a map placed object";
				file = "\x\alive\addons\fnc_strategic\fnc_findObjectID.sqf";
				recompile = RECOMPILE;
			};
			class findObjectIDString {
				description = "Returns the Visitor object ID of a map placed object in string format";
				file = "\x\alive\addons\fnc_strategic\fnc_findObjectIDString.sqf";
				recompile = RECOMPILE;
			};
			class validateLocations {
				description = "Ensure locations are in or out of a markers area";
				file = "\x\alive\addons\fnc_strategic\fnc_validateLocations.sqf";
				recompile = RECOMPILE;
			};
			class findTargets {
				description = "Identify targets within the TAOR";
				file = "\x\alive\addons\fnc_strategic\fnc_findTargets.sqf";
				recompile = RECOMPILE;
			};
			class setTargets {
				description = "Set basic params on clusters";
				file = "\x\alive\addons\fnc_strategic\fnc_setTargets.sqf";
				recompile = RECOMPILE;
			};
			class clustersInsideMarker {
				description = "Return list of clusters inside a marker";
				file = "\x\alive\addons\fnc_strategic\fnc_clustersInsideMarker.sqf";
				recompile = RECOMPILE;
			};
			class clustersOutsideMarker {
				description = "Return list of clusters outside a marker";
				file = "\x\alive\addons\fnc_strategic\fnc_clustersOutsideMarker.sqf";
				recompile = RECOMPILE;
			};
			class staticClusterOutput {
				description = "Returns clusters in string format for static file storage";
				file = "\x\alive\addons\fnc_strategic\fnc_staticClusterOutput.sqf";
				recompile = RECOMPILE;
			};
			class copyClusters {
				description = "Duplicate an array of clusters";
				file = "\x\alive\addons\fnc_strategic\fnc_copyClusters.sqf";
				recompile = RECOMPILE;
			};
			class findHQ {
				description = "Identify potential HQ locations within a radius";
				file = "\x\alive\addons\fnc_strategic\fnc_findHQ.sqf";
				recompile = RECOMPILE;
			};
			class generateParkingPositions {
				description = "Generate parking positions for cluster nodes";
				file = "\x\alive\addons\fnc_strategic\fnc_generateParkingPositions.sqf";
				recompile = RECOMPILE;
			};
			class generateParkingPosition {
				description = "Generate parking position for building";
				file = "\x\alive\addons\fnc_strategic\fnc_generateParkingPosition.sqf";
				recompile = RECOMPILE;
			};
			class getParkingPosition {
				description = "Gets a parking position for a building";
				file = "\x\alive\addons\fnc_strategic\fnc_getParkingPosition.sqf";
				recompile = RECOMPILE;
			};
			class findBuildingsInClusterNodes {
				description = "Find building names in cluster nodes";
				file = "\x\alive\addons\fnc_strategic\fnc_findBuildingsInClusterNodes.sqf";
				recompile = RECOMPILE;
			};
			class GetNearestAirportID {
				description = "Gets the ID of nearest Airport, to be used with landAt";
				file = "\x\alive\addons\fnc_strategic\fnc_GetNearestAirportID.sqf";
				recompile = RECOMPILE;
			};
		};
	};
};
