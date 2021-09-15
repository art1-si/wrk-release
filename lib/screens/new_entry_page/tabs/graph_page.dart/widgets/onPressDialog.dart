import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:workout_notes_app/theme/app_theme.dart';
import 'package:workout_notes_app/provider/day_selector_provider.dart';

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
      final _formatedDate = _date!.prettyToString();
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
            field4: "Date: $_formatedDate",
            field3: details.pointedValue() == null
                ? null
                : details.pointedValue().toString(),
          ),
        ),
      );
    }
    return Container();
  }
}

class _PopUpTable extends StatelessWidget {
  const _PopUpTable({
    Key? key,
    required this.field1,
    required this.field2,
    required this.field3,
    required this.field4,
  }) : super(key: key);

  final String field1;
  final String field2;
  final String? field3;
  final String field4;

  @override
  Widget build(BuildContext context) {
    print("popUpTable rebuild with field3 value $field3");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Container(
        height: 70,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "$field1 x $field2",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            AnimatedAlign(
              alignment:
                  field3 == null ? Alignment.bottomRight : Alignment.bottomLeft,
              duration: Duration(milliseconds: 350),
              curve: Curves.easeInOutCubic,
              child: Text(
                field4,
                style: Theme.of(context).textTheme.overline,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 350),
                opacity: field3 != null ? 1 : 0.0,
                curve: Curves.easeInOutCubic,
                child: SizedBox(
                  width: 100,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: VerticalDivider(
                          color: AppTheme.of(context).divider,
                          thickness: 2,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "VALUE:",
                              style: Theme.of(context).textTheme.caption,
                            ),
                            Text(
                              field3 == null ? "0.0" : field3!,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(color: Colors.white54),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
