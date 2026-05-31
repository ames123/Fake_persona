import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/button/button_widget.dart';
import '/pages/components/player_note_card/player_note_card_widget.dart';
import '/index.dart';
import 'player_notes_widget.dart' show PlayerNotesWidget;
import 'package:flutter/material.dart';

class PlayerNotesModel extends FlutterFlowModel<PlayerNotesWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for PlayerNoteCard.
  late PlayerNoteCardModel playerNoteCardModel1;
  // Model for PlayerNoteCard.
  late PlayerNoteCardModel playerNoteCardModel2;
  // Model for PlayerNoteCard.
  late PlayerNoteCardModel playerNoteCardModel3;
  // Model for PlayerNoteCard.
  late PlayerNoteCardModel playerNoteCardModel4;
  // Model for Button.
  late ButtonModel buttonModel1;
  // Model for Button.
  late ButtonModel buttonModel2;

  @override
  void initState(BuildContext context) {
    playerNoteCardModel1 = createModel(context, () => PlayerNoteCardModel());
    playerNoteCardModel2 = createModel(context, () => PlayerNoteCardModel());
    playerNoteCardModel3 = createModel(context, () => PlayerNoteCardModel());
    playerNoteCardModel4 = createModel(context, () => PlayerNoteCardModel());
    buttonModel1 = createModel(context, () => ButtonModel());
    buttonModel2 = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    playerNoteCardModel1.dispose();
    playerNoteCardModel2.dispose();
    playerNoteCardModel3.dispose();
    playerNoteCardModel4.dispose();
    buttonModel1.dispose();
    buttonModel2.dispose();
  }
}
