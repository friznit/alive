/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_weatherServerInit
Description:
Server side weather init

Parameters:
_this select 0: OBJECT - Reference to module


Returns:
Nil

See Also:
- <ALIVE_fnc_weather>

Author:
Jman
Peer Reviewed:
nil
---------------------------------------------------------------------------- */

	if !(isServer) exitwith {};
	
	private["_cycleDelay","_decimalplaces","_rainProbability","_fogProbability",
	"_lightningProbability","_minimumOvercast","_maximumOvercast","_currentdate",
	"_currenthour","_initialOvercast","_minimumFog","_maximumFog","_initialFog",
	"_initialFogDecay","_initialFogAltitude","_windDir","_isFoggy","_cycleVariance"];
		
      if (isServer) then { 	

         if (WEATHER_DEBUG) then { 
         	 ["Module ALiVE_sys_weather SERVER STARTING"] call ALIVE_fnc_dump; 	 
         	 ["Module ALiVE_sys_weather INITIAL_WEATHER: %1, WEATHER_CYCLE_DELAY: %2, WEATHER_CYCLE_VARIANCE: %3",INITIAL_WEATHER,WEATHER_CYCLE_DELAY,WEATHER_CYCLE_VARIANCE] call ALIVE_fnc_dump;
         }; 	 
                	 
		         switch (INITIAL_WEATHER) do
							{
								
								case 1: {	//  Arid - A region that receives very little precipitation.
									_rainProbability = 0;  
				        	_fogProbability = 0;
									_lightningProbability = 0;
									_minimumOvercast = 0;
				        	_maximumOvercast = 0.35; 
			        	};  
								case 2: {  // Continental - Climate is marked by variable weather patterns and a large seasonal temperature variance.
				        	_rainProbability = 50;  
				        	_fogProbability = 30;  
									_lightningProbability = 50;
									_minimumOvercast = 0;
				        	_maximumOvercast = 1;
			        	};
								case 3: {  // Tropical - Climate zone where winter rainfall is associated with large storms and most summer rainfall occurs during thunderstorms.
				        	_rainProbability = 85; 
				        	_fogProbability = 50;
									_lightningProbability = 95;
									_minimumOvercast = 0.53;
				        	_maximumOvercast = 1;
			        	};
								case 4: {   // Mediterranean - The climate is characterized by hot, dry summers and cool, wet winters. 
				        	_rainProbability = 25; 
				        	_fogProbability = 20;
									_lightningProbability = 35;
									_minimumOvercast = 0;
				        	_maximumOvercast = 1;
			        	};
			        	
			        	
								case 5: { };  // Real	Weather - Real weather for a time and location you specifiy.
								
								
								case 6: { };  // Random - Randomly selects any of the 4 climates.
								
							};
							

								_cycleVariance = WEATHER_CYCLE_VARIANCE;
								_cycleDelay = WEATHER_CYCLE_DELAY;
								_decimalplaces = 2;
								_currentdate = date;
							 	_currenthour = _currentdate select 3;
								_initialOvercast = (_minimumOvercast + random (_maximumOvercast - _minimumOvercast));
								
								_minimumFog = 0; 
								_maximumFog = 0.1;
								_initialFog = (_minimumFog + random (_maximumFog - _minimumFog)); 
								_initialFogDecay = _initialFog/10+random _initialFog/100;
								_initialFogAltitude = random 150;
						
								_windDir = random 360;
								_isFoggy = false;
							
								0 setOvercast round(_initialOvercast * (10 ^ _decimalplaces)) / (10 ^ _decimalplaces);  
								if (_currenthour >= 20 || _currenthour <= 6 && random 100 < _fogProbability) then { 
									_isFoggy = true;
									0 setFog [_initialFog, _initialFogDecay, _initialFogAltitude]; 
								};
								0 setWindForce round(_initialOvercast * (10 ^ _decimalplaces)) / (10 ^ _decimalplaces);
								0 setWindDir _windDir;
								0 setGusts round(_initialOvercast * (10 ^ _decimalplaces)) / (10 ^ _decimalplaces);
								0 setWaves round(_initialOvercast * (10 ^ _decimalplaces)) / (10 ^ _decimalplaces);			   
							
								sleep 0.01;
								forceWeatherChange;
								
								if (WEATHER_DEBUG) then { ["Module ALiVE_sys_weather WEATHER CHANGED! OVERCAST: %1, NEXTWEATHERCHANGE: %2", overcast, nextWeatherChange] call ALIVE_fnc_dump;}; 	 
								
								
								// Now lets apply the first weather settings to the server and run the cycle delay in a new thread and launch the weathercycle function when delay complete.
								[round(_initialOvercast * (10 ^ _decimalplaces)) / (10 ^ _decimalplaces), _rainProbability, _lightningProbability, _cycleDelay, _maximumOvercast, _fogProbability, _minimumOvercast, _windDir, _minimumFog, _maximumFog, _isFoggy, _initialFog, _initialFogDecay, _initialFogAltitude, _decimalplaces, _cycleVariance] spawn ALIVE_fnc_weatherServer;
	
	
										
			};
                
                
                	 
									 