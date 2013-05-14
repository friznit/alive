_logic = _this select ((count _this)-1);

_logic setvariable ["HAC_HQ_Howitzer", []];
_logic setvariable ["HAC_HQ_Mortar", ["O_Mk6","B_Mk6"]];
_logic setvariable ["HAC_HQ_Rocket", []];

_logic setvariable ["HAC_xHQ_AIC_OrdConf", 
	[
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
	]];

_logic setvariable ["HAC_xHQ_AIC_OrdDen", 
	[
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
	]];

_logic setvariable ["HAC_xHQ_AIC_OrdFinal", 
	[
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
	]];

_logic setvariable ["HAC_xHQ_AIC_OrdEnd", 
	[
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
	]];

_logic setvariable ["HAC_xHQ_AIC_SuppReq", 
	[
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
	]];

_logic setvariable ["HAC_xHQ_AIC_MedReq", 
	[
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
	]];

_logic setvariable ["HAC_xHQ_AIC_ArtyReq", 
	[
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
	]];

_logic setvariable ["HAC_xHQ_AIC_SmokeReq", 
	[
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
	]];

_logic setvariable ["HAC_xHQ_AIC_IllumReq", 
	[
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
	]];

_logic setvariable ["HAC_xHQ_AIC_InDanger", 
	[
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
	]];

_logic setvariable ["HAC_xHQ_AIC_EnemySpot", 
	[
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
	]];

_logic setvariable ["HAC_xHQ_AIC_InFear", 
	[
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
	]];

_logic setvariable ["HAC_xHQ_AIC_InPanic", 
	[
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
	]];

_logic setvariable ["HAC_xHQ_AIC_SuppAss", 
	[
	"v2HAC_SuppAss1",
	"v2HAC_SuppAss2",
	"v2HAC_SuppAss3",
	"v2HAC_SuppAss4",
	"v2HAC_SuppAss5"
	]];

_logic setvariable ["HAC_xHQ_AIC_SuppDen", 
	[
	"v2HAC_SuppDen1",
	"v2HAC_SuppDen2",
	"v2HAC_SuppDen3",
	"v2HAC_SuppDen4",
	"v2HAC_SuppDen5"
	]];

_logic setvariable ["HAC_xHQ_AIC_ArtAss", 
	[
	"v2HAC_ArtAss1",
	"v2HAC_ArtAss2",
	"v2HAC_ArtAss3",
	"v2HAC_ArtAss4",
	"v2HAC_ArtAss5"
	]];

_logic setvariable ["HAC_xHQ_AIC_ArtDen", 
	[
	"v2HAC_ArtDen1",
	"v2HAC_ArtDen2",
	"v2HAC_ArtDen3",
	"v2HAC_ArtDen4",
	"v2HAC_ArtDen5"
	]];

_logic setvariable ["HAC_xHQ_AIC_DefStance", 
	[
	"v2HAC_DefStance1"
	]];

_logic setvariable ["HAC_xHQ_AIC_OffStance", 
	[
	"v2HAC_OffStance1"
	]];

_logic setvariable ["HAC_xHQ_AIC_ArtFire", 
	[
	"HAC_ArtFire1",
	"HAC_ArtFire2",
	"HAC_ArtFire3",
	"HAC_ArtFire4",
	"HAC_ArtFire5"
	]];

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

Boss = compile preprocessfile "\x\alive\addons\sys_HAC\Boss.sqf";

A_EnemyScan = compile preprocessfile "\x\alive\addons\sys_HAC\A\EnemyScan.sqf";
A_Flanking = compile preprocessfile "\x\alive\addons\sys_HAC\A\Flanking.sqf";
A_Garrison = compile preprocessfile "\x\alive\addons\sys_HAC\A\Garrison.sqf";
A_GoAmmoSupp = compile preprocessfile "\x\alive\addons\sys_HAC\A\GoAmmoSupp.sqf";
A_GoAttAir = compile preprocessfile "\x\alive\addons\sys_HAC\A\GoAttAir.sqf";
A_GoAttArmor = compile preprocessfile "\x\alive\addons\sys_HAC\A\GoAttArmor.sqf";
A_GoAttInf = compile preprocessfile "\x\alive\addons\sys_HAC\A\GoAttInf.sqf";
A_GoAttSniper = compile preprocessfile "\x\alive\addons\sys_HAC\A\GoAttSniper.sqf";
A_GoCapture = compile preprocessfile "\x\alive\addons\sys_HAC\A\GoCapture.sqf";
A_GoDef = compile preprocessfile "\x\alive\addons\sys_HAC\A\GoDef.sqf";
A_GoDefAir = compile preprocessfile "\x\alive\addons\sys_HAC\A\GoDefAir.sqf";
A_GoDefRecon = compile preprocessfile "\x\alive\addons\sys_HAC\A\GoDefRecon.sqf";
A_GoDefRes = compile preprocessfile "\x\alive\addons\sys_HAC\A\GoDefRes.sqf";
A_GoFlank = compile preprocessfile "\x\alive\addons\sys_HAC\A\GoFlank.sqf";
A_GoFuelSupp = compile preprocessfile "\x\alive\addons\sys_HAC\A\GoFuelSupp.sqf";
A_GoIdle = compile preprocessfile "\x\alive\addons\sys_HAC\A\GoIdle.sqf";
A_GoMedSupp = compile preprocessfile "\x\alive\addons\sys_HAC\A\GoMedSupp.sqf";
A_GoRecon = compile preprocessfile "\x\alive\addons\sys_HAC\A\GoRecon.sqf";
A_GoRepSupp = compile preprocessfile "\x\alive\addons\sys_HAC\A\GoRepSupp.sqf";
A_GoRest = compile preprocessfile "\x\alive\addons\sys_HAC\A\GoRest.sqf";
A_GoSFAttack = compile preprocessfile "\x\alive\addons\sys_HAC\A\GoSFAttack.sqf";
A_HQOrders = compile preprocessfile "\x\alive\addons\sys_HAC\A\HQOrders.sqf";
A_HQOrdersDef = compile preprocessfile "\x\alive\addons\sys_HAC\A\HQOrdersDef.sqf";
A_HQReset = compile preprocessfile "\x\alive\addons\sys_HAC\A\HQReset.sqf";
A_HQSitRep = compile preprocessfile "\x\alive\addons\sys_HAC\A\HQSitRep.sqf";
A_LHQ = compile preprocessfile "\x\alive\addons\sys_HAC\A\LHQ.sqf";
A_LPos = compile preprocessfile "\x\alive\addons\sys_HAC\A\LPos.sqf";
A_Personality = compile preprocessfile "\x\alive\addons\sys_HAC\A\Personality.sqf";
A_Reloc = compile preprocessfile "\x\alive\addons\sys_HAC\A\Reloc.sqf";
A_Rev = compile preprocessfile "\x\alive\addons\sys_HAC\A\Rev.sqf";
A_SCargo = compile preprocessfile "\x\alive\addons\sys_HAC\A\SCargo.sqf";
A_SFIdleOrd = compile preprocessfile "\x\alive\addons\sys_HAC\A\SFIdleOrd.sqf";
A_Spotscan = compile preprocessfile "\x\alive\addons\sys_HAC\A\SpotScan.sqf";
A_SuppAmmo = compile preprocessfile "\x\alive\addons\sys_HAC\A\SuppAmmo.sqf";
A_SuppFuel = compile preprocessfile "\x\alive\addons\sys_HAC\A\SuppFuel.sqf";
A_SuppMed = compile preprocessfile "\x\alive\addons\sys_HAC\A\SuppMed.sqf";
A_SuppRep = compile preprocessfile "\x\alive\addons\sys_HAC\A\SuppRep.sqf";

if (isNil {_logic getvariable ["HAC_HQ_Obj1",nil]}) then {_logic setvariable ["HAC_HQ_Obj1", vehicle _logic]};
if (isNil {_logic getvariable ["HAC_HQ_Obj2",nil]}) then {_logic setvariable ["HAC_HQ_Obj2", HAC_HQ_Obj1]};
if (isNil {_logic getvariable ["HAC_HQ_Obj3",nil]}) then {_logic setvariable ["HAC_HQ_Obj3", HAC_HQ_Obj2]};
if (isNil {_logic getvariable ["HAC_HQ_Obj4",nil]}) then {_logic setvariable ["HAC_HQ_Obj4", HAC_HQ_Obj3]};

_logic setvariable ["HAC_xHQ_Done", true];
