import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'time_slot_model.dart';
export 'time_slot_model.dart';

class TimeSlotWidget extends StatefulWidget {
  const TimeSlotWidget({
    super.key,
    this.icon,
    String? task,
    String? timeLabel,
    this.editable = false,
  })  : task = task ?? 'Maintenance Check: Pool Area',
        timeLabel = timeLabel ?? 'MORNING (08:00 - 11:00)';

  final Widget? icon;
  final String task;
  final String timeLabel;
  final bool editable;

  @override
  State<TimeSlotWidget> createState() => _TimeSlotWidgetState();
}

class _TimeSlotWidgetState extends State<TimeSlotWidget> {
  late TimeSlotModel _model;
  late TextEditingController _taskController;
  late TextEditingController _timeLabelController;

  Future<void> _editField(
    BuildContext context,
    TextEditingController controller,
    String title,
  ) async {
    final controllerCopy = TextEditingController(text: controller.text);
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: TextFormField(
            controller: controllerCopy,
            autofocus: true,
            decoration: InputDecoration(
              hintText: title,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      setState(() {
        controller.text = controllerCopy.text.trim();
      });
    }
  }

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TimeSlotModel());
    _taskController = TextEditingController(text: widget.task);
    _timeLabelController = TextEditingController(text: widget.timeLabel);
  }

  @override
  void dispose() {
    _taskController.dispose();
    _timeLabelController.dispose();
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        boxShadow: [
          BoxShadow(
            blurRadius: 12.0,
            color: FlutterFlowTheme.of(context).primary8,
            offset: const Offset(
              0.0,
              4.0,
            ),
            spreadRadius: 0.0,
          )
        ],
        borderRadius: BorderRadius.circular(24.0),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 48.0,
              height: 48.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primary10,
                borderRadius: BorderRadius.circular(16.0),
                shape: BoxShape.rectangle,
              ),
              alignment: const AlignmentDirectional(0.0, 0.0),
              child: widget.icon!,
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: widget.editable
                        ? () => _editField(
                              context,
                              _timeLabelController,
                              'Edit time window',
                            )
                        : null,
                    child: Text(
                      valueOrDefault<String>(
                        _timeLabelController.text,
                        'MORNING (08:00 - 11:00)',
                      ),
                      style: FlutterFlowTheme.of(context).labelSmall.override(
                            font: GoogleFonts.spaceGrotesk(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .labelSmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelSmall
                                  .fontStyle,
                            ),
                            color: widget.editable
                                ? FlutterFlowTheme.of(context).primary
                                : FlutterFlowTheme.of(context).secondaryText,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .labelSmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .labelSmall
                                .fontStyle,
                            lineHeight: 1.2,
                          ),
                    ),
                  ),
                  InkWell(
                    onTap: widget.editable
                        ? () => _editField(
                              context,
                              _taskController,
                              'Edit task',
                            )
                        : null,
                    child: Text(
                      valueOrDefault<String>(
                        _taskController.text,
                        'Maintenance Check: Pool Area',
                      ),
                      style: FlutterFlowTheme.of(context).titleSmall.override(
                            font: GoogleFonts.urbanist(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontStyle,
                            lineHeight: 1.3,
                          ),
                    ),
                  ),
                ].divide(const SizedBox(height: 4.0)),
              ),
            ),
            Icon(
              Icons.drag_indicator_rounded,
              color: FlutterFlowTheme.of(context).secondaryText40,
              size: 20.0,
            ),
          ].divide(const SizedBox(width: 16.0)),
        ),
      ),
    );
  }
}
