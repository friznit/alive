    
	private ["_sectors"];
	
	// DEBUG -------------------------------------------------------------------------------------
	["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
	["ALIVE Grid create"] call ALIVE_fnc_dump;
	//[true] call ALIVE_fnc_timer;
	// DEBUG -------------------------------------------------------------------------------------
	
	// create sector grid
	ALIVE_sectorGrid = [nil, "create"] call ALIVE_fnc_sectorGrid;
	[ALIVE_sectorGrid, "init"] call ALIVE_fnc_sectorGrid;
	[ALIVE_sectorGrid, "createGrid"] call ALIVE_fnc_sectorGrid;

	// display the grid
	[ALIVE_sectorGrid, "debug", true] call ALIVE_fnc_sectorGrid;
	
	// import static map analysis to the grid
	[ALIVE_sectorGrid] call ALIVE_fnc_gridImportStaticMapAnalysis;
	
	// DEBUG -------------------------------------------------------------------------------------
	//[] call ALIVE_fnc_timer;
	// DEBUG -------------------------------------------------------------------------------------
	
	// create sector plotter
	ALIVE_sectorPlotter = [nil, "create"] call ALIVE_fnc_plotSectors;
	[ALIVE_sectorPlotter, "init"] call ALIVE_fnc_plotSectors;
	
	// create the profile handler
	ALIVE_profileHandler = [nil, "create"] call ALIVE_fnc_profileHandler;
	[ALIVE_profileHandler, "init"] call ALIVE_fnc_profileHandler;
	
	// turn on debug on profile handler to see profile registrations in RPT
	[ALIVE_profileHandler, "debug", true] call ALIVE_fnc_profileHandler;
	
	// create profiles for all map units that dont have profiles
	[true] call ALIVE_fnc_createProfilesFromUnits;
	
	// turn on debug again to see the state of the profile handler, and set debug on all a profiles
	[ALIVE_profileHandler, "debug", true] call ALIVE_fnc_profileHandler;
	
	// get profiles
	_profiles = [ALIVE_profileHandler, "getProfiles"] call ALIVE_fnc_profileHandler;
    player sidechat format["Count Profiles %1",count (_profiles select 2)];
    
	// start profile simulation with debug enabled
    [] spawn {[true] call ALIVE_fnc_simulateProfileMovement};
	
	// start profile spawner with activation radius of 1000m and debug enabled
	[] spawn {[1000,true] call ALIVE_fnc_profileSpawner};
	
	// run grid analysis
	[] spawn { 
		waituntil {
			sleep 90;
			
			private ["_sectors","_sectorData"];
			
			// DEBUG -------------------------------------------------------------------------------------
			["----------------------------------------------------------------------------------------"] call ALIVE_fnc_dump;
			["ALIVE Grid analysis for profile positions"] call ALIVE_fnc_dump;
			// DEBUG -------------------------------------------------------------------------------------
			
			// run profile analysis on all sectors
			[ALIVE_sectorGrid] call ALIVE_fnc_gridAnalysisProfiles;
			
			
			
			// EXAMPLE CODE ONLY FROM HERE ----------------------------------------------------------------------------------
			
			// get array of all sectors from the grid
			_sectors = [ALIVE_sectorGrid, "sectors"] call ALIVE_fnc_sectorGrid;
			
			// HH here is a demo of using the grid data
			// grabbing sector data
			// doing this in a loop for demonstration purposes
			{
				_sector = _x;
				_sectorData = [_sector, "data"] call ALIVE_fnc_sector;
				_sectorID = [_sector, "id"] call ALIVE_fnc_sector;
				
				// get terrain data
				// this was applied to all sectors by the terrain analysis on line 19
				_sectorTerrainData = [_sectorData, "terrain"] call ALIVE_fnc_hashGet;
				
				//["Grid Sector [%1] Terrain: %2",_sectorID,_sectorTerrainData] call ALIVE_fnc_dump;
				
				// if the current sector has vehicle profile data by side..
				if("vehiclesBySide" in (_sectorData select 1)) then {
					_sectorVehicleData = [_sectorData, "vehiclesBySide"] call ALIVE_fnc_hashGet;
					
					["Grid Sector [%1] Vehicle data hash:",_sectorID] call ALIVE_fnc_dump;
					_sectorVehicleData call ALIVE_fnc_inspectHash;
				};
				
				// if the current sector has entity profile data by side..
				if("entitiesBySide" in (_sectorData select 1)) then {
					_sectorEntityData = [_sectorData, "entitiesBySide"] call ALIVE_fnc_hashGet;
					
					["Grid Sector [%1] Entity data hash:",_sectorID] call ALIVE_fnc_dump;
					_sectorEntityData call ALIVE_fnc_inspectHash;
				};
			} forEach _sectors;
			
			
			// HH these will probably interest you most position to grid sector 
			_mySector = [ALIVE_sectorGrid, "positionToSector", getPos player] call ALIVE_fnc_sectorGrid;
			
			// Surrounding sectors
			_mySurroundingSectors = [ALIVE_sectorGrid, "surroundingSectors", getPos player] call ALIVE_fnc_sectorGrid;
			
			
			// DEBUG -------------------------------------------------------------------------------------
			// display visual representation of sector data
			
			// clear the sector data plot
			[ALIVE_sectorPlotter, "clear"] call ALIVE_fnc_plotSectors;
			
			// plot the sector data
			[ALIVE_sectorPlotter, "plot", [_sectors, "entitiesBySide"]] call ALIVE_fnc_plotSectors;
			// DEBUG -------------------------------------------------------------------------------------
			
			false 
		};
	};	
	
    true;