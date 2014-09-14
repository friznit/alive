class CfgVehicles {
        class ModuleAliveSupportBase;
        class ADDON : ModuleAliveSupportBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_PR";
                function = "ALIVE_fnc_PRInit";
                author = MODULE_AUTHOR;
				functionPriority = 0;
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
                };

        };

};
