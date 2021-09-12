
import 'package:flutter/material.dart';
import 'package:line_graph/model_score.dart';
import 'package:line_graph/service_data.dart';


class NotifierData extends ChangeNotifier {

  List<ModelScore> scores;
  bool  isLoading = false;


  NotifierData(): super();


  Future<void> getScores() async {
    isLoading = true;
    try {
      scores = await ServiceData.getScores();
      if (scores != null)
        notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
    isLoading = false;
  }

}
