<?php

/**
 * TEMPO
 * @copyright Copyright (c) 2007, Parca/Nemo/Johnston
 * @author Andy
 */

namespace Tempo\Filesystem;

/**
 * CSV File
 * Provides formatting of input and output for use with CSV files.
 * Contains additional convenience methods specific to CSV manipulation
 */

use SplFileObject;
use LimitIterator;

class CSVFile extends File
{
	
	/**
	 * Creates a file if not existing
	 * @param $contents
	 *  string the contents
	 */
	public function create($contents = null)
	{
		parent::create($contents);
	}
			
	/**
	 * Reads and returns the complete contents of a file
	 * @return $contents
	 *  the files contents
	 */
	public function read()
	{
		if($this->file === null) $this->open(self::MODE_READ);
		
		$this->file->rewind();
		
		$contents = array();
		while ($this->file->valid()) {
    		$contents[] = $this->file->current();
    		$this->file->next();
		}
		
		$this->file->rewind();
		
		return $contents;
	}
	
	/**
	 * Reads a chuck of the file
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
			$chunk[] = $line;
		}
		return $chunk;
	}
	
	/**
	 * Appends content onto an existing file
	 * @param $contents
	 *  string the contents
	 */
	public function write($contents)
	{
		parent::write($contents);
	}	
	
	/**
	 * Writes a line to the file
	 * Converts array input to csv format
	 *  @param array the line
	 */
	public function write_line($line)
	{
	
		if($this->file === null) $this->open(self::MODE_WRITE);
		
		$line = implode(',',$line);

		$this->file->fwrite($line."\n");
	}	
	
	/**
	 * Open the file 
	 * @param $mode
	 *  string the mode
	 */
	public function open($mode = self::MODE_READ)
	{
		parent::open($mode);		
		
		$this->file->setFlags(SplFileObject::READ_CSV);
	}
	
	/**
	 * The header row
	 * Returns the header row of the csv
	 * @return array
	 *  the array of headers
	 */
	public function get_header()
	{
		if($this->file === null) $this->open(self::MODE_READ);
		
		$old_key = $this->file->key();
		$this->file->seek(0);
		$header = $this->file->current();		
		$this->file->seek($old_key);
		return $header;
	}
	
}
