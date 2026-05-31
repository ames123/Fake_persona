import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'schedule_block_model.dart';
export 'schedule_block_model.dart';

class ScheduleBlockWidget extends StatefulWidget {
  const ScheduleBlockWidget({
    super.key,
    Color? color,
    String? location,
    String? task,
    bool? active,
    bool? done,
  })  : color = color ?? const Color(0x00000000),
        location = location ?? 'Hotel Gym',
        task = task ?? 'Morning Workout',
        active = active ?? true,
        done = done ?? false;

  final Color color;
  final String location;
  final String task;
  final bool active;
  final bool done;

  @override
  State<ScheduleBlockWidget> createState() => _ScheduleBlockWidgetState();
}

class _ScheduleBlockWidgetState extends State<ScheduleBlockWidget> {
  late ScheduleBlockModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ScheduleBlockModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.active
            ? FlutterFlowTheme.of(context).tertiary
            : FlutterFlowTheme.of(context).surfaceVariant30,
        borderRadius: BorderRadius.circular(24.0),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: widget.active
              ? FlutterFlowTheme.of(context).tertiary
              : FlutterFlowTheme.of(context).outline20,
          width: widget.active ? 1.0 : 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 4.0,
                height: 32.0,
                decoration: BoxDecoration(
                  color: valueOrDefault<Color>(
                    widget.color,
                    FlutterFlowTheme.of(context).primary,
                  ),
                  borderRadius: BorderRadius.circular(9999.0),
                  shape: BoxShape.rectangle,
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      valueOrDefault<String>(
                        widget.task,
                        'Morning Workout',
                      ),
                      style: FlutterFlowTheme.of(context).labelLarge.override(
                            font: GoogleFonts.spaceGrotesk(
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelLarge
                                  .fontStyle,
                            ),
                            color: widget.active
                                ? FlutterFlowTheme.of(context).onAccent
                                : FlutterFlowTheme.of(context).primaryText,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FlutterFlowTheme.of(context)
                                .labelLarge
                                .fontStyle,
                            lineHeight: 1.2,
                          ),
                    ),
                    Text(
                      valueOrDefault<String>(
                        widget.location,
                        'Hotel Gym',
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
                            color: widget.active
                                ? FlutterFlowTheme.of(context).onAccent80
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
                  ].divide(const SizedBox(height: 4.0)),
                ),
              ),
              SizedBox(
                width: 20.0,
                height: 20.0,
                child: Stack(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  children: [
                    if (widget.done ? true : false)
                      Icon(
                        Icons.check_circle_rounded,
                        color: widget.active
                            ? FlutterFlowTheme.of(context).onAccent
                            : const Color(0x00000000),
                        size: 20.0,
                      ),
                    if (widget.done ? false : true)
                      Icon(
                        Icons.radio_button_unchecked_rounded,
                        color: widget.active
                            ? FlutterFlowTheme.of(context).onAccent
                            : const Color(0x00000000),
                        size: 20.0,
                      ),
                  ],
                ),
              ),
            ].divide(const SizedBox(width: 16.0)),
          ),
        ),
      ),
    );
  }
}
