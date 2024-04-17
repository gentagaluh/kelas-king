<?php

namespace App\Http\Controllers;

use App\Models\absen_kk;
use App\Models\course_join_kk;
use App\Models\course_kk;
use App\Models\user_kk;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class CourseJoinKkController extends Controller
{
    public function joinCourse(Request $req){
        try{
            $course = course_kk::where('id', $req->input('course_id'))->first();
            $user = user_kk::where('id', $req->input('user_id'))->first();
            if($course == null){
                return response()->json(['message'=>'Course tidak ditemukan']);
            } else {
                $cek = course_join_kk::where('course_id', $course->id)
                                    ->where('user_id', $user->id)
                                    ->count();
                if($cek > 0){
                    return response()->json(['message'=>'Kamu sudah bergabung']);
                } else {
                    $input = $req->all();
                    $data = course_join_kk::create($input);
                    return response()->json(['message'=>'Berhasil bergabung course', 'data'=>$data]);
                }
            }
        }catch(\Throwable $e) {
            return response()->json(['message' =>$e->getMessage()]);
        }
    }

    public function getAbsenToday($user_id, $hari, $tanggal, $bulan, $tahun){
        try{
            $absentoday = DB::table('course_join_kks')
                            ->join('jadwal_absen_kks', 'course_join_kks.course_id', 'jadwal_absen_kks.course_id')
                            ->join('course_kks', 'course_kks.id', 'course_join_kks.course_id')
                            ->select('course_join_kks.course_id', 'course_join_kks.user_id', 'course_kks.nama', 'jadwal_absen_kks.mulai', 'jadwal_absen_kks.selesai')
                            ->where('course_join_kks.user_id', $user_id)
                            ->where('jadwal_absen_kks.hari', 'LIKE', '%' . $hari . '%')
                            ->get();
            $absentodaycount = $absentoday->count();
            if($absentodaycount > 0){
                $sudahabsen = DB::table('absen_kks')
                            ->join('course_kks', 'course_kks.id', 'absen_kks.course_id')
                            ->select('absen_kks.keterangan', 'absen_kks.waktu', 'absen_kks.course_id', 'course_kks.nama', 'absen_kks.surat_izin', 'absen_kks.surat_sakit')
                            ->where('absen_kks.tanggal', $tanggal)
                            ->where('absen_kks.bulan', $bulan)
                            ->where('absen_kks.tahun', $tahun)
                            ->where('absen_kks.user_id', $user_id)
                            ->get();
                $belumabsen = [];
                foreach ($absentoday as $item){
                    $found = false;
                    foreach ($sudahabsen as $absen){
                        if($item->course_id === $absen->course_id){
                            $found = true;
                            break;
                        }
                    }
                    if(!$found){
                        $belumabsen[] = $item;
                    }
                }
                $responseData = [];
                if (count($sudahabsen) == 0) {
                    $responseData['message'] = 'Kamu belum absen semua';
                    $responseData['data'] = $belumabsen;
                }else if(count($belumabsen) == 0){
                    $responseData['message'] = 'Kamu sudah absen semua';
                    $responseData['data'] = $sudahabsen;
                }else{
                    $responseData['message'] = 'Data absen kamu';
                    $responseData['sudahabsen'] = $sudahabsen;
                    $responseData['belumabsen'] = $belumabsen;
                }
                return response()->json($responseData);
            }else{
                return response()->json(['message'=>'Tidak ada absen hari ini']);
            }
        }catch(\Throwable $e) {
            return response()->json(['message' =>$e->getMessage()]);
        }
    }

    public function getMember($course_id){
        try{
            $data = DB::table('course_join_kks')->join('user_kks','course_join_kks.user_id', 'user_kks.id')
                                ->select('user_kks.nama', 'user_kks.email', 'course_join_kks.id')
                                ->where('course_join_kks.course_id', $course_id)
                                ->get();
            $count = $data->count();
            if($count > 0){
                return response()->json(['message'=>'Berhasil mendapatkan data', 'data'=>$data]);
            }else{
                return response()->json(['message'=>'Belum ada orang yang bergabung']);
            }
        }catch(\Throwable $e) {
            return response()->json(['message' =>$e->getMessage()]);
        }             
    }

    public function deleteMember($id){
        try {
            $data = course_join_kk::find($id);
            $data->delete();
            return response()->json(['message'=>'Berhasil']);
        } catch(\Throwable $e) {
            return response()->json(['message' => $e->getMessage()]);
        }
    }
    
}
