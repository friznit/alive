<?php

class AOSeeder extends Seeder {

	/**
	 * Run the database seeds.
	 *
	 * @return void
	 */
	public function run()
	{
		DB::table('aos')->delete();
        $ao = array();
        $ao['name'] = 'Altis';
        $ao['size'] = 30720;
        $ao['configName'] = 'Altis';
        $ao['imageMapX'] = 450;
		$ao['imageMapY'] = 450;
		$ao['latitude'] = -35.152;
		$ao['longitude'] = 16.661;
        AO::create($ao);

	}

}
