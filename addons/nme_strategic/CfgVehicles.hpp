class CfgVehicles {
        class ModuleAliveEnemyBase;
        class ADDON : ModuleAliveEnemyBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_SEP";
                function = "ALIVE_fnc_SEPInit";
                isGlobal = 1;
                isPersistent = 1;
				icon = "x\alive\addons\nme_strategic\icon_nme_SEP.paa";
				picture = "x\alive\addons\nme_strategic\icon_nme_SEP.paa";
                class Arguments
                {
                        class debug
                        {
                                displayName = "$STR_ALIVE_SEP_DEBUG";
                                description = "$STR_ALIVE_SEP_DEBUG_COMMENT";
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
                        class style
                        {
                                displayName = "$STR_ALIVE_SEP_STYLE";
                                description = "$STR_ALIVE_SEP_STYLE_COMMENT";
                                class Values
                                {
                                        class SYMMETRIC
                                        {
                                                name = "$STR_ALIVE_SEP_STYLE_SYM";
                                                value = "SYM";
						default = 1;
                                        };
                                        class ASYMMETRIC
                                        {
                                                name = "$STR_ALIVE_SEP_STYLE_ASYM";
                                                value = "ASYM";
                                        };
                                };
                        };
                        class size
                        {
                                displayName = "$STR_ALIVE_SEP_SIZE";
                                description = "$STR_ALIVE_SEP_SIZE_COMMENT";
                                class Values
                                {
                                        class BN
                                        {
                                                name = "$STR_ALIVE_SEP_SIZE_BN";
                                                value = "BN";
                                        };
                                        class COY
                                        {
                                                name = "$STR_ALIVE_SEP_SIZE_COY";
                                                value = "COY";
						default = 1;
                                        };
                                        class PL
                                        {
                                                name = "$STR_ALIVE_SEP_SIZE_PL";
                                                value = "PL";
                                        };
                                };
                        };
                };
                
        };
};
