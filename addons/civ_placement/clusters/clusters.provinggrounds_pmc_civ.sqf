ALIVE_clustersCiv = [] call ALIVE_fnc_hashCreate;
_cluster = [nil, "create"] call ALIVE_fnc_cluster;
_nodes = [];
_nodes set [count _nodes, ["185",[703.045,1215,-0.120998]]];
_nodes set [count _nodes, ["3161",[703.107,1214.99,-0.0553818]]];
_nodes set [count _nodes, ["4974",[706.718,1220.94,-0.0823898]]];
_nodes set [count _nodes, ["3162",[698.175,1207.7,-0.711082]]];
_nodes set [count _nodes, ["3169",[702.621,1196.02,0.223488]]];
_nodes set [count _nodes, ["191",[687.614,1237.26,5.0017]]];
_nodes set [count _nodes, ["207",[762.234,1221.18,4.91739]]];
[_cluster,"nodes",_nodes] call ALIVE_fnc_hashSet;
[_cluster, "state", _cluster] call ALIVE_fnc_cluster;
[_cluster,"clusterID","c_0"] call ALIVE_fnc_hashSet;
[_cluster,"center",[724.924,1216.66]] call ALIVE_fnc_hashSet;
[_cluster,"size",150] call ALIVE_fnc_hashSet;
[_cluster,"type","CIV"] call ALIVE_fnc_hashSet;
[_cluster,"priority",30] call ALIVE_fnc_hashSet;
[_cluster,"debugColor","ColorOrange"] call ALIVE_fnc_hashSet;
[ALIVE_clustersCiv,"c_0",_cluster] call ALIVE_fnc_hashSet;
ALIVE_clustersCivHQ = [] call ALIVE_fnc_hashCreate;
ALIVE_clustersCivPower = [] call ALIVE_fnc_hashCreate;
ALIVE_clustersCivComms = [] call ALIVE_fnc_hashCreate;
ALIVE_clustersCivMarine = [] call ALIVE_fnc_hashCreate;
ALIVE_clustersCivRail = [] call ALIVE_fnc_hashCreate;
ALIVE_clustersCivFuel = [] call ALIVE_fnc_hashCreate;
_cluster = [nil, "create"] call ALIVE_fnc_cluster;
_nodes = [];
_nodes set [count _nodes, ["185",[703.045,1215,-0.120998]]];
_nodes set [count _nodes, ["3161",[703.107,1214.99,-0.0553818]]];
_nodes set [count _nodes, ["4974",[706.718,1220.94,-0.0823898]]];
_nodes set [count _nodes, ["3162",[698.175,1207.7,-0.711082]]];
_nodes set [count _nodes, ["3169",[702.621,1196.02,0.223488]]];
_nodes set [count _nodes, ["191",[687.614,1237.26,5.0017]]];
_nodes set [count _nodes, ["207",[762.234,1221.18,4.91739]]];
[_cluster,"nodes",_nodes] call ALIVE_fnc_hashSet;
[_cluster, "state", _cluster] call ALIVE_fnc_cluster;
[_cluster,"clusterID","c_0"] call ALIVE_fnc_hashSet;
[_cluster,"center",[]] call ALIVE_fnc_hashSet;
[_cluster,"size",0] call ALIVE_fnc_hashSet;
[_cluster,"type","CIV"] call ALIVE_fnc_hashSet;
[_cluster,"priority",30] call ALIVE_fnc_hashSet;
[_cluster,"debugColor","ColorOrange"] call ALIVE_fnc_hashSet;
[ALIVE_clustersCivFuel,"c_0",_cluster] call ALIVE_fnc_hashSet;
ALIVE_clustersCivConstruction = [] call ALIVE_fnc_hashCreate;
ALIVE_clustersCivSettlement = [] call ALIVE_fnc_hashCreate;