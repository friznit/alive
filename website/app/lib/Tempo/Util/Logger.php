<?php

/**
 * TEMPO
 * @copyright Copyright (c) 2007, Parca/Nemo/Johnston
 * @author Andy
 */

namespace Tempo\Util;

use Tempo\Base\StackOptions;
use Tempo\Base\Int\Formatable;
use Tempo\Base\Int\Writable;
use Tempo\Base\Int\Emailable;

class Logger extends StackOptions implements Formatable, Writable, Emailable
{	
	
	/**
	 * Stores the class that formats output
	 * @var mixed
	 */
	protected $formatter;
	
	/**
	 * Stores the class that writes output
	 * @var mixed
	 */
	protected $writer;
	
	/**
	 * Stores the class that emails output
	 * @var mixed
	 */
	protected $emailer;
	
	/**
	 * Stores the default options array
	 * @var array
	 */
	protected $defaults = array
	(
		LOG_EMERG => 'Emergency',
		LOG_ALERT => 'Alert',
		LOG_CRIT => 'Critical',
		LOG_ERR => 'Error',
		LOG_WARNING => 'Warning',
		LOG_NOTICE => 'Notice',
		LOG_INFO => 'Info',
		LOG_DEBUG => 'Debug'
	);
	
	function __construct($formatter, $writer = null, $emailer = null, $options = array())
	{
		$this->formatter_set($formatter);
		$this->writer_set($writer);		
		$this->emailer_set($emailer);
		$this->options_set($options);
	}
	
	/** 
	 * Log a message
	 * @param int $priority
	 * @param string $message
	 */
	public function log($priority, $message)
	{
		$log_item = func_get_args();		
		$this->_stack_push($log_item);
	}
	
	/**
	 * Flush the log
	 */
	public function flush()
	{
		$stack_iterator = $this->_stack_get_iterator();
		
		foreach ($stack_iterator as $log_item)
		{
			$this->_process_log_item($log_item);
		}
		
		$this->_stack_clear();
	}
	
	/**
	 * Sets the formatter class
	 * @param mixed the formatter
	 */
	public function formatter_set($formatter)
	{
		 $this->formatter = $formatter;
	}
	
	/**
	 * Sets the writer class
	 * @param mixed the writer
	 */
	public function writer_set($writer)
	{
		 $this->writer = $writer;
	}
	
	/**
	 * Sets the emailer class
	 * @param mixed the emailer
	 */
	public function emailer_set($emailer)
	{
		 $this->emailer = $emailer;
	}
	
	protected function _process_log_item($log_item)
	{
		$priority = $log_item[0];
		$message = $log_item[1];
		$data = '';
		
		// more args than priority and message
		if(count($log_item) > 2)
		{
			$data = implode(',',array_slice($log_item, 2));
		}
		
		$log_text = $this->formatter->standard_text($this->options[$priority] . ' - ' . $message . ' ' . $data);
		
		// high priority to email
		if($priority < 5)
		{
			$this->_email_log_item($log_text);
		}
		
		$this->_write_log_item($log_text);		
	}
	
	protected function _write_log_item($log_text)
	{
		// no writer just echo log
		if($this->writer === null)
		{
			echo $this->formatter->wrapper_start();
			echo $this->formatter->header($log_text);
			echo $this->formatter->wrapper_end();
		}
		// write the log
		else
		{
			$this->writer->write_line($log_text);
		}
	}
	
	protected function _email_log_item($log_text)
	{
		if($this->emailer != null)
		{
			$this->emailer->send($log_text);	
		}		
	}

}