import 'package:flutter/material.dart';
import 'package:workout_notes_app/screens/new_entry_page/widgets/text_field_number_picker.dart';

class LogScreen extends StatelessWidget {
  LogScreen({
    Key? key,
  }) : super(key: key);

  final String notes = "";

  //final int exerciseIndex;

  //void _onItemTapped(int index) {
  //  rpeValue = index;
  //}

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          child: Column(// Submitt picker
              children: <Widget>[
            Container(
              //width: screenWidth / 2,
              child: WeightNumberPicker(
                title: "WEIGHT",
                numberChangeValue: 2.5,
                //numberValue: logValuesProvider.weightValue,
                //onTapLeftButton: () {
                //  if (logValuesProvider.weightValue > 0) {
                //    logValuesProvider
                //        .setWeightTo(logValuesProvider.weightValue - 2.5);
                //  }
                // },
                //onTapRightButton: () {
                //  logValuesProvider
                //      .setWeightTo(logValuesProvider.weightValue + 2.5);
                //},
              ),
            ),
            Divider(
              thickness: 1,
              height: 0,
              //indent: screenWidth / 3,
              //endIndent: screenWidth / 3,
            ),
            Container(
                /*  //width: screenWidth / 3,
              /* child: RepsNumberPicker(
                title: "REPS",
                numberChangeValue: 1,
                numberValue: logValuesProvider.repsValue,
                onTapLeftButton: () {
                  if (logValuesProvider.repsValue > 0) {
                    logValuesProvider
                        .setRepsTo(logValuesProvider.repsValue - 1);
                  }
                },
                onTapRightButton: () {
                  logValuesProvider.setRepsTo(logValuesProvider.repsValue + 1);
                }, */
              ), */
                ),
            Divider(
              thickness: 1,
              height: 0,
              //indent: screenWidth / 3,
              //endIndent: screenWidth / 3,
            ),
            Divider(
              thickness: 1,
              height: 0,
              indent: screenWidth / 3,
              endIndent: screenWidth / 3,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 0),
              child: InkWell(
                onTap: () {},
                child: Container(
                  height: 30,
                  width: 130,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).accentColor.withOpacity(0.2)),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                      child: Text(
                    "SAVE",
                    style: Theme.of(context).textTheme.button,
                  )),
                ),
              ),
            )
          ]),
        ),
      ],
    );
  }
}

class _LogItem extends StatelessWidget {
  final String setField;
  final String weightField;
  final String repsField;
  final String rpeField;

  const _LogItem({
    Key? key,
    required this.setField,
    required this.weightField,
    required this.repsField,
    required this.rpeField,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(setField),
                Row(
                  children: <Widget>[
                    Text("Weight "),
                    Text(weightField),
                  ],
                ),
                Row(
                  children: <Widget>[Text("Reps "), Text(repsField)],
                ),
                Row(
                  children: <Widget>[Text("RPE "), Text(rpeField)],
                ),
              ]),
        ),
        Divider(),
      ],
    );
  }
}
