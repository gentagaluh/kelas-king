<?php

namespace App\Http\Controllers;

use App\Models\pengumpulan_kk;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class PengumpulanKkController extends Controller
{
    public function getPengumpulantugasPengajar($tugas_id){
        try{
            $data = DB::table('pengumpulan_kks')->join('user_kks', 'user_kks.id', 'pengumpulan_kks.user_id')
            ->join('tugas_kks', 'tugas_kks.id', 'pengumpulan_kks.tugas_id')
                ->select('pengumpulan_kks.id AS ip','tugas_kks.tugas','user_kks.nama', 'pengumpulan_kks.tugas_id', 'pengumpulan_kks.user_id', 'pengumpulan_kks.wkt_pengumpulan', 'pengumpulan_kks.text', 'pengumpulan_kks.foto', 'pengumpulan_kks.nilai')
                ->where('pengumpulan_kks.tugas_id', $tugas_id)
                ->orderBy('pengumpulan_kks.created_at', 'asc')
                ->get();
               
                $count = $data->count();
                if($count > 0){
                    return response()->json(['message'=>'Data berhasil didapatkan', 'data'=>$data]);
                }else{
                    return response()->json(['message'=>'Belum ada yang mengumpulkan tugas']);
                }
        }catch(\Throwable $e) {
            return response()->json(['message' =>$e->getMessage()]);
        }
    }
    public function getPengumpulantugasPelajar($tugas_id, $user_id){
        try{
            $data = pengumpulan_kk::select('nilai')
           ->where('tugas_id',$tugas_id)
                ->where('user_id',$user_id)
                
                ->get();
            $count = $data->count();
            if($count > 0){
                return response()->json(['message'=>'Sudah mengumpulkan tugas', 'data'=>$data]);
            }else{
                return response()->json(['message'=>'Belum mengumpulkan tugas','data'=>$data]);
            }
        }catch(\Throwable $e) {
            return response()->json(['message' =>$e->getMessage()]);
        }
    }

    public function pengumpulanTugas(Request $req){
        try{
            $input = $req->all();
                if($req->input('foto') != 'no'){
                    $foto = $req->file('foto');
                $nama_foto = time().'.'.$foto->getClientOriginalExtension();
                $foto->move('images/', $nama_foto);
                $input['foto'] = $nama_foto;
                }
                $data = pengumpulan_kk::create($input);
                return response()->json(['message'=>'Berhasil menambahkan data', 'data'=>$data]);
        }catch(\Throwable $e) {
            return response()->json(['message' =>$e->getMessage()]);
        }
    }

    public function setNilai(Request $req, $id){
        try {
            $data = pengumpulan_kk::find($id);
            $data->update($req->all());
            return response()->json(['message'=>'Berhasil']);
        } catch(\Throwable $e) {
            return response()->json(['message' => $e->getMessage()]);
        }
    }
    
}
