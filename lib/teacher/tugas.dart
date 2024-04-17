import 'package:app_kelas_king/model/null.dart';
import 'package:app_kelas_king/model/show.dart';
import 'package:app_kelas_king/teacher/tugas_detail.dart';
import 'package:app_kelas_king/url.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TTugas extends StatefulWidget {
  final Map datauser;
  TTugas({required this.datauser});


  @override
  State<TTugas> createState() => _TTugasState();
}

class _TTugasState extends State<TTugas> {
  String tugas_id = '';
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var urlProvider = Provider.of<UrlProvider>(context);
    var currentUrl = urlProvider.url;



    Future getAllmateri() async {
      try {
        var response = await http.get(
          Uri.parse(currentUrl +
              'api/get-allmateri-pengajar/' +
              widget.datauser['data']['id'].toString()),
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

    Future getTugasPengajar(String id) async {
      try {
        var response = await http.get(
          Uri.parse(currentUrl +
              'api/get-tugas/' +
              id),
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
        automaticallyImplyLeading: false,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        title: Text(
          'Tugas',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return LogOut();
                  });
            },
            child: CircleAvatar(
              child: widget.datauser['data']['role'] == 'Pelajar'
                  ? Icon(Icons.people)
                  : Icon(Icons.school),
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: ListView(children: [
        FutureBuilder(future: getAllmateri(), builder: (context, snapshot){
          if (snapshot.hasData){
            return snapshot.data['message'] ==
                          "Berhasil mendapatkan data"
                      ?Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Container(
                              width: width,
                                      height: width / 10,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                            itemCount: snapshot.data['data'].length,
                                itemBuilder: (context, index){
                                  return GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        tugas_id = snapshot.data['data'][index]['id'].toString();
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(8),
                                                            color: tugas_id ==
                                                                snapshot.data['data']
                                                                    [index]['id'].toString()
                                                            ? Color(0xffFBC78D)
                                                            : Color(0xffF9E2AE)),
                                                        child: Center(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets.symmetric(
                                                                    horizontal: 20),
                                                            child: Text('Materi '+
                                                              snapshot.data['data'][index]
                                                                  ['id'].toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight.bold),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                    ),
                                  );
                            
                                }),
                            ),
                            tugas_id == ''
                                ? DataNull(txt: 'Pilih materi!'):
                                FutureBuilder(
                  future: getTugasPengajar(tugas_id),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState ==
                                          ConnectionState.waiting){
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              CircularProgressIndicator(
                                                color: Color(0xff85CBCB),
                                              ),
                                            ],
                                          ),
                      );
                    }
                    else if (snapshot.hasData) {
                      return snapshot.data['message'] ==
                              "Berhasil mendapatkan data"
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data['data'].length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TTugasDetail(
                                                      idx: (index + 1)
                                                          .toString(),
                                                      datatugas:
                                                          snapshot.data['data']
                                                              [index])));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xffFFF5EA),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              blurRadius: 1,
                                              offset: Offset(0, 2))
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Tugas' +
                                                  ' ' +
                                                  (index + 1).toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              snapshot.data['data'][index]
                                                  ['tugas'],
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              })
                          : DataNull(txt: snapshot.data['message']);
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            CircularProgressIndicator(
                              color: Color(0xff85CBCB),
                            )
                          ],
                        ),
                      );
                    }
                  }),
                          ],
                        ),
                      ):DataNull(txt: snapshot.data['message']);
          }else{
              return Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: CircularProgressIndicator(
                                                color: Color(0xff85CBCB),
                                              ),
                                            ),
                                          ],
                                        );
            }

        })
      ],),
    );
  }
}