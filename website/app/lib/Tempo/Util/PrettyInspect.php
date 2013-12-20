<?php
/**
 * Pretty Inspect Utitliy Class
 *
 * This class recursively dumps objects and class definitions
 *
 */

namespace Tempo\Util;

use ReflectionClass;
use ReflectionMethod;
use ReflectionProperty;
use ReflectionParameter;
use Tempo\Base\Output;
use Tempo\Util\Util;

class PrettyInspect extends PrettyDump
{
	
	/**
	 * Inspect a class
	 * @param $input mixed
	 */
	public function inspect($input)
	{
		// safe recursion
		$input = Util::remove_recursion($input);
		
		$this->_buffer_append($this->formatter->page_start(920));
		
		// start inspecting
		$this->_inspect($input,'');		
		
		$this->_buffer_append($this->formatter->page_end());
		
		return $this->buffer_get();		
	}
	
	/**
	 * Inspect a class
	 * Outputs full class details including doc comments
	 * @param $class mixed 
	 * @param $name mixed
	 */
	protected function _inspect($input, $name='...')
	{
		$this->_buffer_append($this->formatter->wrapper_start());
		
		$class = new ReflectionClass($input);
		
		if(is_object($input))
		{
			$this->_object($class, $input, '');	
		}
		else
		{
			$this->_object($class, null, '');
		}		
			
		$this->_buffer_append($this->formatter->wrapper_end());
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
		
		
		// loop class methods
		$methods = $class->getMethods();
		
		foreach ($methods as $method)
		{			
			$this->_buffer_append($this->formatter->wrapper_start());
			
			$class_method = new ReflectionMethod($method->class, $method->name);
			$this->_method($class_method);
			
			$this->_buffer_append($this->formatter->wrapper_end());
		}				
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
		$type = $this->formatter->header_small($type);			
		$source = $this->formatter->header_small($source);	
		
		$header = $this->formatter->header($title.$type.$source);		
		$this->_buffer_append($header);

		if($class->getParentClass())
		{
			$parent = $class->getParentClass();
			$parent_name = $this->formatter->header_small(' Parent: ' . $parent->getName());
			$parent_source = $this->formatter->header_small(' Source: ' . Util::strip_file_name($parent->getFileName()));
			
			$sub_header = $this->formatter->sub_header($parent_name.$parent_source);
			$this->_buffer_append($sub_header);
		}
		
		if($comment = $class->getDocComment())
		{
			$comment = str_replace('*','',$comment);
			$comment = str_replace('/','',$comment);
			$comment = trim(nl2br($comment));
			
			$this->_buffer_append($this->formatter->comment($comment));	
		}
		else
		{
			$comment_block = '/**<br/>';
			$comment_block .= '&nbsp;*<br/>';
			$comment_block .= "&nbsp;*/<br/>";
			
			$this->_buffer_append($this->formatter->comment($comment_block));	
		}		
	}	
	
	/**
	 * Prepare output for class property types 
	 * @param $instance mixed
	 * @param $property ReflectionProperty 
	 */
	protected function _property($instance, ReflectionProperty $property)
	{
		// if in inspect mode display doc comments for properties
		
		if($comment = $property->getDocComment())
		{
			$comment = str_replace('*','',$comment);
			$comment = str_replace('/','',$comment);
			$comment = trim(nl2br($comment));
			
			$this->_buffer_append($this->formatter->comment($comment));	
		}
		
		
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
				$this->_buffer_append($this->formatter->list_item($title.$value.$type));	
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
	 * Prepare output for class method types 
	 * @param $method ReflectionMethod 
	 */
	protected function _method(ReflectionMethod $method)
	{
		if($comment = $method->getDocComment())
		{
			$comment = str_replace('*','',$comment);
			$comment = str_replace('/','',$comment);
			$comment = trim(nl2br($comment));
		
			$this->_buffer_append($this->formatter->comment($comment));	
		}
		else
		{		
			$parameters = $method->getParameters();				
	
			$comment_block = '/**<br/>';
			$comment_block .= '&nbsp;*<br/>';
			foreach ($parameters as $parameter)
			{			
				$param_string = '$' . $parameter->getName();
				if ($parameter->isPassedByReference()) $param_string = '&' . $param_string;
				if ($parameter->isOptional() && $parameter->isDefaultValueAvailable()) $param_string .= ' = '.$parameter->getDefaultValue();
				$comment_block .= "&nbsp;* @param $param_string<br/>";
			}
			$comment_block .= "&nbsp;*/<br/>";	
			
			$this->_buffer_append($this->formatter->comment($comment_block, null, false));
		}		
		
		
		// display sub header
		
		$title = ' ' . $method->getName() . '()';		
				
		$type = '(';
		$type .= $method->isAbstract() ? 'Abstract ' : '';
		$type .= $method->isFinal() ? 'Final ' : '';
		$type .= $method->isPublic() ? 'Public ' : '';
		$type .= $method->isPrivate() ? 'Private ' : '';
		$type .= $method->isProtected() ? 'Protected ' : '';
		$type .= $method->isStatic() ? '' : '';
		$type .= 'Method)';
		
		$title = $this->formatter->small_text($title);		
		$type = $this->formatter->small_text($type);	
		
		$this->_buffer_append($this->formatter->sub_header($title.$type));			
		
	}

}