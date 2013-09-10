class cfgFunctions {
	class PREFIX {
		class COMPONENT {
			class getObjectsByType {
				description = "Returns objects by their P3D name for the entire map";
				file = "\x\alive\addons\fnc_strategic\fnc_getObjectsByType.sqf";
				recompile = 1;
			};
			class getNearestObjectInArray {
				description = "Returns the nearest object to the given object from a list of objects";
				file = "\x\alive\addons\fnc_strategic\fnc_getNearestObjectInArray.sqf";
				recompile = 1;
			};
			class getNearestClusterInArray {
				description = "Returns the nearest cluster to the given cluster from a list of clusters";
				file = "\x\alive\addons\fnc_strategic\fnc_getNearestClusterInArray.sqf";
				recompile = 1;
			};
			class findClusterCenter {
				description = "Return the centre position of an object cluster";
                file = "\x\alive\addons\fnc_strategic\fnc_findClusterCenter.sqf";
				recompile = 1;
			};
			class consolidateClusters {
				description = "Merge cluster objects if they are within close proximity";
                file = "\x\alive\addons\fnc_strategic\fnc_consolidateClusters.sqf";
				recompile = 1;
			};
			class findClusters {
				description = "Returns a list of object clusters";
                file = "\x\alive\addons\fnc_strategic\fnc_findClusters.sqf";
				recompile = 1;
			};
			class getEnterableHouses {
				description = "Returns an array of all enterable Houses in a given radius";
                file = "\x\alive\addons\fnc_strategic\fnc_getEnterableHouses.sqf";
				recompile = 1;
			};
			class getAllEnterableHouses {
				description = "Returns an array of all enterable Houses on the map";
                file = "\x\alive\addons\fnc_strategic\fnc_getAllEnterableHouses.sqf";
				recompile = 1;
			};
			class findNearHousePositions {
				description = "Provide a list of house positions in the area";
                file = "\x\alive\addons\fnc_strategic\fnc_findNearHousePositions.sqf";
				recompile = 1;
			};
			class findIndoorHousePositions {
				description = "Provide a list of indoor house positions in the area";
                file = "\x\alive\addons\fnc_strategic\fnc_findIndoorHousePositions.sqf";
				recompile = 1;
			};
			class getBuildingPositions {
				description = "Returns the building positions for a given object";
                file = "\x\alive\addons\fnc_strategic\fnc_getBuildingPositions.sqf";
				recompile = 1;
			};
			class getMaxBuildingPositions {
				description = "Returns the total number of building positions for a given object";
                file = "\x\alive\addons\fnc_strategic\fnc_getMaxBuildingPositions.sqf";
				recompile = 1;
			};
			class isHouseEnterable {
				description = "Returns true if the building is enterable";
                file = "\x\alive\addons\fnc_strategic\fnc_isHouseEnterable.sqf";
				recompile = 1;
			};
			class cluster {
				description = "Builds clusters";
                file = "\x\alive\addons\fnc_strategic\fnc_cluster.sqf";
				recompile = 1;
			};
			class findFlatArea {
				description = "Finds a flat area within a give radius";
				file = "\x\alive\addons\fnc_strategic\fnc_findFlatArea.sqf";
				recompile = 1;
			};
			class findObjectID {
				description = "Returns the Visitor object ID of a map placed object";
				file = "\x\alive\addons\fnc_strategic\fnc_findObjectID.sqf";
				recompile = 1;
			};
			class findObjectIDString {
				description = "Returns the Visitor object ID of a map placed object in string format";
				file = "\x\alive\addons\fnc_strategic\fnc_findObjectIDString.sqf";
				recompile = 1;
			};
			class validateLocations {
				description = "Ensure locations are in or out of a markers area";
				file = "\x\alive\addons\fnc_strategic\fnc_validateLocations.sqf";
				recompile = 1;
			};
		};
	};
};
