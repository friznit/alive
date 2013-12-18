<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddRemoteIdToClanTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
        Schema::table('clans', function(Blueprint $table)
        {
            $table->string('remote_id', 60)->nullable();
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
            $table->dropColumn('remote_id');
		});
	}

}