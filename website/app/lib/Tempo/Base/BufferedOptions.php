<?php

/**
 * TEMPO
 * @copyright Copyright (c) 2007, Parca/Nemo/Johnston
 * @author Andy
 */

namespace Tempo\Base;

/**
 * Buffered Optional abstract
 */

use Tempo\Base\Int\Bufferable;

class BufferedOptions extends Options implements Bufferable
{
	
	/**
	 * Stores the output string  
	 * @var string
	 */
	protected $buffer = '';
	
	
	/**
	 * Echo the internal buffer
	 */
	public function buffer_echo()
	{
		 echo $this->buffer;
	}
	
	/**
	 * Return the internal buffer 
	 * @return
     *  The buffer string
	 */
	public function buffer_get()
	{
		$buffer = $this->buffer;
		$this->buffer_clear();
		return $buffer;
	}
	
	/**
	 * Clear the internal buffer
	 */
	public function buffer_clear()
	{
		 $this->buffer = '';
	}
	
	/**
	 * Append to the internal buffer 
	 * @param $output string 
	 * 
	 */
	protected function _buffer_append($output)
	{
		 $this->buffer .= $output;
	}
	
}
