import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/graph_model_provider.dart';

final detailsProvider = ChangeNotifierProvider.autoDispose(
  (ref) => DetailsProvider(),
);

class DetailsProvider extends ChangeNotifier {
  GraphModel? _log;

  GraphModel? get logDetails => _log;

  void setDetails(GraphModel? value) {
    print("new detail value ${value!.corespondingLog.weight}");
    print("log details before $logDetails");
    _log = value;
    print("log details after $logDetails");
    notifyListeners();
  }
}
