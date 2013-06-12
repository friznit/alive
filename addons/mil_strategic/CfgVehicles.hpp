class CfgVehicles {
        class ModuleAliveEnemyBase;
        class ADDON : ModuleAliveEnemyBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_SEP";
                function = "ALIVE_fnc_SEPInit";
                isGlobal = 1;
                isPersistent = 1;
				icon = "x\alive\addons\mil_strategic\icon_nme_SEP.paa";
				picture = "x\alive\addons\mil_strategic\icon_nme_SEP.paa";
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
                        class objectives
                        {
                                displayName = "$STR_ALIVE_SEP_OBJECTIVES";
                                description = "$STR_ALIVE_SEP_OBJECTIVES_COMMENT";
                                class Values
                                {
                                        class MILITARY
                                        {
                                                name = "$STR_ALIVE_SEP_OBJECTIVES_MIL";
                                                value = "MIL";
                                        };
                                        class CIVILIAN
                                        {
                                                name = "$STR_ALIVE_SEP_OBJECTIVES_CIV";
                                                value = "CIV";
                                        };
                                        class ALL
                                        {
                                                name = "$STR_ALIVE_SEP_OBJECTIVES_ALL";
                                                value = "ALL";
                                                default = 1;
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
                        class type
                        {
                                displayName = "$STR_ALIVE_SEP_TYPE";
                                description = "$STR_ALIVE_SEP_TYPE_COMMENT";
                                class Values
                                {
                                        class RANDOM
                                        {
                                                name = "$STR_ALIVE_SEP_TYPE_RANDOM";
                                                value = "RANDOM";
						default = 1;
                                        };
                                        class ARMOR
                                        {
                                                name = "$STR_ALIVE_SEP_TYPE_ARMOR";
                                                value = "ARMOR";
                                        };
                                        class MECH
                                        {
                                                name = "$STR_ALIVE_SEP_TYPE_MECH";
                                                value = "MECH";
                                        };
                                        class MOTOR
                                        {
                                                name = "$STR_ALIVE_SEP_TYPE_MOTOR";
                                                value = "MOTOR";
                                        };
                                        class LIGHT
                                        {
                                                name = "$STR_ALIVE_SEP_TYPE_LIGHT";
                                                value = "LIGHT";
                                        };
                                        class AIRBORNE
                                        {
                                                name = "$STR_ALIVE_SEP_TYPE_AIRBORNE";
                                                value = "AIRBORNE";
                                        };
                                        class MARINE
                                        {
                                                name = "$STR_ALIVE_SEP_TYPE_MARINE";
                                                value = "MARINE";
                                        };
                                };
                        };
                        class faction
                        {
                                displayName = "$STR_ALIVE_SEP_FACTION";
                                description = "$STR_ALIVE_SEP_FACTION_COMMENT";
                                defaultValue = "OPF_F";
                        };
                        class taor
                        {
                                displayName = "$STR_ALIVE_SEP_TAOR";
                                description = "$STR_ALIVE_SEP_TAOR_COMMENT";
                                defaultValue = "";
                        };
                        class blacklist
                        {
                                displayName = "$STR_ALIVE_SEP_BLACKLIST";
                                description = "$STR_ALIVE_SEP_BLACKLIST_COMMENT";
                                defaultValue = "";
                        };
                };
                
        };
};
