<?php

/**
 * TEMPO
 * @copyright Copyright (c) 2007, Parca/Nemo/Johnston
 * @author Andy
 */

namespace Tempo\Base\Int;

/**
 * Interface for objects that require an overwritable defaults / options array
 */

interface Optionable
{

	public function options_set(array $options);

	public function options_get();
	
	public function defaults_set(array $defaults);

	public function defaults_get();
	
}