<?php

class SentryGroupSeeder extends Seeder {

	/**
	 * Run the database seeds.
	 *
	 * @return void
     */
	public function run()
	{
		DB::table('groups')->delete();

		Sentry::getGroupProvider()->create(array(
	        'name'        => 'Users',
	        'permissions' => array(
	            'admin' => 0,
                'users' => 0,
                'clans' => 0,
                'clanmembers' => 0,
                'clan' => 0,
        )));

        Sentry::getGroupProvider()->create(array(
	        'name'        => 'Grunt',
	        'permissions' => array(
	            'admin' => 0,
                'users' => 0,
                'clans' => 0,
                'clanmembers' => 0,
                'clan' => 0,
        )));

        Sentry::getGroupProvider()->create(array(
	        'name'        => 'Officer',
	        'permissions' => array(
	            'admin' => 0,
                'users' => 0,
                'clans' => 0,
                'clanmembers' => 1,
                'clan' => 0,
        )));

        Sentry::getGroupProvider()->create(array(
	        'name'        => 'Leader',
	        'permissions' => array(
	            'admin' => 0,
                'users' => 0,
                'clans' => 0,
                'clanmembers' => 1,
                'clan' => 1,
	    )));

		Sentry::getGroupProvider()->create(array(
	        'name'        => 'Admins',
	        'permissions' => array(
	            'admin' => 1,
                'users' => 1,
                'clans' => 1,
                'clanmembers' => 1,
                'clan' => 1,
	    )));
	}

}
