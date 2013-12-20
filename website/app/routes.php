<?php

if(Config::get('app.debug')){
    Log::info("Route ---------------------------------------------");
    query_debug();
}

Route::controller('user', 'UserController');
Route::controller('admin/user', 'AdminUserController');
Route::controller('admin/clan', 'AdminClanController');
Route::controller('admin/application', 'AdminApplicationController');
Route::controller('admin/server', 'AdminServerController');
Route::controller('admin/ao', 'AdminAOController');
Route::controller('api', 'APIController');
Route::controller('war-room/stats', 'StatsController');
Route::resource('admin/group', 'AdminGroupController');

View::composer('warroom/home/index', function($view)
{
    $view->with(get_default_data());
});

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

