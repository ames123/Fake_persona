import '/flutter_flow/flutter_flow_theme.dart';

import '/flutter_flow/flutter_flow_util.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'schedule_item_model.dart';

export 'schedule_item_model.dart';

class ScheduleItemWidget extends StatefulWidget {
  const ScheduleItemWidget({
    super.key,
    String? activity,
    Color? color,
    String? time,
    this.leadingIcon,
    this.period,
  })  : activity = activity ?? 'Kitchen Prep',
        color = color ?? const Color(0x00000000),
        time = time ?? '',
        super();

  final String activity;

  final Color color;

  final String time;

  final IconData? leadingIcon;

  final String? period;

  @override
  State<ScheduleItemWidget> createState() => _ScheduleItemWidgetState();
}

class _ScheduleItemWidgetState extends State<ScheduleItemWidget> {
  late ScheduleItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);

    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();

    _model = createModel(context, () => ScheduleItemModel());
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
        color: FlutterFlowTheme.of(context).surfaceVariant40,
        borderRadius: BorderRadius.circular(12.0),
        shape: BoxShape.rectangle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment
                .end, // Obniża ikonę do poziomu ostatniej linii tekstów
            children: [
              if (widget.leadingIcon != null)
                Padding(
                  padding: const EdgeInsets.only(
                      right: 8.0,
                      bottom:
                          4.0), // bottom: 4.0 dopasowuje ikonę idealnie do dołu
                  child: Icon(
                    widget.leadingIcon,
                    color: FlutterFlowTheme.of(context)
                        .secondaryText, // Przywrócony oryginalny kolor
                    size: 20.0,
                  ),
                ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment
                      .center, // Środkowanie tekstów w poziomie
                  children: [
                    if (widget.period != null)
                      Text(
                        widget.period!,
                        textAlign:
                            TextAlign.center, // Środkowanie tekstu okresu
                        style: FlutterFlowTheme.of(context).labelSmall.override(
                              font: GoogleFonts.spaceGrotesk(
                                fontWeight: FontWeight.w800,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelSmall
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).primary,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w800,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelSmall
                                  .fontStyle,
                              lineHeight: 1.2,
                            ),
                      ),
                    Text(
                      valueOrDefault<String>(widget.activity, 'Kitchen Prep'),
                      textAlign:
                          TextAlign.center, // Środkowanie tekstu aktywności
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            font: GoogleFonts.urbanist(
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontStyle,
                            lineHeight: 1.4,
                          ),
                    ),
                  ].divide(const SizedBox(height: 4.0)),
                ),
              ),
              // Pusty SizedBox o szerokości ikony (20px) + paddingu (8px),
              // aby teksty były idealnie na środku całego kafelka, a nie przesunięte przez ikonę.
              if (widget.leadingIcon != null) const SizedBox(width: 28.0),
            ],
          ),
        ),
      ),
    );
  }
}
