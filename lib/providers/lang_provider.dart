import 'package:flutter/cupertino.dart';

class LanguageProvider extends ChangeNotifier {
  String _langCode = 'ar';

  String get langCode {
    return _langCode;
  }

  Future<void> changeLang(String newLangCode) async {
    _langCode = newLangCode;
    notifyListeners();
  }
}
