import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/button/button_widget.dart';
// DODANO: Import modelu karty notatek, aby typ był znany kompilatorowi
import '/pages/components/player_note_card/player_note_card_model.dart';
import '/index.dart';
import 'player_notes_widget.dart' show PlayerNotesWidget;
import 'package:flutter/material.dart';

class PlayerNotesModel extends FlutterFlowModel<PlayerNotesWidget> {
  ///  State fields for stateful widgets in this page.

  // Zostawiamy po jednej instancji dla przycisków dolnych, jeśli FlutterFlow ich wymaga
  late ButtonModel buttonModel1;
  late ButtonModel buttonModel2;

  @override
  void initState(BuildContext context) {
    buttonModel1 = createModel(context, () => ButtonModel());
    buttonModel2 = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    buttonModel1.dispose();
    buttonModel2.dispose();
  }
}
