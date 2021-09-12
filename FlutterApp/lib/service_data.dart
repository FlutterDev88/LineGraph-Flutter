import 'dart:async';
import 'dart:convert';

import 'package:line_graph/env_conf.dart';
import 'package:line_graph/model_score.dart';
import 'package:line_graph/service_http.dart';

class ServiceData {

  static Future<List<ModelScore>> getScores() async {
    final url = '${EnvConf.URL_BASE}/getScores';

    final response = await ServiceHttp.get(url);
    if (!ServiceHttp.checkResponse(response))
      return null;

    final jsonScores = json.decode(response.body)['scores'];
    List<ModelScore> scores = [];
    for (var item in jsonScores) {
      final mapScore = item as Map<String, dynamic>;
      final score = ModelScore.fromDict(mapScore);
      scores.add(score);
    }

    return scores;
  }

}