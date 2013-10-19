ALIVE_unitBlackist = 
[
	"O_UAV_AI",
	"B_UAV_AI"
];

ALIVE_vehicleBlacklist = 
[
	"O_UAV_02_F",
	"O_UAV_02_CAS_F",
	"O_UAV_01_F",
	"O_UGV_01_F",
	"O_UGV_01_rcws_F",
	"B_UAV_01_F",
	"B_UAV_02_F",
	"B_UAV_02_CAS_F",
	"B_UGV_01_F",
	"B_UGV_01_rcws_F"
];

ALIVE_groupBlacklist = 
[
	"HAF_AttackTeam_UAV",
	"HAF_ReconTeam_UAV",
	"HAF_AttackTeam_UGV",
	"HAF_ReconTeam_UGV",
	"HAF_SmallTeam_UAV",
	"BUS_AttackTeam_UAV",
	"BUS_ReconTeam_UAV",
	"BUS_AttackTeam_UGV",
	"BUS_ReconTeam_UGV",
	"BUS_SmallTeam_UAV",
	"OI_AttackTeam_UAV",
	"OI_ReconTeam_UAV",
	"OI_AttackTeam_UGV",
	"OI_ReconTeam_UGV",
	"OI_SmallTeam_UAV",
	"BUS_TankPlatoon_AA", // BUG in CfgGroups vehicle name wrong
	"BUS_MechInf_AA" // BUG in CfgGroups vehicle name wrong
];

ALIVE_factionDefaultGuards = [] call ALIVE_fnc_hashCreate;
[ALIVE_factionDefaultGuards, "OPF_F", "OIA_InfSquad_Weapons"] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultGuards, "IND_F", "HAF_InfSquad"] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultGuards, "BLU_F", "BUS_InfSquad_Weapons"] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultGuards, "BLU_G_F", "IRG_InfSquad_Weapons"] call ALIVE_fnc_hashSet;