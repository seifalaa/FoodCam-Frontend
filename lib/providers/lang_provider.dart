import 'package:flutter/cupertino.dart';

class LangUageProvider extends ChangeNotifier {
  String _langCode = 'ar';

  String get langCode => _langCode;

  void changeLang(String newLangCode) {
    _langCode = newLangCode;
    notifyListeners();
  }
}
