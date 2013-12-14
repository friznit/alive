<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddAgeGroupToProfileTable extends Migration {

    public function up()
    {
        Schema::table('profiles', function(Blueprint $table)
        {
            $table->string("age_group",5)->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('profiles', function(Blueprint $table)
        {
            $table->string("age_group")->nullable();
        });
    }

}