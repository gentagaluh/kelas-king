import 'package:flutter/material.dart';
import 'package:app_kelas_king/url.dart';
import 'package:provider/provider.dart';

class Foto extends StatelessWidget {
  final String foto;
  Foto({required this.foto});

  @override
  Widget build(BuildContext context) {
    
    var urlProvider = Provider.of<UrlProvider>(context);
    var currentUrl = urlProvider.url;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image.network(
                          currentUrl + 'images/' + foto)
      ),
    );
  }
}