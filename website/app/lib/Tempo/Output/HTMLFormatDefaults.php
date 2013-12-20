<?php

/**
 * TEMPO
 * @copyright Copyright (c) 2007, Parca/Nemo/Johnston
 * @author Andy
 */

namespace Tempo\Output;

/**
 * HTML Format Defaults
 *
 * This class stores default formatting options for HTML format output
 */

class HTMLFormatDefaults
{
	public static $default = array
	(
	
		'page_font_family'=>"'Arial', Arial, sans-serif",
		'wrapper_font_family'=>"'Arial', Arial, sans-serif",
	
		'page_box_shadow'=>'inset 0 0 7px #393838',		
		'wrapper_box_shadow'=>'none',
	
		'page_text_shadow'=>'0px 1px 0px #000',
		'header_text_shadow'=>'0px 1px 0px #000',
		'sub_header_text_shadow'=>'0px 1px 0px #000',
		'list_item_text_shadow'=>'0px 1px 0px #000',
		'big_text_shadow'=>'0px 1px 2px #000',
		'medium_text_shadow'=>'0px 1px 2px #000',
	
		'page_padding'=>'12px',
		'header_padding'=>'7px 10px 7px 10px',
		'sub_header_padding'=>'7px 10px 7px 10px',
		'list_item_padding'=>'0',
		'comment_padding'=>'3px',
		'standard_text_padding'=>'7px 10px 7px 10px',
		'subtle_text_padding'=>'7px 10px 7px 10px',
		'small_text_padding'=>'3px 10px 3px 10px',		
		
		'page_margin'=>'0',
		'page_title_margin'=>'0 0 7px',
		'wrapper_margin'=>'0',
		'list_margin'=>'0',
		'list_item_margin'=>'0',	
	
		'page_border'=>'1px solid #272823',
		'wrapper_border_left'=>'1px solid #363535',
		'header_border_top'=>'1px solid #0e0f0c',
		'header_border_bottom'=>'1px solid #393838',
		'sub_header_border_top'=>'none',
		'sub_header_border_bottom'=>'1px solid #393838',
		'list_border'=>'none',
		'list_item_border_top'=>'none',
		'list_item_border_bottom'=>'1px solid #363535',
		'list_item_border_right'=>'none',
		'standard_text_border_top'=>'none',
		'standard_text_border_bottom'=>'none',
		'standard_text_border_right'=>'none',
		'subtle_text_border_top'=>'none',
		'subtle_text_border_bottom'=>'none',
		'subtle_text_border_right'=>'1px solid #363535',
	
		'page_background'=>'#7d7878',
		'wrapper_background'=>'#393838',
		'header_background'=>'#272823',
		'sub_header_background'=>'#404040',
		'list_background'=>'#404040',
		'list_item_background'=>'#393838',	
		'standard_text_background'=>'none',
		'subtle_text_background'=>'#404040',	
		'comment_background'=>'none',	
	
		'page_color'=>'#e4e0e0',
		'header_color'=>'#7e7a7a',
		'header_small_color'=>'#514f4f',
		'sub_header_color'=>'#b1be95',
		'standard_text_color'=>'#d4c4a9',
		'subtle_text_color'=>'#b1be95',
		'small_text_color'=>'#7d7878',		
		'comment_text_color'=>'#ccc',
		'big_text_color'=>'#d4c4a9',
		'medium_text_color'=>'#c2af8e',
	
		'page_title_size'=>'1em',
		'header_title_size'=>'0.9em',		
		'header_small_size'=>'0.7em',
		'sub_header_title_size'=>'0.8em',
		'standard_text_size'=>'0.9em',
		'subtle_text_size'=>'0.9em',
		'small_text_size'=>'0.7em',
		'comment_text_size'=>'0.7em',
		'big_text_size'=>'3em',
		'medium_text_size'=>'1.5em',
		
		'header_small_min_width'=>'150px;',
		'header_title_min_width'=>'150px;',		
		'sub_header_title_min_width'=>'150px;',		
		'standard_text_min_width'=>'100px;',	
		'subtle_text_min_width'=>'130px;',		
		'small_text_min_width'=>'40px;',
		'comment_min_width'=>'100px',
		'big_min_width'=>'500px',
		'medium_min_width'=>'500px'
	);
	
	public static $error = array
	(
		/*'header_background'=>'#190000'*/	
	);
}