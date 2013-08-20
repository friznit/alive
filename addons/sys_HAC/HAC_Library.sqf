_logic = _this select ((count _this)-1);

//A3
_logic setvariable ["RHQ_Recon", [
"B_recon_TL_F",
"B_recon_exp_F",
"B_recon_LAT_F",
"B_recon_F",
"B_recon_medic_F",
"B_recon_M_F",
"B_recon_JTAC_F",
"B_sniper_F",
"B_spotter_F",
"B_soldier_M_F",
"O_recon_exp_F",
"O_recon_JTAC_F",
"O_recon_M_F",
"O_recon_medic_F",
"O_recon_F",
"O_recon_LAT_F",
"O_recon_TL_F",
"O_sniper_F",
"O_spotter_F",
"O_soldier_M_F",
"I_Sniper_F",
"I_Spotter_F",
"I_Soldier_M_F"

]];

_logic setvariable ["RHQ_FO", [
"B_spotter_F",
"B_sniper_F",
"B_soldier_M_F",
"B_recon_M_F",
"B_recon_JTAC_F",
"O_spotter_F",
"O_sniper_F",
"O_soldier_M_F",
"O_recon_JTAC_F",
"O_recon_M_F",
"I_Soldier_M_F",
"I_Sniper_F",
"I_Spotter_F",
"B_diver_TL_F",
"B_diver_exp_F",
"B_diver_F",
"O_diver_F",
"O_diver_exp_F",
"O_diver_TL_F",
"I_diver_F",
"I_diver_exp_F",
"I_diver_TL_F"

]];

_logic setvariable ["RHQ_Snipers", [
"B_spotter_F",
"B_sniper_F",
"B_soldier_M_F",
"B_recon_M_F",
"O_spotter_F",
"O_sniper_F",
"O_soldier_M_F",
"O_recon_M_F",
"I_Sniper_F",
"I_Spotter_F",
"I_Soldier_M_F"

]];

_logic setvariable ["RHQ_Art",[
"O_Mortar_01_F",
"B_Mortar_01_F",
"I_Mortar_01_F"

]];

_logic setvariable ["RHQ_ATInf", [
"B_soldier_LAT_F",
"B_soldier_AAT_F",
"B_recon_LAT_F",
"B_soldier_AT_F",
"O_Soldier_LAT_F",
"O_Soldier_AAT_F",
"O_recon_LAT_F",
"O_Soldier_AT_F",
"I_Soldier_AAT_F",
"I_Soldier_LAT_F",
"I_Soldier_AT_F"

]];

_logic setvariable ["RHQ_AAInf", [
"B_soldier_AA_F",
"B_soldier_AAA_F",
"O_Soldier_AA_F",
"O_Soldier_AAA_F",
"I_Soldier_AA_F",
"I_Soldier_AAA_F"

]]; 

_logic setvariable ["RHQ_Inf", [
"B_Soldier_SL_F",
"B_soldier_TL_F",
"B_Soldier_A_F",
"B_soldier_AR_F",
"B_medic_F",
"B_crew_F",
"B_engineer_F",
"B_soldier_exp_F",
"B_Soldier_GL_F",
"B_Helipilot_F",
"B_soldier_M_F",
"B_soldier_AA_F",
"B_soldier_AT_F",
"B_officer_F",
"B_soldier_repair_F",
"B_Soldier_F",
"B_soldier_LAT_F",
"B_Soldier_lite_F",
"B_Soldier_F",
"B_soldier_AAR_F",
"B_soldier_AAA_F",
"B_soldier_AAT_F",
"O_Soldier_A_F",
"O_Soldier_AR_F",
"O_medic_F",
"O_crew_F",
"O_engineer_F",
"O_soldier_exp_F",
"O_Soldier_GL_F",
"O_helipilot_F",
"O_soldier_M_F",
"O_Soldier_AA_F",
"O_Soldier_AT_F",
"O_officer_F",
"O_soldier_repair_F",
"O_Soldier_F",
"O_Soldier_LAT_F",
"O_Soldier_lite_F",
"O_Soldier_SL_F",
"O_Soldier_TL_F",
"O_Soldier_AAR_F",
"O_Soldier_AAA_F",
"O_Soldier_AAT_F",
"I_Soldier_A_F",
"I_Soldier_AR_F",
"I_medic_F",
"I_crew_F",
"I_engineer_F",
"I_Soldier_exp_F",
"I_Soldier_GL_F",
"I_helicrew_F",
"I_helipilot_F",
"I_Soldier_M_F",
"I_Soldier_AA_F",
"I_Soldier_AT_F",
"I_officer_F",
"I_Soldier_repair_F",
"I_soldier_F",
"I_Soldier_LAT_F",
"I_Soldier_lite_F",
"I_Soldier_SL_F",
"I_Soldier_TL_F",
"I_Soldier_AAR_F",
"I_Soldier_AAA_F",
"I_Soldier_AAT_F"

]];

_logic setvariable ["RHQ_HArmor", []];

_logic setvariable ["RHQ_MArmor", [
"O_APC_Wheeled_02_rcws_F",
"B_APC_Wheeled_01_cannon_F",
"B_APC_Tracked_01_rcws_F",
"O_APC_Tracked_02_cannon_F"

]];

_logic setvariable ["RHQ_LArmor", [
"B_MRAP_01_gmg_F",
"B_MRAP_01_hmg_F",
"O_MRAP_02_gmg_F",
"O_MRAP_02_hmg_F",
"I_MRAP_03_gmg_F",
"I_MRAP_03_hmg_F",
"B_UGV_01_rcws_F",
"O_UGV_01_rcws_F",
"I_UGV_01_rcws_F"

]];  

_logic setvariable ["RHQ_LarmorAT", [
"O_MRAP_02_gmg_F",
"B_MRAP_01_gmg_F",
"I_MRAP_03_gmg_F"

]];  

_logic setvariable ["RHQ_Cars", [
"B_MRAP_01_F",
"B_Quadbike_01_F",
"O_MRAP_02_F",
"O_Quadbike_01_F",
"I_MRAP_03_F",
"C_Offroad_01_F",
"C_Quadbike_01_F"

]];  

_logic setvariable ["RHQ_Air", [
"B_Heli_Light_01_armed_F",
"B_Heli_Attack_01_F",
"B_UAV_02_F",
"O_UAV_02_F",
"I_UAV_02_F",
"O_Heli_Attack_02_F",
"O_Heli_Attack_02_black_F"

]];

_logic setvariable ["RHQ_NCAir", [
"B_Heli_Light_01_F",
"B_Heli_Transport_01_F",
"B_Heli_Transport_01_camo_F",
"O_Heli_Light_02_F",
"O_Heli_Light_02_unarmed_F",
"I_Heli_Transport_02_F"

]];

_logic setvariable ["RHQ_BAir", []];
_logic setvariable ["RHQ_RAir", [
"B_UAV_01_F",
"O_UAV_01_F",
"I_UAV_01_F"

]];

_logic setvariable ["RHQ_Naval", [
"B_Boat_Transport_01_F",
"B_Lifeboat",
"B_Boat_Armed_01_minigun_F",
"B_SDV_01_F",
"O_Boat_Transport_01_F",
"O_Lifeboat",
"O_Boat_Armed_01_hmg_F",
"O_SDV_01_F",
"I_Boat_Transport_01_F",
"I_Boat_Armed_01_minigun_F",
"I_SDV_01_F",
"C_Rubberboat"

]];

_logic setvariable ["RHQ_Static", []];

_logic setvariable ["RHQ_StaticAA", []];

_logic setvariable ["RHQ_StaticAT", []];

_logic setvariable ["RHQ_Support", [
"B_Soldier_A_F",
"O_Soldier_A_F",
"I_Soldier_A_F"

]];

_logic setvariable ["RHQ_Med", [
"B_recon_medic_F",
"B_medic_F",
"O_medic_F",
"O_recon_medic_F",
"I_medic_F"

]];

_logic setvariable ["RHQ_Ammo", []];

_logic setvariable ["RHQ_Fuel", []];

_logic setvariable ["RHQ_Rep", []];

_logic setvariable ["RHQ_Cargo", [
"B_MRAP_01_hmg_F",
"B_MRAP_01_gmg_F",
"O_MRAP_02_gmg_F",
"O_MRAP_02_hmg_F",
"B_Heli_Light_01_armed_F",
"B_Heli_Transport_01_F",
"B_Heli_Transport_01_camo_F",
"B_MRAP_01_F",
"O_MRAP_02_F",
"O_Heli_Attack_02_F",
"O_Heli_Light_02_unarmed_F",
"I_Heli_Transport_02_F"

]]; 

_logic setvariable ["RHQ_NCCargo", [
"B_Truck_01_transport_F",
"B_Truck_01_covered_F",
"B_MRAP_01_F",
"B_Heli_Light_01_F",
"B_Heli_Transport_01_F",
"B_Heli_Transport_01_camo_F",
"O_MRAP_02_F",
"O_Truck_02_transport_F",
"O_Truck_02_covered_F",
"I_Truck_02_transport_F",
"I_Truck_02_covered_F",
"I_MRAP_03_F",
"I_Heli_Transport_02_F",
"B_UGV_01_F",
"O_UGV_01_F",
"I_UGV_01_F"

]];  

_logic setvariable ["RHQ_Crew", [
"B_Helipilot_F",
"B_crew_F",
"O_helipilot_F",
"O_crew_F",
"I_helicrew_F",
"I_helipilot_F"

]];

// A2
_logic setvariable ["RHQ_Snipers_BAF",
[
"BAF_Soldier_SniperN_MTP",
"BAF_Soldier_SniperH_MTP",
"BAF_Soldier_Sniper_MTP",
"BAF_Soldier_SniperN_W",
"BAF_Soldier_SniperH_W",
"BAF_Soldier_Sniper_W",
"BAF_Soldier_Marksman_DDPM"
]];

_logic setvariable ["RHQ_Snipers_PMC",
[
"Soldier_Sniper_PMC",
"Soldier_Sniper_KSVK_PMC"
]];

_logic setvariable ["RHQ_ATInf_OA",
[
"TK_GUE_Soldier_HAT_EP1",
"TK_GUE_Soldier_AT_EP1",
"US_Soldier_AT_EP1",
"US_Soldier_HAT_EP1",
"US_Soldier_LAT_EP1",
"TK_Soldier_HAT_EP1",
"TK_Soldier_LAT_EP1",
"TK_Soldier_AT_EP1",
"TK_INS_Soldier_AT_EP1",
"UN_CDF_Soldier_AT_EP1"
]];

_logic setvariable ["RHQ_ATInf_ACR",
[
"CZ_Soldier_RPG_Wdl_ACR",
"CZ_Soldier_AT_Wdl_ACR"
]];

_logic setvariable ["RHQ_ATInf_BAF",
[
"BAF_Soldier_AT_MTP",
"BAF_Soldier_HAT_MTP",
"BAF_Soldier_AT_DDPM",
"BAF_Soldier_HAT_DDPM",
"BAF_Soldier_AT_W",
"BAF_Soldier_HAT_W"
]];

_logic setvariable ["RHQ_ATInf_PMC",
[
"Soldier_AT_PMC"
]];

_logic setvariable ["RHQ_AAInf_OA",
[
"M6_EP1",
"ZSU_TK_EP1",
"HMMWV_Avenger_DES_EP1",
"Ural_ZU23_TK_GUE_EP1",
"Ural_ZU23_TK_EP1",
"TK_GUE_Soldier_AA_EP1",
"US_Soldier_AA_EP1",
"TK_Soldier_AA_EP1",
"TK_INS_Soldier_AA_EP1"
]];

_logic setvariable ["RHQ_AAInf_ACR",[]];

_logic setvariable ["RHQ_AAInf_BAF",
[
"BAF_Soldier_AT_MTP",
"BAF_Soldier_HAT_MTP",
"BAF_Soldier_AT_DDPM",
"BAF_Soldier_HAT_DDPM",
"BAF_Soldier_AT_W",
"BAF_Soldier_HAT_W"
]];

_logic setvariable ["RHQ_AAInf_PMC",
[
"Soldier_AA_PMC"
]];

_logic setvariable ["RHQ_Inf_OA",
[
"TK_GUE_Soldier_TL_EP1",
"TK_GUE_Soldier_MG_EP1",
"TK_GUE_Soldier_4_EP1",
"TK_GUE_Soldier_Sniper_EP1",
"TK_GUE_Soldier_5_EP1",
"TK_GUE_Soldier_AT_EP1",
"TK_GUE_Soldier_2_EP1",
"TK_GUE_Soldier_HAT_EP1",
"TK_GUE_Soldier_AT_EP1",
"TK_GUE_Soldier_AA_EP1",
"TK_GUE_Soldier_EP1",
"TK_GUE_Soldier_AR_EP1",
"TK_GUE_Soldier_3_EP1",
"TK_GUE_Bonesetter_EP1",
"TK_GUE_Warlord_EP1",
"TK_CIV_Takistani03_EP1",
"US_Soldier_AA_EP1",
"US_Soldier_AT_EP1",
"US_Soldier_AAT_EP1",
"US_Soldier_HAT_EP1",
"US_Soldier_AHAT_EP1",
"US_Soldier_AR_EP1",
"US_Soldier_AAR_EP1",
"US_Soldier_Crew_EP1",
"US_Soldier_Engineer_EP1",
"US_Soldier_GL_EP1",
"US_Soldier_MG_EP1",
"US_Soldier_AMG_EP1",
"US_Soldier_Marksman_EP1",
"US_Soldier_Medic_EP1",
"US_Soldier_Officer_EP1",
"US_Soldier_Pilot_EP1",
"US_Pilot_Light_EP1",
"US_Soldier_EP1",
"US_Soldier_LAT_EP1",
"US_Soldier_B_EP1",
"US_Soldier_Sniper_EP1",
"US_Soldier_SniperH_EP1",
"US_Soldier_Sniper_NV_EP1",
"US_Soldier_Light_EP1",
"US_Soldier_Spotter_EP1",
"US_Soldier_SL_EP1",
"US_Soldier_TL_EP1",
"TK_Soldier_AA_EP1",
"TK_Soldier_AAT_EP1",
"TK_Soldier_AMG_EP1",
"TK_Soldier_HAT_EP1",
"TK_Soldier_AR_EP1",
"TK_Aziz_EP1",
"TK_Commander_EP1",
"TK_Soldier_Crew_EP1",
"TK_Soldier_Engineer_EP1",
"TK_Soldier_GL_EP1",
"TK_Soldier_MG_EP1",
"TK_Soldier_Medic_EP1",
"TK_Soldier_Officer_EP1",
"TK_Soldier_Pilot_EP1",
"TK_Soldier_EP1",
"TK_Soldier_B_EP1",
"TK_Soldier_LAT_EP1",
"TK_Soldier_AT_EP1",
"TK_Soldier_Sniper_EP1",
"TK_Soldier_SniperH_EP1",
"TK_Soldier_Sniper_Night_EP1",
"TK_Soldier_Night_1_EP1",
"TK_Soldier_Night_2_EP1",
"TK_Soldier_TWS_EP1",
"TK_Soldier_Spotter_EP1",
"TK_Soldier_SL_EP1",
"TK_Special_Forces_MG_EP1",
"TK_Special_Forces_EP1",
"TK_Special_Forces_TL_EP1",
"TK_INS_Soldier_AA_EP1",
"TK_INS_Soldier_AR_EP1",
"TK_INS_Bonesetter_EP1",
"TK_INS_Soldier_MG_EP1",
"TK_INS_Soldier_2_EP1",
"TK_INS_Soldier_EP1",
"TK_INS_Soldier_4_EP1",
"TK_INS_Soldier_3_EP1",
"TK_INS_Soldier_AAT_EP1",
"TK_INS_Soldier_Sniper_EP1",
"TK_INS_Soldier_TL_EP1",
"TK_INS_Warlord_EP1",
"TK_INS_Soldier_AT_EP1",
"TK_GUE_Soldier_AAT_EP1",
"GER_Soldier_MG_EP1",
"GER_Soldier_Medic_EP1",
"GER_Soldier_EP1",
"GER_Soldier_Scout_EP1",
"GER_Soldier_TL_EP1",
"US_Delta_Force_AR_EP1",
"US_Delta_Force_M14_EP1",
"US_Delta_Force_MG_EP1",
"US_Delta_Force_EP1",
"US_Delta_Force_Assault_EP1",
"US_Delta_Force_Marksman_EP1",
"US_Delta_Force_Air_Controller_EP1",
"US_Delta_Force_Medic_EP1",
"US_Delta_Force_Night_EP1",
"CZ_Soldier_AMG_DES_EP1",
"CZ_Soldier_AT_DES_EP1",
"CZ_Soldier_B_DES_EP1",
"CZ_Soldier_DES_EP1",
"CZ_Soldier_Light_DES_EP1",
"CZ_Soldier_MG_DES_EP1",
"CZ_Soldier_Office_DES_EP1",
"CZ_Soldier_Pilot_EP1",
"CZ_Soldier_SL_DES_EP1",
"CZ_Soldier_Sniper_EP1",
"CZ_Special_Forces_DES_EP1",
"CZ_Special_Forces_GL_DES_EP1",
"CZ_Special_Forces_MG_DES_EP1",
"CZ_Special_Forces_Scout_DES_EP1",
"CZ_Special_Forces_TL_DES_EP1",
"Drake",
"Drake_Light",
"Graves",
"Graves_Light",
"Herrera",
"Herrera_Light",
"Pierce",
"Pierce_Light",
"UN_CDF_Soldier_AAT_EP1",
"UN_CDF_Soldier_AMG_EP1",
"UN_CDF_Soldier_Crew_EP1",
"UN_CDF_Soldier_B_EP1",
"UN_CDF_Soldier_AT_EP1",
"UN_CDF_Soldier_Light_EP1",
"UN_CDF_Soldier_SL_EP1",
"UN_CDF_Soldier_Guard_EP1",
"UN_CDF_Soldier_MG_EP1",
"UN_CDF_Soldier_Officer_EP1",
"UN_CDF_Soldier_Pilot_EP1",
"UN_CDF_Soldier_EP1"
]];

_logic setvariable ["RHQ_Inf_ACR",
[
"CZ_Soldier_RPG_Ass_Wdl_ACR",
"CZ_Soldier_MG2_Wdl_ACR",
"CZ_Soldier_Crew_Wdl_ACR",
"CZ_Soldier_Engineer_Wdl_ACR",
"CZ_Soldier_805g_Wdl_ACR",
"CZ_Soldier_MG_Wdl_ACR",
"CZ_Sharpshooter_Wdl_ACR",
"CZ_Soldier_Medic_Wdl_ACR",
"CZ_Soldier_Officer_Wdl_ACR",
"CZ_Soldier_Pilot_Wdl_ACR",
"CZ_Soldier_Wdl_ACR",
"CZ_Soldier_AT_Wdl_ACR",
"CZ_Soldier_805_Wdl_ACR",
"CZ_Soldier_RPG_Wdl_ACR",
"CZ_Soldier_Sniper_ACR",
"CZ_Soldier_Light_Wdl_ACR",
"CZ_Soldier_Spotter_ACR",
"CZ_Soldier_Leader_Wdl_ACR",
"CZ_Soldier_Spec3_Wdl_ACR",
"CZ_Soldier_Spec2_Wdl_ACR",
"CZ_Soldier_Recon_Wdl_ACR",
"CZ_Soldier_Spec_Demo_Wdl_ACR",
"CZ_Soldier_Spec1_Wdl_ACR",
"CZ_Soldier_Crew_Dst_ACR",
"CZ_Soldier_RPG_Dst_ACR",
"CZ_Soldier_medik_DES_EP1",
"CZ_Sharpshooter_DES_ACR",
"CZ_Soldier_MG2_Dst_ACR",
"CZ_Soldier_RPG_Ass_Dst_ACR",
"CZ_Soldier_805g_Dst_ACR",
"CZ_Soldier_Spec_Demo_Dst_ACR",
"CZ_Soldier_Engineer_Dst_ACR",
"CZ_Soldier805_DES_ACR"
]];

_logic setvariable ["RHQ_Inf_BAF",
[
"BAF_Soldier_AA_MTP",
"BAF_Soldier_AAA_MTP",
"BAF_Soldier_AAT_MTP",
"BAF_Soldier_AHAT_MTP",
"BAF_Soldier_AAR_MTP",
"BAF_Soldier_AMG_MTP",
"BAF_Soldier_AT_MTP",
"BAF_Soldier_HAT_MTP",
"BAF_Soldier_AR_MTP",
"BAF_crewman_MTP",
"BAF_Soldier_EN_MTP",
"BAF_Soldier_GL_MTP",
"BAF_Soldier_FAC_MTP",
"BAF_Soldier_MG_MTP",
"BAF_Soldier_scout_MTP",
"BAF_Soldier_Marksman_MTP",
"BAF_Soldier_Medic_MTP",
"BAF_Soldier_Officer_MTP",
"BAF_Pilot_MTP",
"BAF_Soldier_MTP",
"BAF_ASoldier_MTP",
"BAF_Soldier_L_MTP",
"BAF_Soldier_N_MTP",
"BAF_Soldier_SL_MTP",
"BAF_Soldier_SniperN_MTP",
"BAF_Soldier_SniperH_MTP",
"BAF_Soldier_Sniper_MTP",
"BAF_Soldier_spotter_MTP",
"BAF_Soldier_spotterN_MTP",
"BAF_Soldier_TL_MTP",
"BAF_Soldier_AA_DDPM",
"BAF_Soldier_AAA_DDPM",
"BAF_Soldier_AAT_DDPM",
"BAF_Soldier_AHAT_DDPM",
"BAF_Soldier_AAR_DDPM",
"BAF_Soldier_AMG_DDPM",
"BAF_Soldier_AT_DDPM",
"BAF_Soldier_HAT_DDPM",
"BAF_Soldier_AR_DDPM",
"BAF_crewman_DDPM",
"BAF_Soldier_EN_DDPM",
"BAF_Soldier_GL_DDPM",
"BAF_Soldier_FAC_DDPM",
"BAF_Soldier_MG_DDPM",
"BAF_Soldier_scout_DDPM",
"BAF_Soldier_Marksman_DDPM",
"BAF_Soldier_Medic_DDPM",
"BAF_Soldier_Officer_DDPM",
"BAF_Pilot_DDPM",
"BAF_Soldier_DDPM",
"BAF_ASoldier_DDPM",
"BAF_Soldier_L_DDPM",
"BAF_Soldier_N_DDPM",
"BAF_Soldier_SL_DDPM",
"BAF_Soldier_TL_DDPM",
"BAF_Soldier_AA_W",
"BAF_Soldier_AAA_W",
"BAF_Soldier_AAT_W",
"BAF_Soldier_AHAT_W",
"BAF_Soldier_AAR_W",
"BAF_Soldier_AMG_W",
"BAF_Soldier_AT_W",
"BAF_Soldier_HAT_W",
"BAF_Soldier_AR_W",
"BAF_crewman_W",
"BAF_Soldier_EN_W",
"BAF_Soldier_GL_W",
"BAF_Soldier_FAC_W",
"BAF_Soldier_MG_W",
"BAF_Soldier_scout_W",
"BAF_Soldier_Marksman_W",
"BAF_Soldier_Medic_W",
"BAF_Soldier_Officer_W",
"BAF_Pilot_W",
"BAF_Soldier_W",
"BAF_ASoldier_W",
"BAF_Soldier_L_W",
"BAF_Soldier_N_W",
"BAF_Soldier_SL_W",
"BAF_Soldier_SniperN_W",
"BAF_Soldier_SniperH_W",
"BAF_Soldier_Sniper_W",
"BAF_Soldier_spotter_W",
"BAF_Soldier_spotterN_W",
"BAF_Soldier_TL_W"
]];

_logic setvariable ["RHQ_Inf_PMC",
[
"CIV_Contractor1_BAF",
"CIV_Contractor2_BAF",
"Soldier_Bodyguard_M4_PMC",
"Soldier_Bodyguard_AA12_PMC",
"Soldier_Bodyguard_M4_PMC",
"Soldier_Sniper_PMC",
"Soldier_Medic_PMC",
"Soldier_MG_PMC",
"Soldier_MG_PKM_PMC",
"Soldier_AT_PMC",
"Soldier_Engineer_PMC",
"Soldier_GL_M16A2_PMC",
"Soldier_M4A3_PMC",
"Soldier_PMC",
"Soldier_GL_PMC",
"Soldier_Crew_PMC",
"Soldier_Pilot_PMC",
"Soldier_Sniper_KSVK_PMC",
"Soldier_AA_PMC",
"Soldier_TL_PMC",
"Soldier_Sniper_PMC"
]];

_logic setvariable ["RHQ_Art_OA",
[
"D30_TK_GUE_EP1",
"2b14_82mm_TK_GUE_EP1",
"M1129_MC_EP1",
"MLRS_DES_EP1",
"M252_US_EP1",
"M119_US_EP1",
"GRAD_TK_EP1",
"MAZ_543_SCUD_TK_EP1",
"2b14_82mm_TK_EP1",
"D30_TK_EP1",
"2b14_82mm_TK_INS_EP1",
"2b14_82mm_CZ_EP1"
]];

_logic setvariable ["RHQ_Art_ACR",
[
"RM70_ACR"
]];

_logic setvariable ["RHQ_Art_BAF",[]];

_logic setvariable ["RHQ_Art_PMC",[]];

_logic setvariable ["RHQ_HArmor_OA",
[
"T55_TK_GUE_EP1",
"T34_TK_GUE_EP1",
"M1A1_US_DES_EP1",
"M1A2_US_TUSK_MG_EP1",
"T34_TK_EP1",
"T72_TK_EP1",
"T55_TK_EP1"
]];

_logic setvariable ["RHQ_HArmor_ACR",
[
"T72_ACR"
]];

_logic setvariable ["RHQ_HArmor_BAF",[]];

_logic setvariable ["RHQ_HArmor_PMC",[]];

_logic setvariable ["RHQ_MArmor_OA",
[
"M2A2_EP1",
"M2A3_EP1",
"T34_TK_EP1",
"T34_TK_GUE_EP1"
]];

_logic setvariable ["RHQ_MArmor_ACR",
[
"Pandur2_ACR",
"BMP2_Des_ACR",
"BMP2_ACR",
"BVP1_TK_ACR"
]];

_logic setvariable ["RHQ_MArmor_BAF",
[
"BAF_FV510_D",
"BAF_FV510_W"
]];

_logic setvariable ["RHQ_MArmor_PMC",[]];

_logic setvariable ["RHQ_LArmor_OA",
[
"BRDM2_TK_GUE_EP1",
"BRDM2_HQ_TK_GUE_EP1",
"BRDM2_ATGM_TK_EP1",
"M1130_CV_EP1",
"M6_EP1",
"M2A2_EP1",
"M2A3_EP1",
"M1126_ICV_M2_EP1",
"M1126_ICV_mk19_EP1",
"M1135_ATGMV_EP1",
"M1128_MGS_EP1",
"BMP2_TK_EP1",
"BMP2_HQ_TK_EP1",
"BMP2_UN_EP1",
"BRDM2_TK_EP1",
"BTR60_TK_EP1",
"M113_TK_EP1",
"ZSU_TK_EP1",
"M113_UN_EP1"
]];

_logic setvariable ["RHQ_LArmor_ACR",
[
"BRDM2_Desert_ACR",
"BRDM2_ACR",
"BMP2_Des_ACR",
"BMP2_ACR",
"BVP1_TK_ACR",
"Dingo_GL_Wdl_ACR",
"Dingo_WDL_ACR",
"Dingo_DST_ACR",
"Dingo_GL_DST_ACR",
"Pandur2_ACR"
]];

_logic setvariable ["RHQ_LArmor_BAF",
[
"BAF_FV510_D",
"BAF_FV510_W"
]];

_logic setvariable ["RHQ_LArmor_PMC",[]];

_logic setvariable ["RHQ_LArmorAT_OA",
[
"M2A2_EP1",
"M2A3_EP1",
"M1135_ATGMV_EP1",
"M1128_MGS_EP1",
"BMP2_TK_EP1",
"BMP2_UN_EP1"
]];

_logic setvariable ["RHQ_LArmorAT_ACR",
[
"BMP2_Des_ACR",
"BVP1_TK_ACR",
"Pandur2_ACR",
"BVP1_TK_GUE_ACR"
]];

_logic setvariable ["RHQ_LArmorAT_BAF",[]];

_logic setvariable ["RHQ_LArmorAT_PMC",[]];

_logic setvariable ["RHQ_Cars_OA",
[
"UralRefuel_TK_EP1",
"UralReammo_TK_EP1",
"UralRepair_TK_EP1",
"BTR40_TK_GUE_EP1",
"BTR40_MG_TK_GUE_EP1",
"Pickup_PK_TK_GUE_EP1",
"Offroad_SPG9_TK_GUE_EP1",
"Offroad_DSHKM_TK_GUE_EP1",
"V3S_TK_GUE_EP1",
"V3S_Reammo_TK_GUE_EP1",
"ATV_US_EP1",
"ATV_CZ_EP1",
"HMMWV_DES_EP1",
"HMMWV_MK19_DES_EP1",
"HMMWV_TOW_DES_EP1",
"HMMWV_M998_crows_M2_DES_EP1",
"HMMWV_M998_crows_MK19_DES_EP1",
"HMMWV_M1151_M2_DES_EP1",
"HMMWV_M998A2_SOV_DES_EP1",
"HMMWV_Terminal_EP1",
"HMMWV_M1035_DES_EP1",
"HMMWV_Avenger_DES_EP1",
"HMMWV_M1151_M2_CZ_DES_EP1",
"M1030_US_DES_EP1",
"MTVR_DES_EP1",
"LandRover_MG_TK_EP1",
"LandRover_SPG9_TK_EP1",
"LandRover_Special_CZ_EP1",
"TT650_TK_EP1",
"SUV_TK_EP1",
"UAZ_Unarmed_TK_EP1",
"UAZ_AGS30_TK_EP1",
"UAZ_MG_TK_EP1",
"Ural_ZU23_TK_EP1",
"V3S_TK_EP1",
"V3S_Open_TK_EP1",
"BTR40_TK_INS_EP1",
"BTR40_MG_TK_INS_EP1",
"LandRover_MG_TK_INS_EP1",
"LandRover_SPG9_TK_INS_EP1",
"LandRover_CZ_EP1",
"Old_bike_TK_INS_EP1",
"Ural_ZU23_TK_GUE_EP1",
"SUV_UN_EP1",
"UAZ_Unarmed_UN_EP1",
"Ural_UN_EP1"
]];

_logic setvariable ["RHQ_Cars_ACR",
[
"M1114_DSK_ACR",
"LandRover_Ambulance_ACR",
"LandRover_ACR",
"RM70_ACR",
"T810_ACR",
"T810A_MG_ACR",
"T810_Open_ACR",
"T810Reammo_ACR",
"T810Refuel_ACR",
"T810Repair_ACR",
"T810_Des_ACR",
"UAZ_Unarmed_ACR",
"M1114_AGS_ACR",
"T810_Open_Des_ACR",
"T810Refuel_Des_ACR",
"LandRover_Ambulance_Des_ACR"
]];

_logic setvariable ["RHQ_Cars_BAF",
[
"BAF_ATV_D",
"BAF_Jackal2_GMG_D",
"BAF_Jackal2_L2A1_D",
"BAF_Offroad_D",
"BAF_ATV_W",
"BAF_Jackal2_GMG_W",
"BAF_Jackal2_L2A1_W",
"BAF_Offroad_W"
]];

_logic setvariable ["RHQ_Cars_PMC",
[
"SUV_PMC",
"SUV_PMC_BAF",
"ArmoredSUV_PMC"
]];

_logic setvariable ["RHQ_Air_OA",
[
"UH1H_TK_GUE_EP1",
"A10_US_EP1",
"AH64D_EP1",
"AH6J_EP1",
"AH6X_EP1",
"C130J_US_EP1",
"CH_47F_EP1",
"MH6J_EP1",
"MQ9PredatorB_US_EP1",
"UH60M_EP1",
"An2_TK_EP1",
"L39_TK_EP1",
"Mi24_D_TK_EP1",
"Mi17_TK_EP1",
"Su25_TK_EP1",
"UH1H_TK_EP1",
"Mi171Sh_CZ_EP1",
"Mi171Sh_rockets_CZ_EP1",
"Mi17_UN_CDF_EP1"
]];

_logic setvariable ["RHQ_Air_ACR",
[
"L159_ACR",
"L39_ACR",
"L39_2_ACR",
"Mi24_D_CZ_ACR"
]];

_logic setvariable ["RHQ_Air_BAF",
[
"BAF_Apache_AH1_D",
"CH_47F_BAF",
"BAF_Merlin_HC3_D",
"AW159_Lynx_BAF"
]];

_logic setvariable ["RHQ_Air_PMC",
[
"Ka137_PMC",
"Ka137_MG_PMC",
"Ka60_PMC",
"Ka60_GL_PMC"
]];

_logic setvariable ["RHQ_BAir_OA",[]];

_logic setvariable ["RHQ_BAir_ACR",[]];

_logic setvariable ["RHQ_BAir_BAF",[]];

_logic setvariable ["RHQ_BAir_PMC",[]];

_logic setvariable ["RHQ_RAir_OA",
[
"AH6J_EP1",
"AH6X_EP1",
"MQ9PredatorB_US_EP1",
"An2_TK_EP1"
]];

_logic setvariable ["RHQ_RAir_ACR",[]];

_logic setvariable ["RHQ_RAir_BAF",[]];

_logic setvariable ["RHQ_RAir_PMC",
[
"Ka137_PMC"
]];

_logic setvariable ["RHQ_NCAir_OA",
[
"C130J_US_EP1",
"AH6X_EP1",
"MH6J_EP1",
"An2_TK_EP1"
]];

_logic setvariable ["RHQ_NCAir_ACR",[]];

_logic setvariable ["RHQ_NCAir_BAF",[]];

_logic setvariable ["RHQ_NCAir_PMC",
[
"Ka137_PMC"
]];

_logic setvariable ["RHQ_Naval_OA",
[
"SeaFox_EP1"
]];

_logic setvariable ["RHQ_Naval_ACR",
[
"PBX_ACR"
]];

_logic setvariable ["RHQ_Naval_BAF",[]];

_logic setvariable ["RHQ_Naval_PMC",[]];

_logic setvariable ["RHQ_Static_OA",
[
"AGS_TK_GUE_EP1",
"D30_TK_GUE_EP1",
"2b14_82mm_TK_GUE_EP1",
"DSHKM_TK_GUE_EP1",
"DSHkM_Mini_TriPod_TK_GUE_EP1",
"SearchLight_TK_EP1",
"SearchLight_TK_GUE_EP1",
"SearchLight_US_EP1",
"SearchLight_TK_INS_EP1",
"SPG9_TK_GUE_EP1",
"ZU23_TK_GUE_EP1",
"M252_US_EP1",
"M119_US_EP1",
"M2StaticMG_US_EP1",
"M2HD_mini_TriPod_US_EP1",
"MK19_TriPod_US_EP1",
"TOW_TriPod_US_EP1",
"Igla_AA_pod_TK_EP1",
"AGS_TK_EP1",
"D30_TK_EP1",
"KORD_high_TK_EP1",
"KORD_TK_EP1",
"Metis_TK_EP1",
"2b14_82mm_TK_EP1",
"ZU23_TK_EP1",
"AGS_TK_INS_EP1",
"D30_TK_INS_EP1",
"DSHKM_TK_INS_EP1",
"DSHkM_Mini_TriPod_TK_INS_EP1",
"2b14_82mm_TK_INS_EP1",
"SPG9_TK_INS_EP1",
"ZU23_TK_INS_EP1",
"WarfareBMGNest_PK_TK_EP1",
"WarfareBMGNest_PK_TK_GUE_EP1",
"AGS_UN_EP1",
"AGS_CZ_EP1",
"KORD_high_UN_EP1",
"KORD_UN_EP1",
"SearchLight_UN_EP1"
]];

_logic setvariable ["RHQ_Static_ACR",
[
"Rbs70_ACR"
]];

_logic setvariable ["RHQ_Static_BAF",
[
"BAF_GMG_Tripod_D",
"BAF_GPMG_Minitripod_D",
"BAF_L2A1_Minitripod_D",
"BAF_L2A1_Tripod_D",
"BAF_GMG_Tripod_W",
"BAF_GPMG_Minitripod_W",
"BAF_L2A1_Minitripod_W",
"BAF_L2A1_Tripod_W"
]];

_logic setvariable ["RHQ_Static_PMC",[]];

_logic setvariable ["RHQ_StaticAA_OA",
[
"ZU23_TK_GUE_EP1",
"Stinger_Pod_US_EP1",
"Igla_AA_pod_TK_EP1",
"ZU23_TK_EP1",
"ZU23_TK_INS_EP1"
]];

_logic setvariable ["RHQ_StaticAA_ACR",
[
"Rbs70_ACR"
]];

_logic setvariable ["RHQ_StaticAA_BAF",[]];

_logic setvariable ["RHQ_StaticAA_PMC",[]];

_logic setvariable ["RHQ_StaticAT_OA",
[
"SPG9_TK_GUE_EP1",
"TOW_TriPod_US_EP1",
"Metis_TK_EP1",
"SPG9_TK_INS_EP1"
]];

_logic setvariable ["RHQ_StaticAT_ACR",[]];

_logic setvariable ["RHQ_StaticAT_BAF",[]];

_logic setvariable ["RHQ_StaticAT_PMC",[]];

_logic setvariable ["RHQ_Support_OA",
[
"V3S_Reammo_TK_GUE_EP1",
"V3S_Refuel_TK_GUE_EP1",
"V3S_Repair_TK_GUE_EP1",
"HMMWV_Ambulance_DES_EP1",
"HMMWV_Ambulance_CZ_DES_EP1",
"MtvrReammo_DES_EP1",
"MtvrRefuel_DES_EP1",
"MtvrRepair_DES_EP1",
"M1133_MEV_EP1",
"UH60M_MEV_EP1",
"M113Ambul_TK_EP1",
"UralSupply_TK_EP1",
"UralReammo_TK_EP1",
"UralRefuel_TK_EP1",
"UralRepair_TK_EP1",
"M113Ambul_UN_EP1"
]];

_logic setvariable ["RHQ_Support_ACR",
[
"LandRover_Ambulance_ACR",
"T810Reammo_ACR",
"T810Refuel_ACR",
"T810Repair_ACR",
"T810Repair_Des_ACR",
"T810Reammo_Des_ACR",
"T810Refuel_Des_ACR"
]];

_logic setvariable ["RHQ_Support_BAF",[]];

_logic setvariable ["RHQ_Support_PMC",[]];

_logic setvariable ["RHQ_Cargo_OA",
[
"UH1H_TK_GUE_EP1",
"M1126_ICV_M2_EP1",
"M1126_ICV_mk19_EP1",
"M6_EP1",
"M2A3_EP1",
"BTR60_TK_EP1",
"M113_TK_EP1",
"BMP2_TK_EP1",
"V3S_TK_EP1",
"V3S_Open_TK_EP1",
"SUV_TK_EP1",
"UAZ_Unarmed_TK_EP1",
"BTR40_TK_INS_EP1",
"CH_47F_EP1",
"UH60M_EP1",
"BRDM2_ATGM_TK_EP1",
"LandRover_Special_CZ_EP1",
"Mi171Sh_CZ_EP1",
"Mi171Sh_rockets_CZ_EP1"
]];

_logic setvariable ["RHQ_Cargo_ACR",
[
"BMP2_ACR",
"BRDM2_ACR",
"BRDM2_Desert_ACR",
"BRDM2_Desert_ACR",
"BRDM2_ACR",
"Dingo_GL_Wdl_ACR",
"Dingo_WDL_ACR",
"Dingo_DST_ACR",
"Dingo_GL_DST_ACR",
"LandRover_ACR",
"T810_ACR",
"T810A_MG_ACR",
"T810_Open_ACR",
"T810A_Des_MG_ACR",
"Mi24_D_CZ_ACR"
]];

_logic setvariable ["RHQ_Cargo_BAF",
[
"BAF_Offroad_D",
"BAF_Offroad_W",
"BAF_FV510_D",
"BAF_FV510_W"
]];

_logic setvariable ["RHQ_Cargo_PMC",
[
"SUV_PMC",
"SUV_PMC_BAF",
"ArmoredSUV_PMC",
"Ka60_PMC",
"Ka60_GL_PMC"
]];

_logic setvariable ["RHQ_NCCargo_OA",
[
"BTR40_TK_GUE_EP1",
"V3S_TK_GUE_EP1",
"MH6J_EP1",
"HMMWV_DES_EP1",
"MTVR_DES_EP1",
"SUV_TK_EP1",
"UAZ_Unarmed_TK_EP1",
"V3S_TK_EP1",
"V3S_Open_TK_EP1",
"SUV_UN_EP1",
"UAZ_Unarmed_UN_EP1",
"Ural_UN_EP1"
]];

_logic setvariable ["RHQ_NCCargo_ACR",
[
"LandRover_ACR",
"T810_ACR",
"T810_Open_ACR",
"T810_Open_Des_ACR",
"UAZ_Unarmed_ACR"
]];

_logic setvariable ["RHQ_NCCargo_BAF",[]];

_logic setvariable ["RHQ_NCCargo_PMC",
[
"SUV_PMC",
"SUV_PMC_BAF",
"Ka60_PMC"
]];

_logic setvariable ["RHQ_Crew_OA",
[
"US_Soldier_Crew_EP1",
"US_Soldier_Pilot_EP1",
"US_Pilot_Light_EP1",
"TK_Soldier_Crew_EP1",
"TK_Soldier_Pilot_EP1",
"CZ_Soldier_Pilot_EP1",
"UN_CDF_Soldier_Pilot_EP1"
]];

_logic setvariable ["RHQ_Crew_ACR",
[
"CZ_Soldier_Crew_Wdl_ACR",
"CZ_Soldier_Pilot_Wdl_ACR",
"CZ_Soldier_Crew_Dst_ACR"
]];

_logic setvariable ["RHQ_Crew_BAF",
[
"BAF_crewman_MTP",
"BAF_Pilot_MTP",
"BAF_crewman_DDPM",
"BAF_Pilot_DDPM",
"BAF_creWman_W",
"BAF_Pilot_W"
]];

_logic setvariable ["RHQ_Crew_PMC",
[
"Soldier_Crew_PMC",
"Soldier_Pilot_PMC"
]];

_logic setvariable ["HAC_HQ_Howitzer", []];
_logic setvariable ["HAC_HQ_Mortar", ["O_Mortar_01_F","B_Mortar_01_F"]];
_logic setvariable ["HAC_HQ_Rocket", []];

_logic setvariable ["HAC_xHQ_AIC_OrdConf", 
	[
    /*
	"HAC_OrdConf1",
	"HAC_OrdConf2",
	"HAC_OrdConf3",
	"HAC_OrdConf4",
	"HAC_OrdConf5",
	"v2HAC_OrdConf1",
	"v2HAC_OrdConf2",
	"v2HAC_OrdConf3",
	"v2HAC_OrdConf4",
	"v2HAC_OrdConf5",
	"v3HAC_OrdConf1",
	"v3HAC_OrdConf2",
	"v3HAC_OrdConf3",
	"v3HAC_OrdConf4",
	"v3HAC_OrdConf5"
    */
	]];

_logic setvariable ["HAC_xHQ_AIC_OrdDen", 
	[
    /*
	"HAC_OrdDen1",
	"HAC_OrdDen2",
	"HAC_OrdDen3",
	"HAC_OrdDen4",
	"HAC_OrdDen5",
	"v2HAC_OrdDen1",
	"v2HAC_OrdDen2",
	"v2HAC_OrdDen3",
	"v2HAC_OrdDen4",
	"v2HAC_OrdDen5",
	"v3HAC_OrdDen1",
	"v3HAC_OrdDen2",
	"v3HAC_OrdDen3",
	"v3HAC_OrdDen4",
	"v3HAC_OrdDen5"
    */
	]];

_logic setvariable ["HAC_xHQ_AIC_OrdFinal", 
	[
    /*
	"HAC_OrdFinal1",
	"HAC_OrdFinal2",
	"HAC_OrdFinal3",
	"HAC_OrdFinal4",
	"v2HAC_OrdFinal1",
	"v2HAC_OrdFinal2",
	"v2HAC_OrdFinal3",
	"v2HAC_OrdFinal4",
	"v3HAC_OrdFinal1",
	"v3HAC_OrdFinal2",
	"v3HAC_OrdFinal3",
	"v3HAC_OrdFinal4"
    */
    ]];

_logic setvariable ["HAC_xHQ_AIC_OrdEnd", 
	[
    /*
	"HAC_OrdEnd1",
	"HAC_OrdEnd2",
	"HAC_OrdEnd3",
	"HAC_OrdEnd4",
	"v2HAC_OrdEnd1",
	"v2HAC_OrdEnd2",
	"v2HAC_OrdEnd3",
	"v2HAC_OrdEnd4",
	"v3HAC_OrdEnd1",
	"v3HAC_OrdEnd2",
	"v3HAC_OrdEnd3",
	"v3HAC_OrdEnd4"
    */
	]];

_logic setvariable ["HAC_xHQ_AIC_SuppReq", 
	[
    /*
	"HAC_SuppReq1",
	"HAC_SuppReq2",
	"HAC_SuppReq3",
	"HAC_SuppReq4",
	"HAC_SuppReq5",
	"v2HAC_SuppReq1",
	"v2HAC_SuppReq2",
	"v2HAC_SuppReq3",
	"v2HAC_SuppReq4",
	"v2HAC_SuppReq5",
	"v3HAC_SuppReq1",
	"v3HAC_SuppReq2",
	"v3HAC_SuppReq3",
	"v3HAC_SuppReq4",
	"v3HAC_SuppReq5"
    */
	]];

_logic setvariable ["HAC_xHQ_AIC_MedReq", 
	[
    /*
	"HAC_MedReq1",
	"HAC_MedReq2",
	"HAC_MedReq3",
	"HAC_MedReq4",
	"HAC_MedReq5",
	"v2HAC_MedReq1",
	"v2HAC_MedReq2",
	"v2HAC_MedReq3",
	"v2HAC_MedReq4",
	"v2HAC_MedReq5",
	"v3HAC_MedReq1",
	"v3HAC_MedReq2",
	"v3HAC_MedReq3",
	"v3HAC_MedReq4",
	"v3HAC_MedReq5"
    */
	]];

_logic setvariable ["HAC_xHQ_AIC_ArtyReq", 
	[
    /*
	"HAC_ArtyReq1",
	"HAC_ArtyReq2",
	"HAC_ArtyReq3",
	"HAC_ArtyReq4",
	"HAC_ArtyReq5",
	"v2HAC_ArtyReq1",
	"v2HAC_ArtyReq2",
	"v2HAC_ArtyReq3",
	"v2HAC_ArtyReq4",
	"v2HAC_ArtyReq5",
	"v3HAC_ArtyReq1",
	"v3HAC_ArtyReq2",
	"v3HAC_ArtyReq3",
	"v3HAC_ArtyReq4",
	"v3HAC_ArtyReq5"
    */
	]];

_logic setvariable ["HAC_xHQ_AIC_SmokeReq", 
	[
    /*
	"HAC_SmokeReq1",
	"HAC_SmokeReq2",
	"HAC_SmokeReq3",
	"HAC_SmokeReq4",
	"v2HAC_SmokeReq1",
	"v2HAC_SmokeReq2",
	"v2HAC_SmokeReq3",
	"v2HAC_SmokeReq4",
	"v3HAC_SmokeReq1",
	"v3HAC_SmokeReq2",
	"v3HAC_SmokeReq3",
	"v3HAC_SmokeReq4"
    */
	]];

_logic setvariable ["HAC_xHQ_AIC_IllumReq", 
	[
    /*
	"HAC_IllumReq1",
	"HAC_IllumReq2",
	"HAC_IllumReq3",
	"HAC_IllumReq4",
	"v2HAC_IllumReq1",
	"v2HAC_IllumReq2",
	"v2HAC_IllumReq3",
	"v2HAC_IllumReq4",
	"v3HAC_IllumReq1",
	"v3HAC_IllumReq2",
	"v3HAC_IllumReq3",
	"v3HAC_IllumReq4"
    */
	]];

_logic setvariable ["HAC_xHQ_AIC_InDanger", 
	[
    /*
	"HAC_InDanger1",
	"HAC_InDanger2",
	"HAC_InDanger3",
	"HAC_InDanger4",
	"HAC_InDanger5",
	"HAC_InDanger6",
	"HAC_InDanger7",
	"HAC_InDanger8",
	"HAC_InDanger9",
	"HAC_InDanger10",
	"HAC_InDanger11",
	"HAC_InDanger12",
	"HAC_InDanger13",
	"v2HAC_InDanger1",
	"v2HAC_InDanger2",
	"v2HAC_InDanger3",
	"v2HAC_InDanger4",
	"v2HAC_InDanger5",
	"v2HAC_InDanger6",
	"v2HAC_InDanger7",
	"v2HAC_InDanger8",
	"v2HAC_InDanger9",
	"v2HAC_InDanger10",
	"v2HAC_InDanger11",
	"v2HAC_InDanger12",
	"v2HAC_InDanger13",
	"v3HAC_InDanger1",
	"v3HAC_InDanger2",
	"v3HAC_InDanger3",
	"v3HAC_InDanger4",
	"v3HAC_InDanger5",
	"v3HAC_InDanger6",
	"v3HAC_InDanger7",
	"v3HAC_InDanger8",
	"v3HAC_InDanger9",
	"v3HAC_InDanger10",
	"v3HAC_InDanger11",
	"v3HAC_InDanger12",
	"v3HAC_InDanger13"
    */
	]];

_logic setvariable ["HAC_xHQ_AIC_EnemySpot", 
	[
    /*
	"HAC_EnemySpot1",
	"HAC_EnemySpot2",
	"HAC_EnemySpot3",
	"HAC_EnemySpot4",
	"HAC_EnemySpot5",
	"v2HAC_EnemySpot1",
	"v2HAC_EnemySpot2",
	"v2HAC_EnemySpot3",
	"v2HAC_EnemySpot4",
	"v2HAC_EnemySpot5",
	"v3HAC_EnemySpot1",
	"v3HAC_EnemySpot2",
	"v3HAC_EnemySpot3",
	"v3HAC_EnemySpot4",
	"v3HAC_EnemySpot5"
    */
	]];

_logic setvariable ["HAC_xHQ_AIC_InFear", 
	[
    /*
	"HAC_InFear1",
	"HAC_InFear2",
	"HAC_InFear3",
	"HAC_InFear4",
	"HAC_InFear5",
	"HAC_InFear6",
	"HAC_InFear7",
	"HAC_InFear8",
	"v2HAC_InFear1",
	"v2HAC_InFear2",
	"v2HAC_InFear3",
	"v2HAC_InFear4",
	"v2HAC_InFear5",
	"v2HAC_InFear6",
	"v2HAC_InFear7",
	"v2HAC_InFear8",
	"v3HAC_InFear1",
	"v3HAC_InFear2",
	"v3HAC_InFear3",
	"v3HAC_InFear4",
	"v3HAC_InFear5",
	"v3HAC_InFear6",
	"v3HAC_InFear7",
	"v3HAC_InFear8"
    */
	]];

_logic setvariable ["HAC_xHQ_AIC_InPanic", 
	[
    /*
	"HAC_InPanic1",
	"HAC_InPanic2",
	"HAC_InPanic3",
	"HAC_InPanic4",
	"HAC_InPanic5",
	"HAC_InPanic6",
	"HAC_InPanic7",
	"HAC_InPanic8",
	"v2HAC_InPanic1",
	"v2HAC_InPanic2",
	"v2HAC_InPanic3",
	"v2HAC_InPanic4",
	"v2HAC_InPanic5",
	"v2HAC_InPanic6",
	"v2HAC_InPanic7",
	"v2HAC_InPanic8",
	"v3HAC_InPanic1",
	"v3HAC_InPanic2",
	"v3HAC_InPanic3",
	"v3HAC_InPanic4",
	"v3HAC_InPanic5",
	"v3HAC_InPanic6",
	"v3HAC_InPanic7",
	"v3HAC_InPanic8"
    */
	]];

_logic setvariable ["HAC_xHQ_AIC_SuppAss", 
	[
    /*
	"v2HAC_SuppAss1",
	"v2HAC_SuppAss2",
	"v2HAC_SuppAss3",
	"v2HAC_SuppAss4",
	"v2HAC_SuppAss5"
    */
	]];

_logic setvariable ["HAC_xHQ_AIC_SuppDen", 
	[
    /*
	"v2HAC_SuppDen1",
	"v2HAC_SuppDen2",
	"v2HAC_SuppDen3",
	"v2HAC_SuppDen4",
	"v2HAC_SuppDen5"
    */
	]];

_logic setvariable ["HAC_xHQ_AIC_ArtAss", 
	[
    /*
	"v2HAC_ArtAss1",
	"v2HAC_ArtAss2",
	"v2HAC_ArtAss3",
	"v2HAC_ArtAss4",
	"v2HAC_ArtAss5"
    */
	]];

_logic setvariable ["HAC_xHQ_AIC_ArtDen", 
	[
    /*
	"v2HAC_ArtDen1",
	"v2HAC_ArtDen2",
	"v2HAC_ArtDen3",
	"v2HAC_ArtDen4",
	"v2HAC_ArtDen5"
    */
	]];

_logic setvariable ["HAC_xHQ_AIC_DefStance", 
	[
    /*
	"v2HAC_DefStance1"
    */
	]];

_logic setvariable ["HAC_xHQ_AIC_OffStance", 
	[
    /*
	"v2HAC_OffStance1"
    */
	]];

_logic setvariable ["HAC_xHQ_AIC_ArtFire", 
	[
    /*
	"HAC_ArtFire1",
	"HAC_ArtFire2",
	"HAC_ArtFire3",
	"HAC_ArtFire4",
	"HAC_ArtFire5"
    */
	]];

//Dont touch this
if (isNil {_logic getvariable "HAC_BB_Active"}) then {_logic setvariable ["HAC_BB_Active",false]};
if (isNil {_logic getvariable "HAC_BBa_HQs"}) then {_logic setvariable ["HAC_BBa_HQs",[]]};
if (isNil {_logic getvariable "HAC_BBb_HQs"}) then {_logic setvariable ["HAC_BBb_HQs",[]]};
if (isNil {_logic getvariable "HAC_BB_Debug"}) then {_logic setvariable ["HAC_BB_Debug",false]};
if (isNil {_logic getvariable "HAC_BBa_SimpleDebug"}) then {_logic setvariable ["HAC_BBa_SimpleDebug",false]};
if (isNil {_logic getvariable "HAC_BBb_SimpleDebug"}) then {_logic setvariable ["HAC_BBb_SimpleDebug",false]};
if (isNil {_logic getvariable "HAC_BB_BBOnMap"}) then {_logic setvariable ["HAC_BB_BBOnMap",false]};
if (isNil {_logic getvariable "HAC_BB_CustomObjOnly"}) then {_logic setvariable ["HAC_BB_CustomObjOnly",false]};
if (isNil {_logic getvariable "HAC_BB_LRelocating"}) then {_logic setvariable ["HAC_BB_LRelocating",true]};
if (isNil {_logic getvariable "HAC_HQ_PathFinding"}) then {_logic setvariable ["HAC_HQ_PathFinding",0]};
if (isNil {_logic getvariable "HAC_xHQ_SynchroAttack"}) then {_logic setvariable ["HAC_xHQ_SynchroAttack",false]};
if (isNil {_logic getvariable "HAC_HQ_TimeM"}) then {_logic setvariable ["HAC_HQ_TimeM",false]};
if (isNil {_logic getvariable "HAC_xHQ_GPauseActive"}) then {_logic setvariable ["HAC_xHQ_GPauseActive",false]};
if (isNil {_logic getvariable "HAC_xHQ_AllLeaders"}) then {_logic setvariable ["HAC_xHQ_AllLeaders",[]]};
if (isNil {_logic getvariable "HAC_HQ_DbgMon"}) then {_logic setvariable ["HAC_HQ_DbgMon",true]};
if (isNil {_logic getvariable "RHQ_SpecFor"}) then {_logic setvariable ["RHQ_SpecFor",[]]};
if (isNil {_logic getvariable "RHQ_Recon"}) then {_logic setvariable ["RHQ_Recon",[]]};
if (isNil {_logic getvariable "RHQ_FO"}) then {_logic setvariable ["RHQ_FO",[]]};
if (isNil {_logic getvariable "RHQ_Snipers"}) then {_logic setvariable ["RHQ_Snipers",[]]};
if (isNil {_logic getvariable "RHQ_ATInf"}) then {_logic setvariable ["RHQ_ATInf",[]]};
if (isNil {_logic getvariable "RHQ_AAInf"}) then {_logic setvariable ["RHQ_AAInf",[]]};
if (isNil {_logic getvariable "RHQ_Inf"}) then {_logic setvariable ["RHQ_Inf",[]]};
if (isNil {_logic getvariable "RHQ_Art"}) then {_logic setvariable ["RHQ_Art",[]]};
if (isNil {_logic getvariable "RHQ_HArmor"}) then {_logic setvariable ["RHQ_HArmor",[]]};
if (isNil {_logic getvariable "RHQ_LArmor"}) then {_logic setvariable ["RHQ_LArmor",[]]};
if (isNil {_logic getvariable "RHQ_LArmorAT"}) then {_logic setvariable ["RHQ_LArmorAT",[]]};
if (isNil {_logic getvariable "RHQ_Cars"}) then {_logic setvariable ["RHQ_Cars",[]]};
if (isNil {_logic getvariable "RHQ_Air"}) then {_logic setvariable ["RHQ_Air",[]]};
if (isNil {_logic getvariable "RHQ_NCAir"}) then {_logic setvariable ["RHQ_NCAir",[]]};
if (isNil {_logic getvariable "RHQ_Naval"}) then {_logic setvariable ["RHQ_Naval",[]]};
if (isNil {_logic getvariable "RHQ_Static"}) then {_logic setvariable ["RHQ_Static",[]]};
if (isNil {_logic getvariable "RHQ_StaticAA"}) then {_logic setvariable ["RHQ_StaticAA",[]]};
if (isNil {_logic getvariable "RHQ_StaticAT"}) then {_logic setvariable ["RHQ_StaticAT",[]]};
if (isNil {_logic getvariable "RHQ_Support"}) then {_logic setvariable ["RHQ_Support",[]]};
if (isNil {_logic getvariable "RHQ_Cargo"}) then {_logic setvariable ["RHQ_Cargo",[]]};
if (isNil {_logic getvariable "RHQ_NCCargo"}) then {_logic setvariable ["RHQ_NCCargo",[]]};
if (isNil {_logic getvariable "RHQ_Other"}) then {_logic setvariable ["RHQ_Other",[]]};
if (isNil {_logic getvariable "RHQ_Crew"}) then {_logic setvariable ["RHQ_Crew",[]]};
if (isNil {_logic getvariable "RHQ_MArmor"}) then {_logic setvariable ["RHQ_MArmor",[]]};
if (isNil {_logic getvariable "RHQ_BAir"}) then {_logic setvariable ["RHQ_BAir",[]]};
if (isNil {_logic getvariable "RHQ_RAir"}) then {_logic setvariable ["RHQ_RAir",[]]};
if (isNil {_logic getvariable "RHQ_Ammo"}) then {_logic setvariable ["RHQ_Ammo",[]]};
if (isNil {_logic getvariable "RHQ_Fuel"}) then {_logic setvariable ["RHQ_Fuel",[]]};
if (isNil {_logic getvariable "RHQ_Med"}) then {_logic setvariable ["RHQ_Med",[]]};
if (isNil {_logic getvariable "RHQ_Rep"}) then {_logic setvariable ["RHQ_Rep",[]]};
if (isNil {_logic getvariable "RHQs_SpecFor"}) then {_logic setvariable ["RHQs_SpecFor",[]]};
if (isNil {_logic getvariable "RHQs_Recon"}) then {_logic setvariable ["RHQs_Recon",[]]};
if (isNil {_logic getvariable "RHQs_FO"}) then {_logic setvariable ["RHQs_FO",[]]};
if (isNil {_logic getvariable "RHQs_Snipers"}) then {_logic setvariable ["RHQs_Snipers",[]]};
if (isNil {_logic getvariable "RHQs_ATInf"}) then {_logic setvariable ["RHQs_ATInf",[]]};
if (isNil {_logic getvariable "RHQs_AAInf"}) then {_logic setvariable ["RHQs_AAInf",[]]};
if (isNil {_logic getvariable "RHQs_Inf"}) then {_logic setvariable ["RHQs_Inf",[]]};
if (isNil {_logic getvariable "RHQs_Art"}) then {_logic setvariable ["RHQs_Art",[]]};
if (isNil {_logic getvariable "RHQs_HArmor"}) then {_logic setvariable ["RHQs_HArmor",[]]};
if (isNil {_logic getvariable "RHQs_LArmor"}) then {_logic setvariable ["RHQs_LArmor",[]]};
if (isNil {_logic getvariable "RHQs_LArmorAT"}) then {_logic setvariable ["RHQs_LArmorAT",[]]};
if (isNil {_logic getvariable "RHQs_Cars"}) then {_logic setvariable ["RHQs_Cars",[]]};
if (isNil {_logic getvariable "RHQs_Air"}) then {_logic setvariable ["RHQs_Air",[]]};
if (isNil {_logic getvariable "RHQs_NCAir"}) then {_logic setvariable ["RHQs_NCAir",[]]};
if (isNil {_logic getvariable "RHQs_Naval"}) then {_logic setvariable ["RHQs_Naval",[]]};
if (isNil {_logic getvariable "RHQs_Static"}) then {_logic setvariable ["RHQs_Static",[]]};
if (isNil {_logic getvariable "RHQs_StaticAA"}) then {_logic setvariable ["RHQs_StaticAA",[]]};
if (isNil {_logic getvariable "RHQs_StaticAT"}) then {_logic setvariable ["RHQs_StaticAT",[]]};
if (isNil {_logic getvariable "RHQs_Support"}) then {_logic setvariable ["RHQs_Support",[]]};
if (isNil {_logic getvariable "RHQs_Cargo"}) then {_logic setvariable ["RHQs_Cargo",[]]};
if (isNil {_logic getvariable "RHQs_NCCargo"}) then {_logic setvariable ["RHQs_NCCargo",[]]};
if (isNil {_logic getvariable "RHQs_Other"}) then {_logic setvariable ["RHQs_Other",[]]};
if (isNil {_logic getvariable "RHQs_Crew"}) then {_logic setvariable ["RHQs_Crew",[]]};
if (isNil {_logic getvariable "RHQs_MArmor"}) then {_logic setvariable ["RHQs_MArmor",[]]};
if (isNil {_logic getvariable "RHQs_BAir"}) then {_logic setvariable ["RHQs_BAir",[]]};
if (isNil {_logic getvariable "RHQs_RAir"}) then {_logic setvariable ["RHQs_RAir",[]]};
if (isNil {_logic getvariable "RHQs_Ammo"}) then {_logic setvariable ["RHQs_Ammo",[]]};
if (isNil {_logic getvariable "RHQs_Fuel"}) then {_logic setvariable ["RHQs_Fuel",[]]};
if (isNil {_logic getvariable "RHQs_Med"}) then {_logic setvariable ["RHQs_Med",[]]};
if (isNil {_logic getvariable "RHQs_Rep"}) then {_logic setvariable ["RHQs_Rep",[]]};
if (isNil {_logic getvariable "HAC_HQ_Debug"}) then {_logic setvariable ["HAC_HQ_Debug",false]};
if (isNil {_logic getvariable "HAC_HQB_Debug"}) then {_logic setvariable ["HAC_HQB_Debug",false]};
if (isNil {_logic getvariable "HAC_HQC_Debug"}) then {_logic setvariable ["HAC_HQC_Debug",false]};
if (isNil {_logic getvariable "HAC_HQD_Debug"}) then {_logic setvariable ["HAC_HQD_Debug",false]};
if (isNil {_logic getvariable "HAC_HQE_Debug"}) then {_logic setvariable ["HAC_HQE_Debug",false]};
if (isNil {_logic getvariable "HAC_HQF_Debug"}) then {_logic setvariable ["HAC_HQF_Debug",false]};
if (isNil {_logic getvariable "HAC_HQG_Debug"}) then {_logic setvariable ["HAC_HQG_Debug",false]};
if (isNil {_logic getvariable "HAC_HQH_Debug"}) then {_logic setvariable ["HAC_HQH_Debug",false]};
if (isNil {_logic getvariable "HAC_HQ_OALib"}) then {_logic setvariable ["HAC_HQ_OALib",false]};
if (isNil {_logic getvariable "HAC_HQ_ACRLib"}) then {_logic setvariable ["HAC_HQ_ACRLib",false]};
if (isNil {_logic getvariable "HAC_HQ_BAFLib"}) then {_logic setvariable ["HAC_HQ_BAFLib",false]};
if (isNil {_logic getvariable "HAC_HQ_PMCLib"}) then {_logic setvariable ["HAC_HQ_PMCLib",false]};
if (isNil {_logic getvariable "HAC_xHQ_AIChatDensity"}) then {_logic setvariable ["HAC_xHQ_AIChatDensity",10]};
if (isNil {_logic getvariable "HAC_xHQ_NEAware"}) then {_logic setvariable ["HAC_xHQ_NEAware",0]};
if (isNil {_logic getvariable "HAC_xHQ_MARatio"}) then {_logic setvariable ["HAC_xHQ_MARatio",[-1,-1,-1,-1]]};

if (isNil {_logic getvariable ["HAC_HQ_Obj1",nil]}) then {_logic setvariable ["HAC_HQ_Obj1", vehicle _logic]};
if (isNil {_logic getvariable ["HAC_HQ_Obj2",nil]}) then {_logic setvariable ["HAC_HQ_Obj2", (_logic getvariable "HAC_HQ_Obj1")]};
if (isNil {_logic getvariable ["HAC_HQ_Obj3",nil]}) then {_logic setvariable ["HAC_HQ_Obj3", (_logic getvariable "HAC_HQ_Obj2")]};
if (isNil {_logic getvariable ["HAC_HQ_Obj4",nil]}) then {_logic setvariable ["HAC_HQ_Obj4", (_logic getvariable "HAC_HQ_Obj3")]};

if (_logic getvariable ["HAC_HQ_OALib",false]) then
	{
		_logic setvariable ["RHQ_SpecFor",(_logic getvariable "RHQ_SpecFor") + (_logic getvariable "RHQ_SpecFor_OA")];
		_logic setvariable ["RHQ_Recon",(_logic getvariable "RHQ_Recon") + (_logic getvariable "RHQ_Recon_OA")];
		_logic setvariable ["RHQ_FO",(_logic getvariable "RHQ_FO") + (_logic getvariable "RHQ_FO_OA")];
		_logic setvariable ["RHQ_Snipers",(_logic getvariable "RHQ_Snipers") + (_logic getvariable "RHQ_Snipers_OA")];
		_logic setvariable ["RHQ_ATInf",(_logic getvariable "RHQ_ATInf") + (_logic getvariable "RHQ_ATInf_OA")];
		_logic setvariable ["RHQ_AAInf",(_logic getvariable "RHQ_AAInf") + (_logic getvariable "RHQ_AAInf_OA")];
		_logic setvariable ["RHQ_Inf",(_logic getvariable "RHQ_Inf") + (_logic getvariable "RHQ_Inf_OA")];
		_logic setvariable ["RHQ_Art",(_logic getvariable "RHQ_Art") + (_logic getvariable "RHQ_Art_OA")];
		_logic setvariable ["RHQ_HArmor",(_logic getvariable "RHQ_HArmor") + (_logic getvariable "RHQ_HArmor_OA")];
		_logic setvariable ["RHQ_MArmor",(_logic getvariable "RHQ_MArmor") + (_logic getvariable "RHQ_MArmor_OA")];
		_logic setvariable ["RHQ_LArmor",(_logic getvariable "RHQ_LArmor") + (_logic getvariable "RHQ_LArmor_OA")];
		_logic setvariable ["RHQ_LArmorAT",(_logic getvariable "RHQ_LArmorAT") + (_logic getvariable "RHQ_LArmorAT_OA")];
		_logic setvariable ["RHQ_Cars",(_logic getvariable "RHQ_Cars") + (_logic getvariable "RHQ_Cars_OA")];
		_logic setvariable ["RHQ_Air",(_logic getvariable "RHQ_Air") + (_logic getvariable "RHQ_Air_OA")];
		_logic setvariable ["RHQ_BAir",(_logic getvariable "RHQ_BAir") + (_logic getvariable "RHQ_BAir_OA")];
		_logic setvariable ["RHQ_RAir",(_logic getvariable "RHQ_RAir") + (_logic getvariable "RHQ_RAir_OA")];
		_logic setvariable ["RHQ_NCAir",(_logic getvariable "RHQ_NCAir") + (_logic getvariable "RHQ_NCAir_OA")];
		_logic setvariable ["RHQ_Naval",(_logic getvariable "RHQ_Naval") + (_logic getvariable "RHQ_Naval_OA")];
		_logic setvariable ["RHQ_Static",(_logic getvariable "RHQ_Static") + (_logic getvariable "RHQ_Static_OA")];
		_logic setvariable ["RHQ_StaticAA",(_logic getvariable "RHQ_StaticAA") + (_logic getvariable "RHQ_StaticAA_OA")];
		_logic setvariable ["RHQ_StaticAT",(_logic getvariable "RHQ_StaticAT") + (_logic getvariable "RHQ_StaticAT_OA")];
		_logic setvariable ["RHQ_Support",(_logic getvariable "RHQ_Support") + (_logic getvariable "RHQ_Support_OA")];
		_logic setvariable ["RHQ_Cargo",(_logic getvariable "RHQ_Cargo") + (_logic getvariable "RHQ_Cargo_OA")];
		_logic setvariable ["RHQ_NCCargo",(_logic getvariable "RHQ_NCCargo") + (_logic getvariable "RHQ_NCCargo_OA")];
		_logic setvariable ["RHQ_Crew",(_logic getvariable "RHQ_Crew") + (_logic getvariable "RHQ_Crew_OA")];
	};

if (_logic getvariable ["HAC_HQ_ACRLib",false]) then
	{
		_logic setvariable ["RHQ_SpecFor",(_logic getvariable "RHQ_SpecFor") + (_logic getvariable "RHQ_SpecFor_ACR")];
		_logic setvariable ["RHQ_Recon",(_logic getvariable "RHQ_Recon") + (_logic getvariable "RHQ_Recon_ACR")];
		_logic setvariable ["RHQ_FO",(_logic getvariable "RHQ_FO") + (_logic getvariable "RHQ_FO_ACR")];
		_logic setvariable ["RHQ_Snipers",(_logic getvariable "RHQ_Snipers") + (_logic getvariable "RHQ_Snipers_ACR")];
		_logic setvariable ["RHQ_ATInf",(_logic getvariable "RHQ_ATInf") + (_logic getvariable "RHQ_ATInf_ACR")];
		_logic setvariable ["RHQ_AAInf",(_logic getvariable "RHQ_AAInf") + (_logic getvariable "RHQ_AAInf_ACR")];
		_logic setvariable ["RHQ_Inf",(_logic getvariable "RHQ_Inf") + (_logic getvariable "RHQ_Inf_ACR")];
		_logic setvariable ["RHQ_Art",(_logic getvariable "RHQ_Art") + (_logic getvariable "RHQ_Art_ACR")];
		_logic setvariable ["RHQ_HArmor",(_logic getvariable "RHQ_HArmor") + (_logic getvariable "RHQ_HArmor_ACR")];
		_logic setvariable ["RHQ_MArmor",(_logic getvariable "RHQ_MArmor") + (_logic getvariable "RHQ_MArmor_ACR")];
		_logic setvariable ["RHQ_LArmor",(_logic getvariable "RHQ_LArmor") + (_logic getvariable "RHQ_LArmor_ACR")];
		_logic setvariable ["RHQ_LArmorAT",(_logic getvariable "RHQ_LArmorAT") + (_logic getvariable "RHQ_LArmorAT_ACR")];
		_logic setvariable ["RHQ_Cars",(_logic getvariable "RHQ_Cars") + (_logic getvariable "RHQ_Cars_ACR")];
		_logic setvariable ["RHQ_Air",(_logic getvariable "RHQ_Air") + (_logic getvariable "RHQ_Air_ACR")];
		_logic setvariable ["RHQ_BAir",(_logic getvariable "RHQ_BAir") + (_logic getvariable "RHQ_BAir_ACR")];
		_logic setvariable ["RHQ_RAir",(_logic getvariable "RHQ_RAir") + (_logic getvariable "RHQ_RAir_ACR")];
		_logic setvariable ["RHQ_NCAir",(_logic getvariable "RHQ_NCAir") + (_logic getvariable "RHQ_NCAir_ACR")];
		_logic setvariable ["RHQ_Naval",(_logic getvariable "RHQ_Naval") + (_logic getvariable "RHQ_Naval_ACR")];
		_logic setvariable ["RHQ_Static",(_logic getvariable "RHQ_Static") + (_logic getvariable "RHQ_Static_ACR")];
		_logic setvariable ["RHQ_StaticAA",(_logic getvariable "RHQ_StaticAA") + (_logic getvariable "RHQ_StaticAA_ACR")];
		_logic setvariable ["RHQ_StaticAT",(_logic getvariable "RHQ_StaticAT") + (_logic getvariable "RHQ_StaticAT_ACR")];
		_logic setvariable ["RHQ_Support",(_logic getvariable "RHQ_Support") + (_logic getvariable "RHQ_Support_ACR")];
		_logic setvariable ["RHQ_Cargo",(_logic getvariable "RHQ_Cargo") + (_logic getvariable "RHQ_Cargo_ACR")];
		_logic setvariable ["RHQ_NCCargo",(_logic getvariable "RHQ_NCCargo") + (_logic getvariable "RHQ_NCCargo_ACR")];
		_logic setvariable ["RHQ_Crew",(_logic getvariable "RHQ_Crew") + (_logic getvariable "RHQ_Crew_ACR")];
	};

if (_logic getvariable ["HAC_HQ_BAFLib",false]) then
	{
		_logic setvariable ["RHQ_SpecFor",(_logic getvariable "RHQ_SpecFor") + (_logic getvariable "RHQ_SpecFor_BAF")];
		_logic setvariable ["RHQ_Recon",(_logic getvariable "RHQ_Recon") + (_logic getvariable "RHQ_Recon_BAF")];
		_logic setvariable ["RHQ_FO",(_logic getvariable "RHQ_FO") + (_logic getvariable "RHQ_FO_BAF")];
		_logic setvariable ["RHQ_Snipers",(_logic getvariable "RHQ_Snipers") + (_logic getvariable "RHQ_Snipers_BAF")];
		_logic setvariable ["RHQ_ATInf",(_logic getvariable "RHQ_ATInf") + (_logic getvariable "RHQ_ATInf_BAF")];
		_logic setvariable ["RHQ_AAInf",(_logic getvariable "RHQ_AAInf") + (_logic getvariable "RHQ_AAInf_BAF")];
		_logic setvariable ["RHQ_Inf",(_logic getvariable "RHQ_Inf") + (_logic getvariable "RHQ_Inf_BAF")];
		_logic setvariable ["RHQ_Art",(_logic getvariable "RHQ_Art") + (_logic getvariable "RHQ_Art_BAF")];
		_logic setvariable ["RHQ_HArmor",(_logic getvariable "RHQ_HArmor") + (_logic getvariable "RHQ_HArmor_BAF")];
		_logic setvariable ["RHQ_MArmor",(_logic getvariable "RHQ_MArmor") + (_logic getvariable "RHQ_MArmor_BAF")];
		_logic setvariable ["RHQ_LArmor",(_logic getvariable "RHQ_LArmor") + (_logic getvariable "RHQ_LArmor_BAF")];
		_logic setvariable ["RHQ_LArmorAT",(_logic getvariable "RHQ_LArmorAT") + (_logic getvariable "RHQ_LArmorAT_BAF")];
		_logic setvariable ["RHQ_Cars",(_logic getvariable "RHQ_Cars") + (_logic getvariable "RHQ_Cars_BAF")];
		_logic setvariable ["RHQ_Air",(_logic getvariable "RHQ_Air") + (_logic getvariable "RHQ_Air_BAF")];
		_logic setvariable ["RHQ_BAir",(_logic getvariable "RHQ_BAir") + (_logic getvariable "RHQ_BAir_BAF")];
		_logic setvariable ["RHQ_RAir",(_logic getvariable "RHQ_RAir") + (_logic getvariable "RHQ_RAir_BAF")];
		_logic setvariable ["RHQ_NCAir",(_logic getvariable "RHQ_NCAir") + (_logic getvariable "RHQ_NCAir_BAF")];
		_logic setvariable ["RHQ_Naval",(_logic getvariable "RHQ_Naval") + (_logic getvariable "RHQ_Naval_BAF")];
		_logic setvariable ["RHQ_Static",(_logic getvariable "RHQ_Static") + (_logic getvariable "RHQ_Static_BAF")];
		_logic setvariable ["RHQ_StaticAA",(_logic getvariable "RHQ_StaticAA") + (_logic getvariable "RHQ_StaticAA_BAF")];
		_logic setvariable ["RHQ_StaticAT",(_logic getvariable "RHQ_StaticAT") + (_logic getvariable "RHQ_StaticAT_BAF")];
		_logic setvariable ["RHQ_Support",(_logic getvariable "RHQ_Support") + (_logic getvariable "RHQ_Support_BAF")];
		_logic setvariable ["RHQ_Cargo",(_logic getvariable "RHQ_Cargo") + (_logic getvariable "RHQ_Cargo_BAF")];
		_logic setvariable ["RHQ_NCCargo",(_logic getvariable "RHQ_NCCargo") + (_logic getvariable "RHQ_NCCargo_BAF")];
		_logic setvariable ["RHQ_Crew",(_logic getvariable "RHQ_Crew") + (_logic getvariable "RHQ_Crew_BAF")];
	};

if (_logic getvariable ["HAC_HQ_PMCLib",false]) then
	{
		_logic setvariable ["RHQ_SpecFor",(_logic getvariable "RHQ_SpecFor") + (_logic getvariable "RHQ_SpecFor_PMC")];
		_logic setvariable ["RHQ_Recon",(_logic getvariable "RHQ_Recon") + (_logic getvariable "RHQ_Recon_PMC")];
		_logic setvariable ["RHQ_FO",(_logic getvariable "RHQ_FO") + (_logic getvariable "RHQ_FO_PMC")];
		_logic setvariable ["RHQ_Snipers",(_logic getvariable "RHQ_Snipers") + (_logic getvariable "RHQ_Snipers_PMC")];
		_logic setvariable ["RHQ_ATInf",(_logic getvariable "RHQ_ATInf") + (_logic getvariable "RHQ_ATInf_PMC")];
		_logic setvariable ["RHQ_AAInf",(_logic getvariable "RHQ_AAInf") + (_logic getvariable "RHQ_AAInf_PMC")];
		_logic setvariable ["RHQ_Inf",(_logic getvariable "RHQ_Inf") + (_logic getvariable "RHQ_Inf_PMC")];
		_logic setvariable ["RHQ_Art",(_logic getvariable "RHQ_Art") + (_logic getvariable "RHQ_Art_PMC")];
		_logic setvariable ["RHQ_HArmor",(_logic getvariable "RHQ_HArmor") + (_logic getvariable "RHQ_HArmor_PMC")];
		_logic setvariable ["RHQ_MArmor",(_logic getvariable "RHQ_MArmor") + (_logic getvariable "RHQ_MArmor_PMC")];
		_logic setvariable ["RHQ_LArmor",(_logic getvariable "RHQ_LArmor") + (_logic getvariable "RHQ_LArmor_PMC")];
		_logic setvariable ["RHQ_LArmorAT",(_logic getvariable "RHQ_LArmorAT") + (_logic getvariable "RHQ_LArmorAT_PMC")];
		_logic setvariable ["RHQ_Cars",(_logic getvariable "RHQ_Cars") + (_logic getvariable "RHQ_Cars_PMC")];
		_logic setvariable ["RHQ_Air",(_logic getvariable "RHQ_Air") + (_logic getvariable "RHQ_Air_PMC")];
		_logic setvariable ["RHQ_BAir",(_logic getvariable "RHQ_BAir") + (_logic getvariable "RHQ_BAir_PMC")];
		_logic setvariable ["RHQ_RAir",(_logic getvariable "RHQ_RAir") + (_logic getvariable "RHQ_RAir_PMC")];
		_logic setvariable ["RHQ_NCAir",(_logic getvariable "RHQ_NCAir") + (_logic getvariable "RHQ_NCAir_PMC")];
		_logic setvariable ["RHQ_Naval",(_logic getvariable "RHQ_Naval") + (_logic getvariable "RHQ_Naval_PMC")];
		_logic setvariable ["RHQ_Static",(_logic getvariable "RHQ_Static") + (_logic getvariable "RHQ_Static_PMC")];
		_logic setvariable ["RHQ_StaticAA",(_logic getvariable "RHQ_StaticAA") + (_logic getvariable "RHQ_StaticAA_PMC")];
		_logic setvariable ["RHQ_StaticAT",(_logic getvariable "RHQ_StaticAT") + (_logic getvariable "RHQ_StaticAT_PMC")];
		_logic setvariable ["RHQ_Support",(_logic getvariable "RHQ_Support") + (_logic getvariable "RHQ_Support_PMC")];
		_logic setvariable ["RHQ_Cargo",(_logic getvariable "RHQ_Cargo") + (_logic getvariable "RHQ_Cargo_PMC")];
		_logic setvariable ["RHQ_NCCargo",(_logic getvariable "RHQ_NCCargo") + (_logic getvariable "RHQ_NCCargo_PMC")];
		_logic setvariable ["RHQ_Crew",(_logic getvariable "RHQ_Crew") + (_logic getvariable "RHQ_Crew_PMC")];
	};

_logic setvariable ["HAC_xHQ_Done", true];
