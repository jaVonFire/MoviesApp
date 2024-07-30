import 'package:flutter/material.dart';


class SwitchProvider extends ChangeNotifier {
  
  bool _isActive = false;

  get isActive => _isActive;

  changeTheme() {
    _isActive = !_isActive;
    notifyListeners();
  }

}