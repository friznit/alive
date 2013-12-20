<?php

/**
 * TEMPO
 * @copyright Copyright (c) 2007, Parca/Nemo/Johnston
 * @author Andy
 */

namespace Tempo\Base\Int;

/**
 * Interface for classes that require a emailer object
 */

interface Emailable
{

	public function emailer_set($emailer);	

}