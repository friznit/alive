											  disableSerialization;
											  while {true} do  {
											  	if (CREWINFO_UILOC == 1) then {
											   	 1000 cutRsc ["HudNamesRight","PLAIN"]; _ui = uiNameSpace getVariable "HudNamesRight";
											  	} else {
											  	 1000 cutRsc ["HudNamesLeft","PLAIN"]; _ui = uiNameSpace getVariable "HudNamesLeft";
											  	};
											 	   _HudNames = _ui displayCtrl 99999;
													    if (player != vehicle player) then {
													        _name = "";
													        _vehicleID = "";
													        _picture = ""; 
													        _vehicle = assignedVehicle player;
													        _vehname= getText (configFile >> "CfgVehicles" >> (typeOf vehicle player) >> "DisplayName");
													        _weapname = getarray (configFile >> "CfgVehicles" >> typeOf (vehicle player) >> "Turrets" >> "MainTurret" >> "weapons"); 
													         if (count(_weapname) >0) then {_weap = _weapname select 0; } else { _weap = objNull; };
													        _name = format ["<t size='1.25' color='#556b2f'>%1</t><br/>", _vehname];
													        {
													            if((driver _vehicle == _x) || (gunner _vehicle == _x)) then
													            {
														                
													                if(driver _vehicle == _x) then
													                {
													
													                    _name = format ["<t size='0.85' color='#f0e68c'>%1 %2</t> <img size='0.7' color='#6b8e23' image='a3\ui_f\data\IGUI\Cfg\Actions\getindriver_ca.paa'/><br/>", _name, (name _x)];
													                }
													                else {
																	            _target = cursorTarget;
																	            if (_target isKindOf "Car" || _target isKindOf "Motorcycle" || _target isKindOf "Tank" || _target isKindOf "Air" || _target isKindOf "Ship") then {
																			       			_vehicleID = getText (configFile >> "cfgVehicles" >> typeOf _target >> "displayname");		             
																			       			_picture = getText (configFile >> "cfgVehicles" >> typeOf _target >> "picture");
																			      		};
																							if ( typeOf vehicle player == "O_SDV_01_F" || typeOf vehicle player == "B_SDV_01_F" ||  typeOf vehicle player == "I_G_Offroad_01_armed_F") then {
																      		      	  if (!isNull _weap) then {
																	              _wepdir =  (vehicle player) weaponDirection _weap;
																			 					_Azimuth = round  (((_wepdir select 0) ) atan2 ((_wepdir select 1) ) + 360) % 360;
																                _name = format ["<t size='0.85' color='#f0e68c'>%1 %2</t> <img size='0.7' color='#6b8e23' image='a3\ui_f\data\IGUI\Cfg\Actions\getingunner_ca.paa'/><br/> <t size='0.85' color='#f0e68c'>Heading :<t/> <t size='0.85' color='#ff0000'>%3</t><br/><t size='0.85' color='#f0e68c'> Target :<t/> <t size='0.85' color='#ff0000'>%4</t><br/><t size='0.85' color='#f0e68c'> Display : </t><t size='0.85' color='#f0e68c'><img size='1' image='%5'/></t><br/>", _name, (name _x), _Azimuth,_vehicleID, _picture];
																								 } else {
																								  _name = format ["<t size='0.85' color='#f0e68c'>%1 %2</t> <img size='0.7' color='#6b8e23' image='a3\ui_f\data\IGUI\Cfg\Actions\getingunner_ca.paa'/><br/>", _name, (name _x)];
																								}
																							}	else {
																	      		     if (!isNil _weap) then {
																	              _wepdir =  (vehicle player) weaponDirection _weap;
																			 					_Azimuth = round  (((_wepdir select 0) ) atan2 ((_wepdir select 1) ) + 360) % 360;
																                _name = format ["<t size='0.85' color='#f0e68c'>%1 %2</t> <img size='0.7' color='#6b8e23' image='a3\ui_f\data\IGUI\Cfg\Actions\getingunner_ca.paa'/><br/> <t size='0.85' color='#f0e68c'>Heading :<t/> <t size='0.85' color='#ff0000'>%3</t><br/><t size='0.85' color='#f0e68c'> Target :<t/> <t size='0.85' color='#ff0000'>%4</t><br/><t size='0.85' color='#f0e68c'> Display : </t><t size='0.85' color='#f0e68c'><img size='1' image='%5'/></t><br/>", _name, (name _x), _Azimuth,_vehicleID, _picture];
																								 } else {
																								  _name = format ["<t size='0.85' color='#f0e68c'>%1 %2</t> <img size='0.7' color='#6b8e23' image='a3\ui_f\data\IGUI\Cfg\Actions\getingunner_ca.paa'/><br/>", _name, (name _x)];
																								}
																							};					 
													                 };
													            }
													            else {
													              _name = format ["<t size='0.85' color='#f0e68c'>%1 %2</t> <img size='0.7' color='#6b8e23' image='a3\ui_f\data\IGUI\Cfg\Actions\getincargo_ca.paa'/><br/>", _name, (name _x)];
													            };  
													              
													        } forEach crew _vehicle;
													        
													      	_HudNames ctrlSetStructuredText parseText  _name;
													      	_HudNames ctrlCommit 0;
													    };
											    sleep 1;
											  }; 