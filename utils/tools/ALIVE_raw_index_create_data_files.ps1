$mil_cluster_path = 'P:\x\alive\addons\mil_placement\clusters\'
$civ_cluster_path = 'P:\x\alive\addons\civ_placement\clusters\'
$analysis_path = 'P:\x\alive\addons\fnc_analysis\data\'


$index_names = (
    'baranow',
    'france',
    'ivachev',
    'panovo',
    'staszow',
    #'abel',
    'altis',
    #'cain',
    'celle',
    'chernarus',
    'carraigdubh',
    'clafghan',
    'desert',
    'desert_e',
    'desert2',
    'hellskitchen',
    'hellskitchens',
    #'eden',
    'fata',
    'fallujah',
    'fdf_isle1_a',
    'isladuala',
    'koplic',
    'lingor',
    'mcn_hazarkot',
    'namalsk',
    'isoladicapraia',
    #'noe',
    'panthera',
    'provinggrounds_pmc',
    'sara',
    'sara_dbe1',
    'saralite',
    'shapur_baf',
    'stratis',
    'takistan',
    'thirsk',
    'thirskw',
    'tigeria',
    #'tigeria_se',
    'torabora',
    'tup_qom',
    'utes',
    #'vostok',
    #'vostok_w',
    'zargabad')

foreach ($index_name in $index_names){
    
    $mil_cluster_file = $mil_cluster_path + 'clusters.' + $index_name + '_mil.sqf'
    $civ_cluster_file = $civ_cluster_path + 'clusters.' + $index_name + '_civ.sqf'
    $analysis_file = $analysis_path + 'data.' + $index_name + '.sqf'

    if (-not(Test-Path $mil_cluster_file)){
        echo ("Creating File : " + $mil_cluster_file)
        $stream = [System.IO.StreamWriter] $mil_cluster_file
    }

    if (-not(Test-Path $civ_cluster_file)){
        echo ("Creating File : " + $civ_cluster_file)
        $stream = [System.IO.StreamWriter] $civ_cluster_file
    }

    if (-not(Test-Path $analysis_file)){
        echo ("Creating File : " + $analysis_file)
        $stream = [System.IO.StreamWriter] $analysis_file
    }
    
    $stream.close()
}

echo " "
echo " "
Read-Host "Press ENTER to continue"