<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddCountriesToClanTable extends Migration {

    public function up()
    {
        Schema::table('clans', function(Blueprint $table)
        {
            $table->string("country_name")->nullable();
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
            $table->string("country_name")->nullable();
        });
    }

}