<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePengumpulanKksTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('pengumpulan_kks', function (Blueprint $table) {
            $table->id();
            $table->text('tugas_id');
            $table->text('user_id');
            $table->text('wkt_pengumpulan');
            $table->text('text');
            $table->text('foto');
            $table->text('nilai')->default('no');
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
        Schema::dropIfExists('pengumpulan_kks');
    }
}
