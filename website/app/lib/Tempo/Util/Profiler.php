<?php 

/**
 * TEMPO
 * @copyright Copyright (c) 2007, Parca/Nemo/Johnston
 * @author Andy
 */

namespace Tempo\Util;

class Profiler
{    
    function __construct()
	{		
		// set the base points
		$this->_get_execution_time();
		$this->_get_memory_usage();
	}
	
	/**
	 * displays profile info since profiling start 
	 */
	public function reset_profile()
	{
		$time = $this->_get_execution_time(true);
		$memory = $this->_get_memory_usage(true);
	}
	
	/**
	 * displays profile info and resets profile counts
	 */
	public function stop_profile()
	{
		$time = $this->_get_execution_time();
		$memory = $this->_get_memory_usage();
		$result = $this->_micro_to_seconds($time) . ' seconds elapsed ';
		$result .= $this->_bytes_to_human($memory) . ' memory consumed ';
		$result .= $this->_bytes_to_human(memory_get_peak_usage()) . ' memory peak';
		
		$result = $this->_message($result);
		
		$time = $this->_get_execution_time(true);
		$memory = $this->_get_memory_usage(true);
		
		return $result;
	}
	
	/**
	 * get execution time in seconds at current point of call in seconds
	 * @return float Execution time at this point of call
	 */
	protected function _get_execution_time($reset = false)
	{
	    static $microtime_start = null;
	    
	    if($microtime_start === null || $reset)
	    {
	        $microtime_start = microtime(true);
	        return 0.0; 
	    }    
	    return microtime(true) - $microtime_start; 
	}
	
	/**
	 * get consumed memory
	 * @return int Memory consumed time at this point of call
	 */
	protected function _get_memory_usage($reset = false)
	{
		static $mem_start = null;
		if($mem_start === null || $reset)
	    {
	        $mem_start = memory_get_usage();
	        return 0; 
	    }    
	    return memory_get_usage() - $mem_start;
	}
	
	/**
	 * make human readable bytes
	 * @param $path string
	 */
	protected function _bytes_to_human($bytes){
		if ($bytes < 1024) return $bytes.' B';
		elseif ($bytes < 1048576) return round($bytes / 1024, 2).' KB';
		elseif ($bytes < 1073741824) return round($bytes / 1048576, 2).' MB';
		elseif ($bytes < 1099511627776) return round($bytes / 1073741824, 2).' GB';
		else return round($bytes / 1099511627776, 2).' TB';
	}
	
	/**
	 * micro to seconds
	 * @param $path string
	 */
	protected function _micro_to_seconds($micro){
		return number_format($micro,3);
	}
	
	/**
	 * Output a message of your choice..
	 */
	protected function _message($msg)
	{
		//var_dump($msg);
		/*
		$formatter = new HTMLFormat();
		$dump = new PrettyDump($formatter);
		return $dump->message($msg);
		*/
		echo '<div style=" display:block; width: 920px; margin: auto; padding: 12px; font-family: Arial, sans-serif; color: #e4e0e0; border: 1px solid #272823; background: #7d7878; box-shadow: inset 0 0 7px #393838; text-shadow: 0px 1px 0px #000; margin-bottom:13px; margin-top:13px;"><span style="display:inline-block; font-size: 1em; margin: 0 0 7px;">';
		echo $msg . '</span></div>';
	}
	
}