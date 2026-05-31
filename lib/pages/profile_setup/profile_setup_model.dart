import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/button/button_widget.dart';
import '/pages/components/time_slot/time_slot_widget.dart';
import 'profile_setup_widget.dart' show ProfileSetupWidget;
import 'package:flutter/material.dart';

class ProfileSetupModel extends FlutterFlowModel<ProfileSetupWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for TimeSlot.
  late TimeSlotModel timeSlotModel1;
  // Model for TimeSlot.
  late TimeSlotModel timeSlotModel2;
  // Model for TimeSlot.
  late TimeSlotModel timeSlotModel3;
  // Model for TimeSlot.
  late TimeSlotModel timeSlotModel4;
  // Model for TimeSlot.
  late TimeSlotModel timeSlotModel5;
  // Model for Button.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    timeSlotModel1 = createModel(context, () => TimeSlotModel());
    timeSlotModel2 = createModel(context, () => TimeSlotModel());
    timeSlotModel3 = createModel(context, () => TimeSlotModel());
    timeSlotModel4 = createModel(context, () => TimeSlotModel());
    timeSlotModel5 = createModel(context, () => TimeSlotModel());
    buttonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    timeSlotModel1.dispose();
    timeSlotModel2.dispose();
    timeSlotModel3.dispose();
    timeSlotModel4.dispose();
    timeSlotModel5.dispose();
    buttonModel.dispose();
  }
}
