import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/graph_model_provider.dart';

class GraphPoint extends StatelessWidget {
  const GraphPoint({Key? key, required this.entry}) : super(key: key);

  final GraphModel entry;

  @override
  Widget build(BuildContext context) {
    print("graph point");
    return CustomPaint(
      size: MediaQuery.of(context).size,
      painter: DrawPoint(
        pointPosition: entry,
      ),
    );
  }
}

class DrawPoint extends CustomPainter {
  const DrawPoint({
    Key? key,
    required this.pointPosition,
  });

  final GraphModel pointPosition;

  @override
  void paint(Canvas canvas, Size size) {
    Color gradinetColorStarter = Color(0xffFFB81F).withOpacity(0.1);
    Color endGradinetColor = Color(0xffFF52A8).withOpacity(0.07);
    final gradient = LinearGradient(
      colors: [gradinetColorStarter, endGradinetColor],
      stops: [0.2, 0.99],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
    Paint shadowLine2 = Paint()
      ..shader =
          gradient.createShader(Rect.fromLTRB(0, 0, size.width, size.height))
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    Paint points = Paint()
      ..color = Color(0xffFFB81F)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 12;

    var _dx = pointPosition.x * size.width;
    var _nextDx = pointPosition.nextX * size.width;
    var _distance = (_nextDx - _dx) / 2;
    canvas.drawLine(
        Offset((pointPosition.x * size.width), pointPosition.y * size.height),
        Offset(pointPosition.x * size.width, pointPosition.y * size.height),
        points);
    canvas.drawPath(
      Path()
        ..moveTo(_dx - _distance, 0)
        ..lineTo(_dx - _distance, size.height)
        ..lineTo(_nextDx - _distance, size.height)
        ..lineTo(_nextDx - _distance, 0),
      shadowLine2,
    );
  }

  @override
  bool shouldRepaint(DrawPoint oldDelegate) => true;
}
