<?php

class Application extends Eloquent {

	protected $guarded = array();
	public static $rules = array();

    public function __construct(array $attributes = array()) {
        parent::__construct($attributes);
    }

    public function user()
    {
       return $this->belongsTo('User');
    }

    public function clan()
    {
        return $this->belongsTo('Clan');
    }

}
