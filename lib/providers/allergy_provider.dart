import 'package:flutter/material.dart';

class AllergyProvider extends ChangeNotifier {
  final List<String> _allergies = [];
  final List<bool> _allergiesLongPress = [];

  List<String> get allergies => _allergies;

  List<bool> get allergiesLongPress => _allergiesLongPress;

  void add(String allergy) {
    _allergies.add(allergy);
    _allergiesLongPress.add(false);
    notifyListeners();
  }

  void remove(String allergy) {
    final int index = _allergies.indexOf(allergy);
    _allergies.remove(allergy);
    _allergies.removeAt(index);
    notifyListeners();
  }

  void pressed(int index) {
    _allergiesLongPress[index] = !_allergiesLongPress[index];
    notifyListeners();
  }
}
