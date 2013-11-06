class CfgVehicles {
	class ModuleAliveSystemBase;
	class ADDON : ModuleAliveSystemBase {
		scope = 2;
		displayName = "$STR_ALIVE_REVIVE";
		function = "ALIVE_fnc_reviveInit";
		isGlobal = 1;
		isPersistent = 1;
		icon = "\x\alive\addons\sys_revive\icon_sys_revive.paa";
		picture = "\x\alive\addons\sys_revive\icon_sys_revive.paa";

		class Arguments {
			class revive_debug_setting {
				displayName = "$STR_ALIVE_REVIVE_DEBUG";
				description = "$STR_ALIVE_REVIVE_DEBUG_COMMENT";
				class Values {
					class No {
						name = "No";
						value = false;
						default = false;
					};
					class Yes {
						name = "Yes";
						value = true;
					};
				};
			};
			class revive_language_setting {
				displayName = "$STR_ALIVE_REVIVE_LANG";
				description = "$STR_ALIVE_REVIVE_LANG_COMMENT";
				class Values {
					class langEnglish {
						name = "English";
						value = 1;
						default = 1;
					};
					class langFrench {
						name = "French";
						value = 2;
					};
				};
			};
			class revive_lives_setting {
				displayName = "$STR_ALIVE_REVIVE_LIVES";
				description = "$STR_ALIVE_REVIVE_LIVES_COMMENT";
				class Values {
					class livesSetting1 {
						name = "Unlimited";
						value = 999;
						default = 999;
					};
					class livesSetting2 {
						name = "3";
						value = 3;
					};
					class livesSetting3 {
						name = "20";
						value = 20;
					};
					class livesSetting4 {
						name = "100";
						value = 100;
					};
				};
			};
			class revive_allow_respawn {
				displayName = "$STR_ALIVE_REVIVE_ALLOW_RESPAWN";
				description = "$STR_ALIVE_REVIVE_ALLOW_RESPAWN_COMMENT";
				class Values {
					class Yes {
						name = "Yes";
						value = true;
						default = true;
					};
					class No {
						name = "No";
						value = false;
					};
				};
			};
			class revive_spectator {
				displayName = "$STR_ALIVE_REVIVE_SPECTATOR";
				description = "$STR_ALIVE_REVIVE_SPECTATOR_COMMENT";
				class Values {
					class No {
						name = "No";
						value = false;
						default = false;
					};
					class Yes {
						name = "Yes";
						value = true;
					};
				};
			};
			class revive_player_marker {
				displayName = "$STR_ALIVE_REVIVE_MARKER";
				description = "$STR_ALIVE_REVIVE_MARKER_COMMENT";
				class Values {
					class Yes {
						name = "Yes";
						value = true;
						default = true;
					};
					class No {
						name = "No";
						value = false;
					};
				};
			};
			class revive_injured {
				displayName = "$STR_ALIVE_REVIVE_INJURED";
				description = "$STR_ALIVE_REVIVE_INJURED_COMMENT";
				class Values {
					class Yes {
						name = "Yes";
						value = true;
						default = true;
					};
					class No {
						name = "No";
						value = false;
					};
				};
			};
			class revive_drag_body {
				displayName = "$STR_ALIVE_REVIVE_DRAG";
				description = "$STR_ALIVE_REVIVE_DRAG_COMMENT";
				class Values {
					class Yes {
						name = "Yes";
						value = true;
						default = true;
					};
					class No {
						name = "No";
						value = false;
					};
				};
			};
			class revive_carry_body {
				displayName = "$STR_ALIVE_REVIVE_CARRY";
				description = "$STR_ALIVE_REVIVE_CARRY_COMMENT";
				class Values {
					class No {
						name = "No";
						value = false;
						default = false;
					};
					class Yes {
						name = "Yes";
						value = true;
					};
				};
			};

		};
	};
};
