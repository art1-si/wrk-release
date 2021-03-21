import 'package:flutter/Material.dart';

class ProviderOfQuickAddButton extends ChangeNotifier {
  bool _showButton;
  String _addQuickPlanName;

  ProviderOfQuickAddButton(this._showButton, this._addQuickPlanName);

  getshowButton() => _showButton ?? false;
  getAddQuickPlanName() => _addQuickPlanName;

  setShowButton(bool show) {
    _showButton = show;
    notifyListeners();
  }

  setAddQuickPlanName(String name) {
    _addQuickPlanName = name;
    notifyListeners();
  }
}
