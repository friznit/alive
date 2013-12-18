<?php

class Server extends Eloquent {

	protected $guarded = array();
	public static $rules = array();

    public function __construct(array $attributes = array()) {
        parent::__construct($attributes);
    }

    public function clan()
    {
        return $this->belongsTo('Clan');
    }

}
