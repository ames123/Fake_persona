import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/button/button_widget.dart';
import '/pages/components/result_card/result_card_widget.dart';
import 'game_results_widget.dart' show GameResultsWidget;
import 'package:flutter/material.dart';

class GameResultsModel extends FlutterFlowModel<GameResultsWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for ResultCard.
  late ResultCardModel resultCardModel1;
  // Model for ResultCard.
  late ResultCardModel resultCardModel2;
  // Model for ResultCard.
  late ResultCardModel resultCardModel3;
  // Model for ResultCard.
  late ResultCardModel resultCardModel4;
  // Model for Button.
  late ButtonModel buttonModel1;
  // Model for Button.
  late ButtonModel buttonModel2;

  @override
  void initState(BuildContext context) {
    resultCardModel1 = createModel(context, () => ResultCardModel());
    resultCardModel2 = createModel(context, () => ResultCardModel());
    resultCardModel3 = createModel(context, () => ResultCardModel());
    resultCardModel4 = createModel(context, () => ResultCardModel());
    buttonModel1 = createModel(context, () => ButtonModel());
    buttonModel2 = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    resultCardModel1.dispose();
    resultCardModel2.dispose();
    resultCardModel3.dispose();
    resultCardModel4.dispose();
    buttonModel1.dispose();
    buttonModel2.dispose();
  }
}
