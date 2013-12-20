<?php
/**
 * Pretty Dump Utitliy Class
 *
 * This class recursively dumps php basic types, objects and class definitions
 *
 */

namespace Tempo\Util;

use ReflectionClass;
use ReflectionMethod;
use ReflectionProperty;
use ReflectionParameter;
use Tempo\Base\Int\Formatable;
use Tempo\Base\BufferedOptions;
use Tempo\Util\Util;

class PrettyDump extends BufferedOptions implements Formatable
{
	/**
	 * Stores the class that formats output
	 * @var mixed
	 */
	protected $formatter;
	
	/**
	 * The current depth of recursion  
	 * @var int
	 */
	protected $depth = 0;
	
	/**
	 * The maximum depth of recursion
	 * @var int
	 */
	protected $max_depth;
	
	
	public function __construct($formatter, $max_depth=20)
	{
		$this->formatter_set($formatter);
		$this->max_depth = $max_depth;
	}
	
	/**
	 * Output a message
	 * @param $input mixed
	 */
	public function message($title = '')
	{
		$this->_buffer_append($this->formatter->page_start(920));
		$this->_buffer_append($this->formatter->page_title($title));
		$this->_buffer_append($this->formatter->page_end());
		return $this->buffer_get();
	}
	
	/**
	 * Dump one or more items
	 * @param $input mixed
	 */
	public function dump($input=null,$title=false)
	{	
		// no args passed perform environment dump
		if(func_num_args() == 0){
			$this->_env();
		}
		
		// safe recursion
		$input = Util::remove_recursion($input);
		
		$this->_buffer_append($this->formatter->page_start(920));
		
		if($title)
		{
			$this->_buffer_append($this->formatter->page_title($title));	
		}
		
		// start dumping
		$this->_dump($input);
		
		$this->_buffer_append($this->formatter->page_end());
		
		return $this->buffer_get();		
	}
	
	/**
	 * Dump environment variables
	 * Called when no arguments passed to dump() 
	 */
	protected function _env(){
		$this->dump($_SERVER,$_GET,$_POST,$_COOKIE,$_ENV,$_FILES,$_REQUEST,@$_SESSION);
	}
	
	/**
	 * Recursively dump items
	 * @param $input mixed 
	 * @param $name mixed 
	 */
	protected function _dump($input, $name='...')
	{		
		
		// return if recursion depth exceeds 
		// max depth
		if(($this->depth >= $this->max_depth) || ($this->depth < 0 )){
			return;
		}
		
		if(is_scalar($input))
		{
			$this->_scalar($input, $name);
		}		
		else
		{			
			
			if (is_object($input))
			{		
				
				// keep track of current depth
				$this->depth++;
				
				$this->formatter->depth_set($this->depth);
								
				$this->_buffer_append($this->formatter->wrapper_start());

				$class = get_class($input);
				$class = new ReflectionClass($class);
				
				// standard class special treatment
				if($class->getName()=='stdClass')
				{
					$this->_object($class, $input, $name);
					
					$this->_buffer_append($this->formatter->list_start());
			
					foreach($input as $key=>$value)
					{						
						// recurse
						$this->_dump($value, $key);					
					}
					
					$this->_buffer_append($this->formatter->list_end());
					
				}
				elseif($class->getName()=='ErrorException')
				{
					$this->_error_exception($class, $input, $name);
				}
				// other classes
				else
				{
					$this->_object($class, $input, $name);
				}				

				$this->_buffer_append($this->formatter->wrapper_end());
				
				// keep track of current depth
				$this->depth--;
				
				$this->formatter->depth_set($this->depth);
				
			}			
			
			if (is_array($input))
			{				
				
				// keep track of current depth
				$this->depth++;
								
				if($this->depth > 1){
					$this->_array_value($input, $name);
				}
				
				$this->formatter->depth_set($this->depth);				
				
				$this->_buffer_append($this->formatter->wrapper_start());	
				
				if($this->depth <= 1){
					$this->_array($input, $name);
				}	
				
				$this->_buffer_append($this->formatter->list_start());
			
				foreach($input as $key=>$value)
				{					
					// recurse
					$this->_dump($value, $key);					
				}
				
				$this->_buffer_append($this->formatter->list_end());				
				
				$this->_buffer_append($this->formatter->wrapper_end());
				
				// keep track of current depth
				$this->depth--;				
				
				$this->formatter->depth_set($this->depth);
				
			}			
		}	
	}
	
	/**
	 * Prepare output for scalar types 
	 * @param $input mixed 
	 * @param $name mixed
	 */
	protected function _scalar($input, $name)
	{				
		if (is_string($input))
		{
			$len = strlen($input);
			if($len === 0) $input = 'EMPTY STRING';

			// escape script tags 
			if($len>100)
			{
				$start = substr($input,0,5);
				if($start === '<scri' || $start === '<link')
				{
					$input = htmlspecialchars($input);
				}				
			}
			else
			{
				$input = htmlspecialchars($input);
			}			
			 
			$this->_value("(String) [$len]", $input, $name);
		}		
		if (is_float($input))
		{
			$this->_value('(Float)', $input, $name);
		}
		if (is_integer($input))
		{
			$this->_value('(Interger)', $input, $name);
		}
		if (is_bool($input))
		{
			if(!$input) $input = '0';
			$this->_value('(Boolean)', $input, $name);
		}
		if (is_null($input))
		{
			$this->_value('(Null)', $input, $name);
		}
	}
	
	/**
	 * Prepare output for object types 
	 * @param $class ReflectionClass 
	 * @param $instance mixed
	 * @param $name mixed 
	 */
	protected function _object(ReflectionClass $class,$instance,$name)
	{					
		
		$this->_class($class);		

		// loop class properties
		$properties =  $class->getProperties();
		
		$this->_buffer_append($this->formatter->list_start());
		
		foreach ($properties as $property)
		{					
			$class_property = new ReflectionProperty($property->class,$property->name);
			$this->_property($instance, $class_property);	
		}
		$this->_buffer_append($this->formatter->list_end());		
				
	}
	
	/**
	 * Prepare output for error exception types 
	 * @param $class ReflectionClass 
	 * @param $instance mixed
	 * @param $name mixed 
	 */
	protected function _error_exception(ReflectionClass $class,$instance,$name)
	{
		$file = $instance->getFile();
		$file = array_pop(explode('\\',$file));
		$title = $this->formatter->header_title($instance->getMessage(), '920px');
		$type = $this->formatter->big('line:' . $instance->getLine(), '920px');	
		$source_trim = $this->formatter->medium($file, '920px');
		$source = $this->formatter->comment($instance->getFile());
		
		$sub_header = $this->formatter->sub_header($title.$type.$source_trim.$source);
		
		$this->_buffer_append($sub_header);		
	}
	
	/**
	 * Prepare output for array types 
	 * @param $array array
	 * @param $name mixed 
	 */
	protected function _array($array, $name)
	{		
		$type = '(Array) [' . count($array) . ']';
		
		$name = $this->formatter->header_title($name);
		$type = $this->formatter->header_small($type);		
		$header = $this->formatter->header($name.$type);		
		$this->_buffer_append($header);
	}
	
	/**
	 * Prepare output for array types as a value
	 * @param $array array
	 * @param $name mixed 
	 */
	protected function _array_value($array, $name)
	{		
		$type = '(Array) [' . count($array) . ']';
		
		$output = $this->formatter->subtle_text($name);
		$output .= $this->formatter->small_text($type);
		$output = $this->formatter->list_item($output);
		
		$this->_buffer_append($output);
	}
	
	/**
	 * Prepare output for class types 
	 * @param $class ReflectionClass 
	 */
	protected function _class(ReflectionClass $class)
	{
		// display the header		
		$title = ' ' . $class->getName();
		
		$type = '(';
		$type .= $class->isInternal() ? 'Internal' : 'User-Defined';
		$type .= $class->isAbstract() ? ' Abstract' : '';
		$type .= $class->isFinal() ? ' Final' : '';
		$type .= $class->isInterface() ? ' Interface' : ' Class';
		$type .= ')';
		
		$source = ' Source: ' . Util::strip_file_name($class->getFileName());
		
		$title = $this->formatter->header_title($title);
		$type = $this->formatter->header_small($type, '250px');			
		$source = $this->formatter->header_small($source, '200px');	
		
		$header = $this->formatter->header($title.$type.$source);		
		$this->_buffer_append($header);
		
	}	
	
	/**
	 * Prepare output for class property types 
	 * @param $instance mixed
	 * @param $property ReflectionProperty 
	 */
	protected function _property($instance, ReflectionProperty $property)
	{		
		// prepare output for the property list item
		
		$title = ' $' . $property->getName();
				
		$type = '(';
		$type .= $property->isDefault() ? 'Default ' : '';
		$type .= $property->isPrivate() ? ' Private ' : '';
		$type .= $property->isProtected() ? ' Protected ' : '';
		$type .= $property->isPublic() ? ' Public ' : '';
		$type .= $property->isStatic() ? ' ' : '';
		$type .= 'Property)';
		
		$title = $this->formatter->subtle_text($title);
		$type = $this->formatter->small_text($type);	
		
		// if there is an instance of the class
		// try to get value of this property
		if(!is_null($instance)){
			$property->setAccessible(true);
			$value = $property->getValue($instance);
			
			if(is_scalar($value))
			{
				$value = $this->formatter->standard_text($value);
				// output the scalar value
				$this->_buffer_append($this->formatter->list_item($title.$type.$value));	
			}
			elseif(!is_null($value))
			{
				// output the object or array name
				$this->_buffer_append($this->formatter->list_item($title.$type));
				// recurse
				$this->_dump($value);
			}			
		}
		else
		{
			$this->_buffer_append($this->formatter->list_item($title.$type));	
		}
			
	}

	/**
	 * Prepare output for scalar value types 
	 * @param $type string
	 * @param $input mixed
	 * @param $name string 
	 */
	protected function _value($type, $input, $name)
	{
		$output = $this->formatter->subtle_text($name);
		$output .= $this->formatter->small_text($type);
		$output .= $this->formatter->standard_text($input);		
		$output = $this->formatter->list_item($output);
		
		$this->_buffer_append($output);
	}
	
	/**
	 * Sets the formatter class
	 */
	public function formatter_set($formatter)
	{
		 $this->formatter = $formatter;
	}

}