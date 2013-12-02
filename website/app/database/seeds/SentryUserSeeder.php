<?php

class SentryUserSeeder extends Seeder {

	/**
	 * Run the database seeds.
	 *
	 * @return void
	 */
	public function run()
	{
		DB::table('users')->delete();

		Sentry::getUserProvider()->create(array(
	        'email'    => 'arjaydev@gmail.com',
	        'password' => 'cheese',
	        'activated' => 1,
	    ));

	}

}
