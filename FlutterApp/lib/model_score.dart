import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ModelScore {
  DateTime date;
  int score;

  ModelScore(DateTime date, int score) {
    this.date = DateUtils.dateOnly(date);
    this.score = score;
  }

  static ModelScore fromDict(Map<String, dynamic> map) {
    if (map == null) {
      return null;
    }
    if (!map.containsKey('date'))
      return null;
    if (!map.containsKey('score'))
      return null;

    final format = DateFormat('yyyy-MM-dd');
    final date = format.parse(map['date'] as String);
    final score = map['score'] as int;

    return ModelScore(date, score);
  }


  static ModelScore fromJson(String source) =>
    fromDict(json.decode(source));

}
