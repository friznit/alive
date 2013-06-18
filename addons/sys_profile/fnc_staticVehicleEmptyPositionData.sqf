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
[ALIVE_vehiclePositions,"O_Quadbike_F",[1,0,0,1]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_Mk6",[0,1,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_Mk6",[0,1,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_Ka60_F",[1,0,0,8]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_Ka60_Unarmed_F",[1,0,0,8]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_MH9_F",[1,0,0,6]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_AH9_F",[1,0,0,0]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_Assaultboat",[1,0,0,4]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_Assaultboat",[1,0,0,4]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_Lifeboat",[1,0,0,4]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_Lifeboat",[1,0,0,4]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"C_Rubberboat",[1,0,0,4]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_SpeedBoat",[1,1,1,8]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_SpeedBoat",[1,1,1,8]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_Hunter_F",[1,0,0,3]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_Hunter_RCWS_F",[1,1,0,2]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_Hunter_HMG_F",[1,1,0,2]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_Ifrit_F",[1,0,0,4]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_Ifrit_MG_F",[1,1,0,3]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"O_Ifrit_GMG_F",[1,1,0,3]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"c_offroad",[1,0,0,5]] call ALIVE_fnc_hashSet;
[ALIVE_vehiclePositions,"B_Quadbike_F",[1,0,0,1]] call ALIVE_fnc_hashSet;