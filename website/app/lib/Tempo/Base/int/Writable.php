<?php

/**
 * TEMPO
 * @copyright Copyright (c) 2007, Parca/Nemo/Johnston
 * @author Andy
 */

namespace Tempo\Base\Int;

/**
 * Interface for classes that require a writer object
 */

interface Writable
{

	public function writer_set($writer);	

}