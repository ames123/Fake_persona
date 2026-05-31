import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/action_card/action_card_widget.dart';
import '/pages/components/button/button_widget.dart';
import '/pages/components/text_field/text_field_widget.dart';
import 'lobby_entry_widget.dart' show LobbyEntryWidget;
import 'package:flutter/material.dart';

class LobbyEntryModel extends FlutterFlowModel<LobbyEntryWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for ActionCard.
  late ActionCardModel actionCardModel1;
  // Model for ActionCard.
  late ActionCardModel actionCardModel2;
  // Model for TextField.
  late TextFieldModel aliasTextFieldModel;
  // Model for TextField.
  late TextFieldModel textFieldModel;
  // Model for Button.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    actionCardModel1 = createModel(context, () => ActionCardModel());
    actionCardModel2 = createModel(context, () => ActionCardModel());
    aliasTextFieldModel = createModel(context, () => TextFieldModel());
    textFieldModel = createModel(context, () => TextFieldModel());
    buttonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    actionCardModel1.dispose();
    actionCardModel2.dispose();
    aliasTextFieldModel.dispose();
    textFieldModel.dispose();
    buttonModel.dispose();
  }
}
