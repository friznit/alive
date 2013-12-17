<?php

class Clan extends Eloquent {

    use Codesleeve\Stapler\Stapler;

	protected $guarded = array();
	public static $rules = array();

    public function __construct(array $attributes = array()) {
        $this->hasAttachedFile('avatar', [
            'styles' => [
            'medium' => '300x300',
            'thumb' => '100x100',
            'tiny' => '40x40'
            ]
        ]);

        parent::__construct($attributes);
    }

    public function members()
    {
       return $this->hasMany('Profile');
    }

    public function applications() {
        return $this->hasMany('Application');
    }

    public function servers() {
        return $this->hasMany('Server');
    }

}
