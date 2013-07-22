/* alive_sys_weaponrest | fnc_canRestWeapon.sqf - " Rest a weapon on something" | (c) VTS*/

#include "script_component.hpp"

private ["_debug","_colorright","_lrest","_colorleft","_rrest","_colormuzzle","_mzrest","_colordown","_mdown","_colordownterrain","_mdownterrain","_wresting","_colorred","_colorgreen","_dir","_leftoffest","_rightoffest","_frontoffest","_frontterrainoffest","_muzzleoffest","_downoffset","_downoffsetobjectvertical","_downoffsetterrainvertical","_weaponpitch","_distance","_posleft","_posleft0","_posleft1","_posright","_posright0","_posright1","_posmuzzle","_posmuzzle0","_posmuzzle1","_posdown","_posdown0","_posdown1","_posdownterrain","_posdownterrain0","_posdownterrain1","_checkmen","_wresting"];

PARAMS_1(_cAnim); 
	
	_colorred=[1,0,0,1];
	_colorgreen=[0,1,0,1];
	_colorblue=[0,0,1,1];
	_colorblack=[0,0,0,1];
	_colorwhite=[1,1,1,1];
	
	_weapon = currentweapon player;
	
	_longRifle = ["srifle_EBR_F","srifle_EBR_ACO_F","srifle_EBR_MRCO_pointer_F","srifle_EBR_ARCO_pointer_F","srifle_EBR_SOS_F","srifle_EBR_ARCO_pointer_snds_F",
				  "srifle_GM6_F","srifle_GM6_SOS_F",
				  "srifle_LRR_F","srifle_LRR_SOS_F",
				  "arifle_MXM_F","arifle_MXM_Hamr_pointer_F","arifle_MXM_SOS_pointer_F","arifle_MXM_RCO_pointer_snds_F",
				  "arifle_MXC_Holo_pointer_snds_F","arifle_MX_RCO_pointer_snds_F","arifle_MXC_SOS_point_snds_F","arifle_MX_GL_Holo_pointer_snds_F",
				  "arifle_Katiba_ACO_pointer_snds_F","arifle_Katiba_ARCO_pointer_snds_F","arifle_Katiba_GL_ACO_pointer_snds_F",
				  "LMG_Zafir_F","LMG_Zafir_pointer_F"];
	_medRifle = ["LMG_Mk200_F","LMG_Mk200_MRCO_F","LMG_Mk200_pointer_F",
				"arifle_Katiba_F","arifle_Katiba_ACO_F","arifle_Katiba_ACO_pointer_F","arifle_Katiba_ARCO_F","arifle_Katiba_ARCO_pointer_F",
				"arifle_Katiba_GL_F","arifle_Katiba_GL_ACO_F","arifle_Katiba_GL_ARCO_pointer_F","arifle_Katiba_GL_ACO_pointer_F",
				"arifle_MXC_F","arifle_MXC_Holo_F","arifle_MXC_Holo_pointer_F","arifle_MXC_ACO_F","arifle_MXC_ACO_pointer_F",
				"arifle_MX_F","arifle_MX_pointer_F","arifle_MX_Holo_pointer_F","arifle_MX_Hamr_pointer_F","arifle_MX_ACO_pointer_F","arifle_MX_ACO_F",
				"arifle_MX_GL_F","arifle_MX_GL_ACO_F","arifle_MX_GL_ACO_pointer_F","arifle_MX_GL_Hamr_pointer_F",
				"arifle_MX_SW_F","arifle_MX_SW_pointer_F","arifle_MX_SW_Hamr_pointer_F"];

	// Set length of gun based
	switch (true) do {
		case (_weapon in _longRifle): {_distance=0.95};
		case (_weapon in _medRifle): {_distance=0.8};
		case default {_distance=0.65};
	};
	
	_dir=direction  player;
	_leftoffest=0.30;
	_rightoffest=0.40;
	_frontoffest=_distance;
	_muzzleoffest=0.07;
	_muzzledownoffset=0.09;
	_downoffset=0.35;
	_downoffsetobjectvertical=0.3;
	_weaponpitch=asin((player weaponDirection (currentweapon player)) select 2);
	
	
	_posleft=[(eyepos player select 0)+_leftoffest*(sin (_dir-90)),(eyepos player select 1)+_leftoffest*(cos (_dir-90)),(eyepos player select 2)-_downoffset];
	_posleft0=[(_posleft  select 0),( _posleft select 1),( _posleft select 2)];
	_posleft1=[(_posleft  select 0)+_distance*(sin _dir),( _posleft select 1)+_distance*(cos _dir),(_posleft  select 2)+_distance*(sin _weaponpitch)];

	_posright=[(eyepos player select 0)+_rightoffest*(sin (_dir+90)),(eyepos player select 1)+_rightoffest*(cos (_dir+90)),(eyepos player select 2)-_downoffset];
	_posright0=[( _posright select 0),( _posright select 1),( _posright select 2)];
	_posright1=[( _posright select 0)+_distance*(sin _dir),( _posright select 1)+_distance*(cos _dir),(_posright select 2)+_distance*(sin _weaponpitch)];

	
	_posmuzzle=[(eyepos player select 0)+_muzzleoffest*(sin (_dir+90)),(eyepos player select 1)+_muzzleoffest*(cos (_dir+90)),(eyepos player select 2)-_muzzledownoffset];
	_posmuzzle0=[( _posmuzzle select 0),( _posmuzzle select 1),( _posmuzzle select 2)];
	_posmuzzle1=[( _posmuzzle select 0)+_distance*(sin _dir),( _posmuzzle select 1)+_distance*(cos _dir),(_posmuzzle select 2)+_distance*(sin _weaponpitch)];

	
	_posdown=[(eyepos player select 0)+_frontoffest*(sin _dir)+_muzzleoffest*(sin (_dir+90)),(eyepos player select 1)+_frontoffest*(cos _dir)+_muzzleoffest*(cos (_dir+90)),(eyepos player select 2)-_muzzledownoffset];
	_posdown0=[( _posdown select 0),( _posdown select 1),( _posdown select 2)+_frontoffest*(sin _weaponpitch)];
	_posdown1=[( _posdown select 0),( _posdown select 1),( _posdown select 2)+_frontoffest*(sin _weaponpitch)-_downoffsetobjectvertical];


	_colorright=_colorwhite;
	_colorleft=_colorblue;
	_colormuzzle=_colorred;
	_colordown=_colorblack;
	
	_lrest=false;
	_rrest=false;
	_mzrest=false;
	_mdown=false;
	
	_wresting=false;
	
	if (lineIntersects [_posleft0,_posleft1,player]) then
	{
		_colorleft=_colorgreen;
		//if (direction player>_playerdir+15) then {player setdir _playerdir+15};
		_lrest=true;
	};
	if (lineIntersects [_posright0,_posright1,player]) then
	{
		_colorright=_colorgreen;
		//if (direction player>_playerdir+15) then {player setdir _playerdir+15};
		_rrest=true;
	};	
	if (lineIntersects [_posmuzzle0,_posmuzzle1,player]) then
	{
		_colormuzzle=_colorgreen;
		//if (direction player>_playerdir+15) then {player setdir _playerdir+15};
		_mzrest=true;
	};	
	if (lineIntersects [_posdown0,_posdown1,player]) then
	{
		_colordown=_colorgreen;
		//if (direction player>_playerdir+15) then {player setdir _playerdir+15};
		_mdown=true;
	};		
	
	_checkmen=nearestObjects [[(getposatl player select 0)+1.1*sin(direction player),(getposatl player select 1)+1.1*cos(direction player),(getposatl player) select 2],["Man"],0.6];
	if ((count _checkmen)>0) then
	{
		
		if ((_checkmen select 0) iskindof "Man") then
		{
			if ((stance (_checkmen select 0)=="CROUCH") && ((stance player)!="PRONE")) then
			{
				_colordown=_colorgreen;
				_mdown=true;
			};
		};
	};
	
	
	if ((_lrest or _rrest or _mdown) && (!_mzrest)) then 
	{
		_wresting=true;
	};
	
	_debug = false;
	if (_debug) then {
			_num = time;
			while {time < (_num + 10)} do {
				drawLine3D [ASLToATL _posleft0,ASLToATL _posleft1,_colorleft];
				drawLine3D [ASLToATL _posright0,ASLToATL _posright1,_colorright];
				drawLine3D [ASLToATL _posmuzzle0,ASLToATL _posmuzzle1,_colormuzzle];
				drawLine3D [ASLToATL _posdown0,ASLToATL _posdown1,_colordown];
			};
	};
	
	if ((vehicle player!=player) or !(alive player)) then {_wresting=false;};
		
 _wresting;



