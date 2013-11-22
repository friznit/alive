class cfgFunctions {
        class PREFIX {
			class COMPONENT {
				class data {
					description = "Data Handler";
					file = "\x\alive\addons\sys_data\fnc_data.sqf";
					recompile = RECOMPILE;
				};
				class sendToPlugIn {
					description = "Sends data to an external plugin via arma2net";
					file = "\x\alive\addons\sys_data\fnc_sendToPlugIn.sqf";
					recompile = RECOMPILE;
				};
				class sendToPlugInAsync {
					description = "Sends data to an external plugin via arma2net using an Async function";
					file = "\x\alive\addons\sys_data\fnc_sendToPlugInAsync.sqf";
					recompile = RECOMPILE;
				};
				class getServerIP {
					description = "Gets the servers IP address via arma2net";
					file = "\x\alive\addons\sys_data\fnc_getServerIP.sqf";
					recompile = RECOMPILE;
				};
				class getServerName {
					description = "Gets the server hostname via arma2net";
					file = "\x\alive\addons\sys_data\fnc_getServerName.sqf";
					recompile = RECOMPILE;
				};
				class getServerTime {
					description = "Gets the current local time from the server via arma2net";
					file = "\x\alive\addons\sys_data\fnc_getServerTime.sqf";
					recompile = RECOMPILE;
				};
				class parseJSON {
					description = "Converts a JSON string into a CBA Hash";
					file = "\x\alive\addons\sys_data\fnc_parseJSON.sqf";
					recompile = RECOMPILE;
				};
				class data_OnPlayerDisconnected {
						description = "The module onPlayerDisconnected handler";
						file = "\x\alive\addons\sys_data\fnc_data_onPlayerDisconnected.sqf";
						recompile = RECOMPILE;
				};
            };
        };
};
