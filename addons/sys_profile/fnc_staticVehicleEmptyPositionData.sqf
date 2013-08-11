#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(staticVehicleEmptyPositionData);


/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_staticVehicleEmptyPositionData

Description:
Sets global variable for vehicle positions static data, returned from ALIVE_fnc_vehicleGenerateEmptyPositionData


Author:
ARJay
---------------------------------------------------------------------------- */

ALIVE_vehiclePositions = [] call ALIVE_fnc_hashCreate;

[ALIVE_vehiclePositions,"O_Quadbike_01_F",[1,0,0,0,1]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_Quadbike_ALIVE",[1,0,0,0,1]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_Mortar_01_F",[0,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_Mortar_01_F",[0,1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"I_Mortar_01_F",[0,1,0,0,0]] call ALIVE_fnc_hashSet;
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
[ALIVE_vehiclePositions,"B_APC_Tracked_01_rcws_F",[1,1,1,0,8]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_APC_Tracked_02_cannon_F",[1,1,1,0,8]] call ALIVE_fnc_hashSet;
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
[ALIVE_vehiclePositions,"B_APC_Wheeled_01_cannon_F",[1,1,1,0,8]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_APC_Wheeled_02_rcws_F",[1,1,1,0,8]] call ALIVE_fnc_hashSet;
