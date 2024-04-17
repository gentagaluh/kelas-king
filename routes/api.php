<?php

use App\Http\Controllers\AbsenKkController;
use App\Http\Controllers\CourseJoinKkController;
use App\Http\Controllers\CourseKkController;
use App\Http\Controllers\JadwalAbsenKkController;
use App\Http\Controllers\MateriKkController;
use App\Http\Controllers\UserKkController;
use App\Http\Controllers\TugasKkController;
use App\Http\Controllers\PengumpulanKkController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

// Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
//     return $request->user();
// });

Route::post('/register', [UserKkController::class, 'register']);
Route::post('/login', [UserKkController::class, 'login']);

Route::post('/join-course', [CourseJoinKkController::class, 'joinCourse']);
Route::get('/get-course-pelajar/{user_id}', [CourseKkController::class, 'getCoursePelajar']);
Route::get('/search-course-pelajar/{user_id}/{nama_course}', [CourseKkController::class, 'searchCoursePelajar']);
Route::get('/get-materi/{course_id}', [MateriKkController::class, 'getMateri']);

Route::post('/add-course', [CourseKkController::class, 'addCourse']);
Route::post('/add-jadwalabsen', [JadwalAbsenKkController::class, 'addJadwalabsen']);
Route::get('/get-course-pengajar/{user_id}', [CourseKkController::class, 'getCoursePengajar']);
Route::get('/search-course-pengajar/{user_id}/{nama_course}', [CourseKkController::class, 'searchCoursePengajar']);
Route::get('/get-member/{course_id}', [CourseJoinKkController::class, 'getMember']);
Route::post('/add-jadwalabsen-end', [JadwalAbsenKkController::class, 'addJadwalabsenEnd']);
Route::get('/get-absen-pengajar/{user_id}', [AbsenKkController::class, 'getAbsenPengajar']);
Route::post('/add-materi', [MateriKkController::class, 'addMateri']);
Route::get('/get-tugas/{materi_id}', [TugasKkController::class, 'getTugas']);
Route::post('/add-tugas', [TugasKkController::class, 'addTugas']);
Route::get('/get-rekapabsen-pengajar/{course_id}', [AbsenKkController::class, 'getRekapabsenPengajar']);
Route::get('/get-totalabsen-pelajar/{user_id}', [AbsenKkController::class, 'getTotalabsenPelajar']);
Route::get('/get-absen-today/{user_id}/{hari}/{tanggal}/{bulan}/{tahun}', [CourseJoinKkController::class, 'getAbsenToday']);
Route::post('/do-absen', [AbsenKkController::class, 'doAbsen']);
Route::get('/get-pengumpulantugas-pelajar/{tugas_id}/{user_id}', [PengumpulanKkController::class, 'getPengumpulantugasPelajar']);
Route::post('/pengumpulan-tugas', [PengumpulanKkController::class, 'pengumpulanTugas']);
Route::get('/get-allmateri-pengajar/{instructor_id}', [MateriKkController::class, 'getAllmateri']);
Route::get('/get-pengumpulantugas-pengajar/{tugas_id}', [PengumpulanKkController::class, 'getPengumpulantugasPengajar']);
Route::put('/setnilai/{id}', [PengumpulanKkController::class, 'setNilai']);
Route::get('/get-allmateri-pelajar/{user_id}', [MateriKkController::class, 'getAllmateriPelajar']);
Route::put('/setnama/{id}', [UserKkController::class, 'setNama']);
Route::put('/setemail/{id}', [UserKkController::class, 'setEmail']);
Route::delete('/deletemember/{id}', [CourseJoinKkController::class, 'deleteMember']);