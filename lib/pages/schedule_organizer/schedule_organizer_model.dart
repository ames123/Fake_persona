import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/button/button_widget.dart';
import '/pages/components/time_slot2/time_slot2_widget.dart';
import 'schedule_organizer_widget.dart' show ScheduleOrganizerWidget;
import 'package:flutter/material.dart';

class ScheduleOrganizerModel extends FlutterFlowModel<ScheduleOrganizerWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for TimeSlot2.
  late TimeSlot2Model timeSlot2Model1;
  // Model for TimeSlot2.
  late TimeSlot2Model timeSlot2Model2;
  // Model for TimeSlot2.
  late TimeSlot2Model timeSlot2Model3;
  // Model for TimeSlot2.
  late TimeSlot2Model timeSlot2Model4;
  // Model for TimeSlot2.
  late TimeSlot2Model timeSlot2Model5;
  // Model for TimeSlot2.
  late TimeSlot2Model timeSlot2Model6;
  // Model for Button.
  late ButtonModel buttonModel1;
  // Model for Button.
  late ButtonModel buttonModel2;
  // Model for Button.
  late ButtonModel buttonModel3;

  @override
  void initState(BuildContext context) {
    timeSlot2Model1 = createModel(context, () => TimeSlot2Model());
    timeSlot2Model2 = createModel(context, () => TimeSlot2Model());
    timeSlot2Model3 = createModel(context, () => TimeSlot2Model());
    timeSlot2Model4 = createModel(context, () => TimeSlot2Model());
    timeSlot2Model5 = createModel(context, () => TimeSlot2Model());
    timeSlot2Model6 = createModel(context, () => TimeSlot2Model());
    buttonModel1 = createModel(context, () => ButtonModel());
    buttonModel2 = createModel(context, () => ButtonModel());
    buttonModel3 = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    timeSlot2Model1.dispose();
    timeSlot2Model2.dispose();
    timeSlot2Model3.dispose();
    timeSlot2Model4.dispose();
    timeSlot2Model5.dispose();
    timeSlot2Model6.dispose();
    buttonModel1.dispose();
    buttonModel2.dispose();
    buttonModel3.dispose();
  }
}
