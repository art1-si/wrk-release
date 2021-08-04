import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chartProvider = ChangeNotifierProvider<GraphProvider>((ref) {
  return GraphProvider();
});

class GraphProvider extends ChangeNotifier {
  bool _showSelector = false;
  bool get showSelector => _showSelector;
  void handleShowSelector() {
    _showSelector ? _showSelector = false : _showSelector = true;
    notifyListeners();
  }
}
