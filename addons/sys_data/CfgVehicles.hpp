class CfgVehicles {
        class ModuleAliveSystemBase;
        class ADDON : ModuleAliveSystemBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_DATA";
                function = "ALIVE_fnc_DataInit";
                isGlobal = 1;
                isPersistent = 1;
				icon = "x\alive\addons\sys_data\icon_sys_data.paa";
				picture = "x\alive\addons\sys_data\icon_sys_data.paa";
                class Arguments
                {
                        class debug
                        {
                                displayName = "$STR_ALIVE_Data_DEBUG";
                                description = "$STR_ALIVE_Data_DEBUG_COMMENT";
                                class Values
                                {
                                        class Yes
                                        {
                                                name = "Yes";
                                                value = true;
                                                default = true;
                                        };
                                        class No
                                        {
                                                name = "No";
                                                value = false;
                                        };
                                };
                        };
                        class source
                        {
                                displayName = "$STR_ALIVE_DATA_SOURCE";
                                description = "$STR_ALIVE_DATA_SOURCE_COMMENT";
                                class Values
                                {
                                        class SQL
                                        {
                                                name = "SQL";
                                                value = SQL;
                                                default = true;
                                        };
                                        class CouchDB
                                        {
                                                name = "CouchDB";
                                                value = CouchDB;
                                        };
                                };
                        };
                };
                
        };
};
