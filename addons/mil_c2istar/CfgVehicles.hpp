class CfgVehicles {
        class ModuleAliveBase;
        class ADDON : ModuleAliveBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_C2ISTAR";
                function = "ALIVE_fnc_C2ISTARInit";
                author = MODULE_AUTHOR;
				functionPriority = 150;
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
                                    };
                                    class No
                                    {
                                            name = "No";
                                            value = false;
                                            default = true;
                                    };
                            };
                    };
                    class c2_item
                    {
                            displayName = "$STR_ALIVE_C2ISTAR_ALLOW";
                            description = "$STR_ALIVE_C2ISTAR_ALLOW_COMMENT";
                            defaultValue = "LaserDesignator";
                    };
                    // TASKING
                    class TASKING {
                            displayName = "";
                            class Values
                            {
                                    class Divider
                                    {
                                            name = "----- Tasking --------------------------------------------------------";
                                            value = "";
                                    };
                            };
                    };
                    class persistent
                    {
                            displayName = "$STR_ALIVE_C2ISTAR_PERSISTENT";
                            description = "$STR_ALIVE_C2ISTAR_PERSISTENT_COMMENT";
                            class Values
                            {
                                    class No
                                    {
                                            name = "No";
                                            value = false;
                                            default = 1;
                                    };
                                    class Yes
                                    {
                                            name = "Yes";
                                            value = true;
                                    };
                            };
                    };
                    class autoGenerateBlufor
                    {
                            displayName = "$STR_ALIVE_C2ISTAR_AUTOGEN_BLUFOR";
                            description = "$STR_ALIVE_C2ISTAR_AUTOGEN_BLUFOR_COMMENT";
                            class Values
                            {
                                    class No
                                    {
                                            name = "No";
                                            value = false;
                                            default = 1;
                                    };
                                    class Yes
                                    {
                                            name = "Yes";
                                            value = true;
                                    };
                            };
                    };
                    class autoGenerateBluforFaction
                    {
                            displayName = "$STR_ALIVE_C2ISTAR_AUTOGEN_BLUFOR_FACTION";
                            description = "$STR_ALIVE_C2ISTAR_AUTOGEN_BLUFOR_FACTION_COMMENT";
                            defaultValue = "BLU_F";
                    };
                    class autoGenerateBluforEnemyFaction
                    {
                            displayName = "$STR_ALIVE_C2ISTAR_AUTOGEN_BLUFOR_ENEMY_FACTION";
                            description = "$STR_ALIVE_C2ISTAR_AUTOGEN_BLUFOR_ENEMY_FACTION_COMMENT";
                            defaultValue = "OPF_F";
                    };
                    class autoGenerateOpfor
                    {
                            displayName = "$STR_ALIVE_C2ISTAR_AUTOGEN_OPFOR";
                            description = "$STR_ALIVE_C2ISTAR_AUTOGEN_OPFOR_COMMENT";
                            class Values
                            {
                                    class No
                                    {
                                            name = "No";
                                            value = false;
                                            default = 1;
                                    };
                                    class Yes
                                    {
                                            name = "Yes";
                                            value = true;
                                    };
                            };
                    };
                    class autoGenerateOpforFaction
                    {
                            displayName = "$STR_ALIVE_C2ISTAR_AUTOGEN_OPFOR_FACTION";
                            description = "$STR_ALIVE_C2ISTAR_AUTOGEN_OPFOR_FACTION_COMMENT";
                            defaultValue = "OPF_F";
                    };
                    class autoGenerateOpforEnemyFaction
                    {
                            displayName = "$STR_ALIVE_C2ISTAR_AUTOGEN_OPFOR_ENEMY_FACTION";
                            description = "$STR_ALIVE_C2ISTAR_AUTOGEN_OPFOR_ENEMY_FACTION_COMMENT";
                            defaultValue = "BLU_F";
                    };
                    class autoGenerateIndfor
                    {
                            displayName = "$STR_ALIVE_C2ISTAR_AUTOGEN_INDFOR";
                            description = "$STR_ALIVE_C2ISTAR_AUTOGEN_INDFOR_COMMENT";
                            class Values
                            {
                                    class No
                                    {
                                            name = "No";
                                            value = false;
                                            default = 1;
                                    };
                                    class Yes
                                    {
                                            name = "Yes";
                                            value = true;
                                    };
                            };
                    };
                    class autoGenerateIndforFaction
                    {
                            displayName = "$STR_ALIVE_C2ISTAR_AUTOGEN_INDFOR_FACTION";
                            description = "$STR_ALIVE_C2ISTAR_AUTOGEN_INDFOR_FACTION_COMMENT";
                            defaultValue = "IND_F";
                    };
                    class autoGenerateIndforEnemyFaction
                    {
                            displayName = "$STR_ALIVE_C2ISTAR_AUTOGEN_INDFOR_ENEMY_FACTION";
                            description = "$STR_ALIVE_C2ISTAR_AUTOGEN_INDFOR_ENEMY_FACTION_COMMENT";
                            defaultValue = "OPF_F";
                    };
                    // INTEL
                    class INTEL {
                            displayName = "";
                            class Values
                            {
                                    class Divider
                                    {
                                            name = "----- Intel --------------------------------------------------------";
                                            value = "";
                                    };
                            };
                    };
                    class displayIntel
                    {
                            displayName = "$STR_ALIVE_C2ISTAR_DISPLAY_INTEL";
                            description = "$STR_ALIVE_C2ISTAR_DISPLAY_INTEL_COMMENT";
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
                                            default = true;
                                    };
                            };
                    };
                    class intelChance
                    {
                            displayName = "$STR_ALIVE_C2ISTAR_INTEL_CHANCE";
                            description = "$STR_ALIVE_C2ISTAR_INTEL_CHANCE_COMMENT";
                            class Values
                            {
                                    class LOW
                                    {
                                            name = "$STR_ALIVE_C2ISTAR_INTEL_CHANCE_LOW";
                                            value = "0.1";
                                    };
                                    class MEDIUM
                                    {
                                            name = "$STR_ALIVE_C2ISTAR_INTEL_CHANCE_MEDIUM";
                                            value = "0.2";
                                    };
                                    class HIGH
                                    {
                                            name = "$STR_ALIVE_C2ISTAR_INTEL_CHANCE_HIGH";
                                            value = "0.4";
                                    };
                                    class TOTAL
                                    {
                                            name = "$STR_ALIVE_C2ISTAR_INTEL_CHANCE_TOTAL";
                                            value = "1";
                                            default = true;
                                    };
                            };
                    };
                    class friendlyIntel
                    {
                            displayName = "$STR_ALIVE_C2ISTAR_FRIENDLY_INTEL";
                            description = "$STR_ALIVE_C2ISTAR_FRIENDLY_INTEL_COMMENT";
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
                                            default = true;
                                    };
                            };
                    };
                    class friendlyIntelRadius
                    {
                            displayName = "$STR_ALIVE_C2ISTAR_FRIENDLY_INTEL_RADIUS";
                            description = "$STR_ALIVE_C2ISTAR_FRIENDLY_INTEL_RADIUS_COMMENT";
                            defaultValue = "2000";
                    };
                    class displayMilitarySectors
                    {
                            displayName = "$STR_ALIVE_C2ISTAR_DISPLAY_MIL_SECTORS";
                            description = "$STR_ALIVE_C2ISTAR_DISPLAY_MIL_SECTORS_COMMENT";
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
                                            default = true;
                                    };
                            };
                    };
                    class displayPlayerSectors
                    {
                            displayName = "$STR_ALIVE_C2ISTAR_DISPLAY_PLAYER_SECTORS";
                            description = "$STR_ALIVE_C2ISTAR_DISPLAY_PLAYER_SECTORS_COMMENT";
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
                                            default = true;
                                    };
                            };
                    };
                    class runEvery
                    {
                            displayName = "$STR_ALIVE_C2ISTAR_RUN_EVERY";
                            description = "$STR_ALIVE_C2ISTAR_RUN_EVERY_COMMENT";
                            defaultValue = 2;
                            typeName = "NUMBER";
                    };
                };

        };

};
