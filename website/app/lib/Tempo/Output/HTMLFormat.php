<?php

/**
 * TEMPO
 * @copyright Copyright (c) 2007, Parca/Nemo/Johnston
 * @author Andy
 */

namespace Tempo\Output;

/**
 * HTML Format
 *
 * Provides basic formating for system html output
 * All styles are inlined to prevent style collisions 
 * and to avoid stylesheet loading for low level system interfaces 
 */

use Tempo\Base\Options;
use Tempo\Output\HTMLFormatDefaults;

class HTMLFormat extends Options
{
	protected $depth = 0;
	protected $tabs = '';
	
	function __construct(array $options = array())
	{
		$this->defaults_set(HTMLFormatDefaults::$default);
		$this->options_set($options);
	}
	
	public function page_start($width=NULL)
	{		
		$html = '<div style=" display:block;';
		if($width)
		{
			$html .= ' width: '.$width.'px;';
			$html .= ' margin: auto;';
		}
		else
		{
			$html .= ' margin: '.$this->options['page_margin'].';';	
		}				
		$html .= ' padding: '.$this->options['page_padding'].';';
		$html .= ' font-family: '.$this->options['page_font_family'].';';
		$html .= ' color: '.$this->options['page_color'].';';
		$html .= ' border: '.$this->options['page_border'].';';
		$html .= ' background: '.$this->options['page_background'].';';
		$html .= ' box-shadow: '.$this->options['page_box_shadow'].';';
		$html .= ' text-shadow: '.$this->options['page_text_shadow'].';';
		$html .= ' margin-bottom:13px;';
		$html .= ' margin-top:13px;';
		$html .= "\">";
		return $this->_line_start() . $html;
	} 
	
	public function page_end()
	{
		return $this->_line_start() . "</div>";
	}
	
	public function page_title($input, $width = NULL)
	{
		$html = '<span style="display:inline-block;';
		$html .= ' font-size: '.$this->options['page_title_size'].';';
		$html .= ' margin: '.$this->options['page_title_margin'].';';
		$html .= "\">" . $input . "</span>";
		return $html;
	}

	public function wrapper_start($width=NULL)
	{	
		$margin = 0;	
		if($this->depth>1)
		{
			//$margin = ($this->depth-1) * 50;	
			$margin = 50;
		}		

		$html = '<div style=" display:block;';
		if($width)
		{
			$html .= ' width: '.$width.'px;';
			$html .= ' margin: auto;';
		}		
		$html .= ' font-family: '.$this->options['wrapper_font_family'].';';
		$html .= ' border-left: '.$this->options['wrapper_border_left'].';';
		$html .= ' background: '.$this->options['wrapper_background'].';';
		$html .= ' box-shadow: '.$this->options['wrapper_box_shadow'].';';
		$html .= ' margin-left:'.$margin.'px;';
		$html .= "\">";
		return $this->_line_start() . $html;
	} 
	
	public function wrapper_end()
	{
		return $this->_line_start() . "</div>";
	}
	
	public function header($input)
	{		
		$html = '<span style=" display:block;';
		$html .= ' padding: '.$this->options['header_padding'].';';
		$html .= ' background: '.$this->options['header_background'].';';
		$html .= ' color: '.$this->options['header_color'].';';
		$html .= ' border-top: '.$this->options['header_border_top'].';';
		$html .= ' border-bottom: '.$this->options['header_border_bottom'].';';
		$html .= ' text-shadow: '.$this->options['header_text_shadow'].';';
		$html .= "\">" . $input . "</span>";
		return $this->_line_start() . $html;
	}
	
	public function header_title($input, $width = NULL)
	{		
		$min_width = $this->options['header_title_min_width'];
		if(!is_null($width)) $min_width = $width;
		
		$html = '<span style="display:inline-block;';
		$html .= ' font-size: '.$this->options['header_title_size'].';';
		$html .= ' min-width: '.$min_width.';';
		$html .= "\">" . $input . "</span>";
		return $html;
	}
	
	public function header_small($input, $width = NULL)
	{		
		$min_width = $this->options['header_small_min_width'];
		if(!is_null($width)) $min_width = $width;
		
		$html = '<span style="display:inline-block;';
		$html .= ' font-size: '.$this->options['header_small_size'].';';
		$html .= ' min-width: '.$min_width.';';
		$html .= ' color: '.$this->options['header_small_color'].';';
		$html .= "\">" . $input . "</span>";
		return $html;
	}
	
	public function sub_header($input)
	{		
		$html = '<span style=" display:block;';
		$html .= ' padding: '.$this->options['sub_header_padding'].';';
		$html .= ' background: '.$this->options['sub_header_background'].';';
		$html .= ' color: '.$this->options['sub_header_color'].';';
		$html .= ' border-top: '.$this->options['sub_header_border_top'].';';
		$html .= ' border-bottom: '.$this->options['sub_header_border_bottom'].';';
		$html .= ' text-shadow: '.$this->options['sub_header_text_shadow'].';';
		$html .= "\">" . $input . "</span>";
		return $this->_line_start() . $html;
	}
	
	public function sub_header_title($input, $width = NULL)
	{		
		$min_width = $this->options['sub_header_title_min_width'];
		if(!is_null($width)) $min_width = $width;
		
		$html = '<span style="display:inline-block;';
		$html .= ' font-size: '.$this->options['sub_header_title_size'].';';
		$html .= ' min-width: '.$min_width.';';
		$html .= "\">" . $input . "</span>";
		return $html;
	}

	public function list_start()
	{		
		$html = '<ul style="display:block;list-style:none;padding:0;';
		$html .= ' margin: '.$this->options['list_margin'].';';
		$html .= ' border: '.$this->options['list_border'].';';
		$html .= ' background: '.$this->options['list_background'].';';
		$html .= "\">";
		return $this->_line_start() . $html;
	}
	
	public function list_end()
	{
		return $this->_line_start() . "</ul>";
	}
	
	public function list_item($input)
	{		
		$html = '<li style=" display:block;list-style:none;';
		$html .= ' padding: '.$this->options['list_item_padding'].';';
		$html .= ' margin: '.$this->options['list_item_margin'].';';
		$html .= ' border-top: '.$this->options['list_item_border_top'].';';
		$html .= ' border-bottom: '.$this->options['list_item_border_bottom'].';';
		$html .= ' border-right: '.$this->options['list_item_border_right'].';';
		$html .= ' background: '.$this->options['list_item_background'].';';
		$html .= ' text-shadow: '.$this->options['list_item_text_shadow'].';';
		$html .= "\">" . $input . "</li>";
		return $this->_line_start() . $html;
	}
	
	public function standard_text($input, $width = NULL)
	{		
		$min_width = $this->options['standard_text_min_width'];
		if(!is_null($width)) $min_width = $width;
		
		$html = '<span style="display:inline-block;';
		$html .= ' padding: '.$this->options['standard_text_padding'].';';
		$html .= ' font-size: '.$this->options['standard_text_size'].';';
		$html .= ' min-width: '.$min_width.';';
		$html .= ' border-top: '.$this->options['standard_text_border_top'].';';
		$html .= ' border-bottom: '.$this->options['standard_text_border_bottom'].';';
		$html .= ' border-right: '.$this->options['standard_text_border_right'].';';
		$html .= ' background: '.$this->options['standard_text_background'].';';
		$html .= ' color: '.$this->options['standard_text_color'].';';
		$html .= "\">" . $input . "</span>";
		return $html;
	}
	
	public function subtle_text($input, $width = NULL)
	{		
		$min_width = $this->options['subtle_text_min_width'];
		if(!is_null($width)) $min_width = $width;
		
		$html = '<span style="display:inline-block;';
		$html .= ' padding: '.$this->options['subtle_text_padding'].';';
		$html .= ' font-size: '.$this->options['subtle_text_size'].';';
		$html .= ' min-width: '.$min_width.';';
		$html .= ' border-top: '.$this->options['subtle_text_border_top'].';';
		$html .= ' border-bottom: '.$this->options['subtle_text_border_bottom'].';';
		$html .= ' border-right: '.$this->options['subtle_text_border_right'].';';
		$html .= ' background: '.$this->options['subtle_text_background'].';';
		$html .= ' color: '.$this->options['subtle_text_color'].';';
		$html .= "\">" . $input . "</span>";
		return $html;
	}
	
	public function small_text($input, $width = NULL)
	{		
		$min_width = $this->options['small_text_min_width'];
		if(!is_null($width)) $min_width = $width;
		
		$html = '<span style="display:inline-block;';
		$html .= ' padding: '.$this->options['small_text_padding'].';';
		$html .= ' font-size: '.$this->options['small_text_size'].';';
		$html .= ' min-width: '.$min_width.';';
		$html .= ' color: '.$this->options['small_text_color'].';';
		$html .= "\">" . $input . "</span>";
		return $html;
	}
	
	public function comment($input, $width = NULL)
	{				
		$min_width = $this->options['comment_min_width'];
		if(!is_null($width)) $min_width = $width;
		
		$html = '<span style="display:inline-block;';
		$html .= ' padding: '.$this->options['comment_padding'].';';
		$html .= ' font-size: '.$this->options['comment_text_size'].';';
		$html .= ' min-width: '.$min_width.';';
		$html .= ' color: '.$this->options['comment_text_color'].';';
		$html .= ' background: '.$this->options['comment_background'].';';
		$html .= "\">" . $input . "</span>";
		return $html;
	}
	
	public function big($input, $width = NULL)
	{				
		$min_width = $this->options['big_min_width'];
		if(!is_null($width)) $min_width = $width;
		
		$html = '<span style="display:inline-block;';
		$html .= ' padding: 2px;';
		$html .= ' font-size: '.$this->options['big_text_size'].';';
		$html .= ' color: '.$this->options['big_text_color'].';';
		$html .= ' min-width: '.$min_width.';';
		$html .= ' text-shadow: '.$this->options['big_text_shadow'].';';
		$html .= "\">" . $input . "</span>";
		return $html;
	}
	
	public function medium($input, $width = NULL)
	{				
		$min_width = $this->options['medium_min_width'];
		if(!is_null($width)) $min_width = $width;
		
		$html = '<span style="display:inline-block;';
		$html .= ' padding: 2px;';
		$html .= ' font-size: '.$this->options['medium_text_size'].';';
		$html .= ' color: '.$this->options['medium_text_color'].';';
		$html .= ' min-width: '.$min_width.';';
		$html .= ' text-shadow: '.$this->options['medium_text_shadow'].';';
		$html .= "\">" . $input . "</span>";
		return $html;
	}
	
	public function heading($input)
	{
		return $this->newline() . $input . $this->newline(); 
	}
	
	public function newline()
	{
		return "<br/><br/>\n";
	}
	
	public function depth_set($depth)
	{
		$this->depth = $depth;
		$this->tabs = '';
		for($i = 1; $i < $this->depth; ++$i) $this->tabs .= "\t";
	}
	
	protected function _line_start()
	{		
		return PHP_EOL . "$this->tabs";
	}
}