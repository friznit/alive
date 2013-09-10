class CfgVehicles {
        class ModuleAliveMilitaryBase;
        class ADDON : ModuleAliveMilitaryBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_MP";
                function = "ALIVE_fnc_MPInit";
                isGlobal = 1;
                isPersistent = 1;
				icon = "x\alive\addons\mil_placement\icon_mil_MP.paa";
				picture = "x\alive\addons\mil_placement\icon_mil_MP.paa";
                class Arguments
                {
                        class debug
                        {
                                displayName = "$STR_ALIVE_MP_DEBUG";
                                description = "$STR_ALIVE_MP_DEBUG_COMMENT";
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
						class size
                        {
                                displayName = "$STR_ALIVE_MP_SIZE";
                                description = "$STR_ALIVE_MP_SIZE_COMMENT";
                                class Values
                                {
                                        class BN
                                        {
                                                name = "$STR_ALIVE_MP_SIZE_BN";
                                                value = "BN";
                                        };
                                        class CY
                                        {
                                                name = "$STR_ALIVE_MP_SIZE_CY";
                                                value = "CY";
												default = 1;
                                        };
                                        class PL
                                        {
                                                name = "$STR_ALIVE_MP_SIZE_PL";
                                                value = "PL";
                                        };
                                };
                        };
                        class type
                        {
                                displayName = "$STR_ALIVE_MP_TYPE";
                                description = "$STR_ALIVE_MP_TYPE_COMMENT";
                                class Values
                                {
                                        class RANDOM
                                        {
                                                name = "$STR_ALIVE_MP_TYPE_RANDOM";
                                                value = "RANDOM";
												default = 1;
                                        };
                                        class ARMOR
                                        {
                                                name = "$STR_ALIVE_MP_TYPE_ARMOR";
                                                value = "ARMOR";
                                        };
                                        class MECH
                                        {
                                                name = "$STR_ALIVE_MP_TYPE_MECH";
                                                value = "MECH";
                                        };
                                        class MOTOR
                                        {
                                                name = "$STR_ALIVE_MP_TYPE_MOTOR";
                                                value = "MOTOR";
                                        };
                                        class LIGHT
                                        {
                                                name = "$STR_ALIVE_MP_TYPE_LIGHT";
                                                value = "LIGHT";
                                        };
                                        class AIRBORNE
                                        {
                                                name = "$STR_ALIVE_MP_TYPE_AIRBORNE";
                                                value = "AIRBORNE";
                                        };
                                        class MARINE
                                        {
                                                name = "$STR_ALIVE_MP_TYPE_MARINE";
                                                value = "MARINE";
                                        };
                                };
                        };
                        class faction
                        {
                                displayName = "$STR_ALIVE_MP_FACTION";
                                description = "$STR_ALIVE_MP_FACTION_COMMENT";
                                defaultValue = "OPF_F";
                        };
                        class taor
                        {
                                displayName = "$STR_ALIVE_MP_TAOR";
                                description = "$STR_ALIVE_MP_TAOR_COMMENT";
                                defaultValue = "";
                        };
                        class blacklist
                        {
                                displayName = "$STR_ALIVE_MP_BLACKLIST";
                                description = "$STR_ALIVE_MP_BLACKLIST_COMMENT";
                                defaultValue = "";
                        };
                };
                
        };
};
