import 'package:flutter/material.dart';
import 'package:line_graph/meta_graph.dart';


class PainterGraph extends CustomPainter {
  final List<Offset> scores;
  final List<String> labels;

  PainterGraph(this.scores, this.labels): super();


  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.grey;
    paint.strokeWidth = 1;
    paint.style = PaintingStyle.stroke;

    //-- Draw Vertical Lines
    double x = MetaGraph.widthLabel / 2;
    for (int i = 0; i < labels.length; i++) {
      //-- Draw Line
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, MetaGraph.axisB),
        paint
      );

      //-- Draw Label
      String sVal = labels[i];

      TextSpan span = new TextSpan(
        style: TextStyle(
          color: Colors.blue,
          fontSize: 24.0,
        ),
        text: sVal,
      );
      TextPainter tp = new TextPainter(
        text: span,
        textDirection: TextDirection.ltr
      );
      tp.layout();
      tp.paint(
        canvas,
        new Offset(x - MetaGraph.widthLabel / 2, MetaGraph.axisB)
      );

      x += MetaGraph.unitH;
    }

    //-- Draw Graph Line
    paint.color = Colors.blue;
    paint.strokeWidth = MetaGraph.stroke;
    paint.style = PaintingStyle.stroke;
    Path path = Path();
    Offset offsetPrev = Offset(0, 0);
    for (int i = 0; i < scores.length; i++) {
      final score = scores[i];
      final offset = MetaGraph.offsetFromScore(score);
      canvas.drawCircle(offset, MetaGraph.radiusPoint, paint);
      if (i == 0) {
        path.moveTo(offset.dx, offset.dy);
      }
      else {
        path.quadraticBezierTo(
          offsetPrev.dx + MetaGraph.unitH * 0.25,
          offsetPrev.dy,
          (offsetPrev.dx + offset.dx) / 2,
          (offsetPrev.dy + offset.dy) / 2,
        );
        path.quadraticBezierTo(
          offset.dx - MetaGraph.unitH * 0.25,
          offset.dy,
          offset.dx,
          offset.dy,
        );
      }
      offsetPrev = offset;
    }
    canvas.drawPath(path, paint);
  }


  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

}

