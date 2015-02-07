class cfgFunctions {
        class PREFIX {
			class COMPONENT {
				class writeData_file {
					description = "Writes a record/document to a data source";
					file = "\x\alive\addons\sys_data_file\fnc_writeData.sqf";
					recompile = RECOMPILE;
				};
				class updateData_file {
					description = "Updates a record stored in a data source";
					file = "\x\alive\addons\sys_data_file\fnc_updateData.sqf";
					recompile = RECOMPILE;
				};
				class readData_file {
					description = "Reads a record/document from a data source";
					file = "\x\alive\addons\sys_data_file\fnc_readData.sqf";
					recompile = RECOMPILE;
				};
				class convertData_file {
					description = "Decomposes objects/data to a suitable formatted text string for file";
					file = "\x\alive\addons\sys_data_file\fnc_convertData.sqf";
					recompile = RECOMPILE;
				};
				class restoreData_file {
					description = "Composes objects/data from a file formatted text string";
					file = "\x\alive\addons\sys_data_file\fnc_restoreData.sqf";
					recompile = RECOMPILE;
				};
				class saveData_file {
					description = "Saves all records/documents to a data source";
					file = "\x\alive\addons\sys_data_file\fnc_saveData.sqf";
					recompile = RECOMPILE;
				};
				class loadData_file {
					description = "Loads all records/documents from a table/document set stored in a data source";
					file = "\x\alive\addons\sys_data_file\fnc_loadData.sqf";
					recompile = RECOMPILE;
				};

/*
				class deleteData_couchdb {
					description = "Deletes a record stored in a data source";
					file = "\x\alive\addons\sys_data_couchdb\fnc_deleteData.sqf";
					recompile = RECOMPILE;
				};
*/
            };
        };
};
