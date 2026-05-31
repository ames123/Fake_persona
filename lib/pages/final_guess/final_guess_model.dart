import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/button/button_widget.dart';
import '/pages/components/guess_row/guess_row_widget.dart';
import 'final_guess_widget.dart' show FinalGuessWidget;
import 'package:flutter/material.dart';

class FinalGuessModel extends FlutterFlowModel<FinalGuessWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for GuessRow.
  late GuessRowModel guessRowModel1;
  // Model for GuessRow.
  late GuessRowModel guessRowModel2;
  // Model for GuessRow.
  late GuessRowModel guessRowModel3;
  // Model for GuessRow.
  late GuessRowModel guessRowModel4;
  // Model for Button.
  late ButtonModel buttonModel1;
  // Model for Button.
  late ButtonModel buttonModel2;

  @override
  void initState(BuildContext context) {
    guessRowModel1 = createModel(context, () => GuessRowModel());
    guessRowModel2 = createModel(context, () => GuessRowModel());
    guessRowModel3 = createModel(context, () => GuessRowModel());
    guessRowModel4 = createModel(context, () => GuessRowModel());
    buttonModel1 = createModel(context, () => ButtonModel());
    buttonModel2 = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    guessRowModel1.dispose();
    guessRowModel2.dispose();
    guessRowModel3.dispose();
    guessRowModel4.dispose();
    buttonModel1.dispose();
    buttonModel2.dispose();
  }
}
