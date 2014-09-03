class CfgVehicles {
        class ModuleAliveMilitaryBase;
        class ADDON : ModuleAliveMilitaryBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_C2ISTAR";
                function = "ALIVE_fnc_C2ISTARInit";
                author = MODULE_AUTHOR;
				functionPriority = 20;
                isGlobal = 1;
				icon = "x\alive\addons\mil_C2ISTAR\icon_mil_C2.paa";
				picture = "x\alive\addons\mil_C2ISTAR\icon_mil_C2.paa";
                class Arguments
                {
                    class debug
                    {
                            displayName = "$STR_ALIVE_C2ISTAR_DEBUG";
                            description = "$STR_ALIVE_C2ISTAR_DEBUG_COMMENT";
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
                    class c2_item
                    {
                            displayName = "$STR_ALIVE_C2ISTAR_ALLOW";
                            description = "$STR_ALIVE_C2ISTAR_ALLOW_COMMENT";
                            defaultValue = "LaserDesignator";
                    };
                };

        };

};
