<?php

/**
 * TEMPO
 * @copyright Copyright (c) 2007, Parca/Nemo/Johnston
 * @author Andy
 */

namespace Tempo\Base\Int;

/**
 * Interface for classes that require a connection object
 */

use Tempo\database\Connection;

interface Connectable
{

	public function connection_set(Connection $connection);

}