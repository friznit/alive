<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class AddApplicationFieldsToClan extends Migration {

    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('clans', function(Blueprint $table) {
            $table->text('application_text')->nullable();
            $table->boolean('allow_applicants');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('clans', function(Blueprint $table) {
            $table->dropColumn('application_text');
            $table->dropColumn('allow_applicants');
        });
    }

}