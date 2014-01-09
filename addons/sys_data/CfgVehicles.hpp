class CfgVehicles {
	    class ModuleAliveSystemBase;
        class ADDON : ModuleAliveSystemBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_DATA";
                function = "ALIVE_fnc_dataInit";
                functionPriority = 1;
                isGlobal = 1;
                isPersistent = 1;
                icon = "x\alive\addons\sys_data\icon_sys_data.paa";
                picture = "x\alive\addons\sys_data\icon_sys_data.paa";
                author = MODULE_AUTHOR;
                class ModuleDescription
                {
                        description = "This module allows you to persist mission data to an external database as well as enabling data storage for all other modules. This module is required for statistics too."; // Short description, will be formatted as structured text       
                }; 
                 class Arguments
                {
                        class source
                        {
                                displayName = "$STR_ALIVE_data_SOURCE";
                                description = "$STR_ALIVE_data_SOURCE_COMMENT";
                                class Values
                                {
                                        class COUCHDB
                                        {
                                                name = "CouchDB";
                                                value = "CouchDB";
                                                default = true;
                                        };
                                };
                        };
                        class saveDateTime
                        {
                                displayName = "$STR_ALIVE_data_SAVEDATETIME";
                                description = "$STR_ALIVE_data_SAVEDATETIME_COMMENT";
                                class Values
                                {
                                        class Yes
                                        {
                                                name = "Yes";
                                                value = true;
                                                default = 1;
                                        };
                                        class No
                                        {
                                                name = "No";
                                                value = false;
                                        };
                                };
                        };

                        class disableStats
                        {
                                displayName = "$STR_ALIVE_data_disableStats";
                                description = "$STR_ALIVE_data_disableStats_COMMENT";
                                class Values
                                {
                                        class Yes
                                        {
                                                name = "Yes";
                                                value = true;
                                        };
                                        class No
                                        {
                                                name = "No";
                                                value = false;
                                                default = 1;
                                        };
                                };
                        };
                        class disablePerf
                        {
                                displayName = "$STR_ALIVE_data_disablePerf";
                                description = "$STR_ALIVE_data_disablePerf_COMMENT";
                                class Values
                                {
                                        class Yes
                                        {
                                                name = "Yes";
                                                value = true;
                                                default = 1;
                                        };
                                        class No
                                        {
                                                name = "No";
                                                value = false;
                                        };
                                };
                        };
                };
                
        };
};
