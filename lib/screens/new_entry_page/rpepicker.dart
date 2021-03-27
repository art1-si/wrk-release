import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_notes_app/provider/log_values_provider.dart';

class RPEPicker extends StatelessWidget {
  final List<int> rpeValueList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  @override
  Widget build(BuildContext context) {
    return Consumer<LogValuesProvider>(
      builder: (context, log, child) {
        return Container(
          height: 50,
          child: ListView.builder(
              physics: ScrollPhysics(),
              reverse: true,
              scrollDirection: Axis.horizontal,
              itemCount: rpeValueList.length,
              controller: ScrollController(
                  initialScrollOffset: MediaQuery.of(context).size.width / 2),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    log.setRpeTo(rpeValueList[index]);
                  },
                  child: Center(
                    child: Container(
                      width: 40,
                      child: Center(
                        child: Text(
                          "${rpeValueList[index]}",
                          style: TextStyle(
                            fontSize:
                                (log.rpeValue == rpeValueList[index]) ? 28 : 17,
                            color: (log.rpeValue == rpeValueList[index])
                                ? Colors.white
                                : Colors.white54,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}
