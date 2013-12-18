<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class RemoveServerDetailsFromClanTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::table('clans', function(Blueprint $table)
		{
            $table->dropColumn('primary_hostname');
            $table->dropColumn('primary_ip');
            $table->dropColumn('secondary_hostname');
            $table->dropColumn('secondary_ip');
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
            $table->string('primary_hostname', 32)->nullable();
            $table->string('primary_ip', 45)->nullable();
            $table->string('secondary_hostname', 32)->nullable();
            $table->string('secondary_ip', 45)->nullable();
		});
	}

}