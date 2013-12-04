﻿$index_path = 'P:\x\alive\addons\fnc_strategic\indexes\'

$index_names = (
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
    #'eden',
    'fallujah',
    'fdf_isle1_a',
    'isladuala',
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
    
    $output_file = $index_path + 'objects_list.' + $index_name + '.txt'
    $index_file = $index_path + 'objects.' + $index_name + '.sqf'

    echo ("Parsing : " + $index_file)

    $reader = [System.IO.File]::OpenText($index_file)
    $stream = [System.IO.StreamWriter] $output_file
    try {
        for(;;) {
            $line = $reader.ReadLine()
            if ($line -eq $null) { break }
            if($line -match '"'){
                echo $(" -- Block : " + $line)
                $stream.WriteLine($line)
            }
        }
    }
    finally {
        $reader.close()
        $stream.close()
    }
}

echo " "
echo " "
Read-Host "Press ENTER to continue"