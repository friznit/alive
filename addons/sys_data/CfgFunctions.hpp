class cfgFunctions {
        class PREFIX {
                class COMPONENT {
			class convertData {
				description = "Decomposes objects and data to a text string";
				file = "\x\alive\addons\sys_data\fnc_convertData.sqf";
				recompile = 1;
			};
			class restoreData {
				description = "Composes objects and data from a text string";
				file = "\x\alive\addons\sys_data\fnc_restoreData.sqf";
				recompile = 1;
			};
			class sendToPlugIn {
				description = "Sends data to an external plugin via arma2net";
				file = "\x\alive\addons\sys_data\fnc_sendToPlugIn.sqf";
				recompile = 1;
			};
			class writeData {
				description = "Writes data to a data source";
				file = "\x\alive\addons\sys_data\fnc_writeData.sqf";
				recompile = 1;
			};
			class readData {
				description = "Reads data from a data source";
				file = "\x\alive\addons\sys_data\fnc_readData.sqf";
				recompile = 1;
			};
                };
        };
};
