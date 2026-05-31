import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/button/button_widget.dart';
import '/pages/components/player_card/player_card_widget.dart';
import 'room_waiting_area_widget.dart' show RoomWaitingAreaWidget;
import 'package:flutter/material.dart';

class RoomWaitingAreaModel extends FlutterFlowModel<RoomWaitingAreaWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for PlayerCard.
  late PlayerCardModel playerCardModel1;
  // Model for PlayerCard.
  late PlayerCardModel playerCardModel2;
  // Model for PlayerCard.
  late PlayerCardModel playerCardModel3;
  // Model for PlayerCard.
  late PlayerCardModel playerCardModel4;
  // Model for Button.
  late ButtonModel buttonModel1;
  // Model for Button.
  late ButtonModel buttonModel2;

  @override
  void initState(BuildContext context) {
    playerCardModel1 = createModel(context, () => PlayerCardModel());
    playerCardModel2 = createModel(context, () => PlayerCardModel());
    playerCardModel3 = createModel(context, () => PlayerCardModel());
    playerCardModel4 = createModel(context, () => PlayerCardModel());
    buttonModel1 = createModel(context, () => ButtonModel());
    buttonModel2 = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    playerCardModel1.dispose();
    playerCardModel2.dispose();
    playerCardModel3.dispose();
    playerCardModel4.dispose();
    buttonModel1.dispose();
    buttonModel2.dispose();
  }
}
