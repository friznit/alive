[] spawn {	
	// set fog level 
	0 setfog [0.1,0.001,100];
	sleep 30;

	3600 setfog [0.01,0.04,50];
	sleep 3600;
};
    
if (isServer) then {
	//call compile preprocessFileLinenumbers "convertToProfiles.sqf";
};