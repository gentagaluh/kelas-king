<?php

namespace App\Http\Controllers;

use App\Models\absen_kk;
use App\Models\course_kk;
use App\Models\jadwal_absen_kk;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class AbsenKkController extends Controller
{
    public function doAbsen(Request $req){
        try{
            $absen = absen_kk::where('course_id', $req->input('course_id'))
                            ->where('user_id', $req->input('user_id'))
                            ->where('tanggal', $req->input('tanggal'))
                            ->where('bulan', $req->input('bulan'))
                            ->where('tahun', $req->input('tahun'))
                            ->count();
            if($absen > 0){
                return response()->json(['message'=>'Kamu sudah melakukan absen']);
            }else{
                $input = $req->all();
                if($req->input('keterangan') == 'Izin'){
                    $foto = $req->file('surat_izin');
                $nama_foto = time().'.'.$foto->getClientOriginalExtension();
                $foto->move('images/', $nama_foto);
                $input['surat_izin'] = $nama_foto;
                }else if ($req->input('keterangan') == 'Sakit'){
                    $foto = $req->file('surat_sakit');
                $nama_foto = time().'.'.$foto->getClientOriginalExtension();
                $foto->move('images/', $nama_foto);
                $input['surat_sakit'] = $nama_foto;
                }
                $data = absen_kk::create($input);
                return response()->json(['message'=>'Absensi berhasil', 'data'=>$data]);
        }
        }catch(\Throwable $e) {
            return response()->json(['message' =>$e->getMessage()]);
        }
    }

    public function getTotalabsenPelajar($user_id){
        try{
            $masuk = absen_kk::where('user_id',$user_id)
                        ->where('keterangan', 'masuk')
                        ->select('masuk')
                        ->count();
                        $izin = absen_kk::where('user_id',$user_id)
                        ->where('keterangan', 'izin')
                        ->select('izin')
                        ->count();  
                        $sakit = absen_kk::where('user_id',$user_id)
                        ->where('keterangan', 'sakit')
                        ->select('sakit')
                        ->count();        
            
                        return response()->json(['masuk'=>$masuk, 'izin'=>$izin, 'sakit'=>$sakit]);
        }catch(\Throwable $e) {
            return response()->json(['message' =>$e->getMessage()]);
        }
    }

    public function getAbsenPengajar($user_id){
        try{
            $data = DB::table('course_kks')->join('jadwal_absen_kks', 'course_kks.id', 'jadwal_absen_kks.course_id')
                                    ->where('course_kks.instructor_id', $user_id)
                                    ->select('jadwal_absen_kks.hari', 'jadwal_absen_kks.mulai', 'jadwal_absen_kks.selesai', 'course_kks.nama', 'course_kks.id')
                                    ->get();
            $count = $data->count();
            if($count > 0){
                return response()->json(['message'=>'Data berhasil didapatkan', 'data'=>$data]);
            }else{
                return response()->json(['message'=>'Absensi course tidak ditemukan']);
            }
        }catch(\Throwable $e) {
            return response()->json(['message' =>$e->getMessage()]);
        }
    }

    public function getRekapabsenPengajar($course_id){
        try{
            $data = DB::table('absen_kks')
                            ->join('user_kks', 'absen_kks.user_id', 'user_kks.id')
                            ->where('absen_kks.course_id', $course_id)
                            ->select('user_kks.id','user_kks.nama', 'absen_kks.keterangan', 'absen_kks.hari', 'absen_kks.tanggal', 'absen_kks.bulan', 'absen_kks.waktu','absen_kks.tahun', 'absen_kks.surat_sakit', 'absen_kks.surat_izin')
                            ->get();
            $count = $data->count();
            if($count > 0){
                return response()->json(['message'=>'Data berhasil didapatkan', 'data'=>$data]);
            }else{
                return response()->json(['message'=>'Belum ada pelajar yang melakukan absensi']);
            }
        }catch(\Throwable $e) {
            return response()->json(['message' =>$e->getMessage()]);
        }
    }

    
}
