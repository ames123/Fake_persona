import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/button/button_widget.dart';
import 'room_waiting_area_widget.dart' show RoomWaitingAreaWidget;
import 'package:flutter/material.dart';

class RoomWaitingAreaModel extends FlutterFlowModel<RoomWaitingAreaWidget> {
  ///  State fields for stateful widgets in this page.

  // Zostawiamy tylko modele dla przycisków akcji na dole ekranu
  late ButtonModel buttonModel1;
  late ButtonModel buttonModel2;

  @override
  void initState(BuildContext context) {
    // Inicjalizujemy tylko to, co jest stałe na ekranie
    buttonModel1 = createModel(context, () => ButtonModel());
    buttonModel2 = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    buttonModel1.dispose();
    buttonModel2.dispose();
  }
}
