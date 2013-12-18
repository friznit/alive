<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddPicFieldsToAosTable extends Migration {

	/**
	 * Make changes to the table.
	 *
	 * @return void
	 */
	public function up()
	{	
		Schema::table('aos', function(Blueprint $table) {		
			
			$table->string("pic_file_name")->nullable();
			$table->integer("pic_file_size")->nullable();
			$table->string("pic_content_type")->nullable();
			$table->timestamp("pic_updated_at")->nullable();

		});

	}

	/**
	 * Revert the changes to the table.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::table('aos', function(Blueprint $table) {

			$table->dropColumn("pic_file_name");
			$table->dropColumn("pic_file_size");
			$table->dropColumn("pic_content_type");
			$table->dropColumn("pic_updated_at");

		});
	}

}