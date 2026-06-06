import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'guess_row_model.dart';
export 'guess_row_model.dart';

class GuessRowWidget extends StatefulWidget {
  const GuessRowWidget({
    super.key,
    Color? color,
    String? initials,
    String? nicknames,
    String? profileName,
    String? scheduleHint,
    bool? duplicateProfession,
    this.onProfessionChanged,
  })  : color = color ?? const Color(0x00000000),
        initials = initials ?? 'JS',
        nicknames = nicknames ?? 'Alex Rivera,Jordan Smith,Casey V.,Taylor P.',
        profileName = profileName ?? 'Kucharz',
        scheduleHint = scheduleHint ?? '',
        duplicateProfession = duplicateProfession ?? false;

  final Color color;
  final String initials;
  final String nicknames;
  final String profileName;
  final String scheduleHint;
  final bool duplicateProfession;
  final ValueChanged<String?>? onProfessionChanged;

  @override
  State<GuessRowWidget> createState() => _GuessRowWidgetState();
}

class _GuessRowWidgetState extends State<GuessRowWidget> {
  late GuessRowModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GuessRowModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final professionOptions = widget.nicknames
        .split(',')
        .map((option) => option.trim())
        .where((option) => option.isNotEmpty)
        .toList();
    final assignedProfession = _model.dropdownValue;

    return Container(
      decoration: BoxDecoration(
        color: widget.duplicateProfession
            ? FlutterFlowTheme.of(context).error.withOpacity(0.08)
            : FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(9999.0),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: widget.duplicateProfession
              ? FlutterFlowTheme.of(context).error
              : FlutterFlowTheme.of(context).alternate,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: valueOrDefault<Color>(
                    widget.color,
                    FlutterFlowTheme.of(context).primary,
                  ),
                  shape: BoxShape.circle,
                ),
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Text(
                  valueOrDefault<String>(
                    widget.initials,
                    'JS',
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: FlutterFlowTheme.of(context).labelMedium.override(
                        font: GoogleFonts.spaceGrotesk(
                          fontWeight: FontWeight.w600,
                          fontStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 15.2,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).labelMedium.fontStyle,
                        lineHeight: 1.2,
                      ),
                  overflow: TextOverflow.clip,
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      valueOrDefault<String>(
                        widget.profileName,
                        'Pisarz',
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.urbanist(
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                            lineHeight: 1.5,
                          ),
                    ),
                    Text(
                      assignedProfession != null &&
                              assignedProfession.isNotEmpty
                          ? 'Zawód: $assignedProfession'
                          : 'Dostosuj profil',
                      style: FlutterFlowTheme.of(context).labelSmall.override(
                            font: GoogleFonts.spaceGrotesk(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .labelSmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelSmall
                                  .fontStyle,
                            ),
                            color: assignedProfession != null &&
                                    assignedProfession.isNotEmpty
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
                  ].divide(const SizedBox(height: 4.0)),
                ),
              ),
              SizedBox(
                width: 160.0,
                child: FlutterFlowDropDown<String>(
                  controller: _model.dropdownValueController ??=
                      FormFieldController<String>(
                    _model.dropdownValue ??= '',
                  ),
                  options: professionOptions,
                  onChanged: (val) {
                    safeSetState(() => _model.dropdownValue = val);
                    widget.onProfessionChanged?.call(val);
                  },
                  width: 200.0,
                  height: 40.0,
                  textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.urbanist(
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primaryText,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        lineHeight: 1.5,
                      ),
                  hintText: 'Dostosuj profil',
                  icon: Icon(
                    Icons.arrow_drop_down_rounded,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 24.0,
                  ),
                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                  elevation: 2.0,
                  borderColor: FlutterFlowTheme.of(context).alternate,
                  borderWidth: 1.0,
                  borderRadius: 9999.0,
                  margin: const EdgeInsetsDirectional.fromSTEB(
                      16.0, 0.0, 16.0, 0.0),
                  hidesUnderline: true,
                  isOverButton: false,
                  isSearchable: false,
                  isMultiSelect: false,
                ),
              ),
            ].divide(const SizedBox(width: 16.0)),
          ),
        ),
      ),
    );
  }
}
