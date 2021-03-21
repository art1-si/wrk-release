import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:workout_notes_app/provider/day_selector_provider.dart';

class WeekdaysSelector extends StatefulWidget {
  @override
  _WeekdaysSelectorState createState() => _WeekdaysSelectorState();
}

class _WeekdaysSelectorState extends State<WeekdaysSelector> {
  int datePassed = 0;

  @override
  Widget build(BuildContext context) {
    var datePassing = Provider.of<DaySelectorModel>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              datePassed--;
              datePassing.daySelectorSub();
            },
            child: Container(
              color: Theme.of(context).cardColor,
              width: 30,
              height: 30,
              child: Icon(
                Icons.keyboard_arrow_left,
                size: 20,
                color: Color(0xffe8e9eb),
              ),
            ),
          ),
          Container(
            height: 30.0,
            child: GestureDetector(
              child: Container(
                height: 10,
                width: 220.0,
                child: Center(child: Consumer<DaySelectorModel>(
                    builder: (context, dateSe, child) {
                  String date;
                  if ("${dateSe.daySelected.day}${dateSe.daySelected.month}${dateSe.daySelected.year}" ==
                      "${dateSe.today.day}${dateSe.today.month}${dateSe.today.year}") {
                    date = 'Today';
                  } else if ("${dateSe.daySelected.day}${dateSe.daySelected.month}${dateSe.daySelected.year}" ==
                      "${dateSe.yesterday.day}${dateSe.yesterday.month}${dateSe.yesterday.year}") {
                    date = 'Yesterday';
                  } else if ("${dateSe.daySelected.day}${dateSe.daySelected.month}${dateSe.daySelected.year}" ==
                      "${dateSe.tomorrow.day}${dateSe.tomorrow.month}${dateSe.tomorrow.year}") {
                    date = 'Tomorrow';
                  } else {
                    date =
                        "${DateFormat('EEEE').format(dateSe.daySelected)}, ${DateFormat('dd').format(dateSe.daySelected)}  ${DateFormat('MMMM').format(dateSe.daySelected)}";
                  }
                  return GestureDetector(
                    onDoubleTap: () {
                      datePassing.resetDate();
                    },
                    child: Container(
                        width: 250,
                        child: Center(
                          child: Text("$date",
                              style: Theme.of(context).textTheme.headline6),
                        )),
                  );
                })),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              datePassing.daySelectorAdd();
            },
            child: Container(
              color: Theme.of(context).cardColor,
              width: 30,
              height: 30,
              child: Icon(
                Icons.keyboard_arrow_right,
                size: 20,
                color: Color(0xffe8e9eb),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
