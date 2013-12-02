<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateProfileTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('profiles', function(Blueprint $table) {
            $table->increments('id');
   			$table->integer('user_id')->unsigned();
            $table->string('username', 32)->nullable();
            $table->string('a2_id', 100)->nullable();
            $table->string('a3_id', 100)->nullable();
            $table->string('preferred_class', 32)->nullable();
            $table->string('primary_profile', 32)->nullable();
            $table->string('secondary_profile', 32)->nullable();
            $table->string('alias', 32)->nullable();
            $table->string('arma_face', 32)->nullable();
            $table->string('arma_voice', 32)->nullable();
            $table->string('arma_pitch', 32)->nullable();
            $table->string('twitch_stream', 128)->nullable();
			$table->timestamps();
		});
	}


	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::drop('profiles');
	}

}
