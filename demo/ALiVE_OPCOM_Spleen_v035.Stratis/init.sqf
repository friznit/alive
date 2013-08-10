[] spawn {	
	// set fog level 
	0 setfog [0.05,0.065,120];
	sleep 30;

	3600 setfog [0.01,0.04,45];
	sleep 3600;
};
    
if (isServer) then {
	//call compile preprocessFileLinenumbers "convertToProfiles.sqf";
};