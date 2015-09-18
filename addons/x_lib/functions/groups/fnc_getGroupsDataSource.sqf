#include <\x\alive\addons\x_lib\script_component.hpp>
SCRIPT(getGroupsDataSource);

/* ----------------------------------------------------------------------------
Function: ALiVE_fnc_getGroupsDataSource

Description:
Get current groups info formatted for a UI datasource

Parameters:


Returns:
Array - Multi dimensional array of values and options

Examples:
(begin example)
_datasource = call ALiVE_fnc_getGroupsDataSource
(end)

Author:
ARJay
 
Peer reviewed:
nil
---------------------------------------------------------------------------- */

private ["_side","_faction","_sideNumber","_leaderSide","_leaderSideNumber","_matched","_data","_playerRows","_playerValues","_rows","_values","_groups","_leaderFaction","_leaderSide","_leaderSideNumber","_row","_labels","_rank","_containsPlayers"];

_player = _this select 0;
_side = _this select 1;
DEFAULT_PARAM(2,_faction,nil);

_sideNumber = [_side] call ALIVE_fnc_sideTextToNumber;
_data = [];
_playerRows = [];
_playerValues = [];
_rows = [];
_values = [];
_groups = allGroups;

{
    if !(isnull _x) then {

        _leaderFaction = faction leader _x;
	    _leaderSide = _leaderFaction call ALiVE_fnc_FactionSide;
	    _leaderSideNumber = [_leaderSide] call ALIVE_fnc_sideObjectToNumber;

	    _matched = false;

	    if(_sideNumber == _leaderSideNumber) then {
            _matched = true;
        };

	    if!(isNil "_faction") then {
	        if(_faction == _leaderFaction) then {
                _matched = true;
	        }else{
                _matched = false;
	        };
	    };

	    if(_matched) then {

	        _row = [];
	        _labels = [];

	        _distance = floor (player distance leader _x);

	        _labels pushback (format['%1',_x]);
	        _labels pushback (format['----- %1m ------------------',_distance]);
	        _labels pushback ('----------------');
	        _labels pushback ('------------');

	        _row pushback (_labels);

	        _containsPlayers = false;

	        {

                if(alive _x && isPlayer _x) then {
                    _containsPlayers = true;
                };
            } forEach units _x;


            if(_containsPlayers) then {

                _playerRows pushback (_row);
                _playerValues pushback (_x);

            }else{

                _rows pushback (_row);
                _values pushback (_x);

            };


	        {

            	if(alive _x) then {

                    _row = [];
                    _labels = [];
                    _rank = '';

                    switch(rank _x) do {
                        case 'PRIVATE':{
                            _rank = 'PVT';
                        };
                        case 'CORPORAL':{
                            _rank = 'CPL';
                        };
                        case 'SERGEANT':{
                            _rank = 'SGT';
                        };
                        case 'LIEUTENANT':{
                            _rank = 'LT';
                        };
                        case 'CAPTAIN':{
                            _rank = 'CAPT';
                        };
                        case 'MAJOR':{
                            _rank = 'MAJ';
                        };
                        case 'COLONEL':{
                            _rank = 'COL';
                        };
                    };

                    _labels pushback (format['%1',_rank]);

                    _labels pushback (format['%1',name _x]);

                    if(isPlayer _x) then {
                        _labels pushback ('Player');
                    }else{
                        _labels pushback ('AI');
                    };

                    if(isFormationLeader _x) then {
                        _labels pushback ('Lead');
                    };

                    _row pushback (_labels);

                    if(_containsPlayers) then {

                        _playerRows pushback (_row);
                        _playerValues pushback (_x);

                    }else{

                        _rows pushback (_row);
                        _values pushback (_x);

                    };

            	};
            } forEach units _x;
	    };
    };
} foreach _groups;

_rows = _playerRows + _rows;
_values = _playerValues + _values;

_data pushback (_rows);
_data pushback (_values);

_data
