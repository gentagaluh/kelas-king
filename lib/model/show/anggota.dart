import 'dart:convert';
import 'package:app_kelas_king/model/null.dart';
import 'package:app_kelas_king/model/show.dart';
import 'package:app_kelas_king/url.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class PopUpAnggota extends StatelessWidget {
  final Map datacourse;
  PopUpAnggota({
    required this.datacourse,
  });
  @override
  Widget build(BuildContext context) {
    var urlProvider = Provider.of<UrlProvider>(context);
    var currentUrl = urlProvider.url;

    //future
    Future getCourseMember() async {
      try {
        var response = await http.get(
          Uri.parse(currentUrl +
              'api/get-member/' +
              datacourse['id'].toString()),
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

    return PopUp(
        title: "Anggota",
        form: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FutureBuilder(
                future: getCourseMember(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data['message'] ==
                            "Berhasil mendapatkan data"
                        ? Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data['data'].length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                            radius: 12,
                                            child: Icon(
                                              Icons.people,
                                              size: 15,
                                            )),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                snapshot.data['data'][index]
                                                    ['nama'],
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(snapshot.data['data'][index]
                                                  ['email'])
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                             showDialog(context: (context), builder: (context){
                                        return AlertDialog(
                                          contentPadding: EdgeInsets.zero,
                                          shadowColor: Colors.transparent,
                                          backgroundColor: Colors.transparent,
                                          content: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text('Keluarkan anggota?', textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),
                                                  SizedBox(height: 8,),
                                                  GestureDetector(
                                                    onTap: ()async{
                                                      
      try {
        showDialog(
            context: context,
            builder: (context) {
              return Wait();
            });
        var response =
            await http.delete(Uri.parse(currentUrl + 'api/deletemember/'+snapshot.data['data'][index]['id'].toString()),
        );
        Map data = json.decode(response.body);
        String message = data['message'];
        if (message == 'Berhasil') {
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
    
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        color: Colors.red,
                                                        
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(10),
                                                        child: Text('Lanjutkan', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                       });

                                          },
                                          child: Text('Keluarkan', style: TextStyle(color: Colors.red),))
                                      ],
                                    ),
                                  );
                                }),
                          )
                        : DataNull(txt: snapshot.data["message"]);
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          CircularProgressIndicator(
                            color: Color(0xff85CBCB),
                          ),
                        ],
                      ),
                    );
                  }
                })));
  }
}
