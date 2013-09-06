$index_path = 'P:\x\alive\addons\fnc_strategic\indexes\'
#$index_names = ('stratis')
$index_names = ('altis','chernarus','desert_e','provinggrounds_pmc','shapur_baf','stratis','takistan','utes','zargabad')
$black_list = ('rocks_f','plants_f','rocks_e','plants_e','rocks2','plants2','pond')

foreach ($index_name in $index_names){
    
    $index_file = $index_path + 'objects.' + $index_name + '.sqf'
    $parsed_index_file = $index_path + 'parsed.objects.' + $index_name + '.sqf'
    $ignore = $false;

    echo ("Parsing : " + $index_file)

    $reader = [System.IO.File]::OpenText($index_file)
    $stream = [System.IO.StreamWriter] $parsed_index_file
    try {
        for(;;) {
            $line = $reader.ReadLine()
            if ($line -eq $null) { break }
            $in_black_list = $false
            if($line -match '"'){
                echo $(" -- Block : " + $line)
                for ($o = 0; $o -lt $black_list.count; $o++) {
                    if ($line -match $black_list[$o]) {
                        $in_black_list = $true
                    }
                }
                if($in_black_list){
                    $ignore = $true
                }else{
                    $ignore = $false
                }
                if($ignore){
                    echo $(" ----- Ignoring : " + $line)
                }
            }
            if(!$ignore){
                $stream.WriteLine($line)    
            }
        }
    }
    finally {
        $reader.close()
        $stream.close()
    }
}

Start-Sleep -s 10

foreach ($index_name in $index_names){
    $index_file = $index_path + 'objects.' + $index_name + '.sqf'
    $parsed_index_file = $index_path + 'parsed.objects.' + $index_name + '.sqf'

    if (Test-Path $index_file){
        Remove-Item $index_file
    }

    if (Test-Path $parsed_index_file){
        Rename-Item $parsed_index_file -newname $index_file
    } 

}

#lols
Add-Type -AssemblyName System.Speech
$synth = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer
$synth.Speak('Parsing complete')

echo " "
echo " "
Read-Host "Press ENTER to continue"