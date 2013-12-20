<?php

/**
 * TEMPO
 * @copyright Copyright (c) 2007, Parca/Nemo/Johnston
 * @author Andy
 */

namespace Tempo\Base;


/**
 * Connected Optional abstract
 */

use Tempo\Base\Int\Connectable;
use Tempo\database\Connection;

class ConnectedOptions extends Options implements Connectable
{
	
	/**
	 * Stores the connection  
	 * @var Connection
	 */	
	protected $connection;
	
	/**
	 * Set the connection object
	 * @param Connection
	 * 	The database connection
	 */
	public function connection_set(Connection $connection){
		$this->connection = $connection;
	}
	
}
