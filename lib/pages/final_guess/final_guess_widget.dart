import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import '/pages/components/button/button_widget.dart';
import '/pages/components/guess_row/guess_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'final_guess_model.dart';
export 'final_guess_model.dart';

class FinalGuessWidget extends StatefulWidget {
  const FinalGuessWidget({super.key});

  static String routeName = 'FinalGuess';
  static String routePath = '/finalGuess';

  @override
  State<FinalGuessWidget> createState() => _FinalGuessWidgetState();
}

class _FinalGuessWidgetState extends State<FinalGuessWidget> {
  late FinalGuessModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FinalGuessModel());
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
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20.0,
                    color: FlutterFlowTheme.of(context).secondary,
                    offset: const Offset(
                      0.0,
                      4.0,
                    ),
                    spreadRadius: 0.0,
                  )
                ],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32.0),
                  bottomRight: Radius.circular(32.0),
                ),
                shape: BoxShape.rectangle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'OSTATECZNE ZGADNIĘCIE',
                        style: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .override(
                              font: GoogleFonts.poppins(
                                fontWeight: FontWeight.w900,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w900,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .headlineMedium
                                  .fontStyle,
                              lineHeight: 1.2,
                            ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondary10,
                          borderRadius: BorderRadius.circular(9999.0),
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).secondary,
                            width: 1.0,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              24.0, 16.0, 24.0, 16.0),
                          child: Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.timer_rounded,
                                  // ZMIANA: Zmieniono z onSecondary na primaryText dla lepszej widoczności
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 20.0,
                                ),
                                Text(
                                  '01:42',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.urbanist(
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        // ZMIANA: Zmieniono z onSecondary na primaryText
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 24.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                        lineHeight: 1.5,
                                      ),
                                ),
                              ].divide(const SizedBox(width: 8.0)),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Dopasuj wszystkich graczy do ich harmonogramów',
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
                    ].divide(const SizedBox(height: 16.0)),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: SingleChildScrollView(
                  primary: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Zidentyfikuj postacie',
                                style: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      font: GoogleFonts.urbanist(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                      lineHeight: 1.3,
                                    ),
                              ),
                              Builder(
                                builder: (context) {
                                  final selectedProfessions = [
                                    _model.guessRowModel1.dropdownValue,
                                    _model.guessRowModel2.dropdownValue,
                                    _model.guessRowModel3.dropdownValue,
                                    _model.guessRowModel4.dropdownValue,
                                  ]
                                      .where((value) =>
                                          value != null && value.isNotEmpty)
                                      .cast<String>()
                                      .toList();
                                  final duplicateSet = selectedProfessions
                                      .fold<Map<String, int>>({}, (map, value) {
                                        map[value] = (map[value] ?? 0) + 1;
                                        return map;
                                      })
                                      .entries
                                      .where((entry) => entry.value > 1)
                                      .map((entry) => entry.key)
                                      .toSet();

                                  final duplicate1 = duplicateSet.contains(
                                      _model.guessRowModel1.dropdownValue);
                                  final duplicate2 = duplicateSet.contains(
                                      _model.guessRowModel2.dropdownValue);
                                  final duplicate3 = duplicateSet.contains(
                                      _model.guessRowModel3.dropdownValue);
                                  final duplicate4 = duplicateSet.contains(
                                      _model.guessRowModel4.dropdownValue);

                                  return Column(
                                    children: [
                                      wrapWithModel(
                                        model: _model.guessRowModel1,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: GuessRowWidget(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          initials: 'AR',
                                          nicknames:
                                              'Kucharz,Pisarz,Sportowiec,Ogrodnik',
                                          profileName: 'Alex Rivera',
                                          scheduleHint: '',
                                          duplicateProfession: duplicate1,
                                          onProfessionChanged: (_) =>
                                              safeSetState(() {}),
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.guessRowModel2,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: GuessRowWidget(
                                          color: FlutterFlowTheme.of(context)
                                              .tertiary,
                                          initials: 'JS',
                                          nicknames:
                                              'Kucharz,Pisarz,Sportowiec,Ogrodnik',
                                          profileName: 'Jordan Smith',
                                          scheduleHint: '',
                                          duplicateProfession: duplicate2,
                                          onProfessionChanged: (_) =>
                                              safeSetState(() {}),
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.guessRowModel3,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: GuessRowWidget(
                                          color: FlutterFlowTheme.of(context)
                                              .success,
                                          initials: 'CV',
                                          nicknames:
                                              'Kucharz,Pisarz,Sportowiec,Ogrodnik',
                                          profileName: 'Casey V.',
                                          scheduleHint: '',
                                          duplicateProfession: duplicate3,
                                          onProfessionChanged: (_) =>
                                              safeSetState(() {}),
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.guessRowModel4,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: GuessRowWidget(
                                          color: FlutterFlowTheme.of(context)
                                              .warning,
                                          initials: 'TP',
                                          nicknames:
                                              'Kucharz,Pisarz,Sportowiec,Ogrodnik',
                                          profileName: 'Taylor P.',
                                          scheduleHint: '',
                                          duplicateProfession: duplicate4,
                                          onProfessionChanged: (_) =>
                                              safeSetState(() {}),
                                        ),
                                      ),
                                    ].divide(const SizedBox(
                                        height:
                                            16.0)), // ZMIANA: Dodano rozdzielnik wysokości (16px) między wierszami postaci
                                  );
                                },
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).info10,
                                  borderRadius: BorderRadius.circular(24.0),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color: FlutterFlowTheme.of(context).info30,
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.info_rounded,
                                          // ZMIANA: Zmieniono z onInfo na primaryText dla lepszego kontrastu w ramce informacyjnej
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 20.0,
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            'Po zatwierdzeniu nie możesz już zmienić odpowiedzi. Jeśli trafisz, gra się kończy.',
                                            maxLines: 3,
                                            style: FlutterFlowTheme.of(context)
                                                .bodySmall
                                                .override(
                                                  font: GoogleFonts.urbanist(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmall
                                                            .fontStyle,
                                                  ),
                                                  // ZMIANA: Zmieniono kolor z onInfo na primaryText
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmall
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmall
                                                          .fontStyle,
                                                  lineHeight: 1.4,
                                                ),
                                          ),
                                        ),
                                      ].divide(const SizedBox(width: 16.0)),
                                    ),
                                  ),
                                ),
                              ),
                            ].divide(const SizedBox(height: 24.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                shape: BoxShape.rectangle,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 1.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).alternate,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => context.goNamed(
                              PlayerInvestigationWidget.routeName,
                              extra: {
                                kTransitionInfoKey: const TransitionInfo(
                                  hasTransition: true,
                                  transitionType:
                                      PageTransitionType.leftToRight,
                                  duration: Duration(milliseconds: 300),
                                ),
                              },
                            ),
                            child: wrapWithModel(
                              model: _model.buttonModel1,
                              updateCallback: () => safeSetState(() {}),
                              child: ButtonWidget(
                                content: 'Powrót',
                                icon: Icon(
                                  Icons.chevron_left,
                                  color: FlutterFlowTheme.of(context).primary,
                                  size: 16.0,
                                ),
                                iconPresent: true,
                                iconEndPresent: false,
                                variant: 'ghost',
                                size: 'medium',
                                fullWidth: false,
                                loading: false,
                                disabled: false,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: wrapWithModel(
                              model: _model.buttonModel2,
                              updateCallback: () => safeSetState(() {}),
                              child: const ButtonWidget(
                                content: 'WYŚLIJ',
                                iconPresent: false,
                                iconEndPresent: false,
                                variant: 'primary',
                                size: 'large',
                                fullWidth: true,
                                loading: false,
                                disabled: false,
                              ),
                            ),
                          ),
                        ].divide(const SizedBox(width: 16.0)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
