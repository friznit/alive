<?php

use Cartalyst\Sentry\Users\Eloquent\User as SentryUserModel;

class User extends SentryUserModel {

    public function profile() {
        return $this->hasOne('Profile');
    }

    public function group() {
        return $this->hasOne('Group');
    }

    public function applications() {
        return $this->hasMany('Application');
    }

}
