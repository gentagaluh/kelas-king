<?php

namespace App\Http\Controllers;

use App\Models\course_kk;
use App\Models\jadwal_absen_kk;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;

class JadwalAbsenKkController extends Controller
{
    public function addJadwalabsen(Request $req){
        try{
            $input = $req->all();
            $mulai = $req->input('mulai');
            $selesai = $req->input('selesai');
            $cm = Carbon::createFromFormat('H:i', $mulai);
            $cs = Carbon::createFromFormat('H:i', $selesai);
            if($cm->greaterThan($cs)){
                return response()->json(["message"=>"Format waktu salah"]);
            }else{
                $data = jadwal_absen_kk::create($input);
                return response()->json(["message"=>"Jadwal absen berhasil dibuat", 'data'=>$data]);
            }
        }catch(\Throwable $e) {
            return response()->json(['message' =>$e->getMessage()]);
        }
    }

    public function addJadwalabsenEnd(Request $req){
        try{
            $input = $req->all();
            $mulai = $req->input('mulai');
            $selesai = $req->input('selesai');
            $cm = Carbon::createFromFormat('H:i', $mulai);
            $cs = Carbon::createFromFormat('H:i', $selesai);
            if($cm->greaterThan($cs)){
                return response()->json(["message"=>"Format waktu salah"]);
            }else{
                $absen = course_kk::select('absen')
                            ->where('id', $req->input('course_id'));
                $absen->update($req->only(['absen']));
                $data = jadwal_absen_kk::create($input);
                return response()->json(["message"=>"Jadwal absen berhasil dibuat", 'data'=>$data]);
            }
        }catch(\Throwable $e) {
            return response()->json(['message' =>$e->getMessage()]);
        }
    }
}
