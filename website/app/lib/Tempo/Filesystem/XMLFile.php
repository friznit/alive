<?php

/**
 * TEMPO
 * @copyright Copyright (c) 2007, Parca/Nemo/Johnston
 * @author Andy
 */

namespace Tempo\Filesystem;

/**
 * XML File
 * Provides formatting of input and output for use with XML files.
 * Contains additional convenience methods specific to XML manipulation
 */

use SimpleXMLIterator;
use RecursiveIteratorIterator;

class XMLFile extends File
{
	
	/**
	 * The simple xml iterator
	 * @var SimpleXMLIterator
	 */
	protected $xml_iterator;
	
	/**
	 * The recursive simple xml iterator
	 * @var RecursiveIteratorIterator
	 */
	protected $xml_recursive_iterator;
	
	/**
	 * Creates a file if not existing
	 * @param $contents
	 *  string the contents
	 */
	public function create($contents = "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n")
	{
		parent::create($contents);
	}
	
	/**
	 * The xml iterator
	 * @return SimpleXMLIterator
	 *  the file iterator object
	 */
	public function get_xml_iterator()
	{
		if($this->xml_iterator === null)
		{
			$xmlstring = $this->get_contents();
			$this->xml_iterator = simplexml_load_string($xmlstring, 'SimpleXMLIterator');
		}
		
		return $this->xml_iterator;		
	}
	
	/**
	 * The xml recursive iterator
	 * @return RecursiveIteratorIterator
	 *  the file iterator object
	 */
	public function get_xml_recursive_iterator()
	{
		if($this->xml_recursive_iterator === null)
		{
			$xml_iterator = $this->get_xml_iterator();
			$this->xml_recursive_iterator = new RecursiveIteratorIterator($xml_iterator, 1);
		}
		
		return $this->xml_recursive_iterator;
	}
}
