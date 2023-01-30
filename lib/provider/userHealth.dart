import 'package:flutter/cupertino.dart';

class UserHealthStat extends ChangeNotifier {
  bool _isHypertensionControlled = true;
  bool _isDiabeticControlled = true;

  bool get isHypertensionControlled => _isHypertensionControlled;
  bool get isIsDiabeticControlled => _isDiabeticControlled;

  void setDiabetic() {
    _isDiabeticControlled = false;
    notifyListeners();
  }

  void setHypertension() {
    _isHypertensionControlled = false;

    notifyListeners();
  }
}
