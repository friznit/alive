class cfgFunctions {
        class PREFIX {
			class COMPONENT {
				class convertObjectToJSON {
					description = "Decomposes objects to a JSON formatted text string";
					file = "\x\alive\addons\sys_data\fnc_convertObjectToJSON.sqf";
					recompile = 1;
				};
				class convertArrayToJSON {
					description = "Decomposes an array to a JSON formatted text string";
					file = "\x\alive\addons\sys_data\fnc_convertArrayToJSON.sqf";
					recompile = 1;
				};
				class restoreJSONToObject {
					description = "Composes objects from a JSON formatted text string";
					file = "\x\alive\addons\sys_data\fnc_restoreJSONToObject.sqf";
					recompile = 1;
				};
				class restoreJSONToArray {
					description = "Composes an array from a JSON formatted text string";
					file = "\x\alive\addons\sys_data\fnc_restoreJSONToArray.sqf";
					recompile = 1;
				};
				class sendToPlugIn {
					description = "Sends data to an external plugin via arma2net";
					file = "\x\alive\addons\sys_data\fnc_sendToPlugIn.sqf";
					recompile = 1;
				};
            };
        };
};
