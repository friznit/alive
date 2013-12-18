<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AlterAcceptedInApplicationTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::table('applications', function(Blueprint $table)
		{
            $table->renameColumn('accepted', 'denied');
		});
	}

	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::table('applications', function(Blueprint $table)
		{
            $table->renameColumn('denied', 'accepted');
		});
	}

}