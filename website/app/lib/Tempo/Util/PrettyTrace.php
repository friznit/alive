<?php
/**
 * Pretty Trace Utitliy Class
 *
 * This class is used to display stack trace results
 *
 */

namespace Tempo\Util;

use ReflectionClass;
use ReflectionMethod;
use ReflectionProperty;
use ReflectionParameter;
use Tempo\Base\Output;
use Tempo\Util\Util;

class PrettyTrace extends PrettyDump
{
	
	public function __construct($formatter,$max_depth=1)
	{
		$this->formatter_set($formatter);
		$this->max_depth = $max_depth;
	}
	
	/**
	 * Dump a stack trace from debug backtrace
	 * @param $input mixed
	 */
	public function trace($input)
	{		
		// safe recursion
		$input = Util::remove_recursion($input);
		
		$input = array_slice($input,1);
		
		$this->_buffer_append($this->formatter->page_start(920));
		
		// start inspecting
		$this->_trace($input,'');

		$this->_buffer_append($this->formatter->page_end());
		
		return $this->buffer_get();
		
	}
	
	/**
	 * Dump a stack trace
	 * @param $class mixed 
	 * @param $name mixed
	 */
	protected function _trace($input, $name='...')
	{
		$this->_buffer_append($this->formatter->wrapper_start());
		
		if (is_array($input))
		{		
			foreach($input as $item)
			{
				// display the header
				if(isset($item['line']))
				{
					$header = $this->formatter->header_title('Line: '.$item['line'],70);
				}
				
				if(isset($item['file']))
				{
					$header .= $this->formatter->header_small('File: '.Util::strip_file_name($item['file']),400);	
				}
				
				$header = $this->formatter->header($header);
				$this->_buffer_append($header);

				
				// display the sub header				
				if(isset($item['class']))
				{
					$sub_header = $this->formatter->sub_header_title('Class: '.$item['class'].'()');	
					$sub_header = $this->formatter->sub_header($sub_header);
					$this->_buffer_append($sub_header);
				}
				
				if(isset($item['function']))
				{
					$sub_header = $this->formatter->sub_header_title('Function: '.$item['function'].'()');
					$sub_header = $this->formatter->sub_header($sub_header);
					$this->_buffer_append($sub_header);
				}				
									
				if(isset($item['object']))
				{
					$sub_header = $this->formatter->sub_header_title('Object: '.$item['object'].'{}');	
					$sub_header = $this->formatter->sub_header($sub_header);
					$this->_buffer_append($sub_header);
				}
				
				if(isset($item['type']))
				{
					$type = '';
					if($item['type']=='->') $type = 'Method';
					if($item['type']=='::') $type = 'Static';
					$sub_header = $this->formatter->sub_header_title('Type: '.$type);
					$sub_header = $this->formatter->sub_header($sub_header);
					$this->_buffer_append($sub_header);	
				}
								
				if(isset($item['args']))
				{
					if(count($item['args']))
					{
						$this->_buffer_append($this->formatter->list_start());
						foreach($item['args'] as $key=>$value)
						{
							if(is_scalar($value))
							{
								$this->_scalar($value,$key);
							}else
							{
								$this->_dump($value,$key);	
							}
						}
						$this->_buffer_append($this->formatter->list_end());
					}
				}
			}
		}
					
		$this->_buffer_append($this->formatter->wrapper_end());
	}

}