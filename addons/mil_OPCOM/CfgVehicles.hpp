class CfgVehicles {
        class ModuleAliveEnemyBase;
        class ADDON : ModuleAliveEnemyBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_OPCOM";
                function = "ALIVE_fnc_OPCOMInit";
                isGlobal = 1;
                isPersistent = 1;
				icon = "x\alive\addons\mil_opcom\icon_mil_OPCOM.paa";
				picture = "x\alive\addons\mil_opcom\icon_mil_OPCOM.paa";
                class Arguments
                {
                        class debug
                        {
                                displayName = "$STR_ALIVE_OPCOM_DEBUG";
                                description = "$STR_ALIVE_OPCOM_DEBUG_COMMENT";
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
                        class controltype
                        {
                                displayName = "$STR_ALIVE_OPCOM_CONTROLTYPE";
                                description = "$STR_ALIVE_OPCOM_CONTROLTYPE_COMMENT";
                                class Values
                                {
                                        class invasion
                                        {
                                                name = "Invasion";
                                                value = "invasion";
                                                default = "invasion";
                                        };
                                        class occupation
                                        {
                                                name = "Occupation";
                                                value = "occupation";
                                        };
                                };
                        };
                        class side
                        {
                                displayName = "$STR_ALIVE_OPCOM_SIDE";
                                description = "$STR_ALIVE_OPCOM_SIDE_COMMENT";
                                defaultValue = "EAST";
                        };
                };
                
        };
};
