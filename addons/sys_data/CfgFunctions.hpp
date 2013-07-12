class cfgFunctions {
        class PREFIX {
			class COMPONENT {
				class data {
					description = "Data Handler";
					file = "\x\alive\addons\sys_data\fnc_data.sqf";
					recompile = 1;
				};
				class sendToPlugIn {
					description = "Sends data to an external plugin via arma2net";
					file = "\x\alive\addons\sys_data\fnc_sendToPlugIn.sqf";
					recompile = 1;
				};
				class sendToPlugInAsync {
					description = "Sends data to an external plugin via arma2net using an Async function";
					file = "\x\alive\addons\sys_data\fnc_sendToPlugInAsync.sqf";
					recompile = 1;
				};
				class getServerIP {
					description = "Gets the servers IP address via arma2net";
					file = "\x\alive\addons\sys_data\fnc_getServerIP.sqf";
					recompile = 1;
				};
				class getServerName {
					description = "Gets the server hostname via arma2net";
					file = "\x\alive\addons\sys_data\fnc_getServerName.sqf";
					recompile = 1;
				};
				class getServerTime {
					description = "Gets the current local time from the server via arma2net";
					file = "\x\alive\addons\sys_data\fnc_getServerTime.sqf";
					recompile = 1;
				};
				class parseJSON {
					description = "Converts a JSON string into a CBA Hash";
					file = "\x\alive\addons\sys_data\fnc_parseJSON.sqf";
					recompile = 1;
				};
				class data_OnPlayerDisconnected {
						description = "The module onPlayerDisconnected handler";
						file = "\x\alive\addons\sys_data\fnc_data_onPlayerDisconnected.sqf";
						recompile = 1;
				};
            };
        };
};
