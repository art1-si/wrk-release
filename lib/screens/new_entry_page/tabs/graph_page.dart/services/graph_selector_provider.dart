import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum GraphProperties { perWeight, oneRepMax, simpleVolumePerSet }
final graphSelector = ChangeNotifierProvider.autoDispose((ref) {
  return GraphSelectorProvider();
});

class GraphSelectorProvider extends ChangeNotifier {
  GraphProperties _properties = GraphProperties.perWeight;

  GraphProperties get graphProperties => _properties;

  void setGraphProperties(GraphProperties newValue) {
    _properties = newValue;
    notifyListeners();
  }
}
