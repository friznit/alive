<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddAccessFieldsToClanTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::table('clans', function(Blueprint $table)
		{
            $table->string('key', 32)->nullable();
            $table->string('password', 32)->nullable();
		});
	}

	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::table('clans', function(Blueprint $table)
		{
            $table->dropColumn('key');
            $table->dropColumn('password');
		});
	}

}