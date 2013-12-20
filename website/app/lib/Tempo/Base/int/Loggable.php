<?php

/**
 * TEMPO
 * @copyright Copyright (c) 2007, Parca/Nemo/Johnston
 * @author Andy
 */

namespace Tempo\Base\Int;

/**
 * Interface for classes that require a logger object
 */

use Tempo\Util\Logger;

interface Loggable
{

	public function logger_set(Logger $logger);

}