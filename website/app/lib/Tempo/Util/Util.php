<?php

/**
 * TEMPO - Template Pods
 * @copyright Copyright (c) 2007, Parca/Nemo/Johnston
 * @author Andy
 */

namespace Tempo\Util;

class Util
{
	
	/**
	 * Safe recursion handling
	 * @author Andrea Giammarchi
	 * @project http://code.google.com/p/formaldehyde/ 
	 */
	public static function remove_recursion($input)
	{
		static  $replace;
	    if(!isset($replace))
	        $replace = create_function('$m','$r="\x00{$m[1]}ecursion_";return \'s:\'.strlen($r.$m[2]).\':"\'.$r.$m[2].\'";\';')
	    ;
	    if(is_array($input) || is_object($input)){
	        $re = '#(r|R):([0-9]+);#';
	        $serialize = serialize($input);
	        if(preg_match($re, $serialize)){
	            $last = $pos = 0;
	            while(false !== ($pos = strpos($serialize, 's:', $pos))){
	                $chunk = substr($serialize, $last, $pos - $last);
	                if(preg_match($re, $chunk)){
	                    $length = strlen($chunk);
	                    $chunk = preg_replace_callback($re, $replace, $chunk);
	                    $serialize = substr($serialize, 0, $last).$chunk.substr($serialize, $last + ($pos - $last));
	                    $pos += strlen($chunk) - $length;
	                }
	                $pos += 2;
	                $last = strpos($serialize, ':', $pos);
	                $length = substr($serialize, $pos, $last- $pos);
	                $last += 4 + $length;
	                $pos = $last;
	            }
	            $serialize = substr($serialize, 0, $last).preg_replace_callback($re, $replace, substr($serialize, $last));
	            $input = unserialize($serialize);
	        }
	    }
	    return $input;
	}
	
	/**
	 * Make a file path more readable by stripping out root location on disk
	 * @param $path string
	 */
	public static function strip_file_name($path){
        /*
		$search = \tempo\LIBRARY_PATH;
		$path = str_replace($search, '', $path);
		return $path;
        */
	}
	
	/**
	 * Make human readable bytes
	 * @param $path string
	 */
	public static function bytes_to_human($bytes){
		if ($bytes < 1024) return $bytes.' B';
		elseif ($bytes < 1048576) return round($bytes / 1024, 2).' KB';
		elseif ($bytes < 1073741824) return round($bytes / 1048576, 2).' MB';
		elseif ($bytes < 1099511627776) return round($bytes / 1073741824, 2).' GB';
		else return round($bytes / 1099511627776, 2).' TB';
	}
	
}