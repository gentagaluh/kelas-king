import 'package:flutter/material.dart';

class UrlProvider extends ChangeNotifier {
  String _url = 'https://5129-182-2-43-193.ngrok-free.app/';

  String get url => _url;

  void updateUrl(String newUrl) {
    _url = newUrl;
    notifyListeners();
  }
}
