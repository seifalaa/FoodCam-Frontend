import 'package:flutter/cupertino.dart';

class LanguageProvider extends ChangeNotifier {
  String langCode = 'ar';

  String get getLangCode {
    return langCode;
  }

  Future<void> changeLang(String newLangCode) async {
    langCode = newLangCode;
    notifyListeners();
  }
}
