class CfgVehicles {
        class ModuleAliveBase;
        class ADDON : ModuleAliveBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_PR";
                function = "ALIVE_fnc_PRInit";
                author = MODULE_AUTHOR;
				functionPriority = 170;
                isGlobal = 1;
				icon = "x\alive\addons\sup_player_resupply\icon_sup_PR.paa";
				picture = "x\alive\addons\sup_player_resupply\icon_sup_PR.paa";
                class Arguments
                {
                    class pr_item
                    {
                            displayName = "$STR_ALIVE_PR_ALLOW";
                            description = "$STR_ALIVE_PR_ALLOW_COMMENT";
                            defaultValue = "LaserDesignator";
                    };
                    class pr_restrictionType
                    {
                            displayName = "$STR_ALIVE_PR_RESTRICTION_TYPE";
                            description = "$STR_ALIVE_PR_RESTRICTION_TYPE_COMMENT";
                            class Values
                            {
                                    class Side
                                    {
                                            name = "$STR_ALIVE_PR_RESTRICTION_TYPE_SIDE";
                                            value = "SIDE";
                                            default = true;
                                    };
                                    class Faction
                                    {
                                            name = "$STR_ALIVE_PR_RESTRICTION_TYPE_FACTION";
                                            value = "FACTION";
                                    };
                            };
                    };
                };

        };

};
