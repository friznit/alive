class cfgFunctions {
	class PREFIX {
		class COMPONENT {
			class getObjectsByType {
				description = "Returns objects by their P3D name for the entire map";
                                file = "\x\alive\addons\fnc_strategic\fnc_getObjectsByType.sqf";
			};
			class getNearestObjectInArray {
				description = "Returns the nearest object to the given object from a list of objects";
                                file = "\x\alive\addons\fnc_strategic\fnc_getNearestObjectInArray.sqf";
			};
			class findClusterCenter {
				description = "Return the centre position of an object cluster";
                                file = "\x\alive\addons\fnc_strategic\fnc_findClusterCenter.sqf";
			};
			class consolidateClusters {
				description = "Merge cluster objects if they are within close proximity";
                                file = "\x\alive\addons\fnc_strategic\fnc_consolidateClusters.sqf";
			};
			class findClusters {
				description = "Returns a list of object clusters";
                                file = "\x\alive\addons\fnc_strategic\fnc_findClusters.sqf";
			};
			class getEnterableHouses {
				description = "Returns an array of all enterable Houses in a given radius";
                                file = "\x\alive\addons\fnc_strategic\fnc_getEnterableHouses.sqf";
			};
			class getAllEnterableHouses {
				description = "Returns an array of all enterable Houses on the map";
                                file = "\x\alive\addons\fnc_strategic\fnc_getAllEnterableHouses.sqf";
			};
			class findNearHousePositions {
				description = "Provide a list of house positions in the area";
                                file = "\x\alive\addons\fnc_strategic\fnc_findNearHousePositions.sqf";
			};
			class findIndoorHousePositions {
				description = "Provide a list of indoor house positions in the area";
                                file = "\x\alive\addons\fnc_strategic\fnc_findIndoorHousePositions.sqf";
			};
			class getBuildingPositions {
				description = "Returns the building positions for a given object";
                                file = "\x\alive\addons\fnc_strategic\fnc_getBuildingPositions.sqf";
			};
			class getMaxBuildingPositions {
				description = "Returns the total number of building positions for a given object";
                                file = "\x\alive\addons\fnc_strategic\fnc_getMaxBuildingPositions.sqf";
			};
			class isHouseEnterable {
				description = "Returns true if the building is enterable";
                                file = "\x\alive\addons\fnc_strategic\fnc_isHouseEnterable.sqf";
			};
			class cluster {
				description = "Builds clusters";
                                file = "\x\alive\addons\fnc_strategic\fnc_cluster.sqf";
			};
		};
	};
};
