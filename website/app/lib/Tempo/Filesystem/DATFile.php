<?php

/**
 * TEMPO
 * @copyright Copyright (c) 2007, Parca/Nemo/Johnston
 * @author Andy
 */

namespace Tempo\Filesystem;

/**
 * DAT File
 * Provides formatting of input and output for use with DAT files.
 * Contains additional convenience methods specific to DAT manipulation
 */

use LimitIterator;

class DATFile extends File
{
	
	/**
	 * Creates a file if not existing
	 * Encodes content as serialized
	 * @param $contents
	 *  string the contents
	 */
	public function create($contents = null)
	{
		if($contents != null)
		{
			parent::create(serialize($contents)."\n");
		}
		else
		{
			parent::create();
		}
		
	}
			
	/**
	 * Reads and returns the complete contents of a file
	 * Decodes each line as serialized
	 * @return $contents
	 *  the files contents
	 */
	public function read()
	{
		if($this->file === null) $this->open(self::MODE_READ);
		
		$this->file->rewind();
		
		$contents = array();
		while ($this->file->valid()) {
    		$contents[] = unserialize($this->file->current());
    		$this->file->next();
		}
		
		$this->file->rewind();
		
		return $contents;
	}
	
	/**
	 * Reads a line from the file
	 *  @return mixed the unserialized object
	 */
	public function read_line()
	{
		if($this->file === null) $this->open(self::MODE_READ);
					
   		$line = $this->file->current();
   		$this->file->next();
   		
		return unserialize($line);
	}
	
	/**
	 * Reads a chuck of the file
	 * Decodes each line as serialize 
	 *  @param $chunk_size
	 *   int the line count of the chunk
	 *  @return array
	 *   the chunk
	 */
	public function read_chunk($chunk_size = 500)
	{
		if($this->file === null) $this->open(self::MODE_READ);
		
		$iterator = new LimitIterator($this->file, $this->file->key(), $chunk_size);
		$chunk = array();
		foreach ($iterator as $line)
		{
			$chunk[] = unserialize($line);
		}
		return $chunk;
	}
	
	/**
	 * Appends content onto an existing file
	 * Encodes to serialize
	 * @param $contents
	 *  string the contents
	 */
	public function write($contents)
	{
		parent::write(serialize($contents));
	}	
	
	/**
	 * Writes a line to the file
	 * Encodes to serialize
	 *  @param string the line
	 */
	public function write_line($line)
	{
		if($this->file === null) $this->open(self::MODE_WRITE);

		$this->file->fwrite(serialize($line)."\n");
	}	
	
}
