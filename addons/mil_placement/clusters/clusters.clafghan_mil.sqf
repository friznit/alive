ALIVE_clustersMil = [] call ALIVE_fnc_hashCreate;
_cluster = [nil, "create"] call ALIVE_fnc_cluster;
_nodes = [];
_nodes set [count _nodes, ["1226577",[8201.5,8660.04,0.00878906]]];
_nodes set [count _nodes, ["1783504",[8152.9,8652.82,-0.376343]]];
_nodes set [count _nodes, ["1783501",[8146.41,8653.36,-0.293457]]];
_nodes set [count _nodes, ["1227344",[8196.92,8644.84,-0.187012]]];
_nodes set [count _nodes, ["1226586",[8226.84,8672.18,-0.165405]]];
_nodes set [count _nodes, ["1226585",[8210.63,8694.9,-0.140991]]];
_nodes set [count _nodes, ["1781449",[8185.44,8691.5,0.296875]]];
[_cluster,"nodes",_nodes] call ALIVE_fnc_hashSet;
[_cluster, "state", _cluster] call ALIVE_fnc_cluster;
[_cluster,"clusterID","c_0"] call ALIVE_fnc_hashSet;
[_cluster,"center",[8185.33,8669.94]] call ALIVE_fnc_hashSet;
[_cluster,"size",150] call ALIVE_fnc_hashSet;
[_cluster,"type","MIL"] call ALIVE_fnc_hashSet;
[_cluster,"priority",50] call ALIVE_fnc_hashSet;
[_cluster,"debugColor","ColorRed"] call ALIVE_fnc_hashSet;
[ALIVE_clustersMil,"c_0",_cluster] call ALIVE_fnc_hashSet;
_cluster = [nil, "create"] call ALIVE_fnc_cluster;
_nodes = [];
_nodes set [count _nodes, ["1799585",[15518,578.531,-2.86102]]];
_nodes set [count _nodes, ["1799583",[15524.4,567.022,-2.86102]]];
_nodes set [count _nodes, ["1799582",[15530.1,555.158,-2.86102]]];
_nodes set [count _nodes, ["1799580",[15535.5,543.407,-2.86102]]];
_nodes set [count _nodes, ["1799584",[15546.7,563.473,-2.86102]]];
_nodes set [count _nodes, ["1799581",[15541.6,575.438,-2.86102]]];
_nodes set [count _nodes, ["1764579",[15536.3,587.387,-2.86102]]];
_nodes set [count _nodes, ["1799576",[15418.8,755.78,4.76837]]];
_nodes set [count _nodes, ["1799575",[15427.4,740.387,4.76837]]];
_nodes set [count _nodes, ["1764559",[15436.5,721.866,4.76837]]];
_nodes set [count _nodes, ["1799572",[15418.4,782.005,3.33786]]];
_nodes set [count _nodes, ["1799569",[15405.3,804.7,3.33786]]];
_nodes set [count _nodes, ["1799570",[15392.5,827.676,3.33786]]];
_nodes set [count _nodes, ["1799571",[15416.9,840.3,3.33786]]];
_nodes set [count _nodes, ["1799578",[15404.2,859.907,4.76837]]];
_nodes set [count _nodes, ["1799577",[15381.1,851.023,4.76837]]];
_nodes set [count _nodes, ["1799579",[15367.2,844.481,4.76837]]];
_nodes set [count _nodes, ["1799574",[15429.5,818.752,3.33786]]];
_nodes set [count _nodes, ["1764572",[15441.1,796.354,3.33786]]];
_nodes set [count _nodes, ["1764607",[15507.7,869.381,1.90735]]];
_nodes set [count _nodes, ["1764609",[15486.8,903.813,0]]];
_nodes set [count _nodes, ["1764669",[15353.5,921.293,1.90735]]];
_nodes set [count _nodes, ["1764644",[15325.1,967.562,1.90735]]];
_nodes set [count _nodes, ["1764639",[15295.5,1019.51,1.90735]]];
_nodes set [count _nodes, ["1764653",[15321.3,1059.7,111]]];
_nodes set [count _nodes, ["1764634",[15355.9,1079.68,111]]];
_nodes set [count _nodes, ["1765195",[15395.7,1010.63,111]]];
_nodes set [count _nodes, ["1764654",[15361.1,990.652,111]]];
_nodes set [count _nodes, ["1765286",[15401,921.568,111]]];
_nodes set [count _nodes, ["1765231",[15435.6,941.549,111]]];
_nodes set [count _nodes, ["1765318",[15475.6,872.382,111]]];
_nodes set [count _nodes, ["1765317",[15441,852.401,111]]];
_nodes set [count _nodes, ["1772117",[15480.9,783.316,111]]];
_nodes set [count _nodes, ["1772110",[15515.5,803.298,111]]];
_nodes set [count _nodes, ["1772121",[15555.3,734.296,111]]];
_nodes set [count _nodes, ["1772120",[15520.7,714.314,111]]];
_nodes set [count _nodes, ["1772125",[15560.6,645.23,111]]];
_nodes set [count _nodes, ["1772122",[15595.2,665.212,111]]];
_nodes set [count _nodes, ["1772130",[15635,596.195,111]]];
_nodes set [count _nodes, ["1772127",[15600.4,576.213,111]]];
_nodes set [count _nodes, ["1772134",[15640.3,507.129,111]]];
_nodes set [count _nodes, ["1772133",[15674.9,527.111,111]]];
_nodes set [count _nodes, ["1772744",[15727.9,515.1,111.005]]];
_nodes set [count _nodes, ["1772146",[15714.8,458.282,111]]];
_nodes set [count _nodes, ["1772145",[15680.2,438.3,111]]];
_nodes set [count _nodes, ["1772749",[15762.4,455.253,111]]];
_nodes set [count _nodes, ["1772149",[15754.8,389.197,111]]];
_nodes set [count _nodes, ["1772743",[15802.5,385.974,111]]];
_nodes set [count _nodes, ["1772767",[15843,411.703,111]]];
_nodes set [count _nodes, ["1764574",[15505.3,1257.62,1.90735]]];
_nodes set [count _nodes, ["1799255",[15461.7,1333.5,1.90735]]];
_nodes set [count _nodes, ["1764611",[15428.1,1306.2,111]]];
_nodes set [count _nodes, ["1772769",[15393.5,1286.22,111]]];
_nodes set [count _nodes, ["1799160",[15353,1260.41,111]]];
_nodes set [count _nodes, ["1765216",[15310.5,1238.14,111]]];
_nodes set [count _nodes, ["1764630",[15275.9,1218.14,111]]];
_nodes set [count _nodes, ["1764631",[15241.3,1198.16,111]]];
_nodes set [count _nodes, ["1764632",[15281.4,1128.79,111]]];
_nodes set [count _nodes, ["1764633",[15316,1148.77,111]]];
_nodes set [count _nodes, ["1772755",[15402,1175.54,111]]];
_nodes set [count _nodes, ["1772768",[15433.6,1216.85,111]]];
_nodes set [count _nodes, ["1764614",[15468.2,1236.83,111]]];
_nodes set [count _nodes, ["1764676",[15537.6,623.457,9.53674]]];
_nodes set [count _nodes, ["1764684",[15517.5,657.662,9.53674]]];
_nodes set [count _nodes, ["1764670",[15498.2,691.088,9.53674]]];
_nodes set [count _nodes, ["1772746",[15468.1,1157.1,-68.995]]];
_nodes set [count _nodes, ["1772750",[15626,787.568,111]]];
_nodes set [count _nodes, ["1772752",[15570,884.558,111]]];
_nodes set [count _nodes, ["1772753",[15514,981.545,111]]];
_nodes set [count _nodes, ["1772754",[15457.9,1078.62,111]]];
_nodes set [count _nodes, ["1799256",[15459.7,664.86,2.86102]]];
_nodes set [count _nodes, ["1799839",[15453.2,678.18,2.86102]]];
_nodes set [count _nodes, ["1764595",[15447.4,690.961,2.86102]]];
_nodes set [count _nodes, ["1764601",[15433.8,700.602,-5.24521]]];
_nodes set [count _nodes, ["1764591",[15472,721.55,2.86102]]];
_nodes set [count _nodes, ["1799837",[15478.4,708.211,2.86102]]];
_nodes set [count _nodes, ["1799838",[15402.8,757.387,-5.24521]]];
_nodes set [count _nodes, ["1799836",[15378,872.915,-5.24521]]];
_nodes set [count _nodes, ["1764600",[15382.4,881.189,-1.04904]]];
_nodes set [count _nodes, ["1764602",[15340.4,860.74,0.127029]]];
_nodes set [count _nodes, ["1764596",[15333.1,870.886,2.61136]]];
_nodes set [count _nodes, ["1799840",[15511.6,585.462,-5.24521]]];
_nodes set [count _nodes, ["1764592",[15554.9,608.377,-5.24521]]];
_nodes set [count _nodes, ["1764608",[15520.7,839.326,4.76837]]];
[_cluster,"nodes",_nodes] call ALIVE_fnc_hashSet;
[_cluster, "state", _cluster] call ALIVE_fnc_cluster;
[_cluster,"clusterID","c_1"] call ALIVE_fnc_hashSet;
[_cluster,"center",[15542.1,859.433]] call ALIVE_fnc_hashSet;
[_cluster,"size",551.613] call ALIVE_fnc_hashSet;
[_cluster,"type","MIL"] call ALIVE_fnc_hashSet;
[_cluster,"priority",50] call ALIVE_fnc_hashSet;
[_cluster,"debugColor","ColorRed"] call ALIVE_fnc_hashSet;
[ALIVE_clustersMil,"c_1",_cluster] call ALIVE_fnc_hashSet;
_cluster = [nil, "create"] call ALIVE_fnc_cluster;
_nodes = [];
_nodes set [count _nodes, ["653033",[17499.7,6071.59,0.17395]]];
_nodes set [count _nodes, ["653031",[17500.3,6063.29,0.172729]]];
_nodes set [count _nodes, ["1757478",[17504.6,6038.86,-0.449341]]];
[_cluster,"nodes",_nodes] call ALIVE_fnc_hashSet;
[_cluster, "state", _cluster] call ALIVE_fnc_cluster;
[_cluster,"clusterID","c_2"] call ALIVE_fnc_hashSet;
[_cluster,"center",[17501.6,6055.45]] call ALIVE_fnc_hashSet;
[_cluster,"size",150] call ALIVE_fnc_hashSet;
[_cluster,"type","MIL"] call ALIVE_fnc_hashSet;
[_cluster,"priority",50] call ALIVE_fnc_hashSet;
[_cluster,"debugColor","ColorRed"] call ALIVE_fnc_hashSet;
[ALIVE_clustersMil,"c_2",_cluster] call ALIVE_fnc_hashSet;
_cluster = [nil, "create"] call ALIVE_fnc_cluster;
_nodes = [];
_nodes set [count _nodes, ["510189",[14225.1,8315.16,0.116638]]];
_nodes set [count _nodes, ["510099",[14225.2,8321.26,0.0957031]]];
_nodes set [count _nodes, ["510270",[14225.3,8327.32,0.0905151]]];
_nodes set [count _nodes, ["510620",[14225.4,8333.48,0.1651]]];
_nodes set [count _nodes, ["154403",[14210.8,8335.11,0.843933]]];
_nodes set [count _nodes, ["514014",[14160.1,8386.85,0.1651]]];
_nodes set [count _nodes, ["513917",[14144.2,8394.04,0.112915]]];
_nodes set [count _nodes, ["319912",[14203.4,8305.87,-0.85199]]];
_nodes set [count _nodes, ["319976",[14202.8,8313.7,-1.19843]]];
_nodes set [count _nodes, ["319977",[14202,8321.59,-1.06604]]];
_nodes set [count _nodes, ["319899",[14205.7,8318.52,9.6601]]];
_nodes set [count _nodes, ["319905",[14201.5,8329.63,-0.724854]]];
_nodes set [count _nodes, ["319904",[14193.6,8329.77,1.92126]]];
_nodes set [count _nodes, ["319906",[14189.8,8341.53,0.127014]]];
_nodes set [count _nodes, ["320146",[14152.2,8318.2,0]]];
_nodes set [count _nodes, ["417829",[14220.8,8281.94,0]]];
_nodes set [count _nodes, ["346659",[14227.5,8281.93,0]]];
_nodes set [count _nodes, ["408981",[14247.8,8342.2,0]]];
[_cluster,"nodes",_nodes] call ALIVE_fnc_hashSet;
[_cluster, "state", _cluster] call ALIVE_fnc_cluster;
[_cluster,"clusterID","c_3"] call ALIVE_fnc_hashSet;
[_cluster,"center",[14196.2,8338.29]] call ALIVE_fnc_hashSet;
[_cluster,"size",150] call ALIVE_fnc_hashSet;
[_cluster,"type","MIL"] call ALIVE_fnc_hashSet;
[_cluster,"priority",50] call ALIVE_fnc_hashSet;
[_cluster,"debugColor","ColorRed"] call ALIVE_fnc_hashSet;
[ALIVE_clustersMil,"c_3",_cluster] call ALIVE_fnc_hashSet;
_cluster = [nil, "create"] call ALIVE_fnc_cluster;
_nodes = [];
_nodes set [count _nodes, ["650834",[4845.46,13745.5,0.1651]]];
_nodes set [count _nodes, ["650835",[4852.33,13740.2,0.0905151]]];
_nodes set [count _nodes, ["650363",[4938.46,13745.3,-0.253235]]];
_nodes set [count _nodes, ["650364",[4937.07,13760.6,-0.0205994]]];
_nodes set [count _nodes, ["1820867",[4829.38,13773.1,-0.812958]]];
_nodes set [count _nodes, ["1820865",[4836.91,13773,-0.812958]]];
_nodes set [count _nodes, ["1820864",[4846.89,13773,-1.09158]]];
_nodes set [count _nodes, ["1820863",[4856.68,13772.9,-1.379]]];
_nodes set [count _nodes, ["1820843",[4866.37,13772.8,-1.49289]]];
_nodes set [count _nodes, ["1820866",[4876.13,13772.9,-1.80722]]];
_nodes set [count _nodes, ["268216",[4908.68,13797.6,0]]];
_nodes set [count _nodes, ["1820842",[4841.78,13800.8,2.10004]]];
_nodes set [count _nodes, ["1820870",[4811.01,13790.2,0.0962524]]];
_nodes set [count _nodes, ["1820868",[4810.91,13781.1,0.185638]]];
_nodes set [count _nodes, ["1820856",[4834.73,13759.8,1.41388]]];
_nodes set [count _nodes, ["266791",[4876.65,13728.3,-0.2117]]];
[_cluster,"nodes",_nodes] call ALIVE_fnc_hashSet;
[_cluster, "state", _cluster] call ALIVE_fnc_cluster;
[_cluster,"clusterID","c_4"] call ALIVE_fnc_hashSet;
[_cluster,"center",[4874.52,13764.7]] call ALIVE_fnc_hashSet;
[_cluster,"size",150] call ALIVE_fnc_hashSet;
[_cluster,"type","MIL"] call ALIVE_fnc_hashSet;
[_cluster,"priority",50] call ALIVE_fnc_hashSet;
[_cluster,"debugColor","ColorRed"] call ALIVE_fnc_hashSet;
[ALIVE_clustersMil,"c_4",_cluster] call ALIVE_fnc_hashSet;
_cluster = [nil, "create"] call ALIVE_fnc_cluster;
_nodes = [];
_nodes set [count _nodes, ["1227235",[15639.2,17119.8,0.00012207]]];
_nodes set [count _nodes, ["1227237",[15639.3,17131.6,0.0156293]]];
_nodes set [count _nodes, ["1227239",[15620.5,17131.7,0.000193119]]];
_nodes set [count _nodes, ["1227238",[15621.3,17119.7,0.0150042]]];
_nodes set [count _nodes, ["1227240",[15621.3,17107.9,0.0368209]]];
_nodes set [count _nodes, ["1227236",[15639.9,17107.9,-0.014431]]];
_nodes set [count _nodes, ["1227302",[15599.7,17107.5,0.034337]]];
_nodes set [count _nodes, ["1227241",[15599.7,17119.3,0.0170469]]];
_nodes set [count _nodes, ["1227301",[15598.9,17131.3,0.00763655]]];
_nodes set [count _nodes, ["1227233",[15692.5,17132.3,-0.0640192]]];
_nodes set [count _nodes, ["1227232",[15693.3,17120.4,-0.0785618]]];
_nodes set [count _nodes, ["1227234",[15693.3,17108.6,-0.0926971]]];
_nodes set [count _nodes, ["1227179",[15712.1,17108.2,0.205136]]];
_nodes set [count _nodes, ["1227176",[15711.3,17120.2,0.140213]]];
_nodes set [count _nodes, ["1227231",[15711.4,17131.9,0.103558]]];
_nodes set [count _nodes, ["1227135",[15619.1,17244.3,0.0100222]]];
_nodes set [count _nodes, ["1227134",[15656.4,17244.4,0.0100222]]];
_nodes set [count _nodes, ["1227136",[15691.9,17244.4,0.0100226]]];
_nodes set [count _nodes, ["1783523",[15606.4,17174.5,-0.0604997]]];
_nodes set [count _nodes, ["1783507",[15606.2,17165.7,0.0454526]]];
_nodes set [count _nodes, ["1783528",[15629.7,17167,-0.00174236]]];
_nodes set [count _nodes, ["1783533",[15631.3,17194.5,-0.239332]]];
_nodes set [count _nodes, ["1783515",[15617.4,17194.8,-0.224762]]];
_nodes set [count _nodes, ["1226994",[15601,17200.5,0.0398817]]];
_nodes set [count _nodes, ["1783509",[15647.1,17203.5,2.61134]]];
_nodes set [count _nodes, ["1783525",[15661.5,17203.3,2.61136]]];
_nodes set [count _nodes, ["1227119",[15726.5,17102.9,0.00110817]]];
_nodes set [count _nodes, ["1227118",[15582.7,17102.1,0.0148859]]];
_nodes set [count _nodes, ["1783513",[15658.3,17357.8,0.025197]]];
_nodes set [count _nodes, ["1226996",[15725.9,17355.3,-0.048316]]];
_nodes set [count _nodes, ["1226992",[15580.8,17356.5,-0.0187216]]];
[_cluster,"nodes",_nodes] call ALIVE_fnc_hashSet;
[_cluster, "state", _cluster] call ALIVE_fnc_cluster;
[_cluster,"clusterID","c_5"] call ALIVE_fnc_hashSet;
[_cluster,"center",[15653.5,17230.2]] call ALIVE_fnc_hashSet;
[_cluster,"size",150] call ALIVE_fnc_hashSet;
[_cluster,"type","MIL"] call ALIVE_fnc_hashSet;
[_cluster,"priority",50] call ALIVE_fnc_hashSet;
[_cluster,"debugColor","ColorRed"] call ALIVE_fnc_hashSet;
[ALIVE_clustersMil,"c_5",_cluster] call ALIVE_fnc_hashSet;
_cluster = [nil, "create"] call ALIVE_fnc_cluster;
_nodes = [];
_nodes set [count _nodes, ["1226664",[11040.8,19634.5,0.00732422]]];
_nodes set [count _nodes, ["1226683",[10977.2,19640.2,0.0100098]]];
_nodes set [count _nodes, ["1226661",[10993.3,19630,-0.117798]]];
_nodes set [count _nodes, ["1781852",[11045.8,19659.2,-0.164917]]];
[_cluster,"nodes",_nodes] call ALIVE_fnc_hashSet;
[_cluster, "state", _cluster] call ALIVE_fnc_cluster;
[_cluster,"clusterID","c_6"] call ALIVE_fnc_hashSet;
[_cluster,"center",[11011.5,19643.6]] call ALIVE_fnc_hashSet;
[_cluster,"size",150] call ALIVE_fnc_hashSet;
[_cluster,"type","MIL"] call ALIVE_fnc_hashSet;
[_cluster,"priority",50] call ALIVE_fnc_hashSet;
[_cluster,"debugColor","ColorRed"] call ALIVE_fnc_hashSet;
[ALIVE_clustersMil,"c_6",_cluster] call ALIVE_fnc_hashSet;
_cluster = [nil, "create"] call ALIVE_fnc_cluster;
_nodes = [];
_nodes set [count _nodes, ["1787030",[9901.17,16386.4,-0.0121584]]];
_nodes set [count _nodes, ["1786860",[9949.6,16425,0.113496]]];
_nodes set [count _nodes, ["1787028",[9962.48,16365.5,0.00171089]]];
[_cluster,"nodes",_nodes] call ALIVE_fnc_hashSet;
[_cluster, "state", _cluster] call ALIVE_fnc_cluster;
[_cluster,"clusterID","c_7"] call ALIVE_fnc_hashSet;
[_cluster,"center",[9930.46,16396.1]] call ALIVE_fnc_hashSet;
[_cluster,"size",150] call ALIVE_fnc_hashSet;
[_cluster,"type","MIL"] call ALIVE_fnc_hashSet;
[_cluster,"priority",50] call ALIVE_fnc_hashSet;
[_cluster,"debugColor","ColorRed"] call ALIVE_fnc_hashSet;
[ALIVE_clustersMil,"c_7",_cluster] call ALIVE_fnc_hashSet;
_cluster = [nil, "create"] call ALIVE_fnc_cluster;
_nodes = [];
_nodes set [count _nodes, ["1799896",[8424.7,10588,0.125732]]];
_nodes set [count _nodes, ["514866",[8467.68,10572.3,-0.246521]]];
[_cluster,"nodes",_nodes] call ALIVE_fnc_hashSet;
[_cluster, "state", _cluster] call ALIVE_fnc_cluster;
[_cluster,"clusterID","c_8"] call ALIVE_fnc_hashSet;
[_cluster,"center",[8445.03,10581.7]] call ALIVE_fnc_hashSet;
[_cluster,"size",150] call ALIVE_fnc_hashSet;
[_cluster,"type","MIL"] call ALIVE_fnc_hashSet;
[_cluster,"priority",0] call ALIVE_fnc_hashSet;
[_cluster,"debugColor","ColorGreen"] call ALIVE_fnc_hashSet;
[ALIVE_clustersMil,"c_8",_cluster] call ALIVE_fnc_hashSet;
ALIVE_clustersMilHQ = [] call ALIVE_fnc_hashCreate;
_cluster = [nil, "create"] call ALIVE_fnc_cluster;
_nodes = [];
_nodes set [count _nodes, ["1226577",[8201.5,8660.04,0.00878906]]];
[_cluster,"nodes",_nodes] call ALIVE_fnc_hashSet;
[_cluster, "state", _cluster] call ALIVE_fnc_cluster;
[_cluster,"clusterID","c_9"] call ALIVE_fnc_hashSet;
[_cluster,"center",[8201.65,8661.07]] call ALIVE_fnc_hashSet;
[_cluster,"size",150] call ALIVE_fnc_hashSet;
[_cluster,"type","MIL"] call ALIVE_fnc_hashSet;
[_cluster,"priority",50] call ALIVE_fnc_hashSet;
[_cluster,"debugColor","ColorRed"] call ALIVE_fnc_hashSet;
[ALIVE_clustersMilHQ,"c_9",_cluster] call ALIVE_fnc_hashSet;
_cluster = [nil, "create"] call ALIVE_fnc_cluster;
_nodes = [];
_nodes set [count _nodes, ["1799585",[15518,578.531,-2.86102]]];
_nodes set [count _nodes, ["1799583",[15524.4,567.022,-2.86102]]];
_nodes set [count _nodes, ["1799582",[15530.1,555.158,-2.86102]]];
_nodes set [count _nodes, ["1799580",[15535.5,543.407,-2.86102]]];
_nodes set [count _nodes, ["1799584",[15546.7,563.473,-2.86102]]];
_nodes set [count _nodes, ["1799581",[15541.6,575.438,-2.86102]]];
_nodes set [count _nodes, ["1764579",[15536.3,587.387,-2.86102]]];
_nodes set [count _nodes, ["1799576",[15418.8,755.78,4.76837]]];
_nodes set [count _nodes, ["1799575",[15427.4,740.387,4.76837]]];
_nodes set [count _nodes, ["1764559",[15436.5,721.866,4.76837]]];
_nodes set [count _nodes, ["1799572",[15418.4,782.005,3.33786]]];
_nodes set [count _nodes, ["1799569",[15405.3,804.7,3.33786]]];
_nodes set [count _nodes, ["1799570",[15392.5,827.676,3.33786]]];
_nodes set [count _nodes, ["1799571",[15416.9,840.3,3.33786]]];
_nodes set [count _nodes, ["1799578",[15404.2,859.907,4.76837]]];
_nodes set [count _nodes, ["1799577",[15381.1,851.023,4.76837]]];
_nodes set [count _nodes, ["1799579",[15367.2,844.481,4.76837]]];
_nodes set [count _nodes, ["1799574",[15429.5,818.752,3.33786]]];
_nodes set [count _nodes, ["1764572",[15441.1,796.354,3.33786]]];
_nodes set [count _nodes, ["1764607",[15507.7,869.381,1.90735]]];
_nodes set [count _nodes, ["1764609",[15486.8,903.813,0]]];
[_cluster,"nodes",_nodes] call ALIVE_fnc_hashSet;
[_cluster, "state", _cluster] call ALIVE_fnc_cluster;
[_cluster,"clusterID","c_10"] call ALIVE_fnc_hashSet;
[_cluster,"center",[15457.1,721.904]] call ALIVE_fnc_hashSet;
[_cluster,"size",194.922] call ALIVE_fnc_hashSet;
[_cluster,"type","MIL"] call ALIVE_fnc_hashSet;
[_cluster,"priority",50] call ALIVE_fnc_hashSet;
[_cluster,"debugColor","ColorRed"] call ALIVE_fnc_hashSet;
[ALIVE_clustersMilHQ,"c_10",_cluster] call ALIVE_fnc_hashSet;
_cluster = [nil, "create"] call ALIVE_fnc_cluster;
_nodes = [];
_nodes set [count _nodes, ["653033",[17499.7,6071.59,0.17395]]];
_nodes set [count _nodes, ["653031",[17500.3,6063.29,0.172729]]];
[_cluster,"nodes",_nodes] call ALIVE_fnc_hashSet;
[_cluster, "state", _cluster] call ALIVE_fnc_cluster;
[_cluster,"clusterID","c_11"] call ALIVE_fnc_hashSet;
[_cluster,"center",[17499,6067.35]] call ALIVE_fnc_hashSet;
[_cluster,"size",150] call ALIVE_fnc_hashSet;
[_cluster,"type","MIL"] call ALIVE_fnc_hashSet;
[_cluster,"priority",50] call ALIVE_fnc_hashSet;
[_cluster,"debugColor","ColorRed"] call ALIVE_fnc_hashSet;
[ALIVE_clustersMilHQ,"c_11",_cluster] call ALIVE_fnc_hashSet;
_cluster = [nil, "create"] call ALIVE_fnc_cluster;
_nodes = [];
_nodes set [count _nodes, ["510189",[14225.1,8315.16,0.116638]]];
_nodes set [count _nodes, ["510099",[14225.2,8321.26,0.0957031]]];
_nodes set [count _nodes, ["510270",[14225.3,8327.32,0.0905151]]];
_nodes set [count _nodes, ["510620",[14225.4,8333.48,0.1651]]];
_nodes set [count _nodes, ["154403",[14210.8,8335.11,0.843933]]];
_nodes set [count _nodes, ["514014",[14160.1,8386.85,0.1651]]];
_nodes set [count _nodes, ["513917",[14144.2,8394.04,0.112915]]];
[_cluster,"nodes",_nodes] call ALIVE_fnc_hashSet;
[_cluster, "state", _cluster] call ALIVE_fnc_cluster;
[_cluster,"clusterID","c_12"] call ALIVE_fnc_hashSet;
[_cluster,"center",[14185.8,8354.62]] call ALIVE_fnc_hashSet;
[_cluster,"size",150] call ALIVE_fnc_hashSet;
[_cluster,"type","MIL"] call ALIVE_fnc_hashSet;
[_cluster,"priority",50] call ALIVE_fnc_hashSet;
[_cluster,"debugColor","ColorRed"] call ALIVE_fnc_hashSet;
[ALIVE_clustersMilHQ,"c_12",_cluster] call ALIVE_fnc_hashSet;
_cluster = [nil, "create"] call ALIVE_fnc_cluster;
_nodes = [];
_nodes set [count _nodes, ["650834",[4845.46,13745.5,0.1651]]];
_nodes set [count _nodes, ["650835",[4852.33,13740.2,0.0905151]]];
_nodes set [count _nodes, ["650363",[4938.46,13745.3,-0.253235]]];
_nodes set [count _nodes, ["650364",[4937.07,13760.6,-0.0205994]]];
[_cluster,"nodes",_nodes] call ALIVE_fnc_hashSet;
[_cluster, "state", _cluster] call ALIVE_fnc_cluster;
[_cluster,"clusterID","c_13"] call ALIVE_fnc_hashSet;
[_cluster,"center",[4892.15,13750.3]] call ALIVE_fnc_hashSet;
[_cluster,"size",150] call ALIVE_fnc_hashSet;
[_cluster,"type","MIL"] call ALIVE_fnc_hashSet;
[_cluster,"priority",50] call ALIVE_fnc_hashSet;
[_cluster,"debugColor","ColorRed"] call ALIVE_fnc_hashSet;
[ALIVE_clustersMilHQ,"c_13",_cluster] call ALIVE_fnc_hashSet;
_cluster = [nil, "create"] call ALIVE_fnc_cluster;
_nodes = [];
_nodes set [count _nodes, ["1227235",[15639.2,17119.8,0.00012207]]];
_nodes set [count _nodes, ["1227237",[15639.3,17131.6,0.0156293]]];
_nodes set [count _nodes, ["1227239",[15620.5,17131.7,0.000193119]]];
_nodes set [count _nodes, ["1227238",[15621.3,17119.7,0.0150042]]];
_nodes set [count _nodes, ["1227240",[15621.3,17107.9,0.0368209]]];
_nodes set [count _nodes, ["1227236",[15639.9,17107.9,-0.014431]]];
_nodes set [count _nodes, ["1227302",[15599.7,17107.5,0.034337]]];
_nodes set [count _nodes, ["1227241",[15599.7,17119.3,0.0170469]]];
_nodes set [count _nodes, ["1227301",[15598.9,17131.3,0.00763655]]];
_nodes set [count _nodes, ["1227233",[15692.5,17132.3,-0.0640192]]];
_nodes set [count _nodes, ["1227232",[15693.3,17120.4,-0.0785618]]];
_nodes set [count _nodes, ["1227234",[15693.3,17108.6,-0.0926971]]];
_nodes set [count _nodes, ["1227179",[15712.1,17108.2,0.205136]]];
_nodes set [count _nodes, ["1227176",[15711.3,17120.2,0.140213]]];
_nodes set [count _nodes, ["1227231",[15711.4,17131.9,0.103558]]];
[_cluster,"nodes",_nodes] call ALIVE_fnc_hashSet;
[_cluster, "state", _cluster] call ALIVE_fnc_cluster;
[_cluster,"clusterID","c_14"] call ALIVE_fnc_hashSet;
[_cluster,"center",[15655.4,17120]] call ALIVE_fnc_hashSet;
[_cluster,"size",150] call ALIVE_fnc_hashSet;
[_cluster,"type","MIL"] call ALIVE_fnc_hashSet;
[_cluster,"priority",50] call ALIVE_fnc_hashSet;
[_cluster,"debugColor","ColorRed"] call ALIVE_fnc_hashSet;
[ALIVE_clustersMilHQ,"c_14",_cluster] call ALIVE_fnc_hashSet;
_cluster = [nil, "create"] call ALIVE_fnc_cluster;
_nodes = [];
_nodes set [count _nodes, ["1226664",[11040.8,19634.5,0.00732422]]];
[_cluster,"nodes",_nodes] call ALIVE_fnc_hashSet;
[_cluster, "state", _cluster] call ALIVE_fnc_cluster;
[_cluster,"clusterID","c_15"] call ALIVE_fnc_hashSet;
[_cluster,"center",[11039.8,19634.4]] call ALIVE_fnc_hashSet;
[_cluster,"size",150] call ALIVE_fnc_hashSet;
[_cluster,"type","MIL"] call ALIVE_fnc_hashSet;
[_cluster,"priority",50] call ALIVE_fnc_hashSet;
[_cluster,"debugColor","ColorRed"] call ALIVE_fnc_hashSet;
[ALIVE_clustersMilHQ,"c_15",_cluster] call ALIVE_fnc_hashSet;
_cluster = [nil, "create"] call ALIVE_fnc_cluster;
_nodes = [];
_nodes set [count _nodes, ["1787030",[9901.17,16386.4,-0.0121584]]];
_nodes set [count _nodes, ["1786860",[9949.6,16425,0.113496]]];
_nodes set [count _nodes, ["1787028",[9962.48,16365.5,0.00171089]]];
[_cluster,"nodes",_nodes] call ALIVE_fnc_hashSet;
[_cluster, "state", _cluster] call ALIVE_fnc_cluster;
[_cluster,"clusterID","c_16"] call ALIVE_fnc_hashSet;
[_cluster,"center",[9930.46,16396.1]] call ALIVE_fnc_hashSet;
[_cluster,"size",150] call ALIVE_fnc_hashSet;
[_cluster,"type","MIL"] call ALIVE_fnc_hashSet;
[_cluster,"priority",50] call ALIVE_fnc_hashSet;
[_cluster,"debugColor","ColorRed"] call ALIVE_fnc_hashSet;
[ALIVE_clustersMilHQ,"c_16",_cluster] call ALIVE_fnc_hashSet;
ALIVE_clustersMilAir = [] call ALIVE_fnc_hashCreate;
_cluster = [nil, "create"] call ALIVE_fnc_cluster;
_nodes = [];
_nodes set [count _nodes, ["1764669",[15353.5,921.293,1.90735]]];
_nodes set [count _nodes, ["1764644",[15325.1,967.562,1.90735]]];
_nodes set [count _nodes, ["1764639",[15295.5,1019.51,1.90735]]];
_nodes set [count _nodes, ["1764653",[15321.3,1059.7,111]]];
_nodes set [count _nodes, ["1764634",[15355.9,1079.68,111]]];
_nodes set [count _nodes, ["1765195",[15395.7,1010.63,111]]];
_nodes set [count _nodes, ["1764654",[15361.1,990.652,111]]];
_nodes set [count _nodes, ["1765286",[15401,921.568,111]]];
_nodes set [count _nodes, ["1765231",[15435.6,941.549,111]]];
_nodes set [count _nodes, ["1765318",[15475.6,872.382,111]]];
_nodes set [count _nodes, ["1765317",[15441,852.401,111]]];
_nodes set [count _nodes, ["1772117",[15480.9,783.316,111]]];
_nodes set [count _nodes, ["1772110",[15515.5,803.298,111]]];
_nodes set [count _nodes, ["1772121",[15555.3,734.296,111]]];
_nodes set [count _nodes, ["1772120",[15520.7,714.314,111]]];
_nodes set [count _nodes, ["1772125",[15560.6,645.23,111]]];
_nodes set [count _nodes, ["1772122",[15595.2,665.212,111]]];
_nodes set [count _nodes, ["1772130",[15635,596.195,111]]];
_nodes set [count _nodes, ["1772127",[15600.4,576.213,111]]];
_nodes set [count _nodes, ["1772134",[15640.3,507.129,111]]];
_nodes set [count _nodes, ["1772133",[15674.9,527.111,111]]];
_nodes set [count _nodes, ["1772744",[15727.9,515.1,111.005]]];
_nodes set [count _nodes, ["1772146",[15714.8,458.282,111]]];
_nodes set [count _nodes, ["1772145",[15680.2,438.3,111]]];
_nodes set [count _nodes, ["1772749",[15762.4,455.253,111]]];
_nodes set [count _nodes, ["1772149",[15754.8,389.197,111]]];
_nodes set [count _nodes, ["1772743",[15802.5,385.974,111]]];
_nodes set [count _nodes, ["1772767",[15843,411.703,111]]];
_nodes set [count _nodes, ["1764574",[15505.3,1257.62,1.90735]]];
_nodes set [count _nodes, ["1799255",[15461.7,1333.5,1.90735]]];
_nodes set [count _nodes, ["1764611",[15428.1,1306.2,111]]];
_nodes set [count _nodes, ["1772769",[15393.5,1286.22,111]]];
_nodes set [count _nodes, ["1799160",[15353,1260.41,111]]];
_nodes set [count _nodes, ["1765216",[15310.5,1238.14,111]]];
_nodes set [count _nodes, ["1764630",[15275.9,1218.14,111]]];
_nodes set [count _nodes, ["1764631",[15241.3,1198.16,111]]];
_nodes set [count _nodes, ["1764632",[15281.4,1128.79,111]]];
_nodes set [count _nodes, ["1764633",[15316,1148.77,111]]];
_nodes set [count _nodes, ["1772755",[15402,1175.54,111]]];
_nodes set [count _nodes, ["1772768",[15433.6,1216.85,111]]];
_nodes set [count _nodes, ["1764614",[15468.2,1236.83,111]]];
_nodes set [count _nodes, ["1764676",[15537.6,623.457,9.53674]]];
_nodes set [count _nodes, ["1764684",[15517.5,657.662,9.53674]]];
_nodes set [count _nodes, ["1764670",[15498.2,691.088,9.53674]]];
_nodes set [count _nodes, ["1772746",[15468.1,1157.1,-68.995]]];
_nodes set [count _nodes, ["1772750",[15626,787.568,111]]];
_nodes set [count _nodes, ["1772752",[15570,884.558,111]]];
_nodes set [count _nodes, ["1772753",[15514,981.545,111]]];
_nodes set [count _nodes, ["1772754",[15457.9,1078.62,111]]];
[_cluster,"nodes",_nodes] call ALIVE_fnc_hashSet;
[_cluster, "state", _cluster] call ALIVE_fnc_cluster;
[_cluster,"clusterID","c_17"] call ALIVE_fnc_hashSet;
[_cluster,"center",[]] call ALIVE_fnc_hashSet;
[_cluster,"size",0] call ALIVE_fnc_hashSet;
[_cluster,"type","MIL"] call ALIVE_fnc_hashSet;
[_cluster,"priority",10] call ALIVE_fnc_hashSet;
[_cluster,"debugColor","ColorOrange"] call ALIVE_fnc_hashSet;
[ALIVE_clustersMilAir,"c_17",_cluster] call ALIVE_fnc_hashSet;
ALIVE_clustersMilHeli = [] call ALIVE_fnc_hashCreate;
_cluster = [nil, "create"] call ALIVE_fnc_cluster;
_nodes = [];
_nodes set [count _nodes, ["1227135",[15619.1,17244.3,0.0100222]]];
_nodes set [count _nodes, ["1227134",[15656.4,17244.4,0.0100222]]];
_nodes set [count _nodes, ["1227136",[15691.9,17244.4,0.0100226]]];
[_cluster,"nodes",_nodes] call ALIVE_fnc_hashSet;
[_cluster, "state", _cluster] call ALIVE_fnc_cluster;
[_cluster,"clusterID","c_18"] call ALIVE_fnc_hashSet;
[_cluster,"center",[15655.5,17244.4]] call ALIVE_fnc_hashSet;
[_cluster,"size",150] call ALIVE_fnc_hashSet;
[_cluster,"type","MIL"] call ALIVE_fnc_hashSet;
[_cluster,"priority",20] call ALIVE_fnc_hashSet;
[_cluster,"debugColor","ColorYellow"] call ALIVE_fnc_hashSet;
[ALIVE_clustersMilHeli,"c_18",_cluster] call ALIVE_fnc_hashSet;
_cluster = [nil, "create"] call ALIVE_fnc_cluster;
_nodes = [];
_nodes set [count _nodes, ["1226683",[10977.2,19640.2,0.0100098]]];
[_cluster,"nodes",_nodes] call ALIVE_fnc_hashSet;
[_cluster, "state", _cluster] call ALIVE_fnc_cluster;
[_cluster,"clusterID","c_19"] call ALIVE_fnc_hashSet;
[_cluster,"center",[10977.2,19640.2]] call ALIVE_fnc_hashSet;
[_cluster,"size",150] call ALIVE_fnc_hashSet;
[_cluster,"type","MIL"] call ALIVE_fnc_hashSet;
[_cluster,"priority",20] call ALIVE_fnc_hashSet;
[_cluster,"debugColor","ColorYellow"] call ALIVE_fnc_hashSet;
[ALIVE_clustersMilHeli,"c_19",_cluster] call ALIVE_fnc_hashSet;
