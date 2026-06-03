import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/action_card/action_card_widget.dart';
import '/pages/components/button/button_widget.dart';
import '/pages/components/text_field/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'lobby_entry_model.dart';
export 'lobby_entry_model.dart';

class LobbyEntryWidget extends StatefulWidget {
  const LobbyEntryWidget({super.key});

  static String routeName = 'LobbyEntry';
  static String routePath = '/lobbyEntry';

  @override
  State<LobbyEntryWidget> createState() => _LobbyEntryWidgetState();
}

class _LobbyEntryWidgetState extends State<LobbyEntryWidget> {
  late LobbyEntryModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LobbyEntryModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primary10,
                          borderRadius: BorderRadius.circular(24.0),
                          shape: BoxShape.rectangle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(
                            Icons.help,
                            color: FlutterFlowTheme.of(context).onPrimary,
                            size: 48.0,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'FAKE',
                      style:
                          FlutterFlowTheme.of(context).headlineLarge.override(
                                font: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w900,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineLarge
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w900,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .headlineLarge
                                    .fontStyle,
                                lineHeight: 1.2,
                              ),
                    ),
                    Text(
                      'PERSONA',
                      style: FlutterFlowTheme.of(context)
                          .headlineLarge
                          .override(
                            font: GoogleFonts.poppins(
                              fontWeight: FontWeight.w900,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .headlineLarge
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).onBackground,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w900,
                            fontStyle: FlutterFlowTheme.of(context)
                                .headlineLarge
                                .fontStyle,
                            lineHeight: 1.2,
                          ),
                    ),
                    Text(
                      'Idealne życie. Perfekcyjne kłamstwo.',
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            font: GoogleFonts.urbanist(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).secondaryText,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontStyle,
                            lineHeight: 1.4,
                          ),
                    ),
                  ].divide(const SizedBox(height: 8.0)),
                ),
              ),
              Container(
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
                  padding: const EdgeInsets.all(24.0),
                  child: wrapWithModel(
                    model: _model.aliasTextFieldModel,
                    updateCallback: () => safeSetState(() {}),
                    child: const TextFieldWidget(
                      label: 'Nazwa gracza',
                      labelPresent: true,
                      helper: 'Musi być taka sama jak na pionku',
                      helperPresent: true,
                      hint: 'e.g. Shadow',
                      value: '',
                      onChange: '',
                      onSubmit: '',
                      leadingIcon: Icon(
                        Icons.fingerprint_rounded,
                      ),
                      leadingIconPresent: true,
                      trailingIconPresent: false,
                      variant: 'outlined',
                      error: false,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    wrapWithModel(
                      model: _model.actionCardModel1,
                      updateCallback: () => safeSetState(() {}),
                      child: ActionCardWidget(
                        bg: 'primary',
                        bgColor: FlutterFlowTheme.of(context).primary,
                        icon: Icon(
                          Icons.add_rounded,
                          color: FlutterFlowTheme.of(context).onPrimary,
                          size: 32.0,
                        ),
                        iconColor: FlutterFlowTheme.of(context).onPrimary,
                        onTap: 'navigate:RoomWaitingArea',
                        shadowColor: FlutterFlowTheme.of(context).primary25,
                        subtitle: 'Zacznij nowe śledzctwo',
                        title: 'Stwórz pokój',
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).surfaceVariant,
                  borderRadius: BorderRadius.circular(24.0),
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).alternate,
                    width: 1.0,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Dołącz do istniejącej gry',
                              style: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    font: GoogleFonts.urbanist(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                    lineHeight: 1.3,
                                  ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            wrapWithModel(
                              model: _model.textFieldModel,
                              updateCallback: () => safeSetState(() {}),
                              child: const TextFieldWidget(
                                label: 'Kod pokoju',
                                labelPresent: true,
                                helper: '',
                                helperPresent: false,
                                hint: ' e.g. XJ92',
                                value: '',
                                onChange: '',
                                onSubmit: '',
                                leadingIcon: Icon(
                                  Icons.vpn_key_rounded,
                                ),
                                leadingIconPresent: true,
                                trailingIconPresent: false,
                                variant: 'outlined',
                                error: false,
                              ),
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () => context.pushNamed('RoomWaitingArea'),
                              child: wrapWithModel(
                                model: _model.buttonModel,
                                updateCallback: () => safeSetState(() {}),
                                child: ButtonWidget(
                                  content: 'Dołącz do pokoju',
                                  icon: Icon(
                                    Icons.login_rounded,
                                    color:
                                        FlutterFlowTheme.of(context).onPrimary,
                                    size: 16.0,
                                  ),
                                  iconPresent: true,
                                  iconEndPresent: false,
                                  variant: 'primary',
                                  size: 'large',
                                  fullWidth: true,
                                  loading: false,
                                  disabled: false,
                                ),
                              ),
                            ),
                          ].divide(const SizedBox(height: 16.0)),
                        ),
                      ].divide(const SizedBox(height: 24.0)),
                    ),
                  ),
                ),
              ),
            ].divide(const SizedBox(height: 32.0)),
          ),
        ),
      ),
    );
  }
}
