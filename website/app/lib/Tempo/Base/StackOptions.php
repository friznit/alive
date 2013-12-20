<?php

/**
 * TEMPO
 * @copyright Copyright (c) 2007, Parca/Nemo/Johnston
 * @author Andy
 */

namespace Tempo\Base;

/**
 * Stack Optional abstract
 */

use ArrayIterator;

class StackOptions extends Options
{	
	/**
	 * The stack
	 * @var array
	 */	
	protected $stack;
	
	/**
	 * Push an item onto the stack
	 * @param mixed $value
	 * @param mixed $key
	 */
	protected function _stack_push($value, $key = null)
	{
		if($key != null)
		{
			$this->stack[$key] = $value;	
		}
		else
		{
			$this->stack[] = $value;	
		}		
	}
	
	/**
	 * Pop an item off the stack
	 * $return mixed
	 */
	protected function _stack_pop()
	{
		return array_pop($this->stack);
	}
	
	/**
	 * Clear the stack
	 */
	protected function _stack_clear()
	{
		$this->stack = null;
	}	
	
	/**
	 * Get an iterator for the stack
	 * @return ArrayIterator
	 */
	protected function _stack_get_iterator()
	{
		return new ArrayIterator($this->stack);
	}
	
}
