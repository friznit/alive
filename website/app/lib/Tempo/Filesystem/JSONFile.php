<?php

/**
 * TEMPO
 * @copyright Copyright (c) 2007, Parca/Nemo/Johnston
 * @author Andy
 */

namespace Tempo\Filesystem;

/**
 * JSON File
 * Provides formatting of input and output for use with JSON files.
 * Contains additional convenience methods specific to JSON manipulation
 */

use LimitIterator;

class JSONFile extends File
{
	
	/**
	 * Creates a file if not existing
	 * Encodes content as JSON
	 * @param $contents
	 *  string the contents
	 */
	public function create($contents = null)
	{
		if($contents != null)
		{
			parent::create(json_encode($contents)."\n");
		}
		else
		{
			parent::create();
		}
		
	}
			
	/**
	 * Reads and returns the complete contents of a file
	 * Decodes each line as JSON
	 * @return $contents
	 *  the files contents
	 */
	public function read()
	{
		if($this->file === null) $this->open(self::MODE_READ);
		
		$this->file->rewind();
		
		$contents = array();
		while ($this->file->valid()) {
    		$contents[] = json_decode($this->file->current());
    		$this->file->next();
		}
		
		$this->file->rewind();
		
		return $contents;
	}
	
	/**
	 * Reads a line from the file
	 *  @return mixed the JSON decoded object
	 */
	public function read_line()
	{
		if($this->file === null) $this->open(self::MODE_READ);
					
   		$line = $this->file->current();
   		$this->file->next();
   		
		return json_decode($line);
	}
	
	/**
	 * Reads a chuck of the file
	 * Decodes each line as JSON 
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
			$chunk[] = json_decode($line);
		}
		return $chunk;
	}
	
	/**
	 * Appends content onto an existing file
	 * Encodes to JSON
	 * @param $contents
	 *  string the contents
	 */
	public function write($contents)
	{
		parent::write(json_encode($contents));
	}	
	
	/**
	 * Writes a line to the file
	 * Encodes to JSON
	 *  @param string the line
	 */
	public function write_line($line)
	{
		if($this->file === null) $this->open(self::MODE_WRITE);

		$this->file->fwrite(json_encode($line)."\n");
	}	
	
}
