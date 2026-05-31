import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/button/button_widget.dart';
import '/pages/components/time_slot/time_slot_widget.dart';
import '/index.dart';
import 'current_task_view_widget.dart' show CurrentTaskViewWidget;
import 'package:flutter/material.dart';

class CurrentTaskViewModel extends FlutterFlowModel<CurrentTaskViewWidget> {
  ///  State fields for stateful widgets in this page.

  // Modele stanów dla komponentów harmonogramu z ProfileSetup
  late TimeSlotModel timeSlotModel1;
  late TimeSlotModel timeSlotModel2;
  late TimeSlotModel timeSlotModel3;
  late TimeSlotModel timeSlotModel4;
  late TimeSlotModel timeSlotModel5;

  late ButtonModel buttonModel1;
  late ButtonModel buttonModel2;

  @override
  void initState(BuildContext context) {
    timeSlotModel1 = createModel(context, () => TimeSlotModel());
    timeSlotModel2 = createModel(context, () => TimeSlotModel());
    timeSlotModel3 = createModel(context, () => TimeSlotModel());
    timeSlotModel4 = createModel(context, () => TimeSlotModel());
    timeSlotModel5 = createModel(context, () => TimeSlotModel());

    buttonModel1 = createModel(context, () => ButtonModel());
    buttonModel2 = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    timeSlotModel1.dispose();
    timeSlotModel2.dispose();
    timeSlotModel3.dispose();
    timeSlotModel4.dispose();
    timeSlotModel5.dispose();

    buttonModel1.dispose();
    buttonModel2.dispose();
  }
}
