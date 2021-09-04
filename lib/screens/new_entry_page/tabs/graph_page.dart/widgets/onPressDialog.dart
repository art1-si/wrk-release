import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:workout_notes_app/theme/app_theme.dart';

import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/details_provider.dart';

class OnPressDialog extends ConsumerWidget {
  OnPressDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final details = watch(detailsProvider);
    print("details: ${details.offset}");
    if (details.logDetails != null) {
      final _date =
          DateTime.tryParse(details.logDetails!.corespondingLog.dateCreated);
      final _formatedDate = DateFormat("MMMMEEEEd").format(_date!);
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.of(context).primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: _PopUpTable(
            field1: "WEIGHT ${details.logDetails!.corespondingLog.weight}",
            field2: "${details.logDetails!.corespondingLog.reps}",
            field4: "Date $_formatedDate",
            field3: "rpe",
          ),
        ),
      );
    }
    return Container();
  }
}

class _PopUpTable extends StatelessWidget {
  final String field1;
  final String field2;
  final String field3;
  final String field4;

  const _PopUpTable({
    Key? key,
    required this.field1,
    required this.field2,
    required this.field3,
    required this.field4,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Container(
        height: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "$field1 x $field2",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                field4,
                style: Theme.of(context).textTheme.overline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
