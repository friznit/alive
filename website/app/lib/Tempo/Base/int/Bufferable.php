<?php

/**
 * TEMPO
 * @copyright Copyright (c) 2007, Parca/Nemo/Johnston
 * @author Andy
 */

namespace Tempo\Base\Int;

/**
 * Inerface for classes that require an output buffer
 */

interface Bufferable 
{

	public function buffer_echo();
	
	public function buffer_get();
	
	public function buffer_clear();
	
}