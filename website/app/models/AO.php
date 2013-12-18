<?php

class AO extends Eloquent {

    use Codesleeve\Stapler\Stapler;
	
	protected $guarded = array();
	public static $rules = array();
	protected $table = 'aos';

    public function __construct(array $attributes = array()) {
		$this->hasAttachedFile('image', [
            'styles' => [
            'mediumAO' => '512x256',
            'thumbAO' => '256x128'
            ]
        ]);
		$this->hasAttachedFile('pic', [
            'styles' => [
            'largePic' => '2048x2048',
			'mediumPic' => '768x768',
            'smallPic' => '512x512',
			'thumbPic' => '256x256'
            ]
        ]);
        parent::__construct($attributes);
    }
}