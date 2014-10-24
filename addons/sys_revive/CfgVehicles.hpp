class CfgVehicles {
	class ModuleAliveBase;
	class ADDON : ModuleAliveBase {
		scope = 1;
		displayName = "$STR_ALIVE_REVIVE";
		function = "ALIVE_fnc_reviveInit";
		functionPriority = 2;
		isGlobal = 2;
		icon = "\x\alive\addons\sys_revive\icon_sys_revive.paa";
		picture = "\x\alive\addons\sys_revive\icon_sys_revive.paa";

		class Arguments {
			class rev_debug_setting {
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
			// class rev_language_setting {
				// displayName = "$STR_ALIVE_REVIVE_LANG";
				// description = "$STR_ALIVE_REVIVE_LANG_COMMENT";
				// class Values {
					// class langEnglish {
						// name = "English";
						// value = "en";
						// default = "en";
					// };
				// };
			// };
			class rev_mode_setting {
				displayName = "$STR_ALIVE_REVIVE_MODE";
				description = "$STR_ALIVE_REVIVE_MODE_COMMENT";
				typeName = "NUMBER";
				class Values {
					class revModeSetting1 {
						name = "All Players can Revive Only";
						value = 1;
						default = 1;
					};
					class revModeSetting2 {
						name = "Only Medics can Revive, Others can ONLY Stabilize";
						value = 0;
					};
					class revModeSetting3 {
						name = "All Players can Revive/Stabilize";
						value = 2;
					};
				};
			};
			class rev_bleedout_setting {
				displayName = "$STR_ALIVE_BLEEDOUT_TIME";
				description = "$STR_ALIVE_BLEEDOUT_TIME_COMMENT";
				typeName = "NUMBER";
				class Values {
					class bleedoutSetting1 {
						name = "Five Minutes";
						value = 300;
						default = 300;
					};
					class bleedoutSetting2 {
						name = "Two Minutes";
						value = 120;
					};
					class bleedoutSetting3 {
						name = "One Minute";
						value = 60;
					};
					class bleedoutSetting4 {
						name = "Bleedout Only(Damage Based)";
						value = 999;
					};
				};
			};
			class rev_bulletproof_setting {
				displayName = "$STR_ALIVE_BULLETPROOF";
				description = "$STR_ALIVE_BULLETPROOF_COMMENT";
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
			class rev_bulletmagenet_setting {
				displayName = "$STR_ALIVE_MAGNET";
				description = "$STR_ALIVE_MAGNET_COMMENT";
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
			class rev_playableunits_setting {
				displayName = "$STR_ALIVE_PLAYABLE";
				description = "$STR_ALIVE_PLAYABLE_COMMENT";
				typeName = "NUMBER";
				class Values {
					class AIUnits0 {
						name = "MP/SP - No AI Units";
						value = 0;
						default = 0;
					};
					class AIUnits1 {
						name = "SP - Switchable AI Units";
						value = 1;
					};
					class AIUnits2 {
						name = "MP/SP - All AI Units on the Players Side";
						value = 2;
					};
					class AIUnits3 {
						name = "MP/SP - All AI Units (Frendly, Enemy, Civillian)";
						value = 3;
					};
				};
			};
			class rev_notifyplayers_setting {
				displayName = "$STR_ALIVE_NOTIFY_PLAYER";
				description = "$STR_ALIVE_NOTIFY_PLAYER_COMMENT";
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
			class rev_lives_setting {
				displayName = "$STR_ALIVE_REVIVE_LIVES";
				description = "$STR_ALIVE_REVIVE_LIVES_COMMENT";
				typeName = "NUMBER";
				class Values {
					class livesSetting1 {
						name = "Unlimited";
						value = "999";
						default = 999;
					};
					class livesSetting2 {
						name = "3";
						value = 3;
					};
					class livesSetting3 {
						name = "5";
						value = 5;
					};
					class livesSetting4 {
						name = "10";
						value = 10;
					};
					class livesSetting5 {
						name = "20";
						value = 20;
					};
					class livesSetting6 {
						name = "50";
						value = 50;
					};
				};
			};
			class rev_injured_setting {
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
			class rev_allow_suicide_setting {
				displayName = "$STR_ALIVE_PLAYER_SUICIDE";
				description = "$STR_ALIVE_PLAYER_SUICIDE_COMMENT";
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
			class rev_drag_body_setting {
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
			// class rev_carry_body_setting {
				// displayName = "$STR_ALIVE_REVIVE_CARRY";
				// description = "$STR_ALIVE_REVIVE_CARRY_COMMENT";
				// class Values {
					// class No {
						// name = "No";
						// value = false;
						// default = false;
					// };
					// class Yes {
						// name = "Yes";
						// value = true;
					// };
				// };
			// };
			// class rev_spectator_setting {
				// displayName = "$STR_ALIVE_REVIVE_SPECTATOR";
				// description = "$STR_ALIVE_REVIVE_SPECTATOR_COMMENT";
				// class Values {
					// class No {
						// name = "No";
						// value = false;
						// default = false;
					// };
					// class Yes {
						// name = "Yes";
						// value = true;
					// };
				// };
			// };
			class rev_bullet_effects_setting {
				displayName = "$STR_ALIVE_BULLET_EFFECTS";
				description = "$STR_ALIVE_BULLET_EFFECTS_COMMENT";
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
			class rev_player_marker_setting {
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
		};
	};
};
