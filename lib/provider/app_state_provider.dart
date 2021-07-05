import 'package:flutter/cupertino.dart';

class AppStateProvider with ChangeNotifier {
  int _currentIndex = 0;

  get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  refreshState() {
    notifyListeners();
    return true;
  }
}
