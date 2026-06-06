import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/button/button_widget.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'suspect_row_model.dart';
export 'suspect_row_model.dart';

class SuspectRowWidget extends StatefulWidget {
  const SuspectRowWidget({
    super.key,
    Color? accentBg,
    String? initials,
    String? profileName,
    bool? assignedNick,
  })  : accentBg = accentBg ?? const Color(0x00000000),
        initials = initials ?? 'CH',
        profileName = profileName ?? 'The Chef',
        assignedNick = assignedNick ?? false;

  final Color accentBg;
  final String initials;
  final String profileName;
  final bool assignedNick;

  @override
  State<SuspectRowWidget> createState() => _SuspectRowWidgetState();
}

class _SuspectRowWidgetState extends State<SuspectRowWidget> {
  late SuspectRowModel _model;
  String? _selectedNickname;
  final List<String> _playerNicknames = const [
    'Cichy Lis',
    'Nocny Sowa',
    'Srebrny Strzał',
    'Biały Cień',
  ];

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SuspectRowModel());
    _selectedNickname = widget.assignedNick ? 'Gracz' : null;
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
          color: FlutterFlowTheme.of(context).alternate,
          width: 1.0,
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
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: valueOrDefault<Color>(
                    widget.accentBg,
                    FlutterFlowTheme.of(context).secondary,
                  ),
                  shape: BoxShape.circle,
                ),
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Text(
                  valueOrDefault<String>(
                    widget.initials,
                    'K',
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
                        color: FlutterFlowTheme.of(context).onSurface,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      valueOrDefault<String>(
                        widget.profileName,
                        'Kucharz',
                      ),
                      style: FlutterFlowTheme.of(context).titleSmall.override(
                            font: GoogleFonts.urbanist(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontStyle,
                            lineHeight: 1.3,
                          ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        final selected = await showModalBottomSheet<String>(
                          context: context,
                          builder: (bottomSheetContext) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16.0,
                                horizontal: 8.0,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 8.0,
                                    ),
                                    child: Text(
                                      'Wybierz nick gracza',
                                      style: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            font: GoogleFonts.urbanist(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                  ..._playerNicknames.map(
                                    (nick) => ListTile(
                                      title: Text(nick),
                                      trailing: _selectedNickname == nick
                                          ? const Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            )
                                          : null,
                                      onTap: () {
                                        Navigator.pop(bottomSheetContext, nick);
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                ],
                              ),
                            );
                          },
                        );

                        if (selected != null) {
                          setState(() {
                            _selectedNickname = selected;
                          });
                        }
                      },
                      child: wrapWithModel(
                        model: _model.buttonModel,
                        updateCallback: () => safeSetState(() {}),
                        child: ButtonWidget(
                          content: _selectedNickname != null
                              ? '$_selectedNickname'
                              : 'Przypisz gracza',
                          icon: Icon(
                            Icons.person_add_rounded,
                            color: FlutterFlowTheme.of(context).primary,
                            size: 16.0,
                          ),
                          iconPresent: true,
                          iconEndPresent: false,
                          variant: 'ghost',
                          size: 'small',
                          fullWidth: false,
                          loading: false,
                          disabled: false,
                        ),
                      ),
                    ),
                  ].divide(const SizedBox(height: 4.0)),
                ),
              ),
              FlutterFlowIconButton(
                borderRadius: 8.0,
                buttonSize: 40.0,
                fillColor: Colors.transparent,
                icon: Icon(
                  Icons.edit_note_rounded,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 24.0,
                ),
                onPressed: () async {
                  context.goNamed(PlayerNotesWidget.routeName);
                },
              ),
            ].divide(const SizedBox(width: 16.0)),
          ),
        ),
      ),
    );
  }
}
