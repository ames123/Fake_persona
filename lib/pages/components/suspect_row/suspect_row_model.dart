import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/button/button_widget.dart';
import 'suspect_row_widget.dart' show SuspectRowWidget;
import 'package:flutter/material.dart';

class SuspectRowModel extends FlutterFlowModel<SuspectRowWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for Button.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    buttonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    buttonModel.dispose();
  }
}
