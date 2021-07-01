import 'package:flutter/material.dart';

class OnPressDialog extends StatelessWidget {
  final double weight;
  final int reps;
  final String dateCreated;

  OnPressDialog({
    Key? key,
    required this.weight,
    required this.reps,
    required this.dateCreated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _PopUpTable(
      field1: "WEIGHT $weight",
      field2: "$reps",
      field4: "Date $dateCreated",
      field3: "rpe",
    );
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
