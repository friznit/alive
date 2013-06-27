class cfgFunctions {
        class PREFIX {
			class COMPONENT {
				class writeData_couchdb {
					description = "Writes a record/document to a data source";
					file = "\x\alive\addons\sys_data_couchdb\fnc_writeData.sqf";
					recompile = 1;
				};
				class readData_couchdb {
					description = "Reads a record/document from a data source";
					file = "\x\alive\addons\sys_data_couchdb\fnc_readData.sqf";
					recompile = 1;
				};
				class convertData_couchdb {
					description = "Decomposes objects/data to a suitable formatted text string for couchdb";
					file = "\x\alive\addons\sys_data_couchdb\fnc_convertData.sqf";
					recompile = 1;
				};
				class restoreData_couchdb {
					description = "Composes objects/data from a couchdb formatted text string";
					file = "\x\alive\addons\sys_data_couchdb\fnc_restoreData.sqf";
					recompile = 1;
				};
/*				class loadData_couchdb {
					description = "Loads all records/documents from a table/document set stored in a data source";
					file = "\x\alive\addons\sys_data_couchdb\fnc_loadData.sqf";
					recompile = 1;
				};
				class saveData_couchdb {
					description = "Saves all records/documents to a data source";
					file = "\x\alive\addons\sys_data_couchdb\fnc_saveData.sqf";
					recompile = 1;
				};
				class updateData_couchdb {
					description = "Updates a record stored in a data source";
					file = "\x\alive\addons\sys_data_couchdb\fnc_updateData.sqf";
					recompile = 1;
				};
				class deleteData_couchdb {
					description = "Deletes a record stored in a data source";
					file = "\x\alive\addons\sys_data_couchdb\fnc_deleteData.sqf";
					recompile = 1;
				};
*/
            };
        };
};
