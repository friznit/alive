class cfgFunctions {
        class PREFIX {
			class COMPONENT {
				class writeData_sql {
					description = "Writes a record/document to a data source";
					file = "\x\alive\addons\sys_data_sql\fnc_writeData.sqf";
					recompile = 1;
				};
				class readData_sql {
					description = "Reads a record/document from a data source";
					file = "\x\alive\addons\sys_data_sql\fnc_readData.sqf";
					recompile = 1;
				};
				class loadData_sql {
					description = "Loads all records/documents from a table/document set stored in a data source";
					file = "\x\alive\addons\sys_data_sql\fnc_loadData.sqf";
					recompile = 1;
				};
				class saveData_sql {
					description = "Saves all records/documents to a data source";
					file = "\x\alive\addons\sys_data_sql\fnc_saveData.sqf";
					recompile = 1;
				};
				class updateData_sql {
					description = "Updates a record stored in a data source";
					file = "\x\alive\addons\sys_data_sql\fnc_updateData.sqf";
					recompile = 1;
				};
				class deleteData_sql {
					description = "Deletes a record stored in a data source";
					file = "\x\alive\addons\sys_data_sql\fnc_deleteData.sqf";
					recompile = 1;
				};
            };
        };
};
