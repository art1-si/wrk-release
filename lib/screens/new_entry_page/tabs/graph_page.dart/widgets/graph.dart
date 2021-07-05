import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/graph_model_provider.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/widgets/draw_graph.dart';

class MyDrawGraph extends StatefulWidget {
  final GraphModelProvider graphProvider;

  const MyDrawGraph({Key? key, required this.graphProvider}) : super(key: key);
  @override
  _MyDrawGraphState createState() => _MyDrawGraphState();
}

class _MyDrawGraphState extends State<MyDrawGraph> {
  Offset? _tapPosition;
  bool isPressed = false;
  var referenceBox;
  GraphModelProvider get graphProvider => widget.graphProvider;
  @override
  Widget build(BuildContext context) {
    print("agag ${MediaQuery.of(context).size}");
    /* if (_tapPosition != null) {
      if (widget.snapshotToPass.isNotEmpty &&
          widget.snapshotToPass.length > 1) {
        
        widget.snapshotToPass.forEach((element) {
          listOfXOffset.add(len);
          len = len + len2;
        });
        var distance = listOfXOffset[1] - listOfXOffset.first;
        for (var i = 0; i < listOfXOffset.length; i++) {
          if (listOfXOffset[i] < _tapPosition!.dx + distance / 2 &&
              listOfXOffset[i] + distance > _tapPosition!.dx + distance / 2) {
            index = i;
          }
        }
      }
    } */
    return GestureDetector(
      onPanDown: (details) {
        referenceBox = context.findRenderObject();
        setState(() {
          _tapPosition = referenceBox!.globalToLocal(details.globalPosition);
        });
      },
      onPanStart: (details) {
        referenceBox = context.findRenderObject();
        setState(() {
          _tapPosition = referenceBox!.globalToLocal(details.globalPosition);
        });
      },
      onPanUpdate: (details) {
        referenceBox = context.findRenderObject();
        setState(() {
          _tapPosition = referenceBox!.globalToLocal(details.globalPosition);
        });
      },
      onPanEnd: (details) {
        setState(() {
          _tapPosition = null;
        });
      },
      onPanCancel: () {
        setState(() {
          _tapPosition = null;
        });
      },
      child: CustomPaint(
        size: Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height,
        ),
        painter: DrawGraph(
          sizeWidth: MediaQuery.of(context).size.width - 50,
          lineColor: Theme.of(context).accentColor,
          graphProvider: graphProvider,
          linePosition: _tapPosition,
          maxValue: graphProvider.maxValue,
          minValue: graphProvider.minValue,
        ),
      ),
    );
  }
}
