#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(staticVehicleEmptyPositionData);




/* ----------------------------------------------------------------------------
Function;
 ALIVE_fnc_staticVehicleEmptyPositionDatas

Description;

Sets global variable for vehicle positions static data, returned from ALIVE_fnc_vehicleGenerateEmptyPositionData


Author;

ARJay
---------------------------------------------------------------------------- */

ALIVE_vehiclePositions = [] call ALIVE_fnc_hashCreate;

[ALIVE_vehiclePositions,"O_Quadbike_01_F",[1,0,0,0,1]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_Quadbike_ALIVE",[1,0,0,0,1]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_Mortar_01_F",[0,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_Mortar_01_F",[0,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"I_Mortar_01_F",[0,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_HMG_01_F",[0,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_HMG_01_F",[0,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"I_HMG_01_F",[0,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_HMG_01_high_F",[0,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_HMG_01_high_F",[0,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"I_HMG_01_high_F",[0,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_HMG_01_A_F",[0,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_HMG_01_A_F",[0,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"I_HMG_01_A_F",[0,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_GMG_01_F",[0,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_GMG_01_F",[0,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"I_GMG_01_F",[0,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_GMG_01_high_F",[0,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_GMG_01_high_F",[0,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"I_GMG_01_high_F",[0,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_GMG_01_A_F",[0,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_GMG_01_A_F",[0,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"I_GMG_01_A_F",[0,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_static_AA_F",[0,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_static_AA_F",[0,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"I_static_AA_F",[0,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_static_AT_F",[0,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_static_AT_F",[0,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"I_static_AT_F",[0,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"I_G_Mortar_01_F",[0,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_Heli_Light_01_F",[1,0,0,1,6]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_Heli_Light_01_armed_F",[1,0,0,1,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_Heli_Light_02_F",[1,0,0,1,8]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_Heli_Light_02_unarmed_F",[1,0,0,1,8]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_Heli_Attack_01_F",[1,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_Heli_Attack_02_F",[1,1,0,0,8]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_Heli_Attack_02_black_F",[1,1,0,0,8]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_Heli_Transport_01_F",[1,1,0,2,8]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_Heli_Transport_01_camo_F",[1,1,0,2,8]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"I_Heli_Transport_02_F",[1,0,0,1,16]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"I_Plane_Fighter_03_CAS_F",[1,0,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"I_Plane_Fighter_03_AA_F",[1,0,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_APC_Tracked_01_rcws_F",[1,1,1,0,8]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_APC_Tracked_01_CRV_F",[1,1,1,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_APC_Tracked_01_AA_F",[1,1,1,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_APC_Tracked_02_cannon_F",[1,1,1,0,8]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_APC_Tracked_02_AA_F",[1,1,1,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_MBT_01_cannon_F",[1,1,1,0,6]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_MBT_01_arty_F",[1,1,1,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_MBT_01_mlrs_F",[1,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_MBT_02_cannon_F",[1,1,1,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_MBT_02_arty_F",[1,1,1,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_Boat_Armed_01_minigun_F",[1,1,1,0,8]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_Boat_Armed_01_hmg_F",[1,1,1,0,8]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_Boat_Transport_01_F",[1,0,0,0,4]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_Boat_Transport_01_F",[1,0,0,0,4]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_Lifeboat",[1,0,0,0,4]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_Lifeboat",[1,0,0,0,4]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"C_Rubberboat",[1,0,0,0,4]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"I_Boat_Armed_01_minigun_F",[1,1,1,0,8]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"I_Boat_Transport_01_F",[1,0,0,0,4]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_SDV_01_F",[1,1,0,0,2]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_SDV_01_F",[1,1,0,0,2]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"I_SDV_01_F",[1,1,0,0,2]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"C_Boat_Civil_01_F",[1,0,0,0,5]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"C_Boat_Civil_01_rescue_F",[1,0,0,0,5]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"C_Boat_Civil_01_police_F",[1,0,0,0,5]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"C_Boat_Civil_04_F",[0,0,0,0,7]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"I_G_Boat_Transport_01_F",[1,0,0,0,4]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_UAV_01_F",[1,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_UAV_01_F",[1,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"I_UAV_01_F",[1,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_UAV_02_F",[1,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_UAV_02_F",[1,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"I_UAV_02_F",[1,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_UAV_02_CAS_F",[1,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_UAV_02_CAS_F",[1,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"I_UAV_02_CAS_F",[1,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_MRAP_01_F",[1,0,0,0,3]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_MRAP_01_gmg_F",[1,1,0,0,2]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_MRAP_01_hmg_F",[1,1,0,0,2]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_MRAP_02_F",[1,0,0,0,4]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_MRAP_02_hmg_F",[1,1,0,0,3]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_MRAP_02_gmg_F",[1,1,0,0,3]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"C_Offroad_01_F",[1,0,0,0,5]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_Quadbike_01_F",[1,0,0,0,1]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"I_MRAP_03_F",[1,0,1,0,2]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"I_MRAP_03_hmg_F",[1,1,1,0,1]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"I_MRAP_03_gmg_F",[1,1,1,0,1]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"C_Quadbike_01_F",[1,0,0,0,1]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"I_Quadbike_01_F",[1,0,0,0,1]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_Truck_01_transport_F",[1,0,0,0,17]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_Truck_01_covered_F",[1,0,0,0,17]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_Truck_02_covered_F",[1,0,0,0,16]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_Truck_02_transport_F",[1,0,0,0,16]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"I_Truck_02_covered_F",[1,0,0,0,16]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"I_Truck_02_transport_F",[1,0,0,0,16]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"C_Hatchback_01_F",[1,0,0,0,3]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"C_Hatchback_01_sport_F",[1,0,0,0,3]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"I_G_Offroad_01_F",[1,0,0,0,5]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"I_G_Offroad_01_armed_F",[1,1,0,0,1]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"I_G_Quadbike_01_F",[1,0,0,0,1]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"C_SUV_01_F",[1,0,0,0,3]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_Truck_01_mover_F",[1,0,0,0,1]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_Truck_01_box_F",[1,0,0,0,1]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_Truck_01_Repair_F",[1,0,0,0,1]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_Truck_01_ammo_F",[1,0,0,0,1]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_Truck_01_fuel_F",[1,0,0,0,1]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_Truck_01_medical_F",[1,0,0,0,16]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_Truck_02_box_F",[1,0,0,0,2]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_Truck_02_medical_F",[1,0,0,0,9]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_Truck_02_Ammo_F",[1,0,0,0,2]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_Truck_02_fuel_F",[1,0,0,0,2]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"I_Truck_02_ammo_F",[1,0,0,0,2]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"I_Truck_02_box_F",[1,0,0,0,2]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"I_Truck_02_medical_F",[1,0,0,0,16]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"I_Truck_02_fuel_F",[1,0,0,0,2]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"C_Van_01_transport_F",[1,0,0,0,12]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"I_G_Van_01_transport_F",[1,0,0,0,12]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"C_Van_01_box_F",[1,0,0,0,2]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"C_Van_01_fuel_F",[1,0,0,0,2]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"I_G_Van_01_fuel_F",[1,0,0,0,2]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_APC_Wheeled_01_cannon_F",[1,1,1,0,8]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_APC_Wheeled_02_rcws_F",[1,1,1,0,8]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"I_APC_Wheeled_03_cannon_F",[1,1,1,0,8]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_UGV_01_F",[1,0,0,0,1]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_UGV_01_F",[1,0,0,0,1]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"I_UGV_01_F",[1,0,0,0,1]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_UGV_01_rcws_F",[1,1,0,0,1]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_UGV_01_rcws_F",[1,1,0,0,1]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"I_UGV_01_rcws_F",[1,1,0,0,1]] call ALIVE_fnc_hashSet;