import 'package:flutter/cupertino.dart';

class CountProvider extends ChangeNotifier {
  int _count = 1; // Initial count

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    if (_count > 0) {
      _count--;
      notifyListeners();
    }
  }
}
