<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class course_kk extends Model
{
    public $incrementing = false;
    protected $keyType = 'string';
    protected $primaryKey = 'id';

    protected $fillable = [
        'id', 'nama', 'instructor_id', 'absen', 'nilai'
    ];

    protected static function boot()
    {
        parent::boot();

        // static::creating(function ($course) {
        //     $course->id = \Illuminate\Support\Str::uuid()->toString();
        // });
        static::creating(function ($course) {
            $uuid = \Illuminate\Support\Str::uuid()->toString();
            $course->id = strtoupper(substr($uuid, 0, 8));
        });      

        static::saving(function ($model) {
            if (empty($model->absen)) {
                $model->absen = 'no';
            }

            if (empty($model->nilai)) {
                $model->nilai = 'no';
            }
        });
    }
}
