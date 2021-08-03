import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/graph_model_provider.dart';

class LinerGraph extends StatelessWidget {
  const LinerGraph({Key? key, required this.exerciseLog}) : super(key: key);

  final List<GraphModel> exerciseLog;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        size: MediaQuery.of(context).size,
        painter: DrawGraph(
          tapped: true,
          entries: exerciseLog,
          lineColor: Theme.of(context).accentColor,
        ));
  }
}

class DrawGraph extends CustomPainter {
  const DrawGraph({
    Key? key,
    required this.entries,
    required this.lineColor,
    required this.tapped,
  });

  final List<GraphModel> entries;
  final bool tapped;
  final Color lineColor;

  @override
  void paint(Canvas canvas, Size size) {
    Color gradinetColorStarter = (!tapped)
        ? lineColor.withOpacity(0.1)
        : Color(0xffFFB81F).withOpacity(0.1);
    Color endGradinetColor = (!tapped)
        ? Color(0xffFF52A8).withOpacity(0.07)
        : Color(0xffFF52A8).withOpacity(0.07);
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

    Paint line2 = Paint()
      ..color = (!tapped) ? lineColor : Color(0xffFFB81F)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    entries.forEach((element) {
      double _dx = element.x * size.width;
      double _dy = element.y * size.height;
      double _nextDx = element.nextX * size.width;
      double _nextDy = element.nextY * size.height;
      //Draw main line

      canvas.drawLine(Offset(_dx, _dy), Offset(_nextDx, _nextDy), line2);

      //Draw background
      canvas.drawPath(
        Path()
          ..moveTo(_dx, _dy)
          ..lineTo(_dx, size.height)
          ..lineTo(_nextDx, size.height)
          ..lineTo(_nextDx, _nextDy),
        shadowLine2,
      );
    });
  }

  @override
  bool shouldRepaint(DrawGraph oldDelegate) => tapped;
}
