import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'result_card_model.dart';
export 'result_card_model.dart';

class ResultCardWidget extends StatefulWidget {
  const ResultCardWidget({
    super.key,
    String? initials,
    String? name,
    String? points, // Pozostawione dla kompatybilności wstecznej
    String? role, // Pozostawione dla kompatybilności wstecznej
    bool? isWinner,
  })  : initials = initials ?? 'AR',
        name = name ?? 'Alex Rivera',
        points = points ?? '1,250',
        role = role ?? 'Lead Detective',
        isWinner = isWinner ?? true;

  final String initials;
  final String name;
  final String points;
  final String role;
  final bool isWinner;

  @override
  State<ResultCardWidget> createState() => _ResultCardWidgetState();
}

class _ResultCardWidgetState extends State<ResultCardWidget> {
  late ResultCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ResultCardModel());
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
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(24.0),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: widget.isWinner
              ? FlutterFlowTheme.of(context).primary
              : FlutterFlowTheme.of(context).alternate,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 60.0,
                height: 60.0,
                child: Stack(
                  alignment: const AlignmentDirectional(-1.0, -1.0),
                  children: [
                    Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: widget.isWinner
                            ? FlutterFlowTheme.of(context).primary
                            : FlutterFlowTheme.of(context).surfaceVariant,
                        borderRadius: BorderRadius.circular(20.0),
                        shape: BoxShape.rectangle,
                      ),
                      alignment: const AlignmentDirectional(0.0, 0.0),
                      child: Text(
                        valueOrDefault<String>(
                          widget.initials,
                          'AR',
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: FlutterFlowTheme.of(context)
                            .labelMedium
                            .override(
                              font: GoogleFonts.spaceGrotesk(
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
                              color: widget.isWinner
                                  ? FlutterFlowTheme.of(context).onPrimary
                                  : FlutterFlowTheme.of(context).primaryText,
                              fontSize: 22.8,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              lineHeight: 1.2,
                            ),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    if (valueOrDefault<bool>(
                      widget.isWinner,
                      true,
                    ))
                      Align(
                        alignment: const AlignmentDirectional(1.0, 1.0),
                        child: Container(
                          width: 24.0,
                          height: 24.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).tertiary,
                            borderRadius: BorderRadius.circular(9999.0),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              width: 2.0,
                            ),
                          ),
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: Icon(
                            Icons.help,
                            color: FlutterFlowTheme.of(context).onAccent,
                            size: 14.0,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment
                      .start, // Zmieniono na start dla lepszego wyrównania tekstu
                  children: [
                    Text(
                      valueOrDefault<String>(
                        widget.name,
                        'Alex Rivera',
                      ),
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            font: GoogleFonts.urbanist(
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            lineHeight: 1.3,
                          ),
                    ),
                    // USUNIĘTO widget.role Text
                  ],
                ),
              ),
              // USUNIĘTO całą kolumnę z widget.points oraz napisem 'PTS'
            ],
          ),
        ),
      ),
    );
  }
}
