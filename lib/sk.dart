import 'package:flutter/material.dart';

class Sk extends StatelessWidget {
  const Sk({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Syarat & Ketentuan',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10, top: 5),
        child: ListView(
          children: [
            Text('1. Penerimaan Syarat dan Ketentuan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('Penggunaan aplikasi ini setuju pada syarat dan ketentuan berikut. Dengan mengakses atau menggunakan aplikasi ini, Anda dianggap telah membaca, memahami, dan menyetujui semua syarat dan ketentuan yang tercantum di sini.'),
            ),Text('2. Pendaftaran Pengguna', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('Untuk menggunakan aplikasi ini, pengguna harus mendaftar dengan informasi yang benar dan akurat.'),
            ),Text('3. Hak dan Kewajiban Pengguna', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('Pengguna berhak menggunakan fitur-fitur yang disediakan oleh aplikasi sesuai dengan tujuan utama penggunaan.'),
            ),Text('4. Penggunaan Konten', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('Konten yang disediakan dalam aplikasi ini, termasuk tetapi tidak terbatas pada materi pembelajaran, tugas, dan materi lainnya, dilindungi oleh hak cipta.'),
            ),Text('5. Kebijakan Privasi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('Kami menghargai privasi pengguna kami dan akan melindungi informasi pribadi mereka sesuai dengan kebijakan privasi yang telah ditetapkan. Dengan menggunakan aplikasi ini, Anda menyetujui pengumpulan, penggunaan, dan pengungkapan informasi Anda sesuai dengan kebijakan privasi tersebut.'),
            ),Text('6. Penghentian Akses', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('Admin berhak untuk membatasi, menangguhkan, atau mengakhiri akses pengguna ke aplikasi ini jika terjadi pelanggaran terhadap syarat dan ketentuan yang telah ditetapkan.'),
            ),Text('7. Pembaruan Syarat dan Ketentuan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('Syarat dan ketentuan penggunaan aplikasi ini dapat diperbarui dari waktu ke waktu. Pengguna akan diberitahu tentang perubahan tersebut, dan penggunaan lanjutan dari aplikasi ini setelah perubahan tersebut akan dianggap sebagai penerimaan dari syarat dan ketentuan yang diperbarui.'),
            ),Text('8. Pembatasan Tanggung Jawab', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('Pembuat aplikasi tidak bertanggung jawab atas kerugian atau kerusakan yang timbul akibat penggunaan atau ketidakmampuan menggunakan aplikasi ini.'),
            ),
            Text('Dengan menggunakan aplikasi ini, Anda setuju untuk mematuhi semua syarat dan ketentuan yang tercantum di atas. Jika Anda tidak setuju dengan syarat dan ketentuan ini, mohon untuk tidak menggunakan aplikasi ini.')
          ],
        ),
      ),
    );
  }
}
