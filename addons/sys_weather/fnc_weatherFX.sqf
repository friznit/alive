 								private ["_msg","_LightningProbability","_initialFog", "_initialOvercast", "_initialRain", "_initialWind", "_debug"];
								private ["_minWeatherChangeTimeMin", "_maxWeatherChangeTimeMin", "_minTimeBetweenWeatherChangesMin", "_maxTimeBetweenWeatherChangesMin", "_rainIntervalRainProbability", "_windChangeProbability"];
								private ["_minimumFog", "_maximumFog", "_minimumOvercast", "_maximumOvercast", "_minimumRain", "_maximumRain", "_minimumWind", "_maximumWind", "_minRainIntervalTimeMin", "_maxRainIntervalTimeMin", "_forceRainToStopAfterOneRainInterval", "_maxWind"];
                _this = []; _debug = WEATHER_DEBUG; _initialFog = -1; _initialOvercast = -1; _initialRain = -1; _initialWind = [-1, -1];
								_minWeatherChangeTimeMin = 10; _maxWeatherChangeTimeMin = 20; _minTimeBetweenWeatherChangesMin = 5; _maxTimeBetweenWeatherChangesMin = 10; _minimumFog = 0; _maximumFog = 0.1; _minimumOvercast = 0; _maximumOvercast = 1;
								_minimumRain = 0; _maximumRain = 0.8; _minimumWind = 0; _maximumWind = 1; _windChangeProbability = 25; _rainIntervalRainProbability = 50; _LightningProbability = 15; _minRainIntervalTimeMin = 0;
								_maxRainIntervalTimeMin = (_maxWeatherChangeTimeMin + _maxTimeBetweenWeatherChangesMin) / 2; _forceRainToStopAfterOneRainInterval = false;
								_initialFog = (_minimumFog + random (_maximumFog - _minimumFog)); _initialFogDecay = _initialFog/10+random _initialFog/100;
								drn_DynamicWeather_fogDecayValue =   _initialFogDecay;
								drn_DynamicWeather_fogAltitudeValue = random 150;
								drn_DynamicWeather_DebugTextEventArgs = []; 
								drn_DynamicWeatherEventArgs = []; 
								drn_AskServerDynamicWeatherEventArgs = [];
								
								 if (count playableUnits == 0) then {SP = true} else {SP = false};
								 
								"drn_DynamicWeather_DebugTextEventArgs" addPublicVariableEventHandler { drn_DynamicWeather_DebugTextEventArgs call drn_fnc_DynamicWeather_ShowDebugTextLocal;};
								
								drn_fnc_DynamicWeather_ShowDebugTextLocal = {
								    private ["_minutes", "_seconds"];
								    if (!isNull player) then { player sideChat (_this select 0); };
								    _minutes = floor (time / 60); _seconds = floor (time - (_minutes * 60));
								   // if (WEATHER_DEBUG) then { ["ALIVE Dynamic Weather - %1",_this select 0] call ALIVE_fnc_dump;};
								};
								
								drn_fnc_DynamicWeather_ShowDebugTextAllClients = {
								    drn_DynamicWeather_DebugTextEventArgs = _this;
								    publicVariable "drn_DynamicWeather_DebugTextEventArgs";
								    drn_DynamicWeather_DebugTextEventArgs call drn_fnc_DynamicWeather_ShowDebugTextLocal;
								};
								
								drn_fnc_DynamicWeather_SetWeatherLocal = {
								    private ["_thisStatus","_currentOvercast", "_currentFog", "_currentRain", "_currentWeatherChange", "_targetWeatherValue", "_timeUntilCompletion", "_currentWindForce", "_currentWindDirection", "_targetFogDecayValue", "_targetFogAltitudeValue"];
								    _currentOvercast = _this select 0;
								    _currentFog = _this select 1;
								    _currentRain = _this select 2;
								    _currentWeatherChange = _this select 3;
								    _targetWeatherValue = _this select 4;
								    _timeUntilCompletion = _this select 5;
								    _currentWindForce = _this select 6;
								    _currentWindDirection = _this select 7;
								    _targetFogDecayValue = _this select 8;
								    _targetFogAltitudeValue = _this select 9;
	    
	
								    // Set current weather values
								    
								    if (initfirstRunClientside && !isDedicated && !isHC) then { if (WEATHER_DEBUG) then { ["ALIVE Dynamic Weather - Clientside first run, skipping time... initfirstRunClientside: %1;", initfirstRunClientside] call ALIVE_fnc_dump; }; skiptime -24;  };
								    120 setOvercast _currentOvercast;
								    120 setWaves _currentOvercast;
								    120 setGusts _currentOvercast;
								    120 setFog [_currentFog, drn_DynamicWeather_initialFogDecay, drn_DynamicWeather_initialFogAltitude];
								    drn_var_DynamicWeather_Rain = _currentRain;
								    120 setWindForce _currentWindForce;
								    120 setWindDir _currentWindDirection;
								    
								    if (WEATHER_DEBUG) then {  
								    	_msg = format ["_currentFog: %1, _targetFogDecayValue: %2, _targetFogAltitudeValue: %3, _currentOvercast: %4, _currentRain: %5, _currentWindForce: %6, _currentWindDirection: %7", _currentFog, _targetFogDecayValue, _targetFogAltitudeValue, _currentOvercast, _currentRain, _currentWindForce, _currentWindDirection];  [_msg] call drn_fnc_DynamicWeather_ShowDebugTextLocal;
								    	 ["ALIVE Dynamic Weather - _currentFog: %1, _targetFogDecayValue: %2, _targetFogAltitudeValue: %3, _currentOvercast: %4, _currentRain: %5, _currentWindForce: %6, _currentWindDirection: %7", _currentFog, _targetFogDecayValue, _targetFogAltitudeValue, _currentOvercast, _currentRain, _currentWindForce, _currentWindDirection] call ALIVE_fnc_dump;
								    };
								    
								    // Set forecast
								    if (_currentWeatherChange == "OVERCAST") then { 
								    	_timeUntilCompletion setOvercast _targetWeatherValue; _timeUntilCompletion setWaves _targetWeatherValue; _timeUntilCompletion setGusts _targetWeatherValue;
									    	if (WEATHER_DEBUG) then {  
									    	_msg = format ["_currentWeatherChange: %1, %2 setOvercast, setWaves, setGusts  %3", _currentWeatherChange, _timeUntilCompletion, _targetWeatherValue];  [_msg] call drn_fnc_DynamicWeather_ShowDebugTextLocal;
									    	 ["ALIVE Dynamic Weather - _currentWeatherChange: %1, %2 setOvercast, setWaves, setGusts  %3", _currentWeatherChange, _timeUntilCompletion, _targetWeatherValue] call ALIVE_fnc_dump;
									    	};
								    	};
								    	
								    if (_currentWeatherChange == "FOG") then { 
								    	_timeUntilCompletion setFog [_targetWeatherValue, _targetFogDecayValue, _targetFogAltitudeValue]; 
								    		if (WEATHER_DEBUG) then {  
									    	_msg = format ["_currentWeatherChange: %1, %2 setFog [%3,%4,%5]", _currentWeatherChange, _timeUntilCompletion, _targetWeatherValue, _targetFogDecayValue, _targetFogAltitudeValue];  [_msg] call drn_fnc_DynamicWeather_ShowDebugTextLocal;
									    	 ["ALIVE Dynamic Weather - _currentWeatherChange: %1, %2 setFog [%3,%4,%5]", _currentWeatherChange, _timeUntilCompletion, _targetWeatherValue, _targetFogDecayValue, _targetFogAltitudeValue] call ALIVE_fnc_dump;
									    	};
								    	};
								    	
								     if (initfirstRunClientside && !isDedicated && !isHC) then { skiptime 24; 0 = [] spawn {sleep 0.1; simulweathersync}; };
								     initfirstRunClientside = false;
								};
							
							
							 if (WEATHER_DEBUG) then { _msg = format [worldName + " weather forecast starting..."]; [_msg] call drn_fnc_DynamicWeather_ShowDebugTextLocal; };
								
								
                if (isServer) then { 	

                	 if (WEATHER_DEBUG) then {  ["ALIVE Dynamic Weather - Server Starting..."] call ALIVE_fnc_dump;  };
                	 
		                switch (INITIAL_WEATHER) do
										{
											case 1: { };  // Random
											case 2: { _initialOvercast = 0; _initialFog = 0; _initialRain = 0; };  // Clear
											case 3: { _initialOvercast = 0.51; _initialFog = 0; };  // Overcast
											case 4: { _initialOvercast = 0.95; _initialFog = 0; _initialRain = 1; };  // Stormy
										};
                
                
                	 
									    drn_fnc_DynamicWeather_SetWeatherAllClients = {
									        private ["_timeUntilCompletion", "_currentWeatherChange"];
									        _timeUntilCompletion = drn_DynamicWeather_WeatherChangeCompletedTime - drn_DynamicWeather_WeatherChangeStartedTime;
									        if (_timeUntilCompletion > 0) then { _currentWeatherChange = drn_DynamicWeather_CurrentWeatherChange; } else { _currentWeatherChange = ""; };
									        drn_DynamicWeatherEventArgs = [overcast, fog, drn_var_DynamicWeather_Rain, _currentWeatherChange, drn_DynamicWeather_WeatherTargetValue, _timeUntilCompletion, drn_DynamicWeather_WindForce, drn_DynamicWeather_WindDirection, drn_DynamicWeather_fogDecayValue, drn_DynamicWeather_fogAltitudeValue];
									        publicVariable "drn_DynamicWeatherEventArgs";
									        drn_DynamicWeatherEventArgs call drn_fnc_DynamicWeather_SetWeatherLocal;
									    };
    
    									"drn_AskServerDynamicWeatherEventArgs" addPublicVariableEventHandler { call drn_fnc_DynamicWeather_SetWeatherAllClients; };


 								 
							    drn_DynamicWeather_CurrentWeatherChange = "";
							    drn_DynamicWeather_WeatherTargetValue = 0;
							    drn_DynamicWeather_WeatherChangeStartedTime = time;
							    drn_DynamicWeather_WeatherChangeCompletedTime = time;
							    drn_DynamicWeather_WindForce = _initialWind select 0;
							    drn_DynamicWeather_WindDirection = _initialWind select 1;
							    
							    
							     if (SP) then { if (WEATHER_DEBUG) then { ["ALIVE Dynamic Weather - Single player mode, skipping time..."] call ALIVE_fnc_dump; }; skiptime -24; };
							     
							    if (_initialFog == -1) then {
							        _initialFog = (_minimumFog + random (_maximumFog - _minimumFog));
							    }
							    else {
							        if (_initialFog < _minimumFog) then {
							            _initialFog = _minimumFog;
							        };
							        if (_initialFog > _maximumFog) then {
							            _initialFog = _maximumFog;
							        };
							    };
									_initialFogDecay = _initialFog/10+random _initialFog/100;
									_initialFogAltitude = random 150;
    							0 setFog [_initialFog, _initialFogDecay, _initialFogAltitude];
						     drn_DynamicWeather_initialFogDecay = _initialFogDecay; publicvariable "drn_DynamicWeather_initialFogDecay";
						     drn_DynamicWeather_initialFogAltitude = _initialFogAltitude; publicvariable "drn_DynamicWeather_initialFogAltitude";
							    if (_initialOvercast == -1) then {
							        _initialOvercast = (_minimumOvercast + random (_maximumOvercast - _minimumOvercast));
							    }
							    else {
							        if (_initialOvercast < _minimumOvercast) then { _initialOvercast = _minimumOvercast; };
							        if (_initialOvercast > _maximumOvercast) then { _initialOvercast = _maximumOvercast; };
							    };
							    0 setOvercast _initialOvercast;
							    0 setWaves _initialOvercast;
							    0 setGusts _initialOvercast;
							    if (_initialOvercast >= 0.75) then {
							        if (_initialRain == -1) then {
							            _initialRain = (_minimumRain + random (_minimumRain - _minimumRain));
							        }
							        else {
							            if (_initialRain < _minimumRain) then { _initialRain = _minimumRain; };
							            if (_initialRain > _maximumRain) then { _initialRain = _maximumRain; };
							        };
							    }
							    else {  _initialRain = 0; };
						    drn_var_DynamicWeather_Rain = _initialRain;
						    0 setRain drn_var_DynamicWeather_Rain;
						    if (drn_var_DynamicWeather_Rain > 0.75 && (random 100) < _LightningProbability)  then { 0 setLightnings 1;};
    						_maxWind = _minimumWind + random (_maximumWind - _minimumWind);
							    if (drn_DynamicWeather_WindForce == -1) then {
							        if (random 1 < 0.5) then {
							            drn_DynamicWeather_WindForce = -_minimumWind - random (_maxWind - _minimumWind);
							        }
							        else {
							            drn_DynamicWeather_WindForce = _minimumWind + random (_maxWind - _minimumWind);
							        };
							    };
						    if (drn_DynamicWeather_WindDirection == -1) then { drn_DynamicWeather_WindDirection = random 360; };
						    0 setWindForce drn_DynamicWeather_WindForce;
						    0 setWindDir drn_DynamicWeather_WindDirection;
						    publicVariable "drn_var_DynamicWeather_Rain";
						    drn_var_DynamicWeather_ServerInitialized = true;
						    publicVariable "drn_var_DynamicWeather_ServerInitialized";
						     if (SP) then { skiptime 24; 0 = [] spawn {sleep 0.1; simulweathersync}; };

    						if (WEATHER_DEBUG) then {  
    							_msg = format ["_initialFog: %1, _initialFogDecay: %2, _initialFogAltitude: %3, _initialOvercast: %4, _initialRain: %5, initialWindForce: %6, initialWindDirection: %7", _initialFog, _initialFogDecay, _initialFogAltitude, _initialOvercast, _initialRain, drn_DynamicWeather_WindForce, drn_DynamicWeather_WindDirection];  [_msg] call drn_fnc_DynamicWeather_ShowDebugTextLocal; 
    							["ALIVE Dynamic Weather - _initialFog: %1, _initialFogDecay: %2, _initialFogAltitude: %3, _initialOvercast: %4, _initialRain: %5, initialWindForce: %6, initialWindDirection: %7", _initialFog, _initialFogDecay, _initialFogAltitude, _initialOvercast, _initialRain, drn_DynamicWeather_WindForce, drn_DynamicWeather_WindDirection] call ALIVE_fnc_dump;
								};
    

										    // Start weather thread
										    [_minWeatherChangeTimeMin, _maxWeatherChangeTimeMin, _minTimeBetweenWeatherChangesMin, _maxTimeBetweenWeatherChangesMin, _minimumFog, _maximumFog, _minimumOvercast, _maximumOvercast, _minimumWind, _maximumWind, _windChangeProbability, _debug] spawn {
										        private ["_minWeatherChangeTimeMin", "_maxWeatherChangeTimeMin", "_minTimeBetweenWeatherChangesMin", "_maxTimeBetweenWeatherChangesMin", "_minimumFog", "_maximumFog", "_minimumOvercast", "_maximumOvercast", "_minimumWind", "_maximumWind", "_windChangeProbability", "_debug"];
										        private ["_weatherType", "_fogLevel", "_overcastLevel", "_oldFogLevel", "_oldOvercastLevel", "_weatherChangeTimeSek"];
										        
										        _minWeatherChangeTimeMin = _this select 0;
										        _maxWeatherChangeTimeMin = _this select 1;
										        _minTimeBetweenWeatherChangesMin = _this select 2;
										        _maxTimeBetweenWeatherChangesMin = _this select 3;
										        _minimumFog = _this select 4;
										        _maximumFog = _this select 5;
										        _minimumOvercast = _this select 6;
										        _maximumOvercast = _this select 7;
										        _minimumWind = _this select 8;
										        _maximumWind = _this select 9;
										        _windChangeProbability = _this select 10;
										        _debug = _this select 11;
										        // Set initial fog level
										        _fogLevel = 2;
										        _overcastLevel = 2;
										        while {true} do {
										            // Sleep a while until next weather change
										            sleep floor (_minTimeBetweenWeatherChangesMin * 60 + random ((_maxTimeBetweenWeatherChangesMin - _minTimeBetweenWeatherChangesMin) * 60));
										            
										            if (_minimumFog == _maximumFog && _minimumOvercast != _maximumOvercast) then {
										                _weatherType = "OVERCAST";
										            };
										            if (_minimumFog != _maximumFog && _minimumOvercast == _maximumOvercast) then {
										                _weatherType = "FOG";
										            };
										            if (_minimumFog != _maximumFog && _minimumOvercast != _maximumOvercast) then {
										                // Select type of weather to change
										                if ((random 100) < 50) then {
										                    _weatherType = "OVERCAST";
										                }
										                else {
										                    _weatherType = "FOG";
										                };
										            };
										            if (_weatherType == "FOG") then {
										                drn_DynamicWeather_CurrentWeatherChange = "FOG";
										                // Select a new fog level
										                _oldFogLevel = _fogLevel;
										                _fogLevel = floor ((random 100) / 25);
										                
										                while {_fogLevel == _oldFogLevel} do {
										                    _fogLevel = floor ((random 100) / 25);
										                };
										                if (_fogLevel == 0) then {
										                    drn_DynamicWeather_WeatherTargetValue = _minimumFog + (_maximumFog - _minimumFog) * random 0.05;
										                    drn_DynamicWeather_fogDecayValue = drn_DynamicWeather_WeatherTargetValue/10+random drn_DynamicWeather_WeatherTargetValue/100;
										                    drn_DynamicWeather_fogAltitudeValue = random 150;
										                };
										                if (_fogLevel == 1) then {
										                    drn_DynamicWeather_WeatherTargetValue = _minimumFog + (_maximumFog - _minimumFog) * (0.05 + random 0.2);
										                    drn_DynamicWeather_fogDecayValue = drn_DynamicWeather_WeatherTargetValue/10+random drn_DynamicWeather_WeatherTargetValue/100;
										                    drn_DynamicWeather_fogAltitudeValue = random 150;
										                };
										                if (_fogLevel == 2) then {
										                    drn_DynamicWeather_WeatherTargetValue = _minimumFog + (_maximumFog - _minimumFog) * (0.25 + random 0.3);
										                    drn_DynamicWeather_fogDecayValue = drn_DynamicWeather_WeatherTargetValue/10+random drn_DynamicWeather_WeatherTargetValue/100;
										                    drn_DynamicWeather_fogAltitudeValue = random 150;
										                };
										                if (_fogLevel == 3) then {
										                    drn_DynamicWeather_WeatherTargetValue = _minimumFog + (_maximumFog - _minimumFog) * (0.55 + random 0.45);
										                    drn_DynamicWeather_fogDecayValue = drn_DynamicWeather_WeatherTargetValue/10+random drn_DynamicWeather_WeatherTargetValue/100;
										                    drn_DynamicWeather_fogAltitudeValue = random 150;
										                };
										                
										                drn_DynamicWeather_WeatherChangeStartedTime = time;
										                _weatherChangeTimeSek = _minWeatherChangeTimeMin * 60 + random ((_maxWeatherChangeTimeMin - _minWeatherChangeTimeMin) * 60);
										                drn_DynamicWeather_WeatherChangeCompletedTime = time + _weatherChangeTimeSek;
										            };
										            
												            if (_weatherType == "OVERCAST") then {
												                drn_DynamicWeather_CurrentWeatherChange = "OVERCAST";
												                // Select a new overcast level
												                _oldOvercastLevel = _overcastLevel;
												                //_overcastLevel = floor ((random 100) / 25);
												                _overcastLevel = 3;
												                while {_overcastLevel == _oldOvercastLevel} do {
												                    _overcastLevel = floor ((random 100) / 25);
												                };
												                if (_overcastLevel == 0) then {
												                    drn_DynamicWeather_WeatherTargetValue = _minimumOvercast + (_maximumOvercast - _minimumOvercast) * random 0.05;
												                };
												                if (_overcastLevel == 1) then {
												                    drn_DynamicWeather_WeatherTargetValue = _minimumOvercast + (_maximumOvercast - _minimumOvercast) * (0.05 + random 0.3);
												                };
												                if (_overcastLevel == 2) then {
												                    drn_DynamicWeather_WeatherTargetValue = _minimumOvercast + (_maximumOvercast - _minimumOvercast) * (0.35 + random 0.35);
												                };
												                if (_overcastLevel == 3) then {
												                    drn_DynamicWeather_WeatherTargetValue = _minimumOvercast + (_maximumOvercast - _minimumOvercast) * (0.7 + random 0.3);
												                };
												                drn_DynamicWeather_WeatherChangeStartedTime = time;
												                _weatherChangeTimeSek = _minWeatherChangeTimeMin * 60 + random ((_maxWeatherChangeTimeMin - _minWeatherChangeTimeMin) * 60);
												                drn_DynamicWeather_WeatherChangeCompletedTime = time + _weatherChangeTimeSek;
												              _thisStatus = "no change";
																		  if (drn_DynamicWeather_WeatherTargetValue > 0.9) then {_thisStatus = "a possible storm";} else {
																			if (drn_DynamicWeather_WeatherTargetValue > 0.7) then {_thisStatus = "rain"; } else {
																			if (drn_DynamicWeather_WeatherTargetValue > 0.5) then {_thisStatus = "cloudy"; } else {
																			if (drn_DynamicWeather_WeatherTargetValue > 0.2) then {_thisStatus = "partially fine with some cloud cover";} else {
																			if (drn_DynamicWeather_WeatherTargetValue >= 0) then {_thisStatus = "clear and fine"; }}}}};
																	
																	 	
												               if (WEATHER_DEBUG) then {  
												               	[worldName + " forecast is " + _thisStatus + " in " + str round (_weatherChangeTimeSek / 60) + " minutes."] call drn_fnc_DynamicWeather_ShowDebugTextAllClients;
												               	["ALIVE Dynamic Weather - _thisStatus: %1, typeName: %2, drn_DynamicWeather_WeatherTargetValue: %3",_thisStatus, typeName _thisStatus, drn_DynamicWeather_WeatherTargetValue] call ALIVE_fnc_dump;
												               	 };
												            };
										            // On average every one fourth of weather changes, change wind too
										            if (random 100 < _windChangeProbability) then {
										                private ["_maxWind"];
										                _maxWind = _minimumWind + random (_maximumWind - _minimumWind);
										                if (random 1 < 0.5) then {
										                    drn_DynamicWeather_WindForce = -_minimumWind - random (_maxWind - _minimumWind);
										                }
										                else {
										                    drn_DynamicWeather_WindForce = _minimumWind + random (_maxWind - _minimumWind);
										                };
										 								drn_DynamicWeather_WindDirection = random 360; 
										            };
										            call drn_fnc_DynamicWeather_SetWeatherAllClients;
										            sleep _weatherChangeTimeSek;
										        };
										    };
    
										    // Start rain thread
										    if (_rainIntervalRainProbability > 0) then {
										        [_minimumRain, _maximumRain, _forceRainToStopAfterOneRainInterval, _minRainIntervalTimeMin, _maxRainIntervalTimeMin, _rainIntervalRainProbability, _debug] spawn {
										            private ["_minimumRain", "_maximumRain", "_forceRainToStopAfterOneRainInterval", "_minRainIntervalTimeMin", "_maxRainIntervalTimeMin", "_rainIntervalRainProbability", "_debug"];
										            private ["_nextRainEventTime", "_forceStop"];
										            
										            _minimumRain = _this select 0;
										            _maximumRain = _this select 1;
										            _forceRainToStopAfterOneRainInterval = _this select 2;
										            _minRainIntervalTimeMin = _this select 3;
										            _maxRainIntervalTimeMin = _this select 4;
										            _rainIntervalRainProbability = _this select 5;
										            _debug = _this select 6;
										            
										            if (rain > 0) then {
										                drn_var_DynamicWeather_Rain = rain;
										                publicVariable "drn_var_DynamicWeather_Rain";
										            };
										            
										            _nextRainEventTime = time;
										            _forceStop = false;
										            
										            while {true} do {
										                if (overcast > 0.75) then {
										                    if (time >= _nextRainEventTime) then {
										                        private ["_rainTimeSec"];
										                        // At every rain event time, start or stop rain with 50% probability
										                        if (random 100 < _rainIntervalRainProbability && !_forceStop) then {
										                            drn_var_DynamicWeather_rain = _minimumRain + random (_maximumRain - _minimumRain);
										                            publicVariable "drn_var_DynamicWeather_rain";
										                            _forceStop = _forceRainToStopAfterOneRainInterval;
										                        }
										                        else {
										                            drn_var_DynamicWeather_rain = 0;
										                            publicVariable "drn_var_DynamicWeather_rain";
										                            
										                            _forceStop = false;
										                        };
										                        
										                        // Pick a time for next rain change
										                        _rainTimeSec = _minRainIntervalTimeMin * 60 + random ((_maxRainIntervalTimeMin - _minRainIntervalTimeMin) * 60);
										                        _nextRainEventTime = time + _rainTimeSec;
										                    };
										                }
										                else {
										                    if (drn_var_DynamicWeather_rain != 0) then {
										                        drn_var_DynamicWeather_rain = 0;
										                        publicVariable "drn_var_DynamicWeather_rain";
										                    };
										                    
										                    _nextRainEventTime = time;
										                    _forceStop = false;
										                };
										                
										                if (_debug) then {
										                    sleep 1;
										                }
										                else {
										                    sleep 10;
										                };
										            };
										        };
										    };
								}; // end if server	
								

										[_rainIntervalRainProbability, _debug, _LightningProbability] spawn {
										    private ["_rainIntervalRainProbability", "_debug","_rainIntervalRainProbability"];
										    private ["_rain", "_rainPerSecond"];
										    
										    _rainIntervalRainProbability = _this select 0;
										    _debug = _this select 1;
										     _LightningProbability = _this select 2;
										    if (_debug) then { _rainPerSecond = 0.2; }  else { _rainPerSecond = 0.03;  };
										    if (_rainIntervalRainProbability > 0) then { _rain = drn_var_DynamicWeather_Rain; } else { _rain = 0; };
										    0 setRain _rain;
										    if (_rain > 0.75 && (random 100) < _LightningProbability)  then { 0 setLightnings 1;};
										    sleep 0.1;
										    while {true} do {
										        if (_rainIntervalRainProbability > 0) then {
										            if (_rain < drn_var_DynamicWeather_Rain) then {
										                _rain = _rain + _rainPerSecond;
										                if (_rain > 1) then { _rain = 1; };
										            };
										            if (_rain > drn_var_DynamicWeather_Rain) then {
										                _rain = _rain - _rainPerSecond;
										                if (_rain < 0) then { _rain = 0; };
										            };
										        }
										        else {
										            _rain = 0;
										        };
										        3 setRain _rain;
										        if (_rain > 0.75 && (random 100) < _LightningProbability)  then { 3 setLightnings 1;};
										        sleep 3;
										    };
										};
										
								
							  if (isDedicated || isHC) then { initfirstRunClientside = false; };
							   
								if(!isDedicated && !isHC) then {
									  waitUntil {!isNull (findDisplay 46)};
								    "drn_DynamicWeatherEventArgs" addPublicVariableEventHandler { drn_DynamicWeatherEventArgs call drn_fnc_DynamicWeather_SetWeatherLocal; };
								    waitUntil {!isNil "drn_var_DynamicWeather_ServerInitialized"};
								    initfirstRunClientside = true;
								    drn_AskServerDynamicWeatherEventArgs = [true];
								    publicVariable "drn_AskServerDynamicWeatherEventArgs";
								};	