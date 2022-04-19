import 'package:flutter/material.dart';

class index2 extends ChangeNotifier {
  int _index = 1;
  int get index => _index;
  void increment() {
    _index++;
    // _index = 1;
    notifyListeners();
  }

  void decrement() {
    _index--;
    // _index = 0;
    notifyListeners();
  }
}
