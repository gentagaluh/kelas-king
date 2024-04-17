import 'package:app_kelas_king/model/button.dart';
import 'package:app_kelas_king/model/null.dart';
import 'package:app_kelas_king/model/other.dart';
import 'package:flutter/material.dart';
import 'package:app_kelas_king/model/show.dart';
import 'package:http/http.dart' as http;
import 'package:app_kelas_king/model/txtfield.dart';
import 'package:app_kelas_king/teacher/foto.dart';
import 'package:app_kelas_king/url.dart';
import 'dart:convert';

import 'package:provider/provider.dart';

// ignore: must_be_immutable
class TTugasDetail extends StatelessWidget {
  final Map datatugas;
  String idx;
  TTugasDetail({required this.datatugas, required this.idx});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

  TextEditingController _nilai = TextEditingController();
     var urlProvider = Provider.of<UrlProvider>(context);
    var currentUrl = urlProvider.url;
    Future nilai(id) async {
      try {
        showDialog(
            context: context,
            builder: (context) {
              return Wait();
            });
        var response =
            await http.put(Uri.parse(currentUrl + 'api/setnilai/'+id), body: {
          "nilai": _nilai.text,
        });
        Map data = json.decode(response.body);
        String message = data['message'];
        if (message == 'Berhasil') {
          Navigator.pop(context);
          Navigator.pop(context);
          
        } else {
          Navigator.pop(context);
          showDialog(
              context: context,
              builder: (context) {
                return Eror(txt: message);
              });
        }
      } catch (e) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return Eror(txt: e.toString());
            });
      }
    }
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    Future getDetail() async {
      try {
        var response = await http.get(
          Uri.parse(currentUrl +
              'api/get-pengumpulantugas-pengajar/' +
              datatugas['id'].toString()),
        );
        return json.decode(response.body);
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) {
              return Eror(txt: e.toString());
            });
      }
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        title: Text(
          'Tugas ' + idx,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(child: Container()),
              Image.asset(
                'images/bgdown.png',
                height: height / 4,
                width: width,
                fit: BoxFit.fill,
              ),
            ],
          ),
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Judul(txt: 'Course'),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 8, bottom: 10),
                      child: Text(datatugas['nama']),
                    ),
                    Judul(txt: 'Materi'),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 8, bottom: 10),
                      child: Text(datatugas['judul']),
                    ),
                    Judul(txt: 'Tugas'),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 8, bottom: 10),
                      child: Text(datatugas['tugas']),
                    ),
                    Judul(txt: 'Deadline'),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 6),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.red),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            datatugas['deadline'],
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return PopUp(
                                                            title:
                                                                "Rekap Pengumpulan Tugas",
                                                            form: Column(
                                                              children: [
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Judul(
                                                                    txt:
                                                                        'Data'),
                                                                SizedBox(
                                                                  height: 8,
                                                                ),
                                                                FutureBuilder(
  future: getDetail(),
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return snapshot.data['message'] == "Belum ada yang mengumpulkan tugas"
          ? DataNull(txt: snapshot.data['message'])
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: MaterialStateColor.resolveWith((states) => Color(0xffA8DEE0)),
                columns: [
                  DataColumn(label: Text('No')),
                  DataColumn(label: Text('Tugas')),
                  DataColumn(label: Text('Nama Pelajar')),
                  DataColumn(label: Text('Waktu Pengumpulan')),
                  DataColumn(label: Text('Jawaban')),
                  DataColumn(label: Text('Nilai')),
                ],
                rows: List.generate(snapshot.data['data'].length, (index) {
  var rowData = snapshot.data['data'][index];

  return DataRow(cells: [
    DataCell(Text((index + 1).toString(), style: TextStyle(fontWeight: FontWeight.bold))),
    DataCell(Text(rowData['tugas'])),
    DataCell(Text('${rowData['nama']} (${rowData['user_id']})')),
    DataCell(Text(rowData['wkt_pengumpulan'])),
    DataCell(rowData['text'] == 'no' ? GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Foto(foto: snapshot.data['data'][index]['foto'])));
      },
      child: Text('Foto', style:TextStyle(color: Colors.blue))) : Text(rowData['text'])),
    DataCell(rowData['nilai'] == 'no' ? GestureDetector(
      onTap: (){
        Navigator.pop(context);
        showDialog(context: context, builder: (context){
          
          return PopUp(title: 'Beri Nilai', form: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: TxtField(controller: _nilai, hint: '0 - 100', icon: Icon(Icons.grade, color: Colors.grey,),validator: 'isi nilai!'),
                ),
                Button(
                                  txt: 'Nilai',
                                  color: Color(0xff85CBCB),
                                  shadow: Color(0xffA8DEE0),
                                  op: () async {
                                    if (_formKey.currentState!.validate()) {
                                      nilai(snapshot.data['data'][index]['ip'].toString());
                                    }
                                  }),
              ],
            )));
        });
      },
      child: Text('Beri Nilai', style:TextStyle(color: Colors.blue))) : Text(rowData['nilai'])),
  ]);
}),

              ),
            );
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return Column(
        children: [
          CircularProgressIndicator(color: Color(0xff85CBCB)),
        ],
      );
    }
  },
)

                                                              ],
                                                            ));
                                                      });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xff85CBCB)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 15),
                          child: Text(
                            'Rekap Pengumpulan Tugas',
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
