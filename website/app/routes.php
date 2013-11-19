<?php

/*
Event::listen('illuminate.query', function($query) {
    var_dump($query);
});
*/

Route::controller('user', 'UserController');

Route::get('admin', array('before' => 'auth', function()
{
    return View::make('admin/home/index');
}));

Route::controller('admin/user', 'AdminUserController');

Route::resource('admin/group', 'AdminGroupController');

Route::get('war-room', array('before' => 'auth', function()
{
    return View::make('warroom/home/index');
}));

Route::get('style', function() {
    return View::make('public/style/index');
});

Route::get('/', function() {
    return View::make('public/home/index');
});
