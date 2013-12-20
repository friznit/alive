<?php

/**
 * TEMPO
 * @copyright Copyright (c) 2007, Parca/Nemo/Johnston
 * @author Andy
 */

namespace Tempo\Filesystem;

/**
 * File
 * A wrapper for the SplFileInfo and SplFileObject.
 * Provides some safety measures for working with files.
 * Acts as a bridge to delete and get contents methods.
 */

use SplFileInfo;
use SplFileObject;
use RuntimeException;
use LimitIterator;

class File
{
	/**
	 * File open mode - the file (if not existing) will be created
	 * @var const
	 */
	const MODE_CREATE = 1;
	
	/**
	 * File open mode - the file will be read
	 * @var const
	 */
	const MODE_READ = 2;
	
	/**
	 * File open mode - the file (if existing) will be appended to
	 * @var const
	 */
	const MODE_WRITE = 3;
	
	/**
	 * The spl file info object
	 * @var SplFileInfo
	 */
	protected $info;
	
	/**
	 * The spl file iterator object
	 * @var SplFileObject
	 */
	protected $file;
	
	/**
	 * The file open flag
	 * @var boolean
	 */
	protected $file_open = false;
	
	
	function __construct($path)
	{		
		$this->info = new SplFileInfo($path);
	}
	
	/**
	 * Creates a file if not existing
	 * @param $contents
	 *  string the contents
	 */
	public function create($contents = null)
	{
		if($this->info->isFile()) throw new RuntimeException('File already exists');
		if(!$this->file_open) $this->open(self::MODE_CREATE);
		
		$this->file->fwrite($contents);
	}
	
	/**
	 * Deletes a file if existing
	 */
	public function delete()
	{
		if(!$this->info->isFile()) throw new RuntimeException('File does not exist');
		$this->file = null;
		unlink($this->info->getPathname());
		$this->info = null;
	}
	
	/**
	 * Reads and returns the complete contents of a file
	 * @return $contents
	 *  the files contents
	 */
	public function read()
	{
		if(!$this->file_open) $this->open(self::MODE_READ);
		
		$this->file->rewind();
		
		$contents = '';
		while ($this->file->valid()) {
    		$contents .= $this->file->current();
    		$this->file->next();
		}
		
		$this->file->rewind();
		
		return $contents;
	}
	
	/**
	 * Reads a line from the file
	 *  @return string the line
	 */
	public function read_line()
	{
		if(!$this->file_open) $this->open(self::MODE_READ);
					
   		$line = $this->file->current();
   		$this->file->next();
   		
		return $line;
	}
	
	/**
	 * Reads a chuck of the file
	 *  @param $chunk_size
	 *   int the line count of the chunk
	 *   @return string
	 *    the chunk
	 */
	public function read_chunk($chunk_size = 500)
	{
		if(!$this->file_open) $this->open(self::MODE_READ);
		
		$iterator = new LimitIterator($this->file, $this->file->key(), $chunk_size);
		$chunk = '';
		foreach ($iterator as $line)
		{
			$chunk .= $line;
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
		if(!$this->file_open) $this->open(self::MODE_WRITE);
		
		$this->file->fwrite($contents);
	}
	
	/**
	 * Writes a line to the file
	 * Applies line ending on the fly
	 *  @param string the line
	 */
	public function write_line($line)
	{
		if(!$this->file_open) $this->open(self::MODE_WRITE);

		$this->file->fwrite($line."\n");
	}
	
	/**
	 * Seek to a line point in the file
	 * @param $line_pos
	 *  int the position to seek to
	 */	
	public function seek($line_pos)
	{
		if(!$this->file_open) $this->open(self::MODE_READ);
		
		$this->file->seek($line_pos);
	}
	
	/**
	 * Open the file
	 * @param $mode
	 *  string the mode
	 */
	public function open($mode = self::MODE_READ)
	{		
	
		switch($mode){
			case self::MODE_CREATE:
				if($this->info->isFile()) throw new RuntimeException('File already exists');
				$open_mode = 'ab';
				break;
			case self::MODE_WRITE:
				if(!$this->info->isWritable()) throw new RuntimeException('File is not writable');
				if(!$this->info->isFile()) throw new RuntimeException('File is not a file');
				$open_mode = 'ab';	
				break;
			case self::MODE_READ:
			default:
				if(!$this->info->isFile()) throw new RuntimeException('File is not a file');
				if(!$this->info->isReadable()) throw new RuntimeException('File is not readable');
				$open_mode = 'r';
				break;
		}
		
		$this->file = $this->info->openFile($open_mode);
		$this->file->setFlags(SplFileObject::SKIP_EMPTY);
		$this->file_open = true;		
	}
	
	/**
	 * Resets the line point to the first line
	 */	
	public function rewind()
	{
		$this->file->rewind();
	}
	
	/**
	 * The files open state
	 * @return boolean
	 *  the open state flag
	 */
	public function is_open()
	{
		return $this->file_open;
	}
	
	/**
	 * The spl file object
	 * @return SplFileObject
	 *  the file iterator object
	 */
	public function get_file_iterator()
	{
		return $this->file;
	}
	
	/**
	 * Gets file contents 
	 * @return $contents
	 *  the files contents
	 */
	public function get_contents()
	{
		if(!$this->info->isReadable()) throw new RuntimeException('File is not readable');
		if(!$this->info->isFile()) throw new RuntimeException('File is not a file');		
		if($this->is_open()) throw new RuntimeException('File already opened. Use read() instead');
			
		return file_get_contents($this->info->getPathname());
	}
	
	/**
	 * The files path
	 * @return string
	 *  the file path
	 */
	public function get_path()
	{
		return $this->info->getPathname();
	}
	
	/**
	 * The files extension
	 * Returns anything after the last occurance of .
	 * @return string
	 *  the file extension
	 */
	public function get_extension()
	{
		$parts = explode('.',$this->info->getBaseName());
		$ext = array_pop($parts);
		return $ext;
	}
	
	/**
	 * The files name
	 * Returns anything before the first occurance of .
	 * @return string
	 *  the file name
	 */
	public function get_filename()
	{
		$parts = explode('.',$this->info->getBaseName());
		return $parts[0];
	}
	
	/**
	 * The files size
	 * Returns human readable size
	 * @return string
	 *  the file name
	 */
	public function get_size()
	{
		$bytes = $this->file->getSize();
		if ($bytes < 1024) return $bytes.' B';
		elseif ($bytes < 1048576) return round($bytes / 1024, 2).' KB';
		elseif ($bytes < 1073741824) return round($bytes / 1048576, 2).' MB';
		elseif ($bytes < 1099511627776) return round($bytes / 1073741824, 2).' GB';
		else return round($bytes / 1099511627776, 2).' TB';
	}
	
}