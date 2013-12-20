<?php

/**
 * TEMPO
 * @copyright Copyright (c) 2007, Parca/Nemo/Johnston
 * @author Andy
 */

namespace Tempo\Base;

/**
 * Optional abstract class
 */

use Tempo\Base\Int\Optionable;

abstract class Options implements Optionable
{
	
	/**
	 * Stores the options array  
	 * @var array
	 */
	protected $options;
	
	/**
	 * Stores the default options array
	 * @var array
	 */
	protected $defaults = array();
		
	/**
	 * Apply a set of options that will be merged with defaults options.
	 * Passed options overwrite default options
	 * @param array
	 * 	The options array
	 */
	public function options_set(array $options)
	{
		$this->options = $options + $this->defaults;
	}
	
	/**
	 * Return the options array
	 * @return array
     *  The options array
	 */
	public function options_get()
	{
		return $this->options;
	}
	
	/**
	 * Set the defaults options.
	 * @param array
	 * 	The defaults array
	 */
	public function defaults_set(array $defaults)
	{
		$this->defaults = $defaults;
	}
	
	/**
	 * Return the defaults array
	 * @return array
     *  The defaults array
	 */
	public function defaults_get()
	{
		return $this->defaults;
	}

}