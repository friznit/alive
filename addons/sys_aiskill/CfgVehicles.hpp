class CfgVehicles {
        class ModuleAliveSystemBase;
        class ADDON : ModuleAliveSystemBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_AISkill";
                function = "ALIVE_fnc_AISkillInit";
				functionPriority = 5;
                isGlobal = 1;
                isPersistent = 1;
				icon = "x\alive\addons\sys_aiskill\icon_sys_AISkill.paa";
				picture = "x\alive\addons\sys_aiskill\icon_sys_AISkill.paa";
				class Arguments
                {
                        class debug
                        {
                                displayName = "$STR_ALIVE_AISKILL_DEBUG";
                                description = "$STR_ALIVE_AISKILL_COMMENT";
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
                        class skillFactionsRecruit
                        {
                                displayName = "$STR_ALIVE_AISKILL_RECRUIT";
                                description = "$STR_ALIVE_AISKILL_RECRUIT_COMMENT";
                                defaultValue = "";
                        };
                        class skillFactionsRegular
                        {
                                displayName = "$STR_ALIVE_AISKILL_REGULAR";
                                description = "$STR_ALIVE_AISKILL_REGULAR_COMMENT";
                                defaultValue = "";
                        };
                        class skillFactionsVeteran
                        {
                                displayName = "$STR_ALIVE_AISKILL_VETERAN";
                                description = "$STR_ALIVE_AISKILL_VETERAN_COMMENT";
                                defaultValue = "";
                        };
                        class skillFactionsNinja
                        {
                                displayName = "$STR_ALIVE_AISKILL_NINJA";
                                description = "$STR_ALIVE_AISKILL_NINJA_COMMENT";
                                defaultValue = "";
                        };
                        class customSkillFactions
                        {
                                displayName = "$STR_ALIVE_AISKILL_CUSTOM";
                                description = "$STR_ALIVE_AISKILL_CUSTOM_COMMENT";
                                defaultValue = "";
                        };
                        class customSkillAbilityMin
                        {
                                displayName = "$STR_ALIVE_AISKILL_CUSTOM_ABILITY_MIN";
                                description = "$STR_ALIVE_AISKILL_CUSTOM_ABILITY_MIN_COMMENT";
                                defaultValue = 0.2;
                                typeName = "NUMBER";
                        };
                        class customSkillAbilityMax
                        {
                                displayName = "$STR_ALIVE_AISKILL_CUSTOM_ABILITY_MAX";
                                description = "$STR_ALIVE_AISKILL_CUSTOM_ABILITY_MAX_COMMENT";
                                defaultValue = 0.25;
                                typeName = "NUMBER";
                        };
                        class customSkillAimAccuracy
                        {
                                displayName = "$STR_ALIVE_AISKILL_CUSTOM_AIM_ACCURACY";
                                description = "$STR_ALIVE_AISKILL_CUSTOM_AIM_ACCURACY_COMMENT";
                                defaultValue = 0.05;
                                typeName = "NUMBER";
                        };
                        class customSkillAimShake
                        {
                                displayName = "$STR_ALIVE_AISKILL_CUSTOM_AIM_SHAKE";
                                description = "$STR_ALIVE_AISKILL_CUSTOM_AIM_SHAKE_COMMENT";
                                defaultValue = 0.9;
                                typeName = "NUMBER";
                        };
                        class customSkillAimSpeed
                        {
                                displayName = "$STR_ALIVE_AISKILL_CUSTOM_AIM_SPEED";
                                description = "$STR_ALIVE_AISKILL_CUSTOM_AIM_SPEED_COMMENT";
                                defaultValue = 0.1;
                                typeName = "NUMBER";
                        };
                        class customSkillEndurance
                        {
                                displayName = "$STR_ALIVE_AISKILL_CUSTOM_ENDURANCE";
                                description = "$STR_ALIVE_AISKILL_CUSTOM_ENDURANCE_COMMENT";
                                defaultValue = 0.1;
                                typeName = "NUMBER";
                        };
                        class customSkillSpotDistance
                        {
                                displayName = "$STR_ALIVE_AISKILL_CUSTOM_SPOT_DISTANCE";
                                description = "$STR_ALIVE_AISKILL_CUSTOM_SPOT_DISTANCE_COMMENT";
                                defaultValue = 0.5;
                                typeName = "NUMBER";
                        };
                        class customSkillSpotTime
                        {
                                displayName = "$STR_ALIVE_AISKILL_CUSTOM_SPOT_TIME";
                                description = "$STR_ALIVE_AISKILL_CUSTOM_SPOT_TIME_COMMENT";
                                defaultValue = 0.4;
                                typeName = "NUMBER";
                        };
                        class customSkillCourage
                        {
                                displayName = "$STR_ALIVE_AISKILL_CUSTOM_COURAGE";
                                description = "$STR_ALIVE_AISKILL_CUSTOM_COURAGE_COMMENT";
                                defaultValue = 0.1;
                                typeName = "NUMBER";
                        };
                        class customSkillReload
                        {
                                displayName = "$STR_ALIVE_AISKILL_CUSTOM_RELOAD";
                                description = "$STR_ALIVE_AISKILL_CUSTOM_RELOAD_COMMENT";
                                defaultValue = 0.1;
                                typeName = "NUMBER";
                        };
                        class customSkillCommanding
                        {
                                displayName = "$STR_ALIVE_AISKILL_CUSTOM_COMMANDING";
                                description = "$STR_ALIVE_AISKILL_CUSTOM_COMMANDING_COMMENT";
                                defaultValue = 1;
                                typeName = "NUMBER";
                        };
                        class customSkillGeneral
                        {
                                displayName = "$STR_ALIVE_AISKILL_CUSTOM_GENERAL";
                                description = "$STR_ALIVE_AISKILL_CUSTOM_GENERAL_COMMENT";
                                defaultValue = 0.5;
                                typeName = "NUMBER";
                        };
                };
        };
};
