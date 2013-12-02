<?php

class ProfileSeeder extends Seeder {

	/**
	 * Run the database seeds.
	 *
	 * @return void
	 */
	public function run()
	{
		DB::table('profiles')->delete();

		$adminUser = Sentry::getUserProvider()->findByLogin('arjaydev@gmail.com');
        $profile = array();
        $profile['user_id'] = $adminUser->getId();
        $profile['username'] = 'ARJay';
        $profile['a3_id'] = '76561198021311392';
        $profile['primary_profile'] = 'ARJay';
        $profile['twitch_stream'] = 'http://www.twitch.tv/arjaydev';
        Profile::create($profile);

	}

}
