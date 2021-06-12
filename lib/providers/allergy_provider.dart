import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllergyProvider extends ChangeNotifier {
  List<String> _allergies = [];
  List<bool>_allergiesLongPress = [];

  List<String> get allergies => _allergies;

  List<bool> get allergiesLongPress => _allergiesLongPress;

  void add(String allergy) {
    _allergies.add(allergy);
    _allergiesLongPress.add(false);
    notifyListeners();
  }

  void remove(String allergy) {
    int index = _allergies.indexOf(allergy);
    _allergies.remove(allergy);
    _allergies.removeAt(index);
    notifyListeners();
  }

  void pressed(int index) {
    _allergiesLongPress[index] = !_allergiesLongPress[index];
    notifyListeners();
  }

}
