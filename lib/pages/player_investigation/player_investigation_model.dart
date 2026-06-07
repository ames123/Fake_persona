import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/button/button_widget.dart';
import '/pages/components/profile_tab/profile_tab_widget.dart';
import '/pages/components/schedule_item/schedule_item_widget.dart';
import '/pages/components/suspect_row/suspect_row_widget.dart';
import 'player_investigation_widget.dart' show PlayerInvestigationWidget;
import 'package:flutter/material.dart';
import '/pages/components/guess_row/guess_row_model.dart';

class PlayerInvestigationModel
    extends FlutterFlowModel<PlayerInvestigationWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for Button.
  late ButtonModel buttonModel1;
  // Model for ProfileTab.
  late ProfileTabModel profileTabModel1;
  // Model for ProfileTab.
  late ProfileTabModel profileTabModel2;
  // Model for ProfileTab.
  late ProfileTabModel profileTabModel3;
  // Model for ProfileTab.
  late ProfileTabModel profileTabModel4;
  // Model for ScheduleItem.
  late ScheduleItemModel scheduleItemModel1;
  // Model for ScheduleItem.
  late ScheduleItemModel scheduleItemModel2;
  // Model for ScheduleItem.
  late ScheduleItemModel scheduleItemModel3;
  // Model for ScheduleItem.
  late ScheduleItemModel scheduleItemModel4;
  // Model for ScheduleItem.
  late ScheduleItemModel scheduleItemModel5;
  // Model for SuspectRow.
  late SuspectRowModel suspectRowModel1;
  // Model for SuspectRow.
  late SuspectRowModel suspectRowModel2;
  // Model for SuspectRow.
  late SuspectRowModel suspectRowModel3;
  // Model for SuspectRow.
  late SuspectRowModel suspectRowModel4;
  // Model for Button.
  late ButtonModel buttonModel2;
  // Model for Button.
  late ButtonModel buttonModel3;
  late GuessRowModel guessRowModel1;
  late GuessRowModel guessRowModel2;
  late GuessRowModel guessRowModel3;
  late GuessRowModel guessRowModel4;

  @override
  void initState(BuildContext context) {
    buttonModel1 = createModel(context, () => ButtonModel());
    profileTabModel1 = createModel(context, () => ProfileTabModel());
    profileTabModel2 = createModel(context, () => ProfileTabModel());
    profileTabModel3 = createModel(context, () => ProfileTabModel());
    profileTabModel4 = createModel(context, () => ProfileTabModel());
    scheduleItemModel1 = createModel(context, () => ScheduleItemModel());
    scheduleItemModel2 = createModel(context, () => ScheduleItemModel());
    scheduleItemModel3 = createModel(context, () => ScheduleItemModel());
    scheduleItemModel4 = createModel(context, () => ScheduleItemModel());
    scheduleItemModel5 = createModel(context, () => ScheduleItemModel());
    suspectRowModel1 = createModel(context, () => SuspectRowModel());
    suspectRowModel2 = createModel(context, () => SuspectRowModel());
    suspectRowModel3 = createModel(context, () => SuspectRowModel());
    suspectRowModel4 = createModel(context, () => SuspectRowModel());
    buttonModel2 = createModel(context, () => ButtonModel());
    buttonModel3 = createModel(context, () => ButtonModel());
    guessRowModel1 = createModel(context, () => GuessRowModel());
    guessRowModel2 = createModel(context, () => GuessRowModel());
    guessRowModel3 = createModel(context, () => GuessRowModel());
    guessRowModel4 = createModel(context, () => GuessRowModel());
  }

  @override
  void dispose() {
    buttonModel1.dispose();
    profileTabModel1.dispose();
    profileTabModel2.dispose();
    profileTabModel3.dispose();
    profileTabModel4.dispose();
    scheduleItemModel1.dispose();
    scheduleItemModel2.dispose();
    scheduleItemModel3.dispose();
    scheduleItemModel4.dispose();
    scheduleItemModel5.dispose();
    suspectRowModel1.dispose();
    suspectRowModel2.dispose();
    suspectRowModel3.dispose();
    suspectRowModel4.dispose();
    buttonModel2.dispose();
    buttonModel3.dispose();
    guessRowModel1.dispose();
    guessRowModel2.dispose();
    guessRowModel3.dispose();
    guessRowModel4.dispose();
  }
}
