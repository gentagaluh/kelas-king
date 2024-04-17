import 'dart:convert';
import 'package:app_kelas_king/model/button.dart';
import 'package:app_kelas_king/model/null.dart';
import 'package:app_kelas_king/model/show.dart';
import 'package:app_kelas_king/model/txtfield.dart';
import 'package:flutter/material.dart';
import 'package:app_kelas_king/url.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class Setting extends StatefulWidget {
  final Map datauser;
  Setting({required this.datauser});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    
    var width = MediaQuery.of(context).size.width;
    String nomor = '+6282314355261';
    String pesan = 'Halo min!';
    String pesan2 = 'Halo min, aku lupa password';
    String pesan3 = 'Halo min, aku ingin kerja sama';
    final Uri url = Uri.parse('https://wa.me/$nomor?text=$pesan');
    final Uri url2 = Uri.parse('https://wa.me/$nomor?text=$pesan2');
    final Uri url3 = Uri.parse('https://wa.me/$nomor?text=$pesan3');
    Future whatsapp() async {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }

    Future lupapw() async {
      await launchUrl(url2, mode: LaunchMode.externalApplication);
    }

    Future kerjasama() async {
      await launchUrl(url3, mode: LaunchMode.externalApplication);
    }

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.white,
          title: Text(
            'Pengaturan',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Container(
                    width: width / 3,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: width / 8,
                          child: widget.datauser['data']['role'] == 'Pelajar'
                              ? Icon(
                                  Icons.people,
                                  size: width / 7,
                                )
                              : Icon(
                                  Icons.school,
                                  size: width / 7,
                                ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.black.withOpacity(0.1)),
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: Text(
                                widget.datauser['data']['role'],
                                textAlign: TextAlign.center,
                              )),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hallo!'),
                          Text(
                            widget.datauser['data']['nama'],
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Popp(
                                    datauser: widget.datauser,
                                  );
                                });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xff85CBCB),
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Edit Profil',
                      )
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
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
                                                  Text('Hubungi admin untuk reset password', textAlign: TextAlign.center,),
                                                  SizedBox(height: 8,),
                                                  GestureDetector(
                                                    onTap: (){
                                                      lupapw();
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        color: Color(0xff85CBCB),
                                                        
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
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xff85CBCB),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Icon(
                                  Icons.question_mark,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Lupa Password?',
                          )
                        ],
                      )),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
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
                                                  Text('Hubungi admin?', textAlign: TextAlign.center,),
                                                  SizedBox(height: 8,),
                                                  GestureDetector(
                                                    onTap: (){
                                                      whatsapp();
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        color: Color(0xff85CBCB),
                                                        
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
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xff85CBCB),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Icon(
                                  Icons.call,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Hubungi Admin',
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
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
                                                  Text('Ingin bekerjasama dengan kelas king?', textAlign: TextAlign.center,),
                                                  SizedBox(height: 8,),
                                                  GestureDetector(
                                                    onTap: (){
                                                      kerjasama();
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        color: Color(0xff85CBCB),
                                                        
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
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Icon(
                                    Icons.call,
                                    color: Colors.orange,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Kerja Sama',
                            )
                          ],
                        ),
                      ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return LogOut();
                              });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Icon(
                              Icons.logout,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Logout',
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }
}

class Popp extends StatefulWidget {
  final Map datauser;
  Popp({required this.datauser});

  @override
  State<Popp> createState() => _PoppState();
}

class _PoppState extends State<Popp> {

  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  TextEditingController _namaController = TextEditingController();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _pw1Controller = TextEditingController();
  
  TextEditingController _pw2Controller = TextEditingController();

  
     

  bool _obscure = true;
  bool _1 = false;
  bool _2 = false;
  @override
  Widget build(BuildContext context) {
    var urlProvider = Provider.of<UrlProvider>(context);
    var currentUrl = urlProvider.url;
    Future nama() async {
      try {
        showDialog(
            context: context,
            builder: (context) {
              return Wait();
            });
        var response =
            await http.put(Uri.parse(currentUrl + 'api/setnama/'+widget.datauser['data']['id'].toString()), body: {
              
          "password": _pw1Controller.text,
          "nama":_namaController.text
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

    Future setemail() async {
      try {
        showDialog(
            context: context,
            builder: (context) {
              return Wait();
            });
        var response =
            await http.put(Uri.parse(currentUrl + 'api/setemail/'+widget.datauser['data']['id'].toString()), body: {
              
          "password": _pw2Controller.text,
          "email":_emailController.text
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
    edit() {
      if (_1) {
        return Form(
          key: _formKey1,
          child: Column(
            children: [
              SizedBox(
                height: 4,
              ),
              TxtField(
                  controller: _namaController,
                  hint: 'Nama Baru',
                  icon: Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                  validator: 'isi nama!'),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 20),
                child: TextFormField(
                  obscureText: _obscure,
                  controller: _pw1Controller,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(right: width / 30),
                        child: Icon(
                          Icons.lock,
                          color: Colors.grey,
                        ),
                      ),
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: width / 50),
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                _obscure = !_obscure;
                              });
                            },
                            child: _obscure
                                ? Icon(Icons.visibility_off, color: Colors.grey)
                                : Icon(
                                    Icons.visibility,
                                    color: Colors.grey,
                                  )),
                      ),
                      prefixIconConstraints: BoxConstraints(
                        minWidth: 0,
                        minHeight: 0,
                      ),
                      hintText: 'Password',
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'isi password!';
                    }
                    return null;
                  },
                ),
              ),
              Button(
                  txt: 'Edit',
                  color: Color(0xff85CBCB),
                  shadow: Color(0xffA8DEE0),
                  op: () async {
                    if (_formKey1.currentState!.validate()) {
                 
                      nama();
                    }
                  }),
            ],
          ),
        );
      } else if (_2) {
        return Form(
          key: _formKey2,
          child: Column(
            children: [
              SizedBox(
                height: 4,
              ),
              TxtField(
                  controller: _emailController,
                  hint: 'Email Baru',
                  icon: Icon(
                    Icons.email,
                    color: Colors.grey,
                  ),
                  validator: 'isi email!'),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 20),
                child: TextFormField(
                  obscureText: _obscure,
                  controller: _pw2Controller,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(right: width / 30),
                        child: Icon(
                          Icons.lock,
                          color: Colors.grey,
                        ),
                      ),
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: width / 50),
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                _obscure = !_obscure;
                              });
                            },
                            child: _obscure
                                ? Icon(Icons.visibility_off, color: Colors.grey)
                                : Icon(
                                    Icons.visibility,
                                    color: Colors.grey,
                                  )),
                      ),
                      prefixIconConstraints: BoxConstraints(
                        minWidth: 0,
                        minHeight: 0,
                      ),
                      hintText: 'Password',
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'isi password!';
                    }
                    return null;
                  },
                ),
              ),
              Button(
                  txt: 'Edit',
                  color: Color(0xff85CBCB),
                  shadow: Color(0xffA8DEE0),
                  op: () async {
                    if (_formKey2.currentState!.validate()) {
                      setemail();
                    }
                  }),
            ],
          ),
        );
      
      } else {
        return DataNull(txt: 'Pilih Edit!');
      }
    }

    return PopUp(
        title: 'Edit Profil',
        form: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 5),
              child: Container(
                width: width,
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _1 = true;
                          _2 = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: _1 ? Color(0xffFBC78D) : Color(0xffF9E2AE),
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              'Edit Nama',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _2 = true;
                          _1 = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: _2 ? Color(0xffFBC78D) : Color(0xffF9E2AE),
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              'Edit Email',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                        ],
                ),
              ),
            ),
            edit()
          ],
        ));
  }
}
