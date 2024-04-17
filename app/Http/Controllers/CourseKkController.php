<?php

namespace App\Http\Controllers;

use App\Models\course_kk;
use App\Models\user_kk;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class CourseKkController extends Controller
{
    public function addCourse(Request $req){
        try{
            $course = course_kk::where('instructor_id', $req->input('instructor_id'))
                                ->where('nama', $req->input('nama'))
                                ->count();
            if($course > 0){
                return response()->json(['message'=>'Course sudah ada']);
            }else{
                $input = $req->all();
                $course = course_kk::create($input);
                return response()->json(['message'=>'Course berhasil dibuat', 'data'=>$course]);
            }
        }catch(\Throwable $e) {
            return response()->json(['message' =>$e->getMessage()]);
        }
    }

    public function getCoursePelajar($user_id){
        try{
            $course = DB::table('course_kks')->join('course_join_kks', 'course_kks.id', 'course_join_kks.course_id')
                                            ->join('user_kks', 'user_kks.id', 'course_kks.instructor_id')
                                            ->select('course_kks.nama', 'course_join_kks.course_id','course_kks.instructor_id','user_kks.nama AS namaguru', 'course_kks.absen')
                                            ->where('course_join_kks.user_id', $user_id)
                                            ->orderBy('course_join_kks.created_at', 'asc')
                                            ->get();
            $countt = $course->count(); 
            if($countt > 0){
                return response()->json(['message'=>'Course berhasil didapatkan', 'data'=>$course]);
            }else{
                return response()->json(['message'=>'Kamu belum bergabung dengan course']);
            }
        }catch(\Throwable $e) {
            return response()->json(['message' =>$e->getMessage()]);
        }
    }

    public function getCoursePengajar($user_id){
        try{
            $course = DB::table('course_kks')
                                ->join('user_kks', 'user_kks.id', 'course_kks.instructor_id')
                                ->select('course_kks.nama', 'course_kks.id','course_kks.instructor_id','user_kks.nama AS namaguru', 'course_kks.absen')
                                ->where('course_kks.instructor_id', $user_id)
                                ->orderBy('course_kks.created_at', 'asc')
                                ->get();
            $count = $course->count(); 
            if($count > 0){
                return response()->json(['message'=>'Course berhasil didapatkan', 'data'=>$course]);
            }else{
                return response()->json(['message'=>'Kamu tidak memiliki course']);
            }
        }catch(\Throwable $e) {
            return response()->json(['message' =>$e->getMessage()]);
        }
    }

    public function searchCoursePelajar($user_id, $nama_course){
        try{
            $course = DB::table('course_kks')->join('course_join_kks', 'course_kks.id', 'course_join_kks.course_id')
                                            ->join('user_kks', 'user_kks.id', 'course_kks.instructor_id')
                                            ->select('course_kks.nama', 'course_join_kks.course_id','course_kks.instructor_id','user_kks.nama AS namaguru', 'course_kks.absen')
                                            ->where('course_join_kks.user_id', $user_id)
                                            ->where('course_kks.nama', 'like', '%' . $nama_course . '%')
                                            ->orderBy('course_join_kks.created_at', 'asc')
                                            ->get();
            $count = $course->count(); 
            if($count > 0){
                return response()->json(['message'=>'Course berhasil didapatkan', 'data'=>$course]);
            }else{
                return response()->json(['message'=>'Course tidak ditemukan']);
            }
        }catch(\Throwable $e) {
            return response()->json(['message' =>$e->getMessage()]);
        }
    }

    public function searchCoursePengajar($user_id, $nama_course){
        try{
            $course = DB::table('course_kks')
                                ->join('user_kks', 'user_kks.id', 'course_kks.instructor_id')
                                ->select('course_kks.nama', 'course_kks.id','course_kks.instructor_id','user_kks.nama AS namaguru', 'course_kks.absen')
                                ->where('course_kks.instructor_id', $user_id)
                                ->where('course_kks.nama', 'like', '%' . $nama_course . '%')
                                ->orderBy('course_kks.created_at', 'asc')
                                ->get();
            $count = $course->count(); 
            if($count > 0){
                return response()->json(['message'=>'Course berhasil didapatkan', 'data'=>$course]);
            }else{
                return response()->json(['message'=>'Kamu tidak memiliki course']);
            }
        }catch(\Throwable $e) {
            return response()->json(['message' =>$e->getMessage()]);
        }
    }
    
}
