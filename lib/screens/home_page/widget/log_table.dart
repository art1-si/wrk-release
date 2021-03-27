import 'package:flutter/material.dart';
import 'package:workout_notes_app/models/exercise_log_model.dart';

class LogTable extends StatelessWidget {
  final String title;
  final List<ExerciseLogModel> fieldData;
  final String field2;
  final String field3;
  final int itemCount;

  const LogTable(
      {Key key,
      this.title,
      this.fieldData,
      this.field2,
      this.field3,
      this.itemCount})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      child: Container(
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(10),
          border: Border(
            left: BorderSide(
              color: Theme.of(context).dividerColor,
            ),
            right: BorderSide(
              color: Theme.of(context).dividerColor,
            ),
          ),
          color: Theme.of(context).primaryColor,
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
              //color: Theme.of(context).primaryColor,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ),
            ),
            Divider(
              height: 0,
              thickness: 1.25,
            ),
            ListView.builder(
              padding: EdgeInsets.all(0.0),
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: itemCount,
              itemBuilder: (context, int downIdex) {
                return _Table(
                  field4: "${downIdex + 1} SET",
                  field1: "WEIGHT: ${fieldData[downIdex].weight}",
                  field2: "REPS: ${fieldData[downIdex].reps}",
                  field3: "RPE: ${fieldData[downIdex].exerciseRPE}",
                  index: downIdex,
                );
              },
            ),
            Divider(
              height: 12,
              color: Theme.of(context).backgroundColor,
            )
          ],
        ),
      ),
    );
  }
}

class _Table extends StatelessWidget {
  final String field1;
  final String field2;
  final String field3;
  final String field4;
  final int index;
  const _Table({
    Key key,
    this.field1,
    this.field2,
    this.field3,
    this.index,
    this.field4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _screenWidth = MediaQuery.of(context).size.width / 5;
    return Column(
      children: [
        Container(
          height: 25,
          color: (index.isEven)
              ? Theme.of(context).backgroundColor
              : Theme.of(context).primaryColorDark,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: _screenWidth / 1.6,
                child: Center(
                  child: Text(
                    field4,
                    style: Theme.of(context).textTheme.overline,
                  ),
                ),
              ),
              const VerticalDivider(
                width: 0,
              ),
              Container(
                width: _screenWidth * 1.2,
                child: Center(
                  child: Text(
                    field1,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              ),
              const VerticalDivider(
                width: 0,
              ),
              Container(
                //width: _screenWidth,
                child: Center(
                  child: Text(
                    field2,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              ),
              const VerticalDivider(
                width: 0,
              ),
              Container(
                width: _screenWidth / 1.5,
                child: Center(
                  child: Text(
                    field3,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          height: 0,
        )
      ],
    );
  }
}
