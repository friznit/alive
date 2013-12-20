<?php

/**
 * TEMPO - Template Pods
 * @copyright Copyright (c) 2007, Parca/Nemo/Johnston
 * @author Andy
 */

namespace Tempo\Base;

/**
 * Base command.
 */

use Tempo\Output\HTMLFormat;
use Tempo\Util\PrettyDump;

class Base
{

	function __construct()
	{		

	}	
	
	/**
	 * Debug an object of your choice..
	 */
	protected function _dump($object, $title = false)
	{		
		$formatter = new HTMLFormat();
		$dump = new PrettyDump($formatter);
		$dump->dump($object, $title);
	}
	
	/**
	 * Output a message of your choice..
	 */
	protected function _message($msg)
	{
		$formatter = new HTMLFormat();
		$dump = new PrettyDump($formatter);
		$dump->message($object, $title);
	}
		
}