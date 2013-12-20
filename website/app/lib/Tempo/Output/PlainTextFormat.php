<?php

/**
 * TEMPO
 * @copyright Copyright (c) 2007, Parca/Nemo/Johnston
 * @author Andy
 */

namespace Tempo\Output;

/**
 * Plain Text Format
 *
 * Provides basic formating for system plain text output
 * 
 */

use Tempo\Base\Options;

class PlainTextFormat extends Options
{
	
	protected $depth = 0;
	protected $tabs = '';
	
	function __construct(array $options = array())
	{
		$this->options_set($options);
	}

	public function wrapper_start()
	{						
		$text = $this->_line_start() . '>>---------------------------------------------------';
		return $text;
	} 
	
	public function wrapper_end()
	{		
		$text =  $this->_line_start() . '---------------------------------------------------<<';
		return $text;
	}
	
	public function header($input)
	{		
		$text = $this->_line_start() . '' . $input . '';
		return $text;
	}
	
	public function header_title($input)
	{		
		$text = $input . ' ';
		return $text;
	}
	
	public function header_small($input)
	{		
		$text = "\t" . $input . ' ';
		return $text;
	}
	
	public function sub_header($input)
	{		
		$text = $this->_line_start() . '' . $input . '';
		return $text;
	}
	
	public function sub_header_title($input)
	{		
		$text = ' ' . $input . ' ';
		return $text;
	}

	public function list_start()
	{		
		$text = '';
		return $text;
	}
	
	public function list_end()
	{
		$text = '';
		return $text;
	}
	
	public function list_item($input)
	{		
		$text =  $this->_line_start() . ' ' . $input;
		return $text;
	}
	
	public function standard_text($input)
	{		
		$text = "\t" . $input;
		return $text;
	}
	
	public function subtle_text($input)
	{		
		$text = $input . '';
		return $text;
	}
	
	public function small_text($input)
	{		
		$text = " " . $input . '';
		return $text;
	}
	
	public function comment($input)
	{				
		$text = "\t" . $input . '';
		return $text;
	}
	
	public function heading($input)
	{
		return $this->newline() . $input . $this->newline(); 
	}
	
	public function newline()
	{
		return PHP_EOL;
	}
	
	public function depth_set($depth)
	{
		$this->depth = $depth;
		$this->tabs = '';
		for($i = 1; $i < $this->depth; ++$i) $this->tabs .= "\t";
	}
	
	protected function _line_start()
	{		
		return PHP_EOL . $this->tabs;
	}
}