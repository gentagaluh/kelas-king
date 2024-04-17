<?php

namespace App\Http\Controllers;

use App\Models\tugas_kk;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class TugasKkController extends Controller
{
    public function getTugas($materi_id){
        try{
            $data = DB::table('tugas_kks')->join('materi_kks', 'materi_kks.id', 'tugas_kks.materi_id')
                                ->join('course_kks', 'course_kks.id', 'materi_kks.course_id')
                                ->where('tugas_kks.materi_id', $materi_id)
                                ->select('tugas_kks.id','course_kks.nama', 'materi_kks.judul', 'tugas_kks.tugas', 'tugas_kks.deadline')
                                ->get();
                                foreach ($data as $item) {
                                    $item->wkt_pengumpulan = date('d-m-Y');
                                }
            $datacount = $data->count();
            if($datacount > 0){
                return response()->json(['message'=>'Berhasil mendapatkan data', 'data'=>$data]);
            }else{
                return response()->json(['message'=>'Belum ada tugas di materi ini']);
            }
        }catch(\Throwable $e) {
            return response()->json(['message' =>$e->getMessage()]);
        }
    }
    
    

    public function addTugas(Request $req){
        try{
            $input = $req->all();
            $data = tugas_kk::create($input);
                return response()->json(['message'=>'Berhasil menambahkan tugas', 'data'=>$data]);
        }catch(\Throwable $e){
            return response()->json(['message' =>$e->getMessage()]);
        }
    }

    
}
