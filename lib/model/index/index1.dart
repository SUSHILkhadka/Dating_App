import 'package:flutter/material.dart';

class index1 extends ChangeNotifier {
  int _index = 0;
  int get index => _index;
  void increment() {
    _index++;
    notifyListeners();
  }

  void decrement() {
    _index--;
    notifyListeners();
  }
}
