<?php

class SentryUserGroupSeeder extends Seeder {

	/**
	 * Run the database seeds.
	 *
	 * @return void
	 */
	public function run()
	{
		DB::table('users_groups')->delete();

		$adminUser = Sentry::getUserProvider()->findByLogin('arjaydev@gmail.com');

		$userGroup = Sentry::getGroupProvider()->findByName('Users');
        $gruntGroup = Sentry::getGroupProvider()->findByName('Grunt');
        $officerGroup = Sentry::getGroupProvider()->findByName('Officer');
        $leaderGroup = Sentry::getGroupProvider()->findByName('Leader');
        $adminGroup = Sentry::getGroupProvider()->findByName('Admins');

	    // Assign the groups to the users
        $adminUser->addGroup($adminGroup);
	}

}
