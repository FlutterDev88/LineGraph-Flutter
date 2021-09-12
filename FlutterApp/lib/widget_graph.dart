
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:line_graph/meta_graph.dart';
import 'package:line_graph/model_score.dart';
import 'package:line_graph/notifier_data.dart';
import 'package:line_graph/painter_axis.dart';
import 'package:line_graph/painter_graph.dart';
import 'package:provider/provider.dart';


class WidgetGraph extends StatefulWidget {

  WidgetGraph({Key key}) : super(key: key);

  @override
  _WidgetGraphState createState() => _WidgetGraphState();
}


class _WidgetGraphState extends State<WidgetGraph> {

  Size  _size;
  List<ModelScore> _scores;
  List<String>     _labels;
  List<Offset>     _offsets = [];
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _scores = [
      ModelScore(DateTime(2020,  1, 15), 20),
      ModelScore(DateTime(2020,  2, 15), 14),
      ModelScore(DateTime(2020,  3,  1), 22),
      ModelScore(DateTime(2020,  6,  1), 18),
      ModelScore(DateTime(2020,  7, 25), 19),
      ModelScore(DateTime(2020,  9,  1), 18),
      ModelScore(DateTime(2020, 10,  1), 22),
      ModelScore(DateTime(2020, 11,  1), 23),
      ModelScore(DateTime(2020, 12,  1), 22),
    ];

    MetaGraph.markMinV = 12;
    MetaGraph.markMaxV = 24;
    MetaGraph.markCntV = 4;
    MetaGraph.markCntH = 12;  //-- Labels count
    _labels = [
      'Jan 2020', '', '', '', '',
      'Jun 2020', '', '', '', '',
      'Nov 2020', '',
    ];
  }  


  void getSize() {
    RenderBox renderBox = context.findRenderObject();
    var sizeNew = renderBox.size;

    if (_size == sizeNew)
      return;

    setState(() {
      _size = sizeNew;
      MetaGraph.calculate(_size.height);
    });
  }


  void convScoresToOffsets() {
    final dateStart = DateTime(2020, 1, 1);
    _offsets.clear();
    _scores.forEach((e) {
      Duration d = e.date.difference(dateStart);
      double x = d.inDays / 30.416;
      _offsets.add(Offset(x, e.score.toDouble()));
    });
  }


  @override
  Widget build(BuildContext context) {
    final notifierData = Provider.of<NotifierData>(context, listen: true);
    //-- Get Data from Provider, Service
    if (notifierData.isLoading)
      return Container();

    if (notifierData.scores == null) {
      notifierData.getScores();
      return Container();
    }

    //-- Get Widget Size
    if (_size == null) {
      Future.delayed(
        Duration.zero,
        () {
          getSize();
        },
      );
      return Container();
    }
    _size= null;

    //-- Convert Scores to Offsets
    _scores = notifierData.scores;
    convScoresToOffsets();

    //-- Build
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 50,
          height: MetaGraph.height,
          child: CustomPaint(
            painter: PainterAxis(),
          ),
        ),
        Expanded(
          child: (defaultTargetPlatform == TargetPlatform.iOS
               || defaultTargetPlatform == TargetPlatform.android)
            ? SingleChildScrollView(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                child: Container(
                  width: MetaGraph.width,
                  height: MetaGraph.height,
                  child: CustomPaint(
                    painter: PainterGraph(_offsets, _labels),
                  ),
                ),
              )
            : Listener(
                onPointerSignal: (ps) {
                  if (ps is PointerScrollEvent) {
                    final offset = _controller.offset + ps.scrollDelta.dy;
                    if (ps.scrollDelta.dy.isNegative)
                      _controller.jumpTo(
                        max(offset, 0)
                      );
                    else
                      _controller.jumpTo(
                        min(offset, _controller.position.maxScrollExtent)
                      );
                  }
                },
                child: SingleChildScrollView(
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    width: MetaGraph.width,
                    height: MetaGraph.height,
                    child: CustomPaint(
                      painter: PainterGraph(_offsets, _labels),
                    ),
                  ),
                ),
              ),
        ),
      ],
    );
  }

}
