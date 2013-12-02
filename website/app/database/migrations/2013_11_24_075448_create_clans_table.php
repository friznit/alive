<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateClansTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('clans', function(Blueprint $table) {
			$table->increments('id');
            $table->string('name', 32)->nullable();
            $table->string('tag', 16)->nullable();
            $table->string('primary_hostname', 32)->nullable();
            $table->string('primary_ip', 45)->nullable();
            $table->string('secondary_hostname', 32)->nullable();
            $table->string('secondary_ip', 45)->nullable();
            $table->string('country', 2)->nullable();
            $table->string('website', 64)->nullable();
            $table->string('twitch_stream', 128)->nullable();
            $table->text('description')->nullable();
            $table->string('size', 32)->nullable();
            $table->string('type', 32)->nullable();
            $table->string('designation', 128)->nullable();
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
		Schema::drop('clans');
	}

}
