<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateAOTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('aos', function(Blueprint $table)
		{
			$table->increments('id');
			$table->string('name');
			$table->integer('size');
			$table->string('configName');
			$table->integer('imageMapX');
			$table->integer('imageMapY');
			$table->float('latitude');
			$table->float('longitude');
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
		Schema::drop('aos');
	}

}
